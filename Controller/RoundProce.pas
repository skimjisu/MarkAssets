unit RoundProce;

interface

uses
  Winapi.Windows, Winapi.Dwmapi;

type
  TRoundedWindowCornerType = (RoundedCornerDefault, RoundedCornerOff, RoundedCornerOn, RoundedCornerSmall);

procedure SetRoundedCorners(const TheHandle: HWND; const CornerType: TRoundedWindowCornerType);

implementation

const
  DWMWCP_DEFAULT    = 0; // �ý����� â �𼭸��� �ձ۰� ������ �����ϵ��� �մϴ�.
  DWMWCP_DONOTROUND = 1; // â �𼭸��� ���� �ձ۰� ������ �ʽ��ϴ�.
  DWMWCP_ROUND      = 2; // ������ ��� â �𼭸��� �ձ۰� ����ϴ�.
  DWMWCP_ROUNDSMALL = 3; // ������ ��� ���� �ݰ����� â �𼭸��� �ձ۰� ����ϴ�.

  DWMWA_WINDOW_CORNER_PREFERENCE = 33; // â �𼭸� ��å�� �����ϴ� ��

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

