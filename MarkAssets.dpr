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
  uFactory in 'view\uFactory.pas',
  uInventory in 'view\uInventory.pas' {InvFrm},
  uAddInventory in 'view\uAddInventory.pas' {AddFrm},
  DataStruct in 'Model\DataStruct.pas',
  uDataHandler in 'model\uDataHandler.pas',
  Vcl.Themes,
  Vcl.Styles,
  uDBConnect in 'model\uDBConnect.pas',
  AccountHandler in 'model\AccountHandler.pas' {/uDBInfofrm in 'view\uDBInfofrm.pas' {DBInfofrm},
  uAssets in 'view\uAssets.pas' {AssetsFrm},
  uLogManager in 'model\uLogManager.pas';

//uDBInfofrm in 'view\uDBInfofrm.pas' {DBInfofrm};

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
      Application.CreateForm(TMainfrm, Mainfrm);
  Application.CreateForm(TAssetsFrm, AssetsFrm);
  // Application.CreateForm(TDBInfofrm, DBInfofrm);
  // 메인 폼을 생성합니다.
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
