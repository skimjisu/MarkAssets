unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Hash, DataStruct, RoundProce, uDBConnect,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.VirtualImage, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, LoginProce, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI, DBProce, uMain, Vcl.Imaging.pngimage, Vcl.BaseImageCollection, Vcl.ImageCollection, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList;

type
  TLoginfrm = class(TForm)
    MainPanel: TPanel;
    UsernameField: TLabeledEdit;
    PasswordField: TLabeledEdit;
    LogoPanel: TPanel;
    LoginPanel: TPanel;
    LoginButton: TSpeedButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Image1: TImage;
    VirtualImage1: TVirtualImage;
    VirtualImageList1: TVirtualImageList;
    ImageCollection1: TImageCollection;
    procedure LoginButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VirtualImage1Click(Sender: TObject);
    procedure MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    FDBProce: TDBProce;
    LoginControl: TLoginControl;


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

procedure TLoginfrm.FormCreate(Sender: TObject);
begin
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));
  // 애플리케이션 시작 시 데이터베이스 연결 초기화
  FDBProce := TDBProce.GetInstance;
  FDBProce.Connect('C:\Users\KDHS\Desktop\MarkAssets\MarkAssets\Win32\Release\ConnectionDef.ini');    // 추후 외부 데이터 연결로 변경예정

  // 로그인 컨트롤 인스턴스 생성
  LoginControl := TLoginControl.Create(FDBProce.GetInstance.FDConnection);
  LoginControl.OnLoginSuccess := LoginSuccess;
  LoginControl.OnLoginFailure := LoginFailure;
end;

procedure TLoginfrm.FormDestroy(Sender: TObject);
begin
  //FLoginControl.Free;
end;

procedure TLoginfrm.LoginSuccess(Sender: TObject; const Username: string; const IsSuccess: Boolean);
begin
  if IsSuccess then
  begin
    //ShowMessage(Format('%s님, 로그인에 성공하였습니다.', [Username]));

    LoggedUser := Username;
    self.ModalResult := mrOk;
  end;
end;
procedure TLoginfrm.MoveForm(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;


procedure TLoginfrm.VirtualImage1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginfrm.LoginFailure(Sender: TObject; const Username: string; const IsSuccess: Boolean);
begin
  if not IsSuccess then
  begin
    MessageDlg(Format('%s님, 로그인에 실패하였습니다. 사용자 이름 또는 비밀번호를 확인하세요.', [Username]), mtWarning, [mbOK], 0);
  end;
end;

procedure TLoginfrm.LoginButtonClick(Sender: TObject);
var
  Username, Password: string;
begin
  try
    // 입력 값 검증
    Username := UsernameField.Text;
    Password := PasswordField.Text;
    if (Username = '') or (Password = '') then
    begin
      ShowMessage('사용자 이름과 비밀번호를 입력해주세요.');
      Exit; // 입력 값이 비어 있으면 여기서 처리를 중단합니다.
    end;

    // 로그인 시도
    LoginControl.Login(Username, Password);
  except
    on E: Exception do
      ShowMessage('오류 발생: ' + E.Message);
  end;
end;







end.
