unit principal.datamodule;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, REST.Response.Adapter,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
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
  frame.sobre,
  helper.frame,
  FMX.Dialogs;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDtmPrincipal.AtualizarTudo;
begin
  Self.AtualizarResumo;
  Self.AtualizarPaises;
end;

procedure TDtmPrincipal.AtualizarResumo;
begin
  FrmPrincipal.FrameSobre1.Mostrar(TSobreModo.modSplash, 'Atualizando dados gerais...');
  ReqResumo.ExecuteAsync(
    procedure
    begin
      if RESTResp.Status.Success then
      begin
        DtsAdpResumo.Active := True;
        FrmPrincipal.FrameMundo1.Preencher(TbResumo)
      end
      else
      begin
        FrmPrincipal.FrameSobre1.Fechar;
        ShowMessage(
          'Ocorreu um erro ao atualizar os dados:' + sLineBreak +
          RESTResp.StatusCode.ToString + ' - ' + RESTResp.StatusText
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
      if not RESTResp.Status.Success then
      begin
        ShowMessage(
          'Ocorreu um erro ao atualizar os dados de países:' + sLineBreak +
          RESTResp.StatusCode.ToString + ' - ' + RESTResp.StatusText
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

