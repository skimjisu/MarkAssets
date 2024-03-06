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
        ShowMessage('로그인에 성공하였습니다.');
        // 로그인 성공 후 처리할 로직을 여기에 추가하세요.
      end;

      LoginControl.OnLoginFailure := procedure(Sender: TObject)
      begin
        LoginControl.CreateUser(UsernameField.Text, PasswordField.Text);
        ShowMessage('계정이 생성되었습니다. 다시 로그인해 주세요.');
        // 계정 생성 후 처리할 로직을 여기에 추가하세요.
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
    //ShowMessage(Format('%s님, 로그인에 성공하였습니다.', [Username]));
    LoggedUser := Username;
    self.ModalResult := mrOk;
  end;
end;

procedure TLoginfrm.LoginFailure(Sender: TObject; const Username: string; const IsSuccess: Boolean);
begin
  if not IsSuccess then
  begin
    ShowMessage(Format('%s님, 로그인에 실패하였습니다. 사용자 이름 또는 비밀번호를 확인하세요.', [Username]));
  end;
end;

procedure TLoginfrm.LoginButtonClick(Sender: TObject);
var
  DBProce: TDBProce;
  LoginControl: TLoginControl;
  Username, Password: string;
  DBName: string;
begin
  DBName := 'MarkDB'; // 데이터베이스 이름을 설정합니다.
  DBProce := TDBProce.Create(DBName);
  LoginControl := TLoginControl.Create(DBProce);

  try
    Username := UsernameField.Text;
    Password := PasswordField.Text;

    // 로그인 성공 이벤트 핸들러를 설정합니다.
    LoginControl.OnLoginSuccess := LoginSuccess;

    // 로그인 실패 이벤트 핸들러를 설정합니다.
    LoginControl.OnLoginFailure := LoginFailure;

    // 로그인을 처리합니다.
    LoginControl.Login(Username, Password);
  finally
    LoginControl.Free;
    DBProce.Free;
  end;
end;



end.
