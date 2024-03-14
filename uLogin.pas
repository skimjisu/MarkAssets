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
    //FConnectInfo: TConnectInfo;
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
end;

procedure TLoginfrm.FormDestroy(Sender: TObject);
begin
  //FLoginControl.Free;
end;

procedure TLoginfrm.LoginSuccess(Sender: TObject; const Username: string; const IsSuccess: Boolean);
begin
  if IsSuccess then
  begin
    //ShowMessage(Format('%s��, �α��ο� �����Ͽ����ϴ�.', [Username]));

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
    MessageDlg(Format('%s��, �α��ο� �����Ͽ����ϴ�. ����� �̸� �Ǵ� ��й�ȣ�� Ȯ���ϼ���.', [Username]), mtWarning, [mbOK], 0);
  end;
end;

procedure TLoginfrm.LoginButtonClick(Sender: TObject);
var
  LoginControl: TLoginControl;
  Username, Password: string;
begin
  try
    FDBProce := TDBProce.GetInstance;
    LoginControl := TLoginControl.Create(FDBProce);

    // �Է� �� ���� �߰�
    Username := UsernameField.Text;
    Password := PasswordField.Text;
    if (Username = '') or (Password = '') then
    begin
      ShowMessage('����� �̸��� ��й�ȣ�� �Է����ּ���.');
      Exit; // �Է� ���� ��� ������ ���⼭ ó���� �ߴ��մϴ�.
    end;

    FDBProce.Connect('C:\Users\KDHS\Desktop\MarkAssets\MarkAssets\Win32\Release\ConnectionDef.ini');

    try
      LoginControl.OnLoginSuccess := LoginSuccess;
      LoginControl.OnLoginFailure := LoginFailure;
      LoginControl.Login(Username, Password);
    finally
      LoginControl.Free;
    end;
  except
    on E: Exception do
      ShowMessage('���� �߻�: ' + E.Message);
  end;
end;







end.
