unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase,
  Vcl.ExtCtrls, Threads, ConfigConexao, System.Threading, InterfaceConexao,
  ConexaoFB, ConexaoPG;

const
  csSCRIPT_INSERT = 'INSERT INTO %s( ' +
            ' Country, 	Country_local, 	Country_code, 	Continent, 	Capital, 	Population, ' +
            ' Area_sq_km, 	Area_sq_mi, 	Coastline_km, 	Coastline_mi, 	Government_form, ' +
            ' Currency, 	Currency_code, 	Dialing_prefix, 	Birthrate, 	Deathrate, 	Url )' +
            ' VALUES ( ' +
            ' :Country, 	:Country_local, 	:Country_code, 	:Continent, 	:Capital, 	:Population, ' +
            ' :Area_sq_km, 	:Area_sq_mi, 	:Coastline_km, 	:Coastline_mi, 	:Government_form, ' +
            ' :Currency, 	:Currency_code, 	:Dialing_prefix, 	:Birthrate, 	:Deathrate, 	:Url )';

  csSCRIPT_SELECT = 'SELECT * FROM  %s ';
  csTABELA_LISTA_NORMAL = 'LISTA_PAISES';
  csTABELA_LISTA_DML = 'LISTA_PAISES_DML';


type
  TForm1 = class(TForm)
    btnArrayComum: TButton;
    dbgLista: TDBGrid;
    dstBaseLista: TDataSource;
    fdqBase: TFDQuery;
    fdConector: TFDConnection;
    fddDriverFB: TFDPhysFBDriverLink;
    pnlTopo: TPanel;
    dbgListaDML: TDBGrid;
    spltDivisor: TSplitter;
    pnlDML: TPanel;
    btnArrayDML: TButton;
    fdqBaseDML: TFDQuery;
    dsBaseListaDML: TDataSource;
    lblQtdRegNormal: TLabel;
    lblTempoNormal: TLabel;
    lblQtdRegDML: TLabel;
    lblTempoDML: TLabel;
    FDManager: TFDManager;
    procedure btnArrayComumClick(Sender: TObject);
    procedure btnArrayDMLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FConexao: iConexao;
    function PegarQueryInclusao(const ATabela: string): string;
    function PegarQueryListar(const ATabela: string): string;
  public
    procedure GerarDadosArrayNormal;
    procedure GerarDadosArrayDML;
  end;

var
  Form1: TForm1;

implementation

resourcestring
  csTOTAL_REGISTRO = 'Total Registro: %s';
  csTEMPO = 'Tempo: %s';

{$R *.dfm}

procedure TForm1.btnArrayComumClick(Sender: TObject);
var
  oThreadNormal: TThreadListaNormal;
begin
  oThreadNormal := TThreadListaNormal.Create(GerarDadosArrayNormal);
  oThreadNormal.Start;
end;

procedure TForm1.btnArrayDMLClick(Sender: TObject);
var
  oThreadDML: TThreadListaNormal;
begin
  oThreadDML := TThreadListaNormal.Create(GerarDadosArrayDML);
  oThreadDML.Start;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FConexao := TConexaoFB.New;
end;

procedure TForm1.GerarDadosArrayDML;
var
  oListaDadosCSVDML: TStringList;
  oListaCommandTextDML: TStringList;
  lCounter: integer;
  oTempoInicio, oTempoFinal: TDateTime;
begin
  oTempoInicio := Now;
  oListaDadosCSVDML := TStringList.Create;
  oListaCommandTextDML := TStringList.Create;
  try
    try
      lblQtdRegDML.Caption := format(csTOTAL_REGISTRO,['0']);
      lblTempoDML.Caption := format(csTEMPO,['0']);
      oListaDadosCSVDML.LoadFromFile('lista.csv');
      FConexao.PegarNameConexao(fdqBaseDml);
      fdqBaseDml.SQL.Clear;
      fdqBaseDml.SQL.Text := PegarQueryInclusao(csTABELA_LISTA_DML);
      fdqBaseDml.Params.ArraySize := oListaDadosCSVDML.Count;

      for lCounter := 0 to Pred(oListaDadosCSVDML.Count) do
      begin
        oListaCommandTextDML.StrictDelimiter := True;
        oListaCommandTextDML.CommaText := oListaDadosCSVDML[lCounter];

        fdqBaseDml.ParamByName('Country').Values[lCounter]  := oListaCommandTextDML[0];
        fdqBaseDml.ParamByName('Country_local').AsStrings[lCounter]  := oListaCommandTextDML[1];
        fdqBaseDml.ParamByName('Country_code').AsStrings[lCounter]  := oListaCommandTextDML[2];
        fdqBaseDml.ParamByName('Continent').AsStrings[lCounter]  := oListaCommandTextDML[3];
        fdqBaseDml.ParamByName('Capital').AsStrings[lCounter]  := oListaCommandTextDML[4];
        fdqBaseDml.ParamByName('Population').AsStrings[lCounter]  := oListaCommandTextDML[5];
        fdqBaseDml.ParamByName('Area_sq_km').AsStrings[lCounter]  := oListaCommandTextDML[6];
        fdqBaseDml.ParamByName('Area_sq_mi').AsStrings[lCounter]  := oListaCommandTextDML[7];
        fdqBaseDml.ParamByName('Coastline_km').AsStrings[lCounter]  := oListaCommandTextDML[8];
        fdqBaseDml.ParamByName('Coastline_mi').AsStrings[lCounter]  := oListaCommandTextDML[9];
        fdqBaseDml.ParamByName('Government_form').AsStrings[lCounter]  := oListaCommandTextDML[10];
        fdqBaseDml.ParamByName('Currency').AsStrings[lCounter]  := oListaCommandTextDML[11];
        fdqBaseDml.ParamByName('Currency_code').AsStrings[lCounter]  := oListaCommandTextDML[12];
        fdqBaseDml.ParamByName('Dialing_prefix').AsStrings[lCounter]  := oListaCommandTextDML[13];
        fdqBaseDml.ParamByName('Birthrate').AsStrings[lCounter]  := oListaCommandTextDML[14];
        fdqBaseDml.ParamByName('Deathrate').AsStrings[lCounter]  := oListaCommandTextDML[15];
        fdqBaseDml.ParamByName('Url').AsStrings[lCounter]  := oListaCommandTextDML[16];
        TThread.Synchronize(nil, procedure
            begin
              lblQtdRegDML.Caption := format(csTOTAL_REGISTRO,[lCounter.ToString]);
            end);
      end;

      fdqBaseDml.Execute(oListaDadosCSVDML.Count, 0);
    except on E:Exception do
      raise Exception.Create(Format(' erro : %s',[E.Message]));

    end;
  finally
    oListaCommandTextDML.Free;
    oListaDadosCSVDML.Free;
  end;
  fdqBaseDml.SQL.Clear;
  fdqBaseDml.SQL.Text := PegarQueryListar(csTABELA_LISTA_DML);
  fdqBaseDml.Open;

  oTempoFinal := Now;
  lblTempoDML.Caption := format(csTEMPO,[FormatDateTime('hh:nn:ss:zzz', oTempoFinal - oTempoInicio)]);

