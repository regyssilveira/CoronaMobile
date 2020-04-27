unit frame.sobre;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Ani, FMX.Objects, FMX.Controls.Presentation;

type
  TSobreModo = (modSplash, modSobre);

  TFrameSobre = class(TFrame)
    Rectangle1: TRectangle;
    Image1: TImage;
    GridPanelLayout1: TGridPanelLayout;
    LblStatus: TLabel;
    RecMsg1: TRectangle;
    LblMsg1: TLabel;
    RecMsg2: TRectangle;
    LblMsg2: TLabel;
    RecMsg3: TRectangle;
    LblMsg3: TLabel;
    ProgressCircle: TCircle;
    ProgressArc: TArc;
    ProgFloatAnimation: TFloatAnimation;
    CenterCircle: TCircle;
    Label2: TLabel;
    Layout1: TLayout;
    Label1: TLabel;
    Layout2: TLayout;
    BtnVoltar: TSpeedButton;
    Layout3: TLayout;
    Image2: TImage;
    LblSelphi: TLabel;
    Rectangle2: TRectangle;
    procedure BtnVoltarClick(Sender: TObject);
    procedure RecMsg1Click(Sender: TObject);
    procedure RecMsg2Click(Sender: TObject);
    procedure RecMsg3Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
  private
    FMensagem: string;
    FModo: TSobreModo;
    procedure SetMensagem(const Value: string);
    procedure SetModo(const Value: TSobreModo);
  public
    procedure Mostrar(const AModo: TSobreModo; const AMensagem: string = '');
    procedure Fechar;

    property Modo: TSobreModo read FModo write SetModo;
    property Mensagem: string read FMensagem write SetMensagem;
  end;

implementation

uses
  open.url;

{$R *.fmx}

procedure TFrameSobre.SetMensagem(const Value: string);
begin
  FMensagem := Value;
  Self.LblStatus.Text := FMensagem;
end;

procedure TFrameSobre.SetModo(const Value: TSobreModo);
begin
  FModo := Value;

  BtnVoltar.Visible := FModo = modSobre;
  RecMsg1.Visible   := FModo = modSobre;
  RecMsg2.Visible   := FModo = modSobre;
  RecMsg3.Visible   := FModo = modSobre;

  LblStatus.Visible          := FModo = modSplash;
  ProgressCircle.Visible     := FModo = modSplash;
  ProgFloatAnimation.Enabled := ProgressCircle.Visible;
end;

procedure TFrameSobre.Mostrar(const AModo: TSobreModo; const AMensagem: string);
begin
  Self.Modo     := AModo;
  Self.Mensagem := AMensagem;
  Self.Visible  := True;

  Self.BringToFront;
end;

procedure TFrameSobre.Fechar;
begin
  Self.Visible := False;
end;

procedure TFrameSobre.RecMsg1Click(Sender: TObject);
begin
  OpenURL('https://corona.lmao.ninja');
end;

procedure TFrameSobre.RecMsg2Click(Sender: TObject);
begin
  OpenURL('https://corona.lmao.ninja/docs');
end;

procedure TFrameSobre.RecMsg3Click(Sender: TObject);
begin
  OpenURL('https://www.worldometers.info/coronavirus');
end;

procedure TFrameSobre.Rectangle2Click(Sender: TObject);
begin
  OpenURL('https://regys.com.br');
end;

procedure TFrameSobre.BtnVoltarClick(Sender: TObject);
begin
  Self.Fechar;
end;

end.
