unit LoginControl;

interface

uses
  System.SysUtils, Vcl.Dialogs, DBProce, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.DApt, FireDAC.Comp.UI, FireDAC.Stan.Async;

type
  TLoginControl = class
  private
    FUsername: string;
    FPassword: string;
    FAuthorityLevel: string;
    FConnection: TFDConnection;
    function IsAuthenticated: Boolean;
  public
    constructor Create(const Username, Password: string);
    destructor Destroy; override;
    procedure CreateAccount;
    procedure Login;
  end;

implementation

constructor TLoginControl.Create(const Username, Password: string);
begin
  FUsername := Username;
  FPassword := Password;
  FConnection := GetDBConnection;
end;

destructor TLoginControl.Destroy;
begin
  inherited;
end;

function TLoginControl.IsAuthenticated: Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'SELECT * FROM Admins WHERE Username = :Username AND Password = :Password'; // 'Users'를 'Admins'로 변경
    Query.ParamByName('Username').AsString := FUsername;
    Query.ParamByName('Password').AsString := HashPassword(FPassword);
    Query.Open;
    Result := not Query.IsEmpty;

    if Result then
    begin
      // 로그인에 성공하면 authority_level 값을 가져옵니다.
      FAuthorityLevel := Query.FieldByName('authority_level').AsString;
    end;
  finally
    Query.Free;
  end;
end;

procedure TLoginControl.CreateAccount;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'INSERT INTO Admins (Username, Password, authority_level) VALUES (:Username, :Password, :AuthorityLevel)';
    Query.ParamByName('Username').AsString := FUsername;
    Query.ParamByName('Password').AsString := HashPassword(FPassword);
    Query.ParamByName('AuthorityLevel').AsString := '모두';
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TLoginControl.Login;
var
  WaitCursor: TFDGUIxWaitCursor;
  Success: Boolean;
begin
  WaitCursor := TFDGUIxWaitCursor.Create(nil);   // WaitCursor 생성
  try
    WaitCursor.Provider := 'Forms';  // Provider 설정

    // 로그인 처리
    try
      Success := IsAuthenticated;

      if Success then
      begin
        ShowMessage('로그인 성공!')
      end
      else
      begin
        CreateAccount;
        ShowMessage('계정이 생성되었습니다. 다시 로그인 해주세요.');
      end;
    except
      on E: Exception do
        ShowMessage('로그인 처리 중 에러가 발생했습니다: ' + E.Message);
    end;

  finally
    WaitCursor.Free;  // WaitCursor 제거
  end;
end;


end.

