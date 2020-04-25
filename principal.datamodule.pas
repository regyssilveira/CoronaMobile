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
    procedure Preencher(const ADataSet: TDataset);
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
    procedure AtualizarResumo;
    procedure AtualizarPaises;
    procedure ShowBandeiraPais(const AURLPng: string; const AImage: TImage);
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
  System.Net.HttpClientComponent;

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
end;

{ TDtmPrincipal }

procedure TDtmPrincipal.AtualizarResumo;
begin
  TbResumo.Close;

  FrmPrincipal.ShowActivity('Atualizando resumo de informações...');
  ReqResumo.ExecuteAsync(
    procedure
    begin
      FrmPrincipal.FrameMundo1.Preencher(TbResumo);
      FrmPrincipal.HideActivity;
    end
  );
end;

procedure TDtmPrincipal.AtualizarPaises;
begin
  TbPaises.Close;

  FrmPrincipal.ShowActivity('Atualizando informações de países...');
  ReqPaises.ExecuteAsync(
    procedure
    begin
      FrmPrincipal.HideActivity;
    end
  );
end;

procedure TDtmPrincipal.ShowBandeiraPais(const AURLPng: string; const AImage: TImage);
begin
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
          HttpClient.Get(AURLPng, Ms);

          TThread.Synchronize(nil,
            procedure
            begin
              AImage.Bitmap.LoadFromStream(Ms);
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

end.

