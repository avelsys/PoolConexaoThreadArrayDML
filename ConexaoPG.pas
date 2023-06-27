unit ConexaoPG;

interface

uses
  InterfaceConexao, FireDAC.Comp.Client, ConexaoPool;

type
  TConexaoPG = class(TInterfacedObject, iConexao)
  private
    FConexaoPool: iConexaoPool;
    constructor Create;
  public
    destructor Destroy; override;
    class function New : iConexao;
    function PegarNameConexao(out AQuery: TFDQuery): iConexao; overload;
    function IsConected: Boolean;
  end;

implementation

constructor TConexaoPG.Create;
var
  oConnectionDefParams: TConnectionDefParams;
begin
  oConnectionDefParams.ConnectionDefName := 'PG_CONNECTION';
  oConnectionDefParams.Server := 'localhost';
  oConnectionDefParams.Database := 'dblista';
  oConnectionDefParams.UserName := 'postgres';
  oConnectionDefParams.Password := '12936511';
  oConnectionDefParams.DriverName := 'PG_AVEL';
  oConnectionDefParams.Driver := 'PG';
  oConnectionDefParams.VendorLib := 'D:\projetos\FireDac_ArrayDML\lib';
  oConnectionDefParams.LocalConnection := True;

  FConexaoPool:= TConexaoPool.New(oConnectionDefParams);
end;

destructor TConexaoPG.Destroy;
begin
  inherited;
end;

function TConexaoPG.IsConected: Boolean;
begin
  FConexaoPool.IsConnected;
end;

class function TConexaoPG.New : iConexao;
begin
  Result := Self.Create;
end;

function TConexaoPG.PegarNameConexao(out AQuery: TFDQuery): iConexao;
begin
  result:= Self;
  FConexaoPool.PegarNameConexao(AQuery);
end;

end.

