unit LoginUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Common, System.Hash,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.VirtualImage, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, LoginProce, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
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
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
    FDBProce: TDBProce;
    procedure LoginSuccess(Sender: TObject; const Username: string; const IsSuccess: Boolean);
    procedure LoginFailure(Sender: TObject; const Username: string; const IsSuccess: Boolean);

  public
    { Public declarations }

  public

  end;

var
  Loginfrm: TLoginfrm;

implementation

{$R *.dfm}

procedure TLoginfrm.FormDestroy(Sender: TObject);
begin
  //FLoginControl.Free;
end;

{
  procedure TLoginfrm.LoginButtonClick(Sender: TObject);
  var
    LoginControl: TLoginControl;
  begin
    LoginControl := TLoginControl.Create(DBPath);
    try
      LoginControl.OnLoginSuccess := procedure(Sender: TObject)
      begin
        ShowMessage('�α��ο� �����Ͽ����ϴ�.');
        // �α��� ���� �� ó���� ������ ���⿡ �߰��ϼ���.
      end;

      LoginControl.OnLoginFailure := procedure(Sender: TObject)
      begin
        LoginControl.CreateUser(UsernameField.Text, PasswordField.Text);
        ShowMessage('������ �����Ǿ����ϴ�. �ٽ� �α����� �ּ���.');
        // ���� ���� �� ó���� ������ ���⿡ �߰��ϼ���.
      end;

      LoginControl.Login(UsernameField.Text, PasswordField.Text);
    finally
      LoginControl.Free;
    end;
  end;
}

procedure TLoginfrm.LoginSuccess(Sender: TObject; const Username: string; const IsSuccess: Boolean);
begin
  if IsSuccess then
  begin
    //ShowMessage(Format('%s��, �α��ο� �����Ͽ����ϴ�.', [Username]));
    LoggedUser := Username;
    self.ModalResult := mrOk;
  end;
end;

procedure TLoginfrm.LoginFailure(Sender: TObject; const Username: string; const IsSuccess: Boolean);
begin
  if not IsSuccess then
  begin
    ShowMessage(Format('%s��, �α��ο� �����Ͽ����ϴ�. ����� �̸� �Ǵ� ��й�ȣ�� Ȯ���ϼ���.', [Username]));
  end;
end;

procedure TLoginfrm.LoginButtonClick(Sender: TObject);
var
  DBProce: TDBProce;
  LoginControl: TLoginControl;
  Username, Password: string;
  DBName: string;
begin
  DBName := 'MarkDB'; // �����ͺ��̽� �̸��� �����մϴ�.
  DBProce := TDBProce.Create(DBName);
  LoginControl := TLoginControl.Create(DBProce);

  try
    Username := UsernameField.Text;
    Password := PasswordField.Text;

    // �α��� ���� �̺�Ʈ �ڵ鷯�� �����մϴ�.
    LoginControl.OnLoginSuccess := LoginSuccess;

    // �α��� ���� �̺�Ʈ �ڵ鷯�� �����մϴ�.
    LoginControl.OnLoginFailure := LoginFailure;

    // �α����� ó���մϴ�.
    LoginControl.Login(Username, Password);
  finally
    LoginControl.Free;
    DBProce.Free;
  end;
end;



end.
