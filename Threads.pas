unit Threads;

interface

uses
  System.Classes;

type
  TThreadListaNormal = class(TTHread)
    FThreadProc: TThreadMethod;
  protected
    procedure Execute; override;
  public
    constructor Create(const AThreadProc: TThreadMethod); reintroduce;
  end;

implementation

{ TThreadListaNormal }

constructor TThreadListaNormal.Create(const AThreadProc: TThreadMethod);
begin
  inherited Create(true);
  FreeOnTerminate := True;
  FThreadProc := AThreadProc;

end;

procedure TThreadListaNormal.Execute;
begin
  inherited;
  if Assigned(FThreadProc) then
    FThreadProc;
end;

end.
