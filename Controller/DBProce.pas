unit DBProce;

interface

uses
  Windows , FireDAC.Comp.Client, Data.DB, FireDAC.Phys.SQLite, IdHashMessageDigest, Dialogs, System.SysUtils;

function CreateDBConnection: TFDConnection;
function HashPassword(const Password: string): string;
function GetDBConnection: TFDConnection;

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

initialization

finalization
  FDBConnection.Free;

end.
