unit uInventory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, RoundProce, FireDAC.Stan.Param,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.TMSFNCTypes, Vcl.TMSFNCUtils, Vcl.TMSFNCGraphics, Vcl.TMSFNCGraphicsTypes, Vcl.TMSFNCGridCell,
  Vcl.TMSFNCGridOptions, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope,
  Vcl.TMSFNCCustomControl, Vcl.TMSFNCCustomScrollControl, Vcl.TMSFNCGridData, Vcl.TMSFNCCustomGrid, Vcl.TMSFNCGrid, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.TMSFNCCustomComponent, DBProce,
  Vcl.TMSFNCGridDatabaseAdapter, Vcl.Grids, Data.DB, Vcl.DBGrids, Common, uDataHandler, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.TMSFNCDataBinding;

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
    TMSFNCGrid1: TTMSFNCGrid;
    procedure AddBtnClick(Sender: TObject);
    procedure SearchBtmClick(Sender: TObject);
    // procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FDBProce: TDBProce;
    InvSource: TDataSource;
    Query: TFDQuery;
    Adapter: TTMSFNCGridDatabaseAdapter;
    FDataLoaded: Boolean;
  public
    { Public declarations }
    function LoadData: Boolean;
  end;

var
  InvFrm: TInvFrm;

implementation

uses
  uAddInventory;

{$R *.dfm}

procedure TInvFrm.FormCreate(Sender: TObject);
begin
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));
  FDBProce := TDBProce.GetInstance; // TFDConnection �ν��Ͻ�
  InvSource := TDataSource.Create(nil); // TDataSource �ν��Ͻ� ����
  Adapter := TTMSFNCGridDatabaseAdapter.Create(nil);

end;

procedure TInvFrm.FormDestroy(Sender: TObject);
begin
  //
end;

function TInvFrm.LoadData: Boolean;
begin
  Result := False; // �⺻������ ���з� ����
  try
    Query := FDBProce.LoadDataWithTransaction('inventory'); // ������ �ε�
    Query.Refresh; // ������ �����Ͽ� ������ �ε�

    InvSource.DataSet := Query; // Query�� DataSource�� ����
    Adapter.DataSource := InvSource; // DataSource�� TMSFNCGridDatabaseAdapter�� ����
    Adapter.Grid := TMSFNCGrid1; // TMSFNCGridDatabaseAdapter�� TMSFNCGrid ����
    Adapter.Active := True; // TMSFNCGridDatabaseAdapter Ȱ��ȭ�ϱ�

    Result := True; // ������ �ε��� ���������� ��Ÿ��
  except
    on E: Exception do
    begin
      ShowMessage('������ �ε� �� ���� �߻�: ' + E.Message); // ����ڿ��� ���� �޽��� ǥ��
    end;
  end;
end;

procedure TInvFrm.FormShow(Sender: TObject);
begin
  if not FDataLoaded then // �����Ͱ� ���� �ε���� �ʾҴٸ�...
  begin
    if LoadData then // ������ �޼���� �и��� ������ �ε� ���� ȣ��
    begin
      FDataLoaded := True; // ������ �ε� �÷��� ������Ʈ
    end;
  end;
end;

procedure TInvFrm.AddBtnClick(Sender: TObject);
begin
  if AddFrm.ShowModal = mrOk then
    Query.Refresh;
end;

procedure TInvFrm.SearchBtmClick(Sender: TObject);
begin
  // ConnectTable;
end;

end.
