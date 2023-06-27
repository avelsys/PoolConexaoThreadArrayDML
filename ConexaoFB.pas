unit ConexaoFB;

interface

{
 oConnectionDefParams.ConnectionDefName := csCONNECTION_NAME;
  oConnectionDefParams.Server := '127.0.0.1';
  oConnectionDefParams.Database := 'D:\projetos\FireDac_ArrayDML\DBLISTA.FDB';
  oConnectionDefParams.UserName := 'SYSDBA';
  oConnectionDefParams.Password := 'masterkey';
  oConnectionDefParams.LocalConnection := True;

}
uses
  InterfaceConexao, FireDAC.Comp.Client, ConexaoPool;

type
  TConexaoFB = class(TInterfacedObject, iConexao)
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

constructor TConexaoFB.Create;
var
  oConnectionDefParams: TConnectionDefParams;
begin
  oConnectionDefParams.ConnectionDefName := 'FB_CONNECTION';
  oConnectionDefParams.Server := '127.0.0.1';
  oConnectionDefParams.Database := 'D:\projetos\FireDac_ArrayDML\DBLISTA.FDB';
  oConnectionDefParams.UserName := 'SYSDBA';
  oConnectionDefParams.Password := 'masterkey';
  oConnectionDefParams.DriverName := 'FB_AVEL';
  oConnectionDefParams.Driver := 'FB';
  oConnectionDefParams.LocalConnection := True;

  FConexaoPool:= TConexaoPool.New(oConnectionDefParams);
end;

destructor TConexaoFB.Destroy;
begin
  inherited;
end;

class function TConexaoFB.New : iConexao;
begin
  Result := Self.Create;
end;

function TConexaoFB.PegarNameConexao(out AQuery: TFDQuery): iConexao;
begin
  result:= Self;
  FConexaoPool.PegarNameConexao(AQuery);
end;

function TConexaoFB.IsConected: Boolean;
begin
  FConexaoPool.IsConnected;
end;


end.
