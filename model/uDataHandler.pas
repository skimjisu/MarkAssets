unit uDataHandler;

interface

uses
  Classes, System.SysUtils, DBProce, Common, DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, Vcl.Dialogs,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCGridCell, VCL.TMSFNCGridOptions,
  VCL.TMSFNCCustomControl, VCL.TMSFNCCustomScrollControl, VCL.TMSFNCGridData, VCL.TMSFNCCustomGrid, VCL.TMSFNCGridDatabaseAdapter, VCL.TMSFNCGrid, VCL.Forms;

type
  TInventoryRecord = record
    AssetCode: string;
    SerialNumber: string;
    iType: string;
    ModelName: string;
    Contract: string;
    EndDate: string;
  end;

type
  TDataHandler = class
  private
    FDBProce: TDBProce;
  public

    constructor Create;
    destructor Destroy; override;
    procedure InsertData(const TableName: string; const Fields, Values: TStringList);

  end;

implementation

constructor TDataHandler.Create;
begin
  FDBProce := TDBProce.GetInstance;
end;

destructor TDataHandler.Destroy;
begin
  FDBProce.Free;
  inherited;
end;

procedure TDataHandler.InsertData(const TableName: string; const Fields, Values: TStringList);
begin
  FDBProce.InsertData(TableName, Fields, Values);
end;




end.

