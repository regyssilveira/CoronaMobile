unit principal.datamodule;

interface

uses
  FMX.Forms, FMX.StdCtrls, FMX.Objects,

  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, REST.Response.Adapter,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFieldHelper = class helper for TField
    function AsNumFormatado: string;
  end;

  TFrameHelper = class helper for TFrame
    procedure PreencherLabelPercentual(const ADataSet: TDataset; const AFieldCasos: string);
    procedure Preencher(const ADataSet: TDataset);
  end;

  TImageHelper = class helper for TImage
    procedure DownloadPNG(const AURL: string);
  end;

  TDtmPrincipal = class(TDataModule)
    RESTCli: TRESTClient;
    ReqResumo: TRESTRequest;
    ReqPaises: TRESTRequest;
    RESTResp: TRESTResponse;
    ReqPais: TRESTRequest;
    TbResumo: TFDMemTable;
    DtsAdpResumo: TRESTResponseDataSetAdapter;
    TbResumoupdated: TWideStringField;
    TbResumocases: TWideStringField;
    TbResumotodayCases: TWideStringField;
    TbResumodeaths: TWideStringField;
    TbResumotodayDeaths: TWideStringField;
    TbResumorecovered: TWideStringField;
    TbResumoactive: TWideStringField;
    TbResumocritical: TWideStringField;
    TbResumocasesPerOneMillion: TWideStringField;
    TbResumodeathsPerOneMillion: TWideStringField;
    TbResumotests: TWideStringField;
    TbResumotestsPerOneMillion: TWideStringField;
    TbResumoaffectedCountries: TWideStringField;
    DtsAdpPaises: TRESTResponseDataSetAdapter;
    DtsAdpPais: TRESTResponseDataSetAdapter;
    TbPaises: TFDMemTable;
    TbPais: TFDMemTable;
    TbPaisesupdated: TWideStringField;
    TbPaisescountry: TWideStringField;
    TbPaisescountryInfo: TWideStringField;
    TbPaisescountryInfo_id: TWideStringField;
    TbPaisescountryInfoiso2: TWideStringField;
    TbPaisescountryInfoiso3: TWideStringField;
    TbPaisescountryInfolat: TWideStringField;
    TbPaisescountryInfolong: TWideStringField;
    TbPaisescountryInfoflag: TWideStringField;
    TbPaisescases: TWideStringField;
    TbPaisestodayCases: TWideStringField;
    TbPaisesdeaths: TWideStringField;
    TbPaisestodayDeaths: TWideStringField;
    TbPaisesrecovered: TWideStringField;
    TbPaisesactive: TWideStringField;
    TbPaisescritical: TWideStringField;
    TbPaisescasesPerOneMillion: TWideStringField;
    TbPaisesdeathsPerOneMillion: TWideStringField;
    TbPaisestests: TWideStringField;
    TbPaisestestsPerOneMillion: TWideStringField;
    TbPaisescontinent: TWideStringField;
    TbPaisupdated: TWideStringField;
    TbPaiscountry: TWideStringField;
    TbPaiscountryInfo: TWideStringField;
    TbPaiscountryInfo_id: TWideStringField;
    TbPaiscountryInfoiso2: TWideStringField;
    TbPaiscountryInfoiso3: TWideStringField;
    TbPaiscountryInfolat: TWideStringField;
    TbPaiscountryInfolong: TWideStringField;
    TbPaiscountryInfoflag: TWideStringField;
    TbPaiscases: TWideStringField;
    TbPaistodayCases: TWideStringField;
    TbPaisdeaths: TWideStringField;
    TbPaistodayDeaths: TWideStringField;
    TbPaisrecovered: TWideStringField;
    TbPaisactive: TWideStringField;
    TbPaiscritical: TWideStringField;
    TbPaiscasesPerOneMillion: TWideStringField;
    TbPaisdeathsPerOneMillion: TWideStringField;
    TbPaistests: TWideStringField;
    TbPaistestsPerOneMillion: TWideStringField;
    TbPaiscontinent: TWideStringField;
  private

  public
    procedure AtualizarPaises;
    procedure AtualizarResumo;
    procedure AtualizarTudo;
  end;

var
  DtmPrincipal: TDtmPrincipal;

implementation

uses
  principal,
  FMX.Dialogs,
  System.Threading,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent, frame.sobre;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TFieldHelper }

function TFieldHelper.AsNumFormatado: string;
begin
  if Self.AsString.Trim.IsEmpty then
    Result := ''
  else
  begin
    try
      if Frac(Self.AsFloat) = 0.00 then
        Result := FormatFloat(',#0', Self.AsFloat)
      else
        Result:= FormatFloat(',#0.00', Self.AsFloat);
    except
      Result := Self.AsString;
    end;
  end;
