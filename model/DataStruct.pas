unit DataStruct;

interface

uses
  System.SysUtils, Vcl.Forms, uDBConnect, uDataHandler, Common;  // FireDAC MySQL 드라이버

var
  LoggedUser: string;


const
  DBName = 'markdb';

type
  TDataStruct = class
  public
    ConfigFilePath: string;
    constructor Create;
  end;

implementation

constructor TDataStruct.Create;
begin
  ConfigFilePath := ExtractFilePath(Application.ExeName) + 'ConnectionDef.ini'; // 설정 파일 경로 지정
end;





end.
