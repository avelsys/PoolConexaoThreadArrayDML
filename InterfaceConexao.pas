unit InterfaceConexao;

interface

uses
  FireDAC.Comp.Client;

type



  TConnectionDefDriverParams = record
    DriverDefName: string;
    VendorLib: string;
  end;

  TConnectionDefParams = record
    ConnectionDefName: string;
    Server: string;
    Database: string;
    UserName: string;
    Password: string;
    LocalConnection: Boolean;
    DriverName: string;
    Driver: string;
    VendorLib: string;
  end;

  TConnectionDefPoolParams = record
    Pooled: Boolean;
    PoolMaximumItems: Integer;
    PoolCleanupTimeout: Integer;
    PoolExpireTimeout: Integer;
  end;

  iConexaoPool = interface
    ['{2AE17385-38DF-4942-986E-634F2579AA4D}']
    function PegarNameConexao(out AQuery: TFDQuery): iConexaoPool; overload;
    function IsConnected: Boolean;
  end;

  iConexao = interface
    ['{2AE17385-38DF-4942-986E-634F2579AA4D}']
    function PegarNameConexao(out AQuery: TFDQuery): iConexao; overload;
    function IsConected: Boolean;
  end;

implementation

end.
