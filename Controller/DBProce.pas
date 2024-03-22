unit DBProce;

interface

uses
  Vcl.Forms, Windows, IdHashMessageDigest, Dialogs, DateUtils, FireDAC.Stan.Pool, Common, uLogManager,  Vcl.TMSFNCGridDatabaseAdapter,
  Vcl.TMSFNCCustomControl, Vcl.TMSFNCCustomScrollControl, Vcl.TMSFNCGridData, Vcl.TMSFNCCustomGrid, Vcl.TMSFNCGrid, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.TMSFNCCustomComponent,
  System.SysUtils, System.Classes, StrUtils, Vcl.Grids, Vcl.DBGrids, Vcl.Controls,
  System.Hash, System.Generics.Collections , Data.Bind.Components, Data.Bind.DBScope, Data.DB, Data.Bind.Grid,
  FireDAC.Phys.SQLite, System.IOUtils, FireDAC.Stan.Async, FireDAC.Stan.Option,  syncObjs,   FireDAC.Comp.DataSet,
  generics.collections, system.threading,
  FireDAC.UI.Intf,
  FireDAC.Comp.Client, // FireDAC ������Ʈ
  FireDAC.Stan.Def,    // FireDAC ǥ�� ����
  FireDAC.Stan.Param,  // FireDAC ǥ�� �Ķ����
  FireDAC.Stan.Error,  // FireDAC ǥ�� ���� �ڵ鸵
  FireDAC.DatS,        // FireDAC �����ͼ�
  FireDAC.Phys.Intf,   // FireDAC ������ �������̽�
  FireDAC.DApt.Intf,   // FireDAC ������ ����� ��?����̽?  FireDAC.Stan.Async,  // FireDAC �񵿱� ó��
  FireDAC.DApt,        // FireDAC ������ �����
  FireDAC.Phys.MySQL;  // FireDAC MySQL ����̹�

type
  TDataOperation = (doAdd, doGet, doUpdate, doDelete);
  EDBConnectionException = class(Exception);

  TDBProce = class(TObject)
  protected
    destructor Destroy; override;

  private
    class var FInstance: TDBProce;
    FFDManager: TFDManager;
    LogManager: TLogManager;
    FFDConnection: TFDConnection;


    constructor Create;
    function GetFDConnection: TFDConnection;

  public
     //
  public
    class function GetInstance: TDBProce;
    procedure Connect(const FileName: string);
    function BeginTransaction: TFDTransaction;
    procedure EndTransaction(const ATransaction: TFDTransaction; const ACommit: Boolean);

    function LoadTableData(const TableName: string): TFDMemTable;

    procedure ExecuteStoredProce(const SPName: string; const Params: TFDParams);
    property FDConnection: TFDConnection read GetFDConnection;
    function ManageData(const SQL: string; const Params: TFDParams; Operation: TDataOperation): TFDQuery;
    function ExecuteQuery(const SQL: string; const Params: TFDParams; Operation: TDataOperation): TFDQuery;
   // procedure SetDataBingings(aBindSourceDB: TBindSourceDB; aGrid: TTMSFNCGrid);
    procedure AddDataToTable(const TableName: string; const Params: array of Variant);
    procedure LoadTableDataToGridLiveBinding(const TableName: string; Grid: TTMSFNCGrid);
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    function LoadDataWithTransaction(const ATableName: string): TFDQuery;
    function IsValidTableName(const ATableName: string): Boolean;
  end;


implementation



{ TDBProce }

function TDBProce.GetFDConnection: TFDConnection;
begin
  Result := FFDConnection;
end;

constructor TDBProce.Create;
begin
  inherited Create;
  FFDManager := TFDManager.Create(nil);
  FFDConnection := TFDConnection.Create(nil);
  FFDManager.ResourceOptions.AutoConnect := True; // Enable connection pooling

end;
destructor TDBProce.Destroy;
begin
  FFDConnection.Free;
  FFDManager.Free;
  inherited;
