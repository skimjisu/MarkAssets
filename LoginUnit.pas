unit LoginUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.VirtualImage, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, LoginControl, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, DBProce, MainUnit;

type
  TLoginfrm = class(TForm)
    Panel1: TPanel;
    UsernameField: TLabeledEdit;
    PasswordField: TLabeledEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    VirtualImage1: TVirtualImage;
    LoginButton: TSpeedButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure LoginButtonClick(Sender: TObject);
  private
    { Private declarations }
    LoginControl: TLoginControl;
  public
    { Public declarations }

  public
    procedure LoginControlLogin(Sender: TObject; Success: Boolean);
  end;

var
  Loginfrm: TLoginfrm;

implementation

{$R *.dfm}

procedure TLoginfrm.LoginControlLogin(Sender: TObject; Success: Boolean);
begin
  if Success then
  begin
    //ShowMessage('로그인 성공!');
    self.Close;
    //Mainfrm.Show;
  end
  else
  begin
    ShowMessage('계정이 생성되었습니다. 다시 로그인 해주세요.');
  end;
end;

procedure TLoginfrm.LoginButtonClick(Sender: TObject);
var
  LoginControl: TLoginControl;
begin
  LoginControl := TLoginControl.Create(UsernameField.Text, PasswordField.Text);
  try
    LoginControl.OnLogin := LoginControlLogin;
    LoginControl.Login;
  finally
    LoginControl.Free;
  end;
end;
end.
