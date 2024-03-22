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
  FDBProce := TDBProce.GetInstance; // TFDConnection 인스턴스
  DataSource := TDataSource.Create(nil); // TDataSource 인스턴스 생성
  Adapter := TTMSFNCGridDatabaseAdapter.Create(nil);
end;

function TAssetsFrm.LoadData: Boolean;
begin
  Result := False; // 기본적으로 실패로 가정
  try
    Query := FDBProce.LoadDataWithTransaction('assets'); // 데이터 로드
    Query.Refresh; // 쿼리를 갱신하여 데이터 로드

    DataSource.DataSet := Query; // Query를 DataSource에 연결
    Adapter.DataSource := DataSource; // DataSource를 TMSFNCGridDatabaseAdapter에 연결
    Adapter.Grid := DataGrid; // TMSFNCGridDatabaseAdapter에 TMSFNCGrid 연결
    Adapter.Active := True; // TMSFNCGridDatabaseAdapter 활성화하기

    Result := True; // 데이터 로딩이 성공했음을 나타냄
  except
    on E: Exception do
    begin
      ShowMessage('데이터 로딩 중 오류 발생: ' + E.Message); // 사용자에게 오류 메시지 표시
    end;
  end;
end;

end.
