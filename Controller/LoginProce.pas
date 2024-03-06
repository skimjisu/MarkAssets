unit LoginProce;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, System.Hash,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, DBProce, DataStruct,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, System.Classes, System.Variants,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.DApt, FireDAC.Comp.UI, windows, Vcl.Dialogs, Common;

type
  TLoginEvent = procedure(Sender: TObject; const Username: string; const IsSuccess: Boolean) of object;
  TLoginControl = class(TComponent)
  private
    FDBProce: TDBProce;
    FOnLoginSuccess: TLoginEvent;
    FOnLoginFailure: TLoginEvent;
    FFields, FValues : TStringList;
    FLoggedUser: string;
  public
    constructor Create(DBProce: TDBProce);
    destructor Destroy; override;
    procedure Login(const Username, Password: string);
    property OnLoginSuccess: TLoginEvent read FOnLoginSuccess write FOnLoginSuccess;
    property OnLoginFailure: TLoginEvent read FOnLoginFailure write FOnLoginFailure;
    function ValidateUser(const Username, Password: string): Boolean;
    procedure CreateUser(const Username, Password: string);
  published

  end;

implementation

constructor TLoginControl.Create(DBProce: TDBProce);
begin
  FDBProce := DBProce;
end;

destructor TLoginControl.Destroy;
begin
  inherited;
end;

procedure TLoginControl.Login(const Username, Password: string);
var
  IsSuccess: Boolean;
begin
  IsSuccess := FDBProce.ValidateUser(Username, THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256));

  if IsSuccess then
  begin
    if Assigned(FOnLoginSuccess) then
      FOnLoginSuccess(Self, Username, IsSuccess);
  end
  else
  begin
    if Assigned(FOnLoginFailure) then
      FOnLoginFailure(Self, Username, IsSuccess);
  end;
end;

function TLoginControl.ValidateUser(const Username, Password: string): Boolean;
begin
  Result := FDBProce.ValidateUser(Username, THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256));
end;

procedure TLoginControl.CreateUser(const Username, Password: string);
begin
  FDBProce.CreateUser(Username, THashSHA2.GetHashString(Password, THashSHA2.TSHA2Version.SHA256));
end;

end.

