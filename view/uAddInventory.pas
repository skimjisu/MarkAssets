unit uAddInventory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Data.DB, FireDAC.Comp.Client, uInventory,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.TMSFNCTypes, Vcl.TMSFNCUtils, Vcl.TMSFNCGraphics, Vcl.TMSFNCGraphicsTypes, Vcl.TMSFNCCustomControl,
  Vcl.TMSFNCCustomPicker,
  Vcl.TMSFNCComboBox, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, DBProce, FireDAC.Stan.Param, Common;

type
  TAddFrm = class(TForm)
    MainPanel: TPanel;
    AssetCode_lb: TLabel;
    Label2: TLabel;
    Serial_lb: TLabel;
    Model_lb: TLabel;
    AssetID_lb: TLabel;
    Type_lb: TLabel;
    pnl_Top: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    AssetCodePanel: TPanel;
    Shape1: TShape;
    AssetEdit: TEdit;
    SerialPanel: TPanel;
    Shape2: TShape;
    SerialEdit: TEdit;
    ModelPanel: TPanel;
    Shape3: TShape;
    ModelEdit: TEdit;
    AssetIDPanel: TPanel;
    Shape4: TShape;
    Edit4: TEdit;
    TypePanel: TPanel;
    TypeCombo: TTMSFNCComboBox;
    Contract_lb: TLabel;
    ContractPanel: TPanel;
    Shape5: TShape;
    ContractEdit: TEdit;
    EndDate_lb: TLabel;
    EndDatePanel: TPanel;
    Shape6: TShape;
    EndDateEdit: TEdit;
    Button1: TButton;
    Button2: TButton;

    procedure pnl_TopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDBProce: TDBProce;
  public
    { Public declarations }
    InvFrm: TInvFrm;

  end;

var
  AddFrm: TAddFrm;

implementation

{$R *.dfm}

procedure TAddFrm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TAddFrm.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TAddFrm.pnl_TopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TAddFrm.Button1Click(Sender: TObject);
var
  SQL: string;
  Query, UpdateQuery: TFDQuery;
begin

  SQL := 'INSERT INTO inventory (AssetCode, SerialNumber, Type, ModelName, Contract, EndDate) ' +
    'VALUES (:AssetCode, :SerialNumber, :Type, :ModelName, :Contract, :EndDate)';

  // 쿼리 객체를 생성
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := TDBProce.GetInstance.FDConnection; // 싱글턴 인스턴스에서 FDConnection 가져오기

    Query.SQL.Text := SQL;

    Query.ParamByName('AssetCode').AsString := 'A001';
    Query.ParamByName('SerialNumber').AsString := 'SN001';
    Query.ParamByName('Type').AsString := 'Laptop';
    Query.ParamByName('ModelName').AsString := 'XPS 15';
    Query.ParamByName('Contract').AsString := 'Basic';
    Query.ParamByName('EndDate').AsDate := Now + 365; // 현재로부터 1년 후

    // 쿼리 실행
    Query.ExecSQL;

    ShowMessage('데이터가 성공적으로 추가되었습니다.');

  finally
    Query.Free;
  end;

end;

end.
