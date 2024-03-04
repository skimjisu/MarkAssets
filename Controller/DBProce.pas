unit DBProce;

interface

uses
  Windows , FireDAC.Comp.Client, Data.DB, FireDAC.Phys.SQLite, IdHashMessageDigest, Dialogs, System.SysUtils, Classes, StrUtils;
function CreateDBConnection: TFDConnection;
function HashPassword(const Password: string): string;
function GetDBConnection: TFDConnection;
procedure UpdateInventoryFromCSV(const CSVFileName: string);

implementation

var
  FDBConnection: TFDConnection = nil;

function CreateDBConnection: TFDConnection;
begin
   Result := TFDConnection.Create(nil);
  try
    Result.DriverName := 'SQLite';
    Result.Params.Values['Database'] := 'C:\Users\KDHS\Desktop\MarkAssets\MarkAssets\DB\MarkDB.db';  // 데이터베이스 파일 경로 수정해주세요.
    Result.Connected := True;
    //ShowMessage('데이터베이스 연결 성공!');
  except
    on E: Exception do
    begin
      MessageBox(0, PChar('데이터베이스 연결 실패: ' + E.Message), PChar('경고'), MB_ICONWARNING or MB_OK);
      FreeAndNil(Result);
    end;
  end;
end;

function HashPassword(const Password: string): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    Result := idmd5.HashStringAsHex(Password);
  finally
    idmd5.Free;
  end;
end;

function GetDBConnection: TFDConnection;
begin
  if not Assigned(FDBConnection) then
    FDBConnection := CreateDBConnection;
  Result := FDBConnection;
end;

procedure CreateInvDB(const ID: Integer; const AssetCode, ModelName, SerialNumber, Manufacturer, EneDate, aType: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := GetDBConnection;
    Query.SQL.Text := 'INSERT INTO Inventory (ID, AssetCode, ModelName, SerialNumber, Manufacturer, EneDate, Type) VALUES (:ID, :AssetCode, :ModelName, :SerialNumber, :Manufacturer, :EneDate, :Type)';
    Query.ParamByName('ID').AsInteger := ID;
    Query.ParamByName('AssetCode').AsString := AssetCode;
    Query.ParamByName('ModelName').AsString := ModelName;
    Query.ParamByName('SerialNumber').AsString := SerialNumber;
    Query.ParamByName('Manufacturer').AsString := Manufacturer;
    Query.ParamByName('EneDate').AsString := EneDate;
    Query.ParamByName('Type').AsString := aType;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function ReadInvDB(const ID: Integer): TDataSet;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := GetDBConnection;
    Query.SQL.Text := 'SELECT * FROM Inventory WHERE ID = :ID';
    Query.ParamByName('ID').AsInteger := ID;
    Query.Open;
    Result := Query;
  except
    on E: Exception do
 begin
      FreeAndNil(Query);
      raise;
    end;
  end;
end;

procedure UpdateInvDB(const ID: Integer; const AssetCode, ModelName, SerialNumber, Manufacturer, EneDate, aType: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := GetDBConnection;
    Query.SQL.Text := 'UPDATE Inventory SET AssetCode = :AssetCode, ModelName = :ModelName, SerialNumber = :SerialNumber, Manufacturer = :Manufacturer, EneDate = :EneDate, Type = :Type WHERE ID = :ID';
    Query.ParamByName('ID').AsInteger := ID;
    Query.ParamByName('AssetCode').AsString := AssetCode;
    Query.ParamByName('ModelName').AsString := ModelName;
    Query.ParamByName('SerialNumber').AsString := SerialNumber;
    Query.ParamByName('Manufacturer').AsString := Manufacturer;
    Query.ParamByName('EneDate').AsString := EneDate;
    Query.ParamByName('Type').AsString := aType;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure DeleteInvDB(const ID: Integer);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := GetDBConnection;
    Query.SQL.Text := 'DELETE FROM Inventory WHERE ID = :ID';
    Query.ParamByName('ID').AsInteger := ID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure UpdateInventoryFromCSV(const CSVFileName: string);
var
  CSVFile: TextFile;
  Line: string;
  Parts: TStringList;
  FDQuery: TFDQuery;
  LineNumber: Integer;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := GetDBConnection;

    Parts := TStringList.Create;
    try
      AssignFile(CSVFile, CSVFileName);
      Reset(CSVFile);

      LineNumber := 0;
      while not Eof(CSVFile) do
      begin
        Inc(LineNumber);
        ReadLn(CSVFile, Line);

        Parts.Clear;
        ExtractStrings([','], [], PChar(Line), Parts);  // Assuming fields are comma-separated

        // Check if the row has the correct number of columns
        if Parts.Count <> 6 then
        begin
          // If the row is invalid, log the line number and skip this row
          WriteLn('Invalid row at line ' + IntToStr(LineNumber));
          Continue;
        end;

        FDQuery.SQL.Text := 'UPDATE Inventory SET Type = :Type, ModelName = :ModelName, Contract = :Contract, EneDate = :EneDate WHERE AssetCode = :AssetCode AND SerialNumber = :SerialNumber';

        FDQuery.ParamByName('AssetCode').AsString := Parts[0];
        FDQuery.ParamByName('SerialNumber').AsString := Parts[1];

        if Parts[2] <> '' then
          FDQuery.ParamByName('Type').AsString := Parts[2]
        else
          FDQuery.ParamByName('Type').Clear;

        if Parts[3] <> '' then
          FDQuery.ParamByName('ModelName').AsString := Parts[3]
        else
          FDQuery.ParamByName('ModelName').Clear;

        if Parts[4] <> '' then
          FDQuery.ParamByName('Contract').AsString := Parts[4]
        else
          FDQuery.ParamByName('Contract').Clear;

        if Parts[5] <> '' then
          FDQuery.ParamByName('EneDate').AsString := Parts[5]
        else
          FDQuery.ParamByName('EneDate').Clear;

        try
          FDQuery.ExecSQL;  // Execute the update
        except
          on E: Exception do
          begin
            // If there's an error updating the row, log the line number and error message
            WriteLn('Error at line ' + IntToStr(LineNumber) + ': ' + E.Message);
          end;
        end;
      end;
    finally
      Parts.Free;
    end;

    CloseFile(CSVFile);
  finally
    FDQuery.Free;
  end;
end;

initialization

finalization
  FDBConnection.Free;

end.
