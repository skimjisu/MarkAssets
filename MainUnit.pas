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
  MenuCaptions: array[0..3] of string = ('�ڻ���Ȳ', '�����', '�κ��丮', '��Ÿ');
begin
  // ���� �޴� �г� ����
  //TPanel.Create()
  MenuPanel := TPanel.Create(Self);
  with MenuPanel do
  begin
    Parent := Self;
    Align := alLeft;
    Width := 200;
  end;

  // �޴� ��ư ����
  for i := 0 to High(MenuCaptions) do
  begin
    MenuButton := TButton.Create(Self);
    with MenuButton do
    begin
      Parent := MenuPanel;
      Caption := MenuCaptions[i];
      Top := i * 50;  // ��ư ��ġ ����
      Height := 40;  // ��ư ���� ����
      Width := MenuPanel.Width; // ��ư ���� ����
    end;
  end;

  // ������ �׸��� ����
  Grid := TStringGrid.Create(Self);
  with Grid do
  begin
    Parent := Self;
    Align := alClient;
    // �׸��� ����...
  end;
end;

end.
