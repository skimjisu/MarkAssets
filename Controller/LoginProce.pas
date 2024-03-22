unit LoginProce;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, System.Hash, VCL.TMSFNCGridDatabaseAdapter,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, DBProce, DataStruct, AccountProce,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, System.Classes, System.Variants,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.DApt, FireDAC.Comp.UI, windows, VCL.Dialogs, Common;

type
  TLoginEvent = procedure(Sender: TObject; const Username: string; const IsSuccess: Boolean) of object;

  TLoginControl = class(TComponent)
  private
    FDBProce: TDBProce;
    FUserStore: TUserStore;
    FOnLoginSuccess: TLoginEvent;
    FOnLoginFailure: TLoginEvent;
    FFDConnection: TFDConnection;
    FLoggedUser: string;
    Adapter: TTMSFNCGridDatabaseAdapter;
    procedure CreateUser(const Username, Password: string);
    function ValidateUser(const Username, PasswordHash: string): Boolean;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    procedure Login(const Username, Password: string);
    property OnLoginSuccess: TLoginEvent read FOnLoginSuccess write FOnLoginSuccess;
    property OnLoginFailure: TLoginEvent read FOnLoginFailure write FOnLoginFailure;

  published

  end;

implementation

constructor TLoginControl.Create(AConnection: TFDConnection);
begin
  //inherited Create;
  FFDConnection := AConnection;
end;


destructor TLoginControl.Destroy;
begin
  inherited;
end;

procedure TLoginControl.Login(const Username, Password: string);
begin
  if ValidateUser(Username, THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256)) then
  begin
    // 로그인 성공 이벤트 호출
    if Assigned(FOnLoginSuccess) then
      FOnLoginSuccess(Self, Username, True);
  end
  else
  begin
    // 로그인 실패 이벤트 호출
    if Assigned(FOnLoginFailure) then
      FOnLoginFailure(Self, Username, False);
  end;
end;


procedure TLoginControl.CreateUser(const Username, Password: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FFDConnection;
    Query.SQL.Text := 'INSERT INTO Admins (Username, Password, authority_level) VALUES (:Username, :Password, :authority_level)';
    Query.ParamByName('Username').AsString := Username;
    Query.ParamByName('Password').AsString := Password;
    Query.ParamByName('authority_level').AsString := '모두';
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TLoginControl.ValidateUser(const Username, PasswordHash: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FFDConnection;
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

end.
