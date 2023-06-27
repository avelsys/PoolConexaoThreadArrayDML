unit ConexaoPool;

interface

uses
  InterfaceConexao,  System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,

  //FIREBIRD
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IBWrapper,

  //postgres
  FireDAC.Phys.PGDef, 
  FireDAC.Phys.PG,
  FireDAC.Phys.PGWrapper, System.Types;

type
  TConexaoPool = class(TInterfacedObject, iConexaoPool)
  protected
    constructor Create(const AConnectionDefParams: TConnectionDefParams);
  private    
    FConnectionName: string;
    FDriveName: string;
    FDriver: string;
    function ConfigurarConexao(
      const AConnectionDefDriverParams: TConnectionDefDriverParams;
      const AConnectionDefParams: TConnectionDefParams;
      const AConnectionDefPoolParams: TConnectionDefPoolParams): iConexaoPool; overload;
    procedure DefinirParametroFB(
      AConnectionDefParams: TConnectionDefParams; 
      AConnectionDefDriverParams: TConnectionDefDriverParams; 
      AFDStanConnectionDef: IFDStanConnectionDef; 
      AConnectionDefPoolParams: TConnectionDefPoolParams);
      
    procedure DefinirParametroPG(
      AConnectionDefParams: TConnectionDefParams;
      AConnectionDefDriverParams: TConnectionDefDriverParams;
      AFDStanConnectionDef: IFDStanConnectionDef;
      AConnectionDefPoolParams: TConnectionDefPoolParams);
      
  public
    destructor Destroy; override;
    class function New(const AConnectionDefParams: TConnectionDefParams) : iConexaoPool;
    function PegarNameConexao(out AQuery: TFDQuery): iConexaoPool;
    function IsConnected: Boolean;
    
  end;

implementation

resourcestring
  csBASE_DRIVER_ID_FIREBIRD = 'BaseDriverID';
  csVENDOR_LIB = 'VendorLib';
  
constructor TConexaoPool.Create(const AConnectionDefParams: TConnectionDefParams);
var
  oConnectionDefDriverParams: TConnectionDefDriverParams;
  oConnectionDefParams: TConnectionDefParams;
  oConnectionDefPoolParams: TConnectionDefPoolParams;
begin
  FDriver:= AConnectionDefParams.Driver;
  FDriveName:= AConnectionDefParams.DriverName;
  FConnectionName := AConnectionDefParams.ConnectionDefName;
  
  oConnectionDefDriverParams.DriverDefName := FDriver;
  
  if not AConnectionDefParams.VendorLib.IsEmpty then
    oConnectionDefDriverParams.VendorLib := AConnectionDefParams.VendorLib; 

  oConnectionDefParams.ConnectionDefName := FConnectionName;
  oConnectionDefParams.Server := AConnectionDefParams.Server;
  oConnectionDefParams.Database := AConnectionDefParams.Database;
  oConnectionDefParams.UserName := AConnectionDefParams.UserName;
  oConnectionDefParams.Password := AConnectionDefParams.Password;
  oConnectionDefParams.LocalConnection := True;

  oConnectionDefPoolParams.Pooled := true;
  oConnectionDefPoolParams.PoolMaximumItems := 50;
  oConnectionDefPoolParams.PoolCleanupTimeout := 30000;
  oConnectionDefPoolParams.PoolExpireTimeout := 60000;

  ConfigurarConexao(oConnectionDefDriverParams,
                    oConnectionDefParams,
                    oConnectionDefPoolParams);

end;  
  
function TConexaoPool.ConfigurarConexao(
      const AConnectionDefDriverParams: TConnectionDefDriverParams;
      const AConnectionDefParams: TConnectionDefParams;
      const AConnectionDefPoolParams: TConnectionDefPoolParams): iConexaoPool;
var
  oConnection: TFDCustomConnection;
  oFDStanConnectionDef: IFDStanConnectionDef;
  oFDStanDefinition: IFDStanDefinition;
begin
  Result := Self;
  FDManager.CloseConnectionDef(AConnectionDefParams.ConnectionDefName);
  FDManager.ActiveStoredUsage := [auRunTime];
  FDManager.ConnectionDefFileAutoLoad := False;
  FDManager.DriverDefFileAutoLoad := False;
  FDManager.SilentMode := True;

  oFDStanDefinition := FDManager.DriverDefs.FindDefinition(AConnectionDefDriverParams.DriverDefName);
  if not Assigned(FDManager.DriverDefs.FindDefinition(AConnectionDefDriverParams.DriverDefName)) then
  begin
    oFDStanDefinition := FDManager.DriverDefs.Add;
    oFDStanDefinition.Name := AConnectionDefDriverParams.DriverDefName;
  end;
  oFDStanDefinition.AsString[csBASE_DRIVER_ID_FIREBIRD] := FDriver;
