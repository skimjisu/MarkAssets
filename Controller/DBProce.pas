unit DBProce;

interface

uses
  Vcl.Forms, Windows , FireDAC.Phys.SQLite, IdHashMessageDigest, Dialogs, DateUtils, FireDAC.Stan.Pool,
  System.SysUtils, System.Classes, StrUtils,  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Controls, VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGrid, VCL.TMSFNCGridDatabaseAdapter,
  System.Hash, FireDAC.UI.Intf, FireDAC.Stan.Option, Data.DB, Common,
  FireDAC.Comp.Client, // FireDAC ������Ʈ
  FireDAC.Stan.Def,    // FireDAC ǥ�� ����
  FireDAC.Stan.Param,  // FireDAC ǥ�� �Ķ����
  FireDAC.Stan.Error,  // FireDAC ǥ�� ���� �ڵ鸵
  FireDAC.DatS,        // FireDAC �����ͼ�
  FireDAC.Phys.Intf,   // FireDAC ������ �������̽�
  FireDAC.DApt.Intf,   // FireDAC ������ ����� �������̽�
  FireDAC.Stan.Async,  // FireDAC �񵿱� ó��
  FireDAC.DApt,        // FireDAC ������ �����
  FireDAC.Phys.MySQL;  // FireDAC MySQL ����̹�
type
  TDBProce = class

  private
      FDBConnection: TFDConnection;
      FDBManager: TFDManager;
      class var FInstance: TDBProce;
  public
      class function GetInstance(const DBPath: string): TDBProce;
      procedure StartTransaction;
      procedure Commit;
      procedure Rollback;

      constructor Create(const DB_Name: string);
      destructor Destroy; override;
      function GetDBConnection: TFDConnection;
      procedure InsertData(const TableName: string; const Fields: TStringList; const Values: TStringList);
      function ReadData(const TableName, FieldName: string): TStringList;
      procedure UpdateData(const TableName, FieldName, OldValue, NewValue: string);
      procedure DeleteData(const TableName, FieldName, Value: string);

      function HashPassword(const Password: string): string;
      function ValidateUser(const Username, PasswordHash: string): Boolean;
      function UserExists(const Username: string): Boolean;
      procedure CreateUser(const Username, Password: string);
      procedure LoadDataIntoFNCGrid(Grid: TTMSFNCGrid);

    end;

implementation

var
  FDBConnection: TFDConnection = nil;

class function TDBProce.GetInstance(const DBPath: string): TDBProce;
begin
  if FInstance = nil then
    FInstance := TDBProce.Create(DBPath);
  Result := FInstance;
end;

function TDBProce.HashPassword(const Password: string): string;
begin
  Result := THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256);
end;

constructor TDBProce.Create(const DB_Name: string);
var
  Params: TStringList;
begin
  FDBManager := TFDManager.Create(nil);

  Params := TStringList.Create;
  try
    Params.Add('Database=' + DB_Name);
    Params.Add('DriverID=MySQL');
    Params.Add('Pooled=True');
    Params.Add('Pool_CleanupTimeout=60');
    Params.Add('Pool_ExpireTimeout=600');
    Params.Add('Pool_MaximumItems=50');
    Params.Add('Pool_MinimumItems=5');
    Params.Add('User_Name=admin'); // MySQL ����� �̸�
    Params.Add('Password=1234'); // MySQL ��й�ȣ
    Params.Add('Server=127.0.0.1'); // MySQL ���� �ּ�

    FDBManager.AddConnectionDef('MyConnection', 'MySQL', Params);
  finally
    Params.Free;
  end;

  FDBConnection := TFDConnection.Create(nil);
  FDBConnection.ConnectionDefName := 'MyConnection';
  FDBConnection.Connected := True;

end;


destructor TDBProce.Destroy;
begin
  FDBConnection.Connected := False;
  FDBConnection.Free;
  FDBManager.Free;
  inherited;
end;

function TDBProce.GetDBConnection: TFDConnection;
begin
  Result := FDBConnection;
end;

function TDBProce.UserExists(const Username: string): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(FDBConnection);
  try
    Query.Connection := FDBConnection;
    Query.SQL.Text := 'SELECT COUNT(*) FROM Admins WHERE Username = :username';
    Query.ParamByName('username').AsString := Username;
    Query.Open;
    Result := Query.Fields[0].AsInteger > 0;
  finally
    Query.Free;
  end;
end;

procedure TDBProce.InsertData(const TableName: string; const Fields: TStringList; const Values: TStringList);
var
  FDQuery: TFDQuery;
  SQL, FieldsStr, ValuesStr: string;
  I: Integer;
begin
  FDBConnection.StartTransaction;
  try
    FDQuery := TFDQuery.Create(nil);
    try
      FDQuery.Connection := FDBConnection;

      FieldsStr := '';
      ValuesStr := '';
      for I := 0 to Fields.Count - 1 do
      begin
        FieldsStr := FieldsStr + Fields.Strings[I];
        ValuesStr := ValuesStr + QuotedStr(Values.Strings[I]);
        if I < Fields.Count - 1 then
        begin
          FieldsStr := FieldsStr + ', ';
          ValuesStr := ValuesStr + ', ';
        end;
      end;

      SQL := Format('INSERT INTO %s (%s) VALUES (%s);', [TableName, FieldsStr, ValuesStr]);
      FDQuery.SQL.Text := SQL;
      FDQuery.ExecSQL;
    finally
      FDQuery.Free;
    end;
    FDBConnection.Commit;
  except
    FDBConnection.Rollback;
    raise;
  end;