end;

class function TDBProce.GetInstance : TDBProce;
begin
  if FInstance = nil then
    FInstance := TDBProce.Create;
  Result := FInstance;
end;

procedure TDBProce.Connect(const FileName: string);
begin
  if FileName.IsEmpty then raise EDBConnectionException.Create('���� ���� �̸��� �������� �ʾҽ��ϴ�.');
  if not TFile.Exists(FileName) then raise EDBConnectionException.Create('������ ������ ã�� �� �����ϴ�: ' + FileName);

  FFDManager.ConnectionDefFileName := FileName;
  try
    FFDManager.LoadConnectionDefFile;
    FFDConnection.ConnectionDefName := FFDManager.ConnectionDefs.Items[0].Name; // Assuming the first definition is what we want
    FFDConnection.Connected := True;
  except
    on E: Exception do raise EDBConnectionException.Create('�����ͺ��̽� ���� ���� ���� �ε� ����: ' + E.Message);
  end;
end;

procedure TDBProce.StartTransaction;
begin
  FFDConnection.StartTransaction;
end;

procedure TDBProce.Commit;
begin
  FFDConnection.Commit;
end;

procedure TDBProce.Rollback;
begin
  FFDConnection.Rollback;
end;

function TDBProce.LoadTableData(const TableName: string): TFDMemTable;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FFDConnection;
    Query.SQL.Text := 'SELECT * FROM ' + TableName;
    Query.Open;
    Result := TFDMemTable.Create(nil);
    Result.Data := Query.Data;
  finally
    Query.Free;
  end;
end;

procedure TDBProce.LoadTableDataToGridLiveBinding(const TableName: string; Grid: TTMSFNCGrid);
var
  Query: TFDQuery;
  DataSource: TDataSource;
  GridDatabaseAdapter: TTMSFNCGridDatabaseAdapter;
begin
  Query := TFDQuery.Create(nil);
  DataSource := TDataSource.Create(nil);
  GridDatabaseAdapter := TTMSFNCGridDatabaseAdapter.Create(nil);
  try
    // �����ͺ��̽� ���� ����
    Query.Connection := FFDConnection;
    Query.SQL.Text := 'SELECT * FROM ' + TableName;
    Query.Open;

    // TDataSource ����
    DataSource.DataSet := Query;

    // TMSFNCGridDatabaseAdapter ����
    GridDatabaseAdapter.Grid := Grid;
    GridDatabaseAdapter.DataSource := DataSource;

  finally
    GridDatabaseAdapter.Free;
    DataSource.Free;
    Query.Free;
  end;
end;

function TDBProce.LoadDataWithTransaction(const ATableName: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil); // TFDQuery ��ü ����
  try
    Result.Connection := FFDConnection; // FFDConnection�� ����

    if IsValidTableName(ATableName) then // IsValidTableName�� ���� ���̺� �̸��� �����ϴ� �Լ�
    begin
      Result.SQL.Text := 'SELECT * FROM ' + ATableName; // ���⼭ ATableName�� ������ ����
    end
    else
      raise Exception.Create('Invalid table name.');

    // Ʈ����� ����
    FFDConnection.StartTransaction;
    try
      Result.Open; // ���� ����
      FFDConnection.Commit; // Ʈ����� ���� �� Ŀ��
    except
      on E: Exception do
      begin
        FFDConnection.Rollback; // ���� �߻� �� �ѹ�
        raise;
      end;
    end;
  except
    on E: Exception do
    begin
      FreeAndNil(Result); // ���� �߻� �� Result ��ü ����
      raise;
    end;
  end;
end;

function TDBProce.IsValidTableName(const ATableName: string): Boolean;
var
  AllowedTableNames: TStringList;
