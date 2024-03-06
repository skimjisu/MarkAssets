unit AddInventoryFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCCustomPicker,
  VCL.TMSFNCComboBox, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, DBProce, Common;

type
  TAddFrm = class(TForm)
    Panel1: TPanel;
    Label13: TLabel;
    Label2: TLabel;
    Price_LB: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    pnl_Top: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    ProductName_pn: TPanel;
    Shape1: TShape;
    AessetEdit: TEdit;
    ProductPrice_pn: TPanel;
    Shape2: TShape;
    SerialEdit: TEdit;
    Panel4: TPanel;
    Shape3: TShape;
    ModelEdit: TEdit;
    Panel5: TPanel;
    Shape4: TShape;
    Edit4: TEdit;
    Panel3: TPanel;
    TypeCombo: TTMSFNCComboBox;
    Label6: TLabel;
    Panel6: TPanel;
    Shape5: TShape;
    ContractEdit: TEdit;
    Label7: TLabel;
    Panel7: TPanel;
    Shape6: TShape;
    EndDateEdit: TEdit;

    procedure pnl_TopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddFrm: TAddFrm;

implementation

{$R *.dfm}

procedure TAddFrm.pnl_TopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TAddFrm.SpeedButton2Click(Sender: TObject);
begin
  close
end;

end.
