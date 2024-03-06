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
    if LoginFrm.ShowModal = mrOk then // 로그인 폼이 성공적으로 닫히면
    begin
      Application.CreateForm(TMainfrm, Mainfrm); // 메인 폼을 생성합니다.
      Application.CreateForm(TDashbdFrm, DashbdFrm); // 추가 폼을 생성합니다.
      Application.CreateForm(TInvFrm, InvFrm); // 추가 폼을 생성합니다.
      Application.CreateForm(TAddFrm, AddFrm); // 추가 폼을 생성합니다.
      Application.Run; // 애플리케이션을 실행합니다.
    end
    else
    begin
      Application.Terminate; // 애플리케이션을 종료합니다.
    end;
  finally
    LoginFrm.Free; // 로그인 폼을 해제합니다.
  end;
end.
