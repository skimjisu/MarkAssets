unit uAddInventory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCCustomPicker,
  VCL.TMSFNCComboBox, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, DBProce, Common;

type
  TAddFrm = class(TForm)
    MainPanel: TPanel;
    AssetCode_lb: TLabel;
    Label2: TLabel;
    Serial_lb: TLabel;
    Model_lb: TLabel;
    AssetID_lb: TLabel;
    Type_lb: TLabel;
    Add_Btn: TSpeedButton;
    Cancel_Btn: TSpeedButton;
    pnl_Top: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    AssetCodePanel: TPanel;
    Shape1: TShape;
    AessetEdit: TEdit;
    SerialPanel: TPanel;
    Shape2: TShape;
    SerialEdit: TEdit;
    ModelPanel: TPanel;
    Shape3: TShape;
    ModelEdit: TEdit;
    AssetIDPanel: TPanel;
    Shape4: TShape;
    Edit4: TEdit;
    TypePanel: TPanel;
    TypeCombo: TTMSFNCComboBox;
    Contract_lb: TLabel;
    ContractPanel: TPanel;
    Shape5: TShape;
    ContractEdit: TEdit;
    EndDate_lb: TLabel;
    EndDatePanel: TPanel;
    Shape6: TShape;
    EndDateEdit: TEdit;

    procedure pnl_TopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Cancel_BtnClick(Sender: TObject);
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

procedure TAddFrm.Cancel_BtnClick(Sender: TObject);
begin
  close
end;

end.
