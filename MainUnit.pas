unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.ComCtrls, FactoryProce, InventoryFrm,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.Imaging.pngimage, Vcl.Buttons, LoginProce, Common, RoundProce, DashboardFrm, DBProce;

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
    PagePanel: TPanel;
   // Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ChangeLabelOnMouseEnter(Sender: TObject);
    procedure ChangeLabelOnMouseLeave(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    FPageControl: TPageControl;
    FDBProce: TDBProce;
    procedure CreateFormInTab(TabCaption: string; FormClass: TFormClass);
    procedure CreateInventoryFormAndLoadData;
  public
   //
  public
    { Public declarations }
    procedure ChangeLabel;
  end;

var
  Mainfrm: TMainfrm;
  DashbdFrm: TDashbdFrm;
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
const
  TargetLabelNames: array[0..5] of string =
    ('Label3', 'Label4', 'Label6', 'Label7', 'Label8', 'Label10');
var
  i, j: Integer;
  currentLabel: TLabel;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TLabel then
    begin
      currentLabel := TLabel(Components[i]);
      for j := Low(TargetLabelNames) to High(TargetLabelNames) do
      begin
        if currentLabel.Name = TargetLabelNames[j] then
        begin
          currentLabel.OnMouseEnter := ChangeLabelOnMouseEnter;
          currentLabel.OnMouseLeave := ChangeLabelOnMouseLeave;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TMainfrm.CreateInventoryFormAndLoadData;
var
  InventoryForm: TInvFrm;
begin
  // Get the instance of InventoryForm
  InventoryForm := TInvFrm(FPageControl.ActivePage.Controls[0]);

  // Using TDBProce to load data into the grid
  if Assigned(InventoryForm.TMSFNCGrid1) then
    TDBProce.GetInstance(DB_Name).LoadDataIntoFNCGrid(InventoryForm.TMSFNCGrid1);
end;

procedure TMainFrm.CreateFormInTab(TabCaption: string; FormClass: TFormClass);
var
  TabSheet: TTabSheet;
  i: integer;
begin
  TabSheet := TControlFactory.CreateAndSetupTabSheet(FPageControl, TabCaption);
  TControlFactory.CreateAndSetupForm(TabSheet, FormClass);

  for i := 0 to FPageControl.PageCount - 1 do
    FPageControl.Pages[i].TabVisible := False;
end;

procedure TMainfrm.FormCreate(Sender: TObject);
begin
  ChangeLabel;
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));

  FPageControl := TControlFactory.CreateAndSetupPageControl(self.PagePanel);

  // Create forms in tabs
  CreateFormInTab('Dashboard', TDashbdFrm);
  CreateFormInTab('Inventory', TInvFrm);
  // Process messages to complete the creation and initialization of the forms
  Application.ProcessMessages;

  // Then set the active page index
  FPageControl.ActivePageIndex := 0;
end;

procedure TMainfrm.FormDestroy(Sender: TObject);
begin
  FDBProce.Free;
end;

procedure TMainFrm.MenuClick(Sender: TObject);
var
  Ima: TImage;
  lb: TLabel;
begin
  if Sender is TImage then
  begin
    Ima := TImage(Sender);
    FPageControl.ActivePageIndex := Ima.Tag - 1;
  end
  else if Sender is TLabel then
  begin
    lb := TLabel(Sender);
    FPageControl.ActivePageIndex := lb.Tag - 1;
  end;
end;


procedure TMainfrm.FormShow(Sender: TObject);
begin
  SpeedButton2.Caption := LoggedUser;
end;

procedure TMainfrm.Label10Click(Sender: TObject);
begin
  FPageControl.ActivePageIndex := 0;
end;

procedure TMainfrm.Label4Click(Sender: TObject);
begin
  FPageControl.ActivePageIndex := 1;
end;

procedure TMainfrm.Panel1DblClick(Sender: TObject);
begin
  if self.WindowState = wsMaximized then self.WindowState := wsNormal
  else self.WindowState := wsMaximized;
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
  Application.Terminate;
end;

procedure TMainfrm.SpeedButton2Click(Sender: TObject);
begin
 // ImportCSVIntoDB('C:\Users\KDHS\Downloads\1234.csv');
end;

end.
