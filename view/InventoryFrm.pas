unit InventoryFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCGridCell, VCL.TMSFNCGridOptions,
  VCL.TMSFNCCustomControl, VCL.TMSFNCCustomScrollControl, VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGrid, Vcl.StdCtrls, Vcl.ExtCtrls, VCL.TMSFNCCustomComponent,
  VCL.TMSFNCGridDatabaseAdapter, Vcl.Grids,AddInventoryFrm;

type
  TInvFrm = class(TForm)
    Panel1: TPanel;
    Label13: TLabel;
    Label2: TLabel;
    pnl_Top: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Panel5: TPanel;
    Shape1: TShape;
    Edit1: TEdit;
    Panel7: TPanel;
    Panel3: TPanel;
    StringGrid1: TStringGrid;
    procedure Panel3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvFrm: TInvFrm;

implementation

{$R *.dfm}

procedure TInvFrm.Panel3Click(Sender: TObject);
begin
  AddInventoryFrm.AddFrm.ShowModal;
end;

end.
