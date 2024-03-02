unit DBProce;

interface

uses
  FireDAC.Comp.Client, Data.DB, IdHashMessageDigest;

function CreateDBConnection: TFDConnection;
function HashPassword(const Password: string): string;
function GetDBConnection: TFDConnection;

implementation

var
  FDBConnection: TFDConnection = nil;

function CreateDBConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.DriverName := 'SQLite';
  Result.Params.Values['Database'] := '..\DB\MarkAssets.db';  // 데이터베이스 파일 경로를 적절하게 수정해주세요.
  Result.Connected := True;
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

initialization

finalization
  FDBConnection.Free;

end.
