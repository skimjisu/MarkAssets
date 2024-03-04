unit RoundProce;

interface

uses
  Winapi.Windows, Winapi.Dwmapi;

type
  TRoundedWindowCornerType = (RoundedCornerDefault, RoundedCornerOff, RoundedCornerOn, RoundedCornerSmall);

procedure SetRoundedCorners(const TheHandle: HWND; const CornerType: TRoundedWindowCornerType);

implementation

const
  DWMWCP_DEFAULT    = 0; // 시스템이 창 모서리를 둥글게 만들지 결정하도록 합니다.
  DWMWCP_DONOTROUND = 1; // 창 모서리를 절대 둥글게 만들지 않습니다.
  DWMWCP_ROUND      = 2; // 적절한 경우 창 모서리를 둥글게 만듭니다.
  DWMWCP_ROUNDSMALL = 3; // 적절한 경우 작은 반경으로 창 모서리를 둥글게 만듭니다.

  DWMWA_WINDOW_CORNER_PREFERENCE = 33; // 창 모서리 정책을 제어하는 값

procedure SetRoundedCorners(const TheHandle: HWND; const CornerType: TRoundedWindowCornerType);
var
  DWM_WINDOW_CORNER_PREFERENCE: Cardinal;
begin
  case CornerType of
    RoundedCornerOff:     DWM_WINDOW_CORNER_PREFERENCE := DWMWCP_DONOTROUND;
    RoundedCornerOn:      DWM_WINDOW_CORNER_PREFERENCE := DWMWCP_ROUND;
    RoundedCornerSmall:   DWM_WINDOW_CORNER_PREFERENCE := DWMWCP_ROUNDSMALL;
  else
    DWM_WINDOW_CORNER_PREFERENCE := DWMWCP_DEFAULT;
  end;
  DwmSetWindowAttribute(TheHandle, DWMWA_WINDOW_CORNER_PREFERENCE, @DWM_WINDOW_CORNER_PREFERENCE, sizeof(DWM_WINDOW_CORNER_PREFERENCE));
end;

end.

