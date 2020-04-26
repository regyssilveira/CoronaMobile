unit principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.TabControl, System.ImageList, FMX.ImgList, FMX.MultiView,
  frame.paises, frame.mundo, frame.sobre;

type
  TFrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    TbcGeral: TTabControl;
    TabMundo: TTabItem;
    TabPaises: TTabItem;
    LblCaption: TLabel;
    FrameMundo1: TFrameMundo;
    BtnSobre: TSpeedButton;
    FramePaises1: TFramePaises;
    BtnAtualizar: TSpeedButton;
    FrameSobre1: TFrameSobre;
    procedure TbcGeralChange(Sender: TObject);
    procedure BtnSobreClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
  private

  public

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  principal.datamodule;

{$R *.fmx}

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  TbcGeral.TabIndex := 0;
  Self.Caption := LblCaption.Text;
end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key in [vkBack, vkHardwareBack] then
  begin
    if FrameSobre1.Visible then
    begin
      FrameSobre1.Fechar;
      Key := 0;
    end
    else
    if TbcGeral.ActiveTab = TabPaises then
    begin
      if FramePaises1.TbcPaises.TabIndex > 0 then
      begin
        FramePaises1.BtnVoltarClick(nil);
        Key := 0;
      end;
    end;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  BtnAtualizarClick(nil);
end;

procedure TFrmPrincipal.TbcGeralChange(Sender: TObject);
begin
  if TbcGeral.ActiveTab = TabPaises then
    FramePaises1.Inicializar;
end;

procedure TFrmPrincipal.BtnAtualizarClick(Sender: TObject);
begin
  TbcGeral.TabIndex := 0;
  DtmPrincipal.AtualizarTudo;
end;

procedure TFrmPrincipal.BtnSobreClick(Sender: TObject);
begin
  FrameSobre1.Mostrar(TSobreModo.modSobre);
end;

end.