end;

function TDBProce.ReadData(const TableName, FieldName: string): TStringList;
var
  FDQuery: TFDQuery;
  SQL: string;
begin
  Result := TStringList.Create;

  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDBConnection;

    FDBConnection.StartTransaction;
    try
      SQL := Format('SELECT %s FROM %s;', [FieldName, TableName]);
      FDQuery.SQL.Text := SQL;
      FDQuery.Open;

      while not FDQuery.Eof do
      begin
        Result.Add(FDQuery.FieldByName(FieldName).AsString);
        FDQuery.Next;
      end;

      FDBConnection.Commit;
    except
      FDBConnection.Rollback;
      raise;
    end;
  finally
    FDQuery.Free;
  end;
end;

procedure TDBProce.UpdateData(const TableName, FieldName, OldValue, NewValue: string);
var
  FDQuery: TFDQuery;
  SQL: string;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDBConnection;

    FDBConnection.StartTransaction;
    try
      SQL := Format('UPDATE %s SET %s = :NewValue WHERE %s = :OldValue;', [TableName, FieldName, FieldName]);
      FDQuery.SQL.Text := SQL;
      FDQuery.ParamByName('NewValue').AsString := NewValue;
      FDQuery.ParamByName('OldValue').AsString := OldValue;
      FDQuery.ExecSQL;

      FDBConnection.Commit;
    except
      FDBConnection.Rollback;
      raise;
    end;
  finally
    FDQuery.Free;
  end;
end;

procedure TDBProce.DeleteData(const TableName, FieldName, Value: string);
var
  FDQuery: TFDQuery;
  SQL: string;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDBConnection;

    FDBConnection.StartTransaction;
    try
      SQL := Format('DELETE FROM %s WHERE %s = :Value;', [TableName, FieldName]);
      FDQuery.SQL.Text := SQL;
      FDQuery.ParamByName('Value').AsString := Value;
      FDQuery.ExecSQL;

      FDBConnection.Commit;
    except
      FDBConnection.Rollback;
      raise;
    end;
  finally
    FDQuery.Free;
  end;
end;

// ����� ������ �����ͺ��̽��� �����ϴ� �޼ҵ�
procedure TDBProce.CreateUser(const Username, Password: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(FDBConnection);
  try
    Query.Connection := FDBConnection;
    Query.SQL.Text := 'INSERT INTO Admins (Username, Password, authority_level) VALUES (:Username, :Password, :authority_level)';
    Query.ParamByName('Username').AsString := Username;
    Query.ParamByName('Password').AsString := Password;
    Query.ParamByName('authority_level').AsString := '���';
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

// ������� ��ȿ���� �����ϴ� �޼ҵ�
function TDBProce.ValidateUser(const Username, PasswordHash: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;

  Query := TFDQuery.Create(FDBConnection);
  try
    Query.Connection := FDBConnection;
    Query.SQL.Text := 'SELECT Password FROM Admins WHERE Username = :Username';
    Query.ParamByName('Username').AsString := Username;
    Query.Open;

    if not Query.Eof then
    begin
      Result := Query.FieldByName('Password').AsString = PasswordHash;
    end;
  finally
    Query.Free;
  end;
end;

procedure TDBProce.LoadDataIntoFNCGrid(Grid: TTMSFNCGrid);
var
  Query: TFDQuery;
  MemTable: TFDMemTable;
  DataSource: TDataSource;
  GridData: TTMSFNCGridDatabaseAdapter;
begin
  Query := TFDQuery.Create(nil);
  MemTable := TFDMemTable.Create(nil);
  DataSource := TDataSource.Create(nil);
  GridData := TTMSFNCGridDatabaseAdapter.Create(nil);

  try
    Query.Connection := FDBConnection;
    Query.SQL.Text := 'SELECT AssetCode, SerialNumber, Type, ModelName, Contract, EndDate FROM Inventory';  // ���� ����
    Query.Open;

    MemTable.Data := Query.Data;
    DataSource.DataSet := MemTable;

    GridData.DataSource := DataSource;
    GridData.Active := True;

    Grid.BeginUpdate;
    try
      Grid.Adapter := GridData;
      Grid.AutoSizeColumns();
    finally
      Grid.EndUpdate;
      Application.ProcessMessages;
      Grid.Invalidate;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('������ �ε� �� ���� �߻�: ' + E.Message);
    end;
  end;
end;

procedure TDBProce.StartTransaction;
begin
  FDBConnection.StartTransaction;
end;

procedure TDBProce.Commit;
begin
  FDBConnection.Commit;
end;

procedure TDBProce.Rollback;
begin
  FDBConnection.Rollback;
end;

initialization
  TDBProce.FInstance := nil;

finalization
  TDBProce.FInstance.Free;



end.
