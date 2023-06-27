program ArrayDML;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  Threads in 'Threads.pas',
  ConfigConexao in 'ConfigConexao.pas',
  InterfaceConexao in 'InterfaceConexao.pas',
  ConexaoPool in 'ConexaoPool.pas',
  ConexaoFB in 'ConexaoFB.pas',
  ConexaoPG in 'ConexaoPG.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
