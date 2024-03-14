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
  ShowMessage('�����Ͱ� ���������� ������Ʈ �Ǿ����ϴ�.');
end;

procedure TDataHandler.SetDataBindGrid(const TableName: string; Grid: TTMSFNCGrid);
var
  FConnection: TFDConnection;
  FQuery: TFDQuery;
  BindSourceDB: TBindSourceDB;
  LinkGridToDataSource: TLinkGridToDataSource;
begin
  // TDBProce �̱��� �ν��Ͻ��� ���� �����ͺ��̽� ���� �� ����
  FDBProce := TDBProce.GetInstance;

  // FireDAC ������Ʈ ����
  FConnection := FDBProce.FDConnection; // �����ͺ��̽� Ŀ�ؼ� ����
  FQuery := TFDQuery.Create(nil); // ���� ������Ʈ ����
  try
    FQuery.Connection := FConnection; // ������ Ŀ�ؼ��� ������ �Ҵ�

    // ������ ��ȸ
    FQuery.SQL.Text := 'SELECT * FROM ' + TableName; // ��ȸ�� ���̺� ����
    FQuery.Open; // ���� ����

    // LiveBindings�� ���� ������ ���ε� ����
    BindSourceDB := TBindSourceDB.Create(nil); // ���ε� �ҽ� ����
    try
      BindSourceDB.DataSet := FQuery; // ���� ����� ���ε� �ҽ��� �Ҵ�

      LinkGridToDataSource := TLinkGridToDataSource.Create(nil); // �׸���� ������ �ҽ� ��ũ ����
      try
        LinkGridToDataSource.DataSource := BindSourceDB; // ��ũ�� ���ε� �ҽ� �Ҵ�
        LinkGridToDataSource.GridControl := Grid; // ��ũ�� �׸��� ��Ʈ�� ���� (������ �κ�)

        // ������ ���� �� ó���� ���� �̺�Ʈ �ڵ鷯 ����
        FQuery.AfterPost := AfterPostEvent; // ������ ���� �� ������ �̺�Ʈ ����
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

