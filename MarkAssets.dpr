program MarkAssets;

uses
  Vcl.Forms,
  System.SysUtils,
  FireDAC.Comp.UI,
  DBProce in 'Controller\DBProce.pas',
  LoginControl in 'Controller\LoginControl.pas',
  LoginUnit in 'LoginUnit.pas' {Loginfrm},
  MainUnit in 'MainUnit.pas' {Mainfrm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //TFDGUIxWaitCursor.RegisterProvider;
 // Application.CreateForm(TLoginfrm, Loginfrm);
  LoginFrm := TLoginFrm.Create(Nil);
  LoginFrm.ShowModal;
  Application.CreateForm(TMainfrm, Mainfrm);
  Application.Run;
end.
