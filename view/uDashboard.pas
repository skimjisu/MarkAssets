unit uDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, CurvyControls,
  Vcl.ComCtrls, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TDashbdFrm = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    pnl_Top: TPanel;
    Label6: TLabel;
    Panel3: TPanel;
    Memo2: TMemo;
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
