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
  FDBProce := TDBProce.GetInstance; // TFDConnection 인스턴스
  InvSource := TDataSource.Create(nil); // TDataSource 인스턴스 생성
  Adapter := TTMSFNCGridDatabaseAdapter.Create(nil);

end;

procedure TInvFrm.FormDestroy(Sender: TObject);
begin
  //
end;

function TInvFrm.LoadData: Boolean;
begin
  Result := False; // 기본적으로 실패로 가정
  try
    Query := FDBProce.LoadDataWithTransaction('inventory'); // 데이터 로드
    Query.Refresh; // 쿼리를 갱신하여 데이터 로드

    InvSource.DataSet := Query; // Query를 DataSource에 연결
    Adapter.DataSource := InvSource; // DataSource를 TMSFNCGridDatabaseAdapter에 연결
    Adapter.Grid := TMSFNCGrid1; // TMSFNCGridDatabaseAdapter에 TMSFNCGrid 연결
    Adapter.Active := True; // TMSFNCGridDatabaseAdapter 활성화하기

    Result := True; // 데이터 로딩이 성공했음을 나타냄
  except
    on E: Exception do
    begin
      ShowMessage('데이터 로딩 중 오류 발생: ' + E.Message); // 사용자에게 오류 메시지 표시
    end;
  end;
end;

procedure TInvFrm.FormShow(Sender: TObject);
begin
  if not FDataLoaded then // 데이터가 아직 로드되지 않았다면...
  begin
    if LoadData then // 별도의 메서드로 분리된 데이터 로딩 로직 호출
    begin
      FDataLoaded := True; // 데이터 로드 플래그 업데이트
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
