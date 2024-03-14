unit uDataHandler;

interface

uses
  Classes,
  System.SysUtils,
  DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  Vcl.Dialogs,
  DBProce,
  VCL.TMSFNCTypes,
  VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCGridCell,
  VCL.TMSFNCGridOptions,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  VCL.TMSFNCCustomControl,
  VCL.TMSFNCCustomScrollControl,
  VCL.TMSFNCGridData,
  VCL.TMSFNCCustomGrid,
  VCL.TMSFNCGrid,
  VCL.Forms,
  Data.Bind.Components,
  Data.Bind.DBScope,
  Data.Bind.Grid;


type
  TInventoryRecord = record
    AssetCode: string;
    SerialNumber: string;
    iType: string;
    ModelName: string;
    Contract: string;
    EndDate: string;
  end;

type
  TDataHandler = class
  private
    FDBProce: TDBProce;
    procedure AfterPostEvent(Sender: TDataSet);
  public

    constructor Create;
    destructor Destroy; override;

    procedure SetDataBindGrid(const TableName: string; Grid: TTMSFNCGrid);
   // procedure InsertData(const TableName: string; const Fields, Values: TStringList);
   // procedure LoadDataIntoGrid(const TableName: string; Grid: TTMSFNCGrid; Adapter: TTMSFNCGridDatabaseAdapter);
  end;

implementation

constructor TDataHandler.Create;
begin
  //FDBProce := TDBProce.GetInstance;
end;

destructor TDataHandler.Destroy;
begin
  inherited;
end;

procedure TDataHandler.AfterPostEvent(Sender: TDataSet);
begin
  ShowMessage('데이터가 성공적으로 업데이트 되었습니다.');
end;

procedure TDataHandler.SetDataBindGrid(const TableName: string; Grid: TTMSFNCGrid);
var
  FConnection: TFDConnection;
  FQuery: TFDQuery;
  BindSourceDB: TBindSourceDB;
  LinkGridToDataSource: TLinkGridToDataSource;
begin
  // TDBProce 싱글톤 인스턴스를 통해 데이터베이스 연결 및 설정
  FDBProce := TDBProce.GetInstance;

  // FireDAC 컴포넌트 설정
  FConnection := FDBProce.FDConnection; // 데이터베이스 커넥션 생성
  FQuery := TFDQuery.Create(nil); // 쿼리 컴포넌트 생성
  try
    FQuery.Connection := FConnection; // 생성된 커넥션을 쿼리에 할당

    // 데이터 조회
    FQuery.SQL.Text := 'SELECT * FROM ' + TableName; // 조회할 테이블 지정
    FQuery.Open; // 쿼리 실행

    // LiveBindings를 통한 데이터 바인딩 설정
    BindSourceDB := TBindSourceDB.Create(nil); // 바인드 소스 생성
    try
      BindSourceDB.DataSet := FQuery; // 쿼리 결과를 바인드 소스에 할당

      LinkGridToDataSource := TLinkGridToDataSource.Create(nil); // 그리드와 데이터 소스 링크 생성
      try
        LinkGridToDataSource.DataSource := BindSourceDB; // 링크에 바인드 소스 할당
        LinkGridToDataSource.GridControl := Grid; // 링크할 그리드 컨트롤 지정 (수정된 부분)

        // 데이터 변경 후 처리를 위한 이벤트 핸들러 연결
        FQuery.AfterPost := AfterPostEvent; // 데이터 변경 후 실행할 이벤트 지정
      except
        LinkGridToDataSource.Free;
        raise;
      end;
    except
      BindSourceDB.Free;
      raise;
    end;
  except
    FQuery.Free;
    raise;
  end;
end;






end.

