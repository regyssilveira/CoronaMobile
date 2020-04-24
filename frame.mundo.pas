unit frame.mundo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation;

type
  TFrameMundo = class(TFrame)
    LstDadosMundo: TListBox;
    ListBoxGroupHeader5: TListBoxGroupHeader;
    ListBoxItem6: TListBoxItem;
    active: TLabel;
    ListBoxItem7: TListBoxItem;
    critical: TLabel;
    ListBoxItem5: TListBoxItem;
    recovered: TLabel;
    ListBoxItem12: TListBoxItem;
    affectedCountries: TLabel;
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
  private

  public
    procedure Atualizar;
  end;

implementation

uses
  principal.datamodule;

{$R *.fmx}

{ TFrameMundo }

procedure TFrameMundo.Atualizar;
begin
  DtmPrincipal.AtualizarResumo;
end;

end.