begin
  AllowedTableNames := TStringList.Create;
  try
    // ���� ���̺� �̸� �߰�
    AllowedTableNames.Add('Assets');
    AllowedTableNames.Add('Inventory');

    // IndexOf �޼���� ��Ͽ� �ش� ���ڿ��� ������ 0 �̻��� �ε����� ��ȯ�ϰ�, ������ -1�� ��ȯ
    Result := AllowedTableNames.IndexOf(ATableName) >= 0;
  finally
    AllowedTableNames.Free;
  end;
end;

procedure TDBProce.AddDataToTable(const TableName: string; const Params: array of Variant);
var
  Query: TFDQuery;
  SQLText: string;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FFDConnection;
    // ������ �߰� ������ �Ķ����ȭ�� ������ ����
    SQLText := 'INSERT INTO ' + TableName +
               ' (AssetCode, SerialNumber, Type, ModelName, Contract, EndDate) ' +
               'VALUES (:AssetCode, :SerialNumber, :Type, :ModelName, :Contract, :EndDate)';

    Query.SQL.Text := SQLText;
    // �Ķ���� �� �Ҵ�
    Query.ParamByName('AssetCode').Value := Params[0];
    Query.ParamByName('SerialNumber').Value := Params[1];
    Query.ParamByName('Type').Value := Params[2];
    Query.ParamByName('ModelName').Value := Params[3];
    Query.ParamByName('Contract').Value := Params[4];
    Query.ParamByName('EndDate').Value := Params[5];

    Query.ExecSQL;

    FFDConnection.CommitRetaining;
    LoadTableData(TableName); // TFDMemTable ������Ʈ
  finally
    Query.Free;
  end;
end;

function TDBProce.ManageData(const SQL: string; const Params: TFDParams; Operation: TDataOperation): TFDQuery;
begin
  Result := ExecuteQuery(SQL, Params, Operation);
end;

function TDBProce.ExecuteQuery(const SQL: string; const Params: TFDParams; Operation: TDataOperation): TFDQuery;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FFDConnection;
  try
    Query.SQL.Text := SQL;
    if Assigned(Params) then
      Query.Params.Assign(Params);

    case Operation of
      doAdd, doUpdate, doDelete:
        begin
          FFDConnection.StartTransaction;
          try
            Query.ExecSQL;
            FFDConnection.Commit;
          except
            FFDConnection.Rollback;
            raise;
          end;
        end;
      doGet:
        begin
          Query.Open;
          Result := Query;
          Exit;
        end;
    end;
  except
    on E: Exception do
      begin
        if Operation = doGet then
          Query.Free;
        raise;
      end;
  end;

  if Operation <> doGet then
    FreeAndNil(Query);

  Result := nil;
end;

function TDBProce.BeginTransaction: TFDTransaction;
begin
  Result := TFDTransaction.Create(nil);
  Result.Connection := FFDConnection;
  Result.StartTransaction;
end;

procedure TDBProce.EndTransaction(const ATransaction: TFDTransaction; const ACommit: Boolean);
begin
  if ACommit then
    ATransaction.Commit
  else
    ATransaction.Rollback;
  ATransaction.Free;
end;

procedure TDBProce.ExecuteStoredProce(const SPName: string; const Params: TFDParams);
var
  Query: TFDStoredProc;
begin
  Query := TFDStoredProc.Create(nil);
  LogManager := TLogManager.Create;
  try
    Query.Connection := FFDConnection;
    FFDConnection.StartTransaction;
    try
      Query.StoredProcName := SPName;
      Query.Params.Clear;
      Query.Params.Assign(Params); // �Ķ���� �Ҵ�
      Query.Prepare; // ������ ���ν��� �غ�
      Query.ExecProc; // ������ ���ν��� ����
      FFDConnection.Commit; // Ʈ����� Ŀ��
    except
      on E: Exception do
      begin
        FFDConnection.Rollback; // ���� �߻� �� �ѹ�
        LogManager.LogError(E); // ���� ���� �α�
        raise; // ���� ��߻�
      end;
    end;
  finally
    Query.Free;
  end;
end;

initialization
  TDBProce.FInstance := nil;

finalization
  TDBProce.FInstance.Free;


end.
