object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 647
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object spltDivisor: TSplitter
    AlignWithMargins = True
    Left = 3
    Top = 311
    Width = 893
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ResizeStyle = rsUpdate
    ExplicitLeft = 0
    ExplicitTop = 40
    ExplicitWidth = 899
  end
  object dbgLista: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 361
    Width = 893
    Height = 283
    Align = alClient
    DataSource = dsBaseListaDML
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNTRY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNTRY_LOCAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNTRY_CODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTINENT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAPITAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POPULATION'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AREA_SQ_KM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AREA_SQ_MI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COASTLINE_KM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COASTLINE_MI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GOVERNMENT_FORM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CURRENCY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CURRENCY_CODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIALING_PREFIX'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BIRTHRATE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEATHRATE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Visible = True
      end>
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 899
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 895
    object lblQtdRegNormal: TLabel
      Left = 344
      Top = 9
      Width = 193
      Height = 25
      AutoSize = False
      Caption = 'Total Registro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object lblTempoNormal: TLabel
      Left = 568
      Top = 9
      Width = 193
      Height = 25
      AutoSize = False
      Caption = 'Tempo: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object btnArrayComum: TButton
      Left = 8
      Top = 9
      Width = 281
      Height = 25
      Caption = 'Array Normal'
      TabOrder = 0
      OnClick = btnArrayComumClick
    end
  end
  object dbgListaDML: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 44
    Width = 893
    Height = 261
    Align = alTop
    DataSource = dstBaseLista
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNTRY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNTRY_LOCAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNTRY_CODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTINENT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CAPITAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POPULATION'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AREA_SQ_KM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AREA_SQ_MI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COASTLINE_KM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COASTLINE_MI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GOVERNMENT_FORM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CURRENCY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CURRENCY_CODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIALING_PREFIX'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BIRTHRATE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEATHRATE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Visible = True
      end>
  end
  object pnlDML: TPanel
    Left = 0
    Top = 317
    Width = 899
    Height = 41
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 895
    object lblQtdRegDML: TLabel
      Left = 344
      Top = 8
      Width = 193
      Height = 25
      AutoSize = False
      Caption = 'Total Registro: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object lblTempoDML: TLabel
      Left = 568
      Top = 8
      Width = 193
      Height = 25
      AutoSize = False
      Caption = 'Tempo: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object btnArrayDML: TButton
      Left = 8
      Top = 8
      Width = 281
      Height = 25
      Caption = 'Array DML FireDac'
      TabOrder = 0
      OnClick = btnArrayDMLClick
    end
  end
  object dstBaseLista: TDataSource
    DataSet = fdqBase
    Left = 848
    Top = 136
  end
  object fdqBase: TFDQuery
    Connection = fdConector
    SQL.Strings = (
      'SELECT * FROM LISTA_PAISES')
    Left = 848
    Top = 80
  end
  object fdConector: TFDConnection
    Params.Strings = (
      'Database=D:\projetos\FireDac_ArrayDML\DBLISTA.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=localhost'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 73
  end
  object fddDriverFB: TFDPhysFBDriverLink
    VendorHome = 'D:\projetos\FireDac_ArrayDML'
    VendorLib = 'fbclient.dll'
    Left = 40
    Top = 128
  end
  object fdqBaseDML: TFDQuery
    Connection = fdConector
    SQL.Strings = (
      'SELECT * FROM LISTA_PAISES_DML')
    Left = 840
    Top = 392
  end
  object dsBaseListaDML: TDataSource
    DataSet = fdqBaseDML
    Left = 840
    Top = 448
  end
  object FDManager: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 48
    Top = 200
  end
end
