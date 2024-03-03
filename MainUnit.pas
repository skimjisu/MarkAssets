unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.ComCtrls, FactoryProce,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.Imaging.pngimage, Vcl.Buttons, LoginProce, Common, RoundProce, DashboardFrm;

type
  TMainfrm = class(TForm)
    Menu_pn: TPanel;
    Image2: TImage;
    Label3: TLabel;
    Image3: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Image4: TImage;
    Label6: TLabel;
    Image5: TImage;
    Label7: TLabel;
    Image6: TImage;
    Label8: TLabel;
    Image7: TImage;
    Label10: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Label9: TLabel;
   // Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ChangeLabelOnMouseEnter(Sender: TObject);
    procedure ChangeLabelOnMouseLeave(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure ChangeLabel;
  end;

var
  Mainfrm: TMainfrm;

implementation

{$R *.dfm}


procedure TMainfrm.ChangeLabelOnMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := $000080FF;
  TLabel(Sender).Font.Style := [fsBold];
end;

procedure TMainfrm.ChangeLabelOnMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clWhite;
  TLabel(Sender).Font.Style := [];
end;

procedure TMainfrm.ChangeLabel;
var
  i: Integer;
  labelName: String;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TLabel then
    begin
      labelName := TLabel(Components[i]).Name;
      if (labelName = 'Label3') or (labelName = 'Label4') or
         (labelName = 'Label6') or (labelName = 'Label7') or
         (labelName = 'Label8') or (labelName = 'Label10') then
      begin
        TLabel(Components[i]).OnMouseEnter := ChangeLabelOnMouseEnter;
        TLabel(Components[i]).OnMouseLeave := ChangeLabelOnMouseLeave;
      end;
    end;
  end;
end;


procedure TMainfrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := caFree;
end;

(*
  procedure TMainfrm.FormCreate(Sender: TObject);
  const
    TabNames: array[0..5] of string = ('Dashboard', 'Inventory', 'List', 'Service', 'Admin', 'Users');
  var
    ViewPanel: TPanel;
    PageControl: TPageControl;
    DashbdFrm: TDashbdFrm;
    I: Integer;
  begin
    SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));

    // TPanel 积己
    ViewPanel := TPanel.Create(Self);
    with ViewPanel do
    begin
      Parent := Self;
      Align := alClient;
      BorderStyle := bsNone;
    end;

    // TPageControl 积己
    PageControl := TPageControl.Create(ViewPanel);
    with PageControl do
    begin
      Parent          := ViewPanel;
      Align           := alClient;
      MultiLine       := True;
      ScrollOpposite  := True;
      TabWidth        := 100;
      TabHeight       := 20;

      // 阿 徘 积己
      for I := Low(TabNames) to High(TabNames) do
        with TTabSheet.Create(PageControl) do
        begin
          PageControl := Self.Parent as TPageControl;
          Caption := TabNames[I];

          // 'Dashboard' 徘俊 措茄 贸府
          if I = 0 then
          begin
            DashbdFrm := TDashbdFrm.Create(Self);
            with DashbdFrm do
            begin
              Parent := Self;
              Align := alClient;
              Visible := True;
            end;
          end;
        end;

      ActivePageIndex := 0;
    end;
  end;
*)
procedure TMainfrm.FormCreate(Sender: TObject);
const
  TabNames: array[0..5] of string = ('Dashboard', 'Inventory', 'List', 'Service', 'Admin', 'Users');
var
  ViewPanel: TPanel;
  PageControl: TPageControl;
  I: Integer;
begin
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));
  ChangeLabel;
  ViewPanel := TControlFactory.CreateAndSetupPanel(Self);
  PageControl := TControlFactory.CreateAndSetupPageControl(ViewPanel);

  for I := Low(TabNames) to High(TabNames) do
    with TControlFactory.CreateAndSetupTabSheet(PageControl, TabNames[I]) do
      if I = 0 then
        TDashbdFrmFactory.CreateAndSetupDashbdFrm(Self);

  PageControl.ActivePageIndex := 0;
end;

procedure TMainfrm.FormShow(Sender: TObject);
begin
  SpeedButton2.Caption := LoggedUser;
end;

procedure TMainfrm.Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $F012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TMainfrm.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TMainfrm.SpeedButton1Click(Sender: TObject);
begin
  application.Terminate;
end;

end.
