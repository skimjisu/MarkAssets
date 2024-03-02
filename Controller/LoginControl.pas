unit LoginControl;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, DBProce, FireDAC.DApt, FireDAC.Comp.UI, windows, Vcl.Dialogs;


type
  TLoginEvent = procedure(Sender: TObject; Success: Boolean) of object;

  TLoginControl = class
  private
    FOnLogin: TLoginEvent;
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
    property OnLogin: TLoginEvent read FOnLogin write FOnLogin;
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
  // WaitCursor 생성
  WaitCursor := TFDGUIxWaitCursor.Create(nil);
  try
    WaitCursor.Provider := 'Forms';  // Provider 설정

    // 로그인 처리
    try
      // IsAuthenticated 메서드는 사용자가 올바른 인증 정보를 제공했는지 확인합니다.
      // 이 메서드는 TLoginControl 클래스에 정의되어 있어야 합니다.
      Success := IsAuthenticated;

      if Success then
      begin
        // OnLogin 이벤트를 트리거합니다.
        // 이 이벤트는 로그인 성공 시에 호출되어야 하는 동작을 정의합니다.
        if Assigned(FOnLogin) then
          FOnLogin(Self, Success);
      end
      else
      begin
        // CreateAccount 메서드는 새 계정을 생성합니다.
        // 이 메서드는 TLoginControl 클래스에 정의되어 있어야 합니다.
        CreateAccount;
        ShowMessage('계정이 생성되었습니다. 다시 로그인 해주세요.');
      end;
    except
      on E: Exception do
        ShowMessage('로그인 처리 중 에러가 발생했습니다: ' + E.Message);
    end;

  finally
    // WaitCursor 제거
    WaitCursor.Free;
  end;
end;


end.

