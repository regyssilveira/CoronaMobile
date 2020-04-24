unit frame.paises;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, FMX.Controls.Presentation, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, System.Actions, FMX.ActnList,
  FMX.ListBox, FMX.Layouts, FMX.ListView;

type
  TFramePaises = class(TFrame)
    TbcPaises: TTabControl;
    TabPaises: TTabItem;
    TabPaisSelecionado: TTabItem;
    LsvPaises: TListView;
    ActPaises: TActionList;
    ChangeTabAction1: TChangeTabAction;
    BindSourcePaises: TBindSourceDB;
    BindingsListPaises: TBindingsList;
    BtnVoltar: TSpeedButton;
    LinkListControlToField1: TLinkListControlToField;
    ToolBar1: TToolBar;
    LblNomePais: TLabel;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LstDadosPais: TListBox;
    ListBoxGroupHeader5: TListBoxGroupHeader;
    ListBoxItem6: TListBoxItem;
    active: TLabel;
    ListBoxItem7: TListBoxItem;
    critical: TLabel;
    ListBoxItem5: TListBoxItem;
    recovered: TLabel;
    ListBoxGroupHeader3: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    cases: TLabel;
    ListBoxItem2: TListBoxItem;
    todayCases: TLabel;
    ListBoxItem8: TListBoxItem;
    casesPerOneMillion: TLabel;
    ListBoxGroupHeader4: TListBoxGroupHeader;
    ListBoxItem3: TListBoxItem;
    deaths: TLabel;
    ListBoxItem4: TListBoxItem;
    todayDeaths: TLabel;
    ListBoxItem9: TListBoxItem;
    deathsPerOneMillion: TLabel;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem10: TListBoxItem;
    tests: TLabel;
    ListBoxItem11: TListBoxItem;
    testsPerOneMillion: TLabel;
    ListBoxItem12: TListBoxItem;
    continent: TLabel;
    procedure LsvPaisesPullRefresh(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure LsvPaisesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private

  public
    procedure Atualizar;
  end;

implementation

uses
  principal.datamodule;

{$R *.fmx}


procedure TFramePaises.Atualizar;
begin
  TbcPaises.TabIndex := 0;
  DtmPrincipal.AtualizarPaises;
end;

procedure TFramePaises.LsvPaisesPullRefresh(Sender: TObject);
begin
  // forçar atualização quando deslizar o dedo para baixo segurando
  DtmPrincipal.AtualizarPaises;
end;

procedure TFramePaises.LsvPaisesItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  Self.Preencher(DtmPrincipal.TbPaises);

  ChangeTabAction1.Tab := TabPaisSelecionado;
  ChangeTabAction1.Execute;
end;

procedure TFramePaises.BtnVoltarClick(Sender: TObject);
begin
  ChangeTabAction1.Tab := TabPaises;
  ChangeTabAction1.Execute;
end;

end.
