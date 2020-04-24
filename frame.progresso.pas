unit frame.progresso;

interface

uses
  FMX.VirtualKeyboard, FMX.Platform,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Ani, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrameProgresso = class(TFrame)
    ProgressCircle: TCircle;
    ProgressArc: TArc;
    CenterCircle: TCircle;
    ProgFloatAnimation: TFloatAnimation;
    BackgroundRectangle: TRectangle;
    Label1: TLabel;
    Layout1: TLayout;
    LblMensagem: TLabel;
    Layout2: TLayout;
  private
  public
    procedure ShowActivity(const AMsg: string = '');
    procedure HideActivity;
  end;

implementation

{$R *.fmx}

procedure TFrameProgresso.ShowActivity(const AMsg: string);
var
  FService: IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  try
    if (FService <> nil) then
      FService.HideVirtualKeyboard;
  finally
    FService := nil;
  end;

  if not Self.Visible then
  begin
    Self.Visible := True;
    ProgFloatAnimation.Enabled := True;
  end;

  Self.LblMensagem.Text := AMsg.Trim;

  Application.ProcessMessages;
end;

procedure TFrameProgresso.HideActivity;
begin
  Application.ProcessMessages;

  ProgFloatAnimation.Enabled := False;
  Self.Visible := False;
end;

end.