end;

{ TFrameHelper }

procedure TFrameHelper.PreencherLabelPercentual(const ADataSet: TDataset; const AFieldCasos: string);
var
  LabelCalc: TComponent;
  CampoCasos: TField;
  PercCasos: Double;
begin
  CampoCasos := ADataSet.FindField(AFieldCasos);
  if Assigned(CampoCasos) then
  begin
    LabelCalc := Self.FindComponent(AFieldCasos);
    if Assigned(LabelCalc) then
    begin
      try
        PercCasos := (CampoCasos.AsFloat * 100) / 1000000;
      except
        PercCasos := 0.00;
      end;

      (LabelCalc as TLabel).Text := FormatFloat(',#0.000%', PercCasos);
    end;
  end;
end;

procedure TFrameHelper.Preencher(const ADataSet: TDataset);
var
  I: Integer;
  Controle: TComponent;
  Campo: TField;
begin
  for I := 0 to Self.ComponentCount - 1 do
  begin
    Controle := Self.Components[I];
    if (Controle is TLabel) then
    begin
      Campo := ADataSet.FindField(Controle.Name);
      if Assigned(Campo) then
        (Controle as TLabel).Text := Campo.AsNumFormatado;
    end;
  end;

  Self.PreencherLabelPercentual(ADataSet, 'casesPerOneMillion');
  Self.PreencherLabelPercentual(ADataSet, 'deathsPerOneMillion');
  Self.PreencherLabelPercentual(ADataSet, 'testsPerOneMillion');
end;

{ TImageHelper }

procedure TImageHelper.DownloadPNG(const AURL: string);
begin
  Self.Bitmap := nil;

  TThread.CreateAnonymousThread(
    procedure
    var
      Ms: TMemoryStream;
      HttpClient: TNetHTTPClient;
    begin
      HttpClient := TNetHTTPClient.Create(nil);
      try
        Ms := TMemoryStream.Create;
        try
          HttpClient.Get(AURL, Ms);

          TThread.Synchronize(nil,
            procedure
            begin
              Self.Bitmap.LoadFromStream(Ms);
            end
          );
        finally
          Ms.DisposeOf;
        end;
      finally
        HttpClient.DisposeOf;
      end;
    end
  ).Start;
end;

{ TDtmPrincipal }

procedure TDtmPrincipal.AtualizarTudo;
begin
  Self.AtualizarResumo;
  Self.AtualizarPaises;
end;

procedure TDtmPrincipal.AtualizarResumo;
begin
  FrmPrincipal.FrameSobre1.Mostrar(TSobreModo.modSplash, 'Atualizando dados gerais...');
  DtmPrincipal.ReqResumo.ExecuteAsync(
    procedure
    begin
      if DtmPrincipal.RESTResp.Status.Success then
        FrmPrincipal.FrameMundo1.Preencher(DtmPrincipal.TbResumo)
      else
      begin
        FrmPrincipal.FrameSobre1.Fechar;
        ShowMessage(
          'Ocorreu um erro ao atualizar os dados:' + sLineBreak +
          DtmPrincipal.RESTResp.StatusCode.ToString + ' - ' + DtmPrincipal.RESTResp.StatusText
        );
      end;
    end,
    True,
    True,
    procedure(AObject: TObject)
    begin
      FrmPrincipal.FrameSobre1.Fechar;
      if Assigned(AObject) and (AObject is Exception) then
      begin
        ShowMessage(
          'Ocorreu um erro ao atualizar os dados:' + sLineBreak +
          Exception(AObject).Message
        );
      end;
    end
  );
end;

procedure TDtmPrincipal.AtualizarPaises;
begin
  FrmPrincipal.FrameSobre1.Mostrar(TSobreModo.modSplash, 'Efetuando download dos dados de países...');
  ReqPaises.ExecuteAsync(
    procedure
    begin
      FrmPrincipal.FrameSobre1.Fechar;
      if not DtmPrincipal.RESTResp.Status.Success then
      begin
        ShowMessage(
          'Ocorreu um erro ao atualizar os dados de países:' + sLineBreak +
          DtmPrincipal.RESTResp.StatusCode.ToString + ' - ' + DtmPrincipal.RESTResp.StatusText
        );
      end;
    end,
    True,
    True,
    procedure(AObject: TObject)
    begin
      FrmPrincipal.FrameSobre1.Fechar;
      if Assigned(AObject) and (AObject is Exception) then
      begin
        ShowMessage(
          'Ocorreu um erro ao atualizar os dados de países:' + sLineBreak +
          Exception(AObject).Message
        );
      end;
    end
  );
end;

end.

