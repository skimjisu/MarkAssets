program MarkAssets;

uses
  Vcl.Forms,
  System.SysUtils,
  Vcl.Controls,
  FireDAC.Comp.UI,
  DBProce in 'Controller\DBProce.pas',
  LoginProce in 'Controller\LoginProce.pas',
  LoginUnit in 'LoginUnit.pas' {Loginfrm},
  MainUnit in 'MainUnit.pas' {Mainfrm},
  Common in 'Common.pas',
  RoundProce in 'Controller\RoundProce.pas',
  DashboardFrm in 'view\DashboardFrm.pas' {DashbdFrm},
  FactoryProce in 'Controller\FactoryProce.pas',
  InventoryFrm in 'view\InventoryFrm.pas' {InvFrm},
  AddInventoryFrm in 'view\AddInventoryFrm.pas' {AddFrm},
  DataStruct in 'Model\DataStruct.pas';

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
      Application.CreateForm(TMainfrm, Mainfrm); // ���� ���� �����մϴ�.
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
