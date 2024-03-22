unit uAssets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, DBProce, RoundProce, Data.DB, FireDAC.Comp.Client,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCGridCell, VCL.TMSFNCGridOptions,
  VCL.TMSFNCCustomControl, VCL.TMSFNCCustomScrollControl, VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGrid, Vcl.StdCtrls, Vcl.ExtCtrls, VCL.TMSFNCCustomComponent,
  VCL.TMSFNCGridDatabaseAdapter;

type
  TAssetsFrm = class(TForm)
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
    DataGrid: TTMSFNCGrid;
    procedure FormCreate(Sender: TObject);
  private
    FDBProce: TDBProce;
    DataSource: TDataSource;
    Query: TFDQuery;
    Adapter: TTMSFNCGridDatabaseAdapter;
  public
    { Public declarations }
    function LoadData: Boolean;
  end;

var
  AssetsFrm: TAssetsFrm;

implementation

{$R *.dfm}

procedure TAssetsFrm.FormCreate(Sender: TObject);
begin
  SetRoundedCorners(self.Handle, TRoundedWindowCornerType(2));
  FDBProce := TDBProce.GetInstance; // TFDConnection �ν��Ͻ�
  DataSource := TDataSource.Create(nil); // TDataSource �ν��Ͻ� ����
  Adapter := TTMSFNCGridDatabaseAdapter.Create(nil);
end;

function TAssetsFrm.LoadData: Boolean;
begin
  Result := False; // �⺻������ ���з� ����
  try
    Query := FDBProce.LoadDataWithTransaction('assets'); // ������ �ε�
    Query.Refresh; // ������ �����Ͽ� ������ �ε�

    DataSource.DataSet := Query; // Query�� DataSource�� ����
    Adapter.DataSource := DataSource; // DataSource�� TMSFNCGridDatabaseAdapter�� ����
    Adapter.Grid := DataGrid; // TMSFNCGridDatabaseAdapter�� TMSFNCGrid ����
    Adapter.Active := True; // TMSFNCGridDatabaseAdapter Ȱ��ȭ�ϱ�

    Result := True; // ������ �ε��� ���������� ��Ÿ��
  except
    on E: Exception do
    begin
      ShowMessage('������ �ε� �� ���� �߻�: ' + E.Message); // ����ڿ��� ���� �޽��� ǥ��
    end;
  end;
end;

end.