end;

procedure TForm1.GerarDadosArrayNormal;
var
  oListaDadosCSV: TStringList;
  oListaCommandText: TStringList;
  sLinha: string;
  oTempoInicio, oTempoFinal: TDateTime;
  iRegistro: Integer;
begin
  iRegistro := 0;
  oTempoInicio := Now;
  oListaDadosCSV := TStringList.Create;
  oListaCommandText := TStringList.Create;
  try
    lblQtdRegNormal.Caption := format(csTOTAL_REGISTRO,['0']);
    lblTempoNormal.Caption := format(csTEMPO,['0']);
    oListaDadosCSV.LoadFromFile('lista.csv');
    FConexao.PegarNameConexao(fdqBase);
    fdqBase.SQL.Clear;
    fdqBase.SQL.Text := PegarQueryInclusao(csTABELA_LISTA_NORMAL);

    for sLinha in oListaDadosCSV do
    begin
      oListaCommandText.StrictDelimiter := True;
      oListaCommandText.CommaText := sLinha;

      fdqBase.ParamByName('Country').AsString := oListaCommandText[0];
      fdqBase.ParamByName('Country_local').AsString := oListaCommandText[1];
      fdqBase.ParamByName('Country_code').AsString := oListaCommandText[2];
      fdqBase.ParamByName('Continent').AsString := oListaCommandText[3];
      fdqBase.ParamByName('Capital').AsString := oListaCommandText[4];
      fdqBase.ParamByName('Population').AsString := oListaCommandText[5];
      fdqBase.ParamByName('Area_sq_km').AsString := oListaCommandText[6];
      fdqBase.ParamByName('Area_sq_mi').AsString := oListaCommandText[7];
      fdqBase.ParamByName('Coastline_km').AsString := oListaCommandText[8];
      fdqBase.ParamByName('Coastline_mi').AsString := oListaCommandText[9];
      fdqBase.ParamByName('Government_form').AsString := oListaCommandText[10];
      fdqBase.ParamByName('Currency').AsString := oListaCommandText[11];
      fdqBase.ParamByName('Currency_code').AsString := oListaCommandText[12];
      fdqBase.ParamByName('Dialing_prefix').AsString := oListaCommandText[13];
      fdqBase.ParamByName('Birthrate').AsString := oListaCommandText[14];
      fdqBase.ParamByName('Deathrate').AsString := oListaCommandText[15];
      fdqBase.ParamByName('Url').AsString := oListaCommandText[16];
      Inc(iRegistro);

      TThread.Synchronize(nil, procedure
          begin
             lblQtdRegNormal.Caption := format(csTOTAL_REGISTRO,[IntToStr(iRegistro)]);
          end);
      fdqBase.ExecSQL;
    end;

  finally
    oListaCommandText.Free;
    oListaDadosCSV.Free;
  end;
  fdqBase.SQL.Text := PegarQueryListar(csTABELA_LISTA_NORMAL);
  fdqBase.Open;
  oTempoFinal := Now;

  lblTempoNormal.Caption := format(csTEMPO,[FormatDateTime('hh:nn:ss:zzz', oTempoFinal - oTempoInicio)]);

end;

function TForm1.PegarQueryInclusao(const ATabela: string): string;
begin
  result := Format(csSCRIPT_INSERT,[ATabela]);
end;

function TForm1.PegarQueryListar(const ATabela: string): string;
begin
  result := Format(csSCRIPT_SELECT,[ATabela]);
end;

end.
