program MarkAssets;

uses
  Vcl.Forms,
  System.SysUtils,
  Vcl.Controls,
  FireDAC.Comp.UI,
  DBProce in 'Controller\DBProce.pas',
  LoginProce in 'Controller\LoginProce.pas',
  uLogin in 'uLogin.pas' {Loginfrm},
  uMain in 'uMain.pas' {Mainfrm},
  Common in 'Common.pas',
  RoundProce in 'Controller\RoundProce.pas',
  uDashboard in 'view\uDashboard.pas' {DashbdFrm},
  FactoryProce in 'Controller\FactoryProce.pas',
  uInventory in 'view\uInventory.pas' {InvFrm},
  uAddInventory in 'view\uAddInventory.pas' {AddFrm},
  DataStruct in 'Model\DataStruct.pas',
  uDataHandler in 'model\uDataHandler.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //TFDGUIxWaitCursor.RegisterProvider;
  //Application.CreateForm(TLoginfrm, Loginfrm);
  LoginFrm := TLoginFrm.Create(Application);
  try
    if LoginFrm.ShowModal = mrOk then // �α��� ���� ���������� ������
    begin
      Application.CreateForm(TMainfrm, Mainfrm);
  // ���� ���� �����մϴ�.
      Application.CreateForm(TDashbdFrm, DashbdFrm); // �߰� ���� �����մϴ�.
      Application.CreateForm(TInvFrm, InvFrm); // �߰� ���� �����մϴ�.
      Application.CreateForm(TAddFrm, AddFrm); // �߰� ���� �����մϴ�.
      Application.Run; // ���ø����̼��� �����մϴ�.
    end
    else
    begin
      Application.Terminate; // ���ø����̼��� �����մϴ�.
    end;
  finally
    LoginFrm.Free; // �α��� ���� �����մϴ�.
  end;
end.
