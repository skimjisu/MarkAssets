unit AddInventoryFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCCustomPicker,
  VCL.TMSFNCComboBox, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

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
    Edit1: TEdit;
    ProductPrice_pn: TPanel;
    Shape2: TShape;
    Edit2: TEdit;
    Panel4: TPanel;
    Shape3: TShape;
    Edit3: TEdit;
    Panel5: TPanel;
    Shape4: TShape;
    Edit4: TEdit;
    Panel3: TPanel;
    TMSFNCComboBox1: TTMSFNCComboBox;
    SpeedButton3: TSpeedButton;
    Label6: TLabel;
    Panel6: TPanel;
    Shape5: TShape;
    Edit5: TEdit;
    Label7: TLabel;
    Panel7: TPanel;
    Shape6: TShape;
    Edit6: TEdit;
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddFrm: TAddFrm;

implementation

{$R *.dfm}

procedure TAddFrm.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

end.
