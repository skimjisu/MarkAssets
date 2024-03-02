unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids;

type
  TMainfrm = class(TForm)
   // Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Mainfrm: TMainfrm;

implementation

{$R *.dfm}

procedure TMainfrm.FormCreate(Sender: TObject);
var
  MenuPanel: TPanel;
  MenuButton: TButton;
  Grid: TStringGrid;
  i: Integer;
  const
  MenuCaptions: array[0..3] of string = ('자산현황', '사용자', '인벤토리', '기타');
begin
  // 왼쪽 메뉴 패널 생성
  //TPanel.Create()
  MenuPanel := TPanel.Create(Self);
  with MenuPanel do
  begin
    Parent := Self;
    Align := alLeft;
    Width := 200;
  end;

  // 메뉴 버튼 생성
  for i := 0 to High(MenuCaptions) do
  begin
    MenuButton := TButton.Create(Self);
    with MenuButton do
    begin
      Parent := MenuPanel;
      Caption := MenuCaptions[i];
      Top := i * 50;  // 버튼 위치 조정
      Height := 40;  // 버튼 높이 설정
      Width := MenuPanel.Width; // 버튼 넓이 설정
    end;
  end;

  // 오른쪽 그리드 생성
  Grid := TStringGrid.Create(Self);
  with Grid do
  begin
    Parent := Self;
    Align := alClient;
    // 그리드 설정...
  end;
end;

end.
