program CoronaMob;

uses
  System.StartUpCopy,
  FMX.Forms,
  principal in 'principal.pas' {FrmPrincipal},
  principal.datamodule in 'principal.datamodule.pas' {DtmPrincipal: TDataModule},
  frame.mundo in 'frame.mundo.pas' {FrameMundo: TFrame},
  frame.paises in 'frame.paises.pas' {FramePaises: TFrame},
  open.url in 'open.url.pas',
  frame.sobre in 'frame.sobre.pas' {FrameSobre: TFrame},
  helper.image in 'helper.image.pas',
  helper.frame in 'helper.frame.pas',
  helper.field in 'helper.field.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TDtmPrincipal, DtmPrincipal);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
