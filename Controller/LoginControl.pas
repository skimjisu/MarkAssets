unit LoginControl;

interface

uses
  System.SysUtils, Vcl.Dialogs, DBProce, Data.DB, FireDAC.Comp.Client;

type
  TLoginControl = class
  private
    FUsername: string;
    FPassword: string;
    FConnection: TFDConnection;
    function IsAuthenticated: Boolean;
  public
    constructor Create(const Username, Password: string);
    destructor Destroy; override;
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
    Query.SQL.Text := 'SELECT * FROM Users WHERE Username = :Username AND Password = :Password';
    Query.ParamByName('Username').AsString := FUsername;
    Query.ParamByName('Password').AsString := HashPassword(FPassword);
    Query.Open;
    Result := not Query.IsEmpty;
  finally
    Query.Free;
  end;
end;

procedure TLoginControl.Login;
begin
  try
    if IsAuthenticated then ShowMessage('�α��� ����!')
    else ShowMessage('�α��� ����. ����� �̸� �Ǵ� ��й�ȣ�� Ȯ�����ּ���.');
  except
    on E: Exception do ShowMessage('�α��� ó�� �� ������ �߻��߽��ϴ�: ' + E.Message);
  end;
end;

end.

