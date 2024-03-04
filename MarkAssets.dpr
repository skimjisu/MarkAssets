program MarkAssets;

uses
  Vcl.Forms,
  System.SysUtils,
  FireDAC.Comp.UI,
  DBProce in 'Controller\DBProce.pas',
  LoginProce in 'Controller\LoginProce.pas',
  LoginUnit in 'LoginUnit.pas' {Loginfrm},
  MainUnit in 'MainUnit.pas' {Mainfrm},
  Common in 'Common.pas',
  RoundProce in 'Controller\RoundProce.pas',
  DashboardFrm in 'view\DashboardFrm.pas' {DashbdFrm},
  FactoryProce in 'Controller\FactoryProce.pas',
  InventoryFrm in 'view\InventoryFrm.pas' {InvFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //TFDGUIxWaitCursor.RegisterProvider;
 // Application.CreateForm(TLoginfrm, Loginfrm);
  LoginFrm := TLoginFrm.Create(Nil);
  LoginFrm.ShowModal;
  Application.CreateForm(TMainfrm, Mainfrm);
  Application.CreateForm(TDashbdFrm, DashbdFrm);
  Application.CreateForm(TInvFrm, InvFrm);
  Application.Run;
end.
