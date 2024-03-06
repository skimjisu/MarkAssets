unit uInventory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, RoundProce,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCGridCell, VCL.TMSFNCGridOptions,
  VCL.TMSFNCCustomControl, VCL.TMSFNCCustomScrollControl, VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGrid, Vcl.StdCtrls, Vcl.ExtCtrls, VCL.TMSFNCCustomComponent, DBProce,
  VCL.TMSFNCGridDatabaseAdapter, Vcl.Grids,uAddInventory, Data.DB, Vcl.DBGrids, Common, uDataHandler, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt;

type
  TInvFrm = class(TForm)
    InvPanel: TPanel;
    DecLB: TLabel;
    NoticeLB: TLabel;
    pnl_Top: TPanel;
    InvTitle: TLabel;
    LineHeader: TPanel;
    FindPanel: TPanel;
    FindED_Shape: TShape;
    FindED: TEdit;
    SearchBtm: TPanel;
    AddBtn: TPanel;
    InvGrid: TTMSFNCGrid;
    procedure AddBtnClick(Sender: TObject);
    procedure SearchBtmClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    DBProce: TDBProce;
    Adapter: TTMSFNCGridDatabaseAdapter;
    DataHandler: TDataHandler;
  public
    { Public declarations }
  end;

var
  InvFrm: TInvFrm;

implementation

{$R *.dfm}

procedure TInvFrm.FormCreate(Sender: TObject);
begin
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));
end;

procedure TInvFrm.FormDestroy(Sender: TObject);
begin
  Adapter.Free;
end;

procedure TInvFrm.FormShow(Sender: TObject);
begin
  DBProce := TDBProce.GetInstance;
  Adapter := TTMSFNCGridDatabaseAdapter.Create(Self);
  try
    DBProce.ConnectTableToGrid('Inventory', InvGrid, Adapter);
  finally
   // Adapter.Free;
  end;
end;

procedure TInvFrm.AddBtnClick(Sender: TObject);
begin
  uAddInventory.AddFrm.ShowModal;
end;

procedure TInvFrm.SearchBtmClick(Sender: TObject);
begin
//
end;

end.
