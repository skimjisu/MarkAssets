unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.ComCtrls, uFactory, uInventory, DataStruct, uAssets,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.Imaging.pngimage, Vcl.Buttons, LoginProce, Common, RoundProce, uDashboard, DBProce,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TMainfrm = class(TForm)
    MenuPanel: TPanel;
    Customer_Img: TImage;
    Customer_lb: TLabel;
    Inv_Img: TImage;
    Inv_lb: TLabel;
    Nil_lb: TLabel;
    History_Img: TImage;
    History_lb: TLabel;
    Status_Img: TImage;
    Status_lb: TLabel;
    Set_Img: TImage;
    Service_lb: TLabel;
    Dash_Img: TImage;
    Dash_lb: TLabel;
    BarPanel: TPanel;
    UserBtn: TSpeedButton;
    NameLB: TLabel;
    Label2: TLabel;
    Image1: TImage;
    subNameLB: TLabel;
    PagePanel: TPanel;
    CloseBtn: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    SetBtn: TButton;
   // Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BarPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BarPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ChangeLabelOnMouseEnter(Sender: TObject);
    procedure ChangeLabelOnMouseLeave(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure UserBtnClick(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure BarPanelDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);

  private
    FPageControl: TPageControl;
    FDBProce: TDBProce;
    procedure CreateFormInTab(TabCaption: string; FormClass: TFormClass);
    //procedure CreateInventoryFormAndLoadData;
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

procedure TMainfrm.CloseBtnClick(Sender: TObject);
begin
  Application.Terminate;
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

procedure TMainFrm.CreateFormInTab(TabCaption: string; FormClass: TFormClass);
var
  TabSheet: TTabSheet;
  i: integer;
begin
  TabSheet := TControlFactory.CreateAndSetupTabSheet(FPageControl, TabCaption);
  TControlFactory.CreateAndSetupForm(TabSheet, FormClass);

  for i := 0 to FPageControl.PageCount - 1 do FPageControl.Pages[i].TabVisible := False;
end;

procedure TMainfrm.FormCreate(Sender: TObject);
begin
  ChangeLabel;
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));

  FPageControl := TControlFactory.CreateAndSetupPageControl(self.PagePanel);

  CreateFormInTab('Dashboard', TDashbdFrm);
  CreateFormInTab('Inventory', TInvFrm);
  CreateFormInTab('Assets', TAssetsFrm);

  Application.ProcessMessages;
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
  UserBtn.Caption := LoggedUser;

end;

procedure TMainfrm.Label10Click(Sender: TObject);
begin
  FPageControl.ActivePageIndex := 0;
end;

procedure TMainfrm.Label4Click(Sender: TObject);
begin
  FPageControl.ActivePageIndex := 1;
end;

procedure TMainfrm.BarPanelDblClick(Sender: TObject);
begin
  if self.WindowState = wsMaximized then self.WindowState := wsNormal
  else self.WindowState := wsMaximized;
end;

procedure TMainfrm.BarPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $F012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TMainfrm.BarPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TMainfrm.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainfrm.UserBtnClick(Sender: TObject);
begin
 // ImportCSVIntoDB('C:\Users\KDHS\Downloads\1234.csv');
end;

end.
