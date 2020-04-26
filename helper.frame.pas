unit helper.frame;

interface

uses
  Data.DB, FMX.Forms, FMX.StdCtrls, FMX.Objects;

type
  TFrameHelper = class helper for TFrame
    procedure PreencherLabelPercentual(const ADataSet: TDataset; const AFieldCasos: string);
    procedure Preencher(const ADataSet: TDataset);
  end;

implementation

uses
  System.Classes,
  System.SysUtils,
  helper.field;

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

end.
