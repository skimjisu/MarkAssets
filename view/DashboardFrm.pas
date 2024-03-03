unit DashboardFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, CurvyControls,
  Vcl.ComCtrls, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TDashbdFrm = class(TForm)
    ImageCollection1: TImageCollection;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    CurvyPanel1: TCurvyPanel;
    Label1: TLabel;
    Image1: TImage;
    CurvyPanel2: TCurvyPanel;
    Label2: TLabel;
    Image2: TImage;
    CurvyPanel3: TCurvyPanel;
    Label3: TLabel;
    Image3: TImage;
    CurvyPanel4: TCurvyPanel;
    Label4: TLabel;
    Image4: TImage;
    CurvyPanel5: TCurvyPanel;
    Label5: TLabel;
    Image5: TImage;
    CurvyPanel6: TCurvyPanel;
    Label7: TLabel;
    Image6: TImage;
    CurvyPanel7: TCurvyPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    CurvyPanel8: TCurvyPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    CurvyPanel9: TCurvyPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    CurvyPanel10: TCurvyPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    CurvyPanel11: TCurvyPanel;
    HoursLabel: TLabel;
    MinsLabel: TLabel;
    SecsLabel: TLabel;
    CurvyPanel12: TCurvyPanel;
    Label20: TLabel;
    Label21: TLabel;
    ToggleSwitch1: TToggleSwitch;
    TabSheet2: TTabSheet;
    pnl_Top: TPanel;
    Label6: TLabel;
    Panel3: TPanel;
    Timer: TTimer;
    VirtualImageList1: TVirtualImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DashbdFrm: TDashbdFrm;

implementation

{$R *.dfm}

end.