//  if not AConnectionDefDriverParams.VendorLib.Trim.IsEmpty then
//    oFDStanDefinition.AsString[csVENDOR_LIB] := AConnectionDefDriverParams.VendorLib;

  oFDStanConnectionDef := FDManager.ConnectionDefs.FindConnectionDef(AConnectionDefParams.ConnectionDefName);
  if not Assigned(FDManager.ConnectionDefs.FindConnectionDef(AConnectionDefParams.ConnectionDefName)) then
  begin
    oFDStanConnectionDef := FDManager.ConnectionDefs.AddConnectionDef;
    oFDStanConnectionDef.Name := AConnectionDefParams.ConnectionDefName;
  end;
  
  if FDriver = 'FB' then  
    DefinirParametroFB(AConnectionDefParams, AConnectionDefDriverParams, oFDStanConnectionDef, AConnectionDefPoolParams)
  else    
    DefinirParametroPG(AConnectionDefParams, AConnectionDefDriverParams, oFDStanConnectionDef, AConnectionDefPoolParams);
        
  oConnection := TFDCustomConnection.Create(nil);
  try
    oConnection.FetchOptions.Mode := TFDFetchMode.fmAll; //fmAll
    oConnection.ResourceOptions.AutoConnect := False;

    with oConnection.FormatOptions.MapRules.Add do
    begin
      SourceDataType := dtDateTime; { TFDParam.DataType }
      TargetDataType := dtDateTimeStamp; { Firebird TIMESTAMP }
    end;

    oFDStanConnectionDef.WriteOptions(oConnection.FormatOptions,
                                      oConnection.UpdateOptions,
                                      oConnection.FetchOptions,
                                      oConnection.ResourceOptions);
  finally
    oConnection.Free;
  end;

  if (FDManager.State <> TFDPhysManagerState.dmsActive) then
    FDManager.Open;

end;

destructor TConexaoPool.Destroy;
begin
  inherited;
end;

function TConexaoPool.IsConnected: Boolean;
var
  lFDConnection: TFDConnection;
begin
  lFDConnection := TFDConnection.Create(nil);
  try
    lFDConnection.ConnectionDefName := FConnectionName;
    lFDConnection.Connected := True;   
    Result := lFDConnection.Connected;
  finally
    lFDConnection.Free;
  end;
end;

procedure TConexaoPool.DefinirParametroFB(
      AConnectionDefParams: TConnectionDefParams; 
      AConnectionDefDriverParams: TConnectionDefDriverParams; 
      AFDStanConnectionDef: IFDStanConnectionDef; 
      AConnectionDefPoolParams: TConnectionDefPoolParams);
var
  oFBConnectionDefParams: TFDPhysFBConnectionDefParams;
begin
  oFBConnectionDefParams := TFDPhysFBConnectionDefParams(AFDStanConnectionDef.Params);
  oFBConnectionDefParams.DriverID := AConnectionDefDriverParams.DriverDefName;
  oFBConnectionDefParams.Database := AConnectionDefParams.Database;
  oFBConnectionDefParams.UserName := AConnectionDefParams.UserName;
  oFBConnectionDefParams.Password := AConnectionDefParams.Password;
  oFBConnectionDefParams.Server := AConnectionDefParams.Server;
  oFBConnectionDefParams.Protocol := TIBProtocol.ipLocal;

  if not AConnectionDefParams.LocalConnection then
    oFBConnectionDefParams.Protocol := TIBProtocol.ipTCPIP;

  oFBConnectionDefParams.Pooled := AConnectionDefPoolParams.Pooled;
  oFBConnectionDefParams.PoolMaximumItems := AConnectionDefPoolParams.PoolMaximumItems;
  oFBConnectionDefParams.PoolCleanupTimeout := AConnectionDefPoolParams.PoolCleanupTimeout;
  oFBConnectionDefParams.PoolExpireTimeout := AConnectionDefPoolParams.PoolExpireTimeout;
end;

procedure TConexaoPool.DefinirParametroPG(
      AConnectionDefParams: TConnectionDefParams;
      AConnectionDefDriverParams: TConnectionDefDriverParams;
      AFDStanConnectionDef: IFDStanConnectionDef;
      AConnectionDefPoolParams: TConnectionDefPoolParams);
var                                                          
  oPGConnectionDefParams: TFDPhysPGConnectionDefParams;
begin
  oPGConnectionDefParams := TFDPhysPGConnectionDefParams(AFDStanConnectionDef.Params);
  oPGConnectionDefParams.DriverID := AConnectionDefDriverParams.DriverDefName;
  oPGConnectionDefParams.Database := AConnectionDefParams.Database;
  oPGConnectionDefParams.UserName := AConnectionDefParams.UserName;
  oPGConnectionDefParams.Password := AConnectionDefParams.Password;
  oPGConnectionDefParams.Server := AConnectionDefParams.Server;
    
  oPGConnectionDefParams.Pooled := AConnectionDefPoolParams.Pooled;
  oPGConnectionDefParams.PoolMaximumItems := AConnectionDefPoolParams.PoolMaximumItems;
  oPGConnectionDefParams.PoolCleanupTimeout := AConnectionDefPoolParams.PoolCleanupTimeout;
  oPGConnectionDefParams.PoolExpireTimeout := AConnectionDefPoolParams.PoolExpireTimeout;
end;

class function TConexaoPool.New (const AConnectionDefParams: TConnectionDefParams) : iConexaoPool;
begin
  Result := Self.Create(AConnectionDefParams);
end;

function TConexaoPool.PegarNameConexao(out AQuery: TFDQuery): iConexaoPool;
begin
  Result := Self;
  AQuery.Connection := TFDConnection.Create(nil);
  AQuery.Connection.ConnectionDefName := FConnectionName;
end;

end.
