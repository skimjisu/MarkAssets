unit DataStruct;

interface

uses
  System.SysUtils, Vcl.Forms, uDBConnect, uDataHandler, Common;  // FireDAC MySQL ����̹�

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
  ConfigFilePath := ExtractFilePath(Application.ExeName) + 'ConnectionDef.ini'; // ���� ���� ��� ����
end;





end.
