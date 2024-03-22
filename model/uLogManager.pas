unit uLogManager;

interface

uses
  System.SysUtils, System.Classes;

type
  TLogManager = class
  private
    FLogFilePath: string; // �α� ���� ��θ� �����ϴ� �ʵ�
    function GetFileName: string;
  public
    constructor Create; // ������ ����
    destructor Destroy; override; // �Ҹ��� ����
    procedure LogError(E: Exception); // ���� �α� ��� �޼���
  end;

implementation

{ TLogManager }

constructor TLogManager.Create;
begin
  inherited Create;
  FLogFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Logs'; // �α� ������ ������ ��� ����
  if not DirectoryExists(FLogFilePath) then CreateDir(FLogFilePath); // �α� ���丮�� ������ ����
end;

destructor TLogManager.Destroy;
begin
  // �ʿ��� ���, ���⿡ ���� �ڵ� �߰�

  inherited Destroy;
end;

function TLogManager.GetFileName: string;
var
  DateTimeStr: string;
begin
  // �α� ���� �̸��� ���� ��¥�� ������� ����, ��: Log_2024-03-09.txt
  DateTimeStr := FormatDateTime('yyyy-mm-dd', Now);
  Result := FLogFilePath + '\Log_' + DateTimeStr + '.txt';
end;

procedure TLogManager.LogError(E: Exception);
var
  LogFile: TextFile;
  FileName: string;
begin
  FileName := GetFileName;

  // �α� ���� ���� (������ �������� ������ ����)
  AssignFile(LogFile, FileName);
  if FileExists(FileName) then Append(LogFile) // ������ �����ϸ� ���� ���� �߰�
  else Rewrite(LogFile); // ������ �������� ������ ���� ����

  try
    // ���� �ð��� ���� ���� �α�
    WriteLn(LogFile, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ' - ' + E.ClassName + ': ' + E.Message);
  finally
    CloseFile(LogFile); // �α� ���� �ݱ�
  end;
end;

end.

