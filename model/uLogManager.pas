unit uLogManager;

interface

uses
  System.SysUtils, System.Classes;

type
  TLogManager = class
  private
    FLogFilePath: string; // 로그 파일 경로를 저장하는 필드
    function GetFileName: string;
  public
    constructor Create; // 생성자 선언
    destructor Destroy; override; // 소멸자 선언
    procedure LogError(E: Exception); // 예외 로그 기록 메서드
  end;

implementation

{ TLogManager }

constructor TLogManager.Create;
begin
  inherited Create;
  FLogFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Logs'; // 로그 파일을 저장할 경로 설정
  if not DirectoryExists(FLogFilePath) then CreateDir(FLogFilePath); // 로그 디렉토리가 없으면 생성
end;

destructor TLogManager.Destroy;
begin
  // 필요한 경우, 여기에 정리 코드 추가

  inherited Destroy;
end;

function TLogManager.GetFileName: string;
var
  DateTimeStr: string;
begin
  // 로그 파일 이름을 현재 날짜를 기반으로 설정, 예: Log_2024-03-09.txt
  DateTimeStr := FormatDateTime('yyyy-mm-dd', Now);
  Result := FLogFilePath + '\Log_' + DateTimeStr + '.txt';
end;

procedure TLogManager.LogError(E: Exception);
var
  LogFile: TextFile;
  FileName: string;
begin
  FileName := GetFileName;

  // 로그 파일 열기 (파일이 존재하지 않으면 생성)
  AssignFile(LogFile, FileName);
  if FileExists(FileName) then Append(LogFile) // 파일이 존재하면 파일 끝에 추가
  else Rewrite(LogFile); // 파일이 존재하지 않으면 새로 생성

  try
    // 현재 시각과 예외 정보 로깅
    WriteLn(LogFile, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ' - ' + E.ClassName + ': ' + E.Message);
  finally
    CloseFile(LogFile); // 로그 파일 닫기
  end;
end;

end.

