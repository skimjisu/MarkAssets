unit InventoryFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCGridCell, VCL.TMSFNCGridOptions,
  VCL.TMSFNCCustomControl, VCL.TMSFNCCustomScrollControl, VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGrid, Vcl.StdCtrls, Vcl.ExtCtrls, VCL.TMSFNCCustomComponent, DBProce,
  VCL.TMSFNCGridDatabaseAdapter, Vcl.Grids,AddInventoryFrm, Data.DB, Vcl.DBGrids, Common;

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
    TMSFNCGrid1: TTMSFNCGrid;
    procedure Panel3Click(Sender: TObject);
   // procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvFrm: TInvFrm;

implementation

{$R *.dfm}



//procedure TInvFrm.FormShow(Sender: TObject);
//var
//  DBProce: TDBProce;
//begin
//  if Assigned(TMSFNCGrid1) then
//  begin
//    if not FileExists(DB_Name) then
//    begin
//      ShowMessage('�����ͺ��̽� ��ΰ� ��ȿ���� �ʽ��ϴ�: ' + DB_Name);
//      Exit;
//    end;
//
//    DBProce := TDBProce.GetInstance(DB_Name);
//    try
//      DBProce.LoadDataIntoFNCGrid(TMSFNCGrid1);
//    except
//      on E: Exception do
//        ShowMessage('������ �ε� �� ���� �߻�: ' + E.Message);
//    end;
//  end;
//end;

procedure TInvFrm.Panel3Click(Sender: TObject);
begin
  AddInventoryFrm.AddFrm.ShowModal;
end;

end.
