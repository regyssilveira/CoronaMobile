unit principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.TabControl, System.ImageList, FMX.ImgList, FMX.MultiView,
  frame.paises, frame.mundo, frame.progresso;

type
  TFrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    TbcGeral: TTabControl;
    TabMundo: TTabItem;
    TabPaises: TTabItem;
    Label1: TLabel;
    FrameMundo1: TFrameMundo;
    BtnSobre: TSpeedButton;
    FrameProgresso1: TFrameProgresso;
    FramePaises1: TFramePaises;
    procedure TbcGeralChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameMundo1LstResumoMundoTap(Sender: TObject;
      const Point: TPointF);
    procedure BtnSobreClick(Sender: TObject);
  private

  public
    procedure ShowActivity(const AMsg: string);
    procedure HideActivity;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  principal.datamodule, open.url;

{$R *.fmx}

procedure TFrmPrincipal.BtnSobreClick(Sender: TObject);
begin
  OpenURL('https://corona.lmao.ninja/');
  OpenURL('https://corona.lmao.ninja/docs/');
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  TbcGeral.TabIndex := 0;
  FrameMundo1.Atualizar;
end;

procedure TFrmPrincipal.FrameMundo1LstResumoMundoTap(Sender: TObject;
  const Point: TPointF);
begin
  FrameMundo1.Atualizar;
end;

procedure TFrmPrincipal.TbcGeralChange(Sender: TObject);
begin
  if TbcGeral.ActiveTab = TabMundo then
    FrameMundo1.Atualizar
  else
  if TbcGeral.ActiveTab = TabPaises then
    FramePaises1.Atualizar;
end;

procedure TFrmPrincipal.ShowActivity(const AMsg: string);
begin
  FrameProgresso1.ShowActivity;
end;

procedure TFrmPrincipal.HideActivity;
begin
  FrameProgresso1.HideActivity;
end;

end.
