unit LoginUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.VirtualImage, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, LoginControl, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, DBProce;

type
  TLoginfrm = class(TForm)
    Panel1: TPanel;
    UsernameField: TLabeledEdit;
    PasswordField: TLabeledEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    VirtualImage1: TVirtualImage;
    SpeedButton1: TSpeedButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Loginfrm: TLoginfrm;

implementation

{$R *.dfm}

procedure TLoginfrm.FormShow(Sender: TObject);
begin
//
end;

procedure TLoginfrm.SpeedButton1Click(Sender: TObject);
var
  LoginControl: TLoginControl;
begin
  LoginControl := TLoginControl.Create(UsernameField.Text, PasswordField.Text);
  try
    LoginControl.Login;
  finally
    LoginControl.Free;
  end;
end;

end.
