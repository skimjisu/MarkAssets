unit uDataHandler;

interface

uses
  Classes, System.SysUtils, DBProce, Common, DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
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
    procedure LoadDataToGrid(const Grid: TTMSFNCGrid);
  end;

implementation

constructor TDataHandler.Create;
begin
  FDBProce := TDBProce.Create(DB_Name);
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

procedure TDataHandler.LoadDataToGrid(const Grid: TTMSFNCGrid);
var
  Data: TStringList;
  MemTable: TFDMemTable;
  DataSource: TDataSource;
  DBAdapter: TTMSFNCGridDatabaseAdapter;
  I, J: Integer;
begin
  // Query data from database
  Data := FDBProce.ReadData('Inventory', 'AssetCode, SerialNumber, Type, ModelName, Contract, EndDate');

  // Create a MemTable and load data into it
  MemTable := TFDMemTable.Create(nil);
  MemTable.FieldDefs.Add('AssetCode', ftString);
  MemTable.FieldDefs.Add('SerialNumber', ftString);
  MemTable.FieldDefs.Add('Type', ftString);
  MemTable.FieldDefs.Add('ModelName', ftString);
  MemTable.FieldDefs.Add('Contract', ftString);
  MemTable.FieldDefs.Add('EndDate', ftString);
  MemTable.CreateDataSet;

  for I := 0 to Data.Count - 1 do
  begin
    MemTable.Append;
    for J := 0 to MemTable.FieldCount - 1 do
      MemTable.Fields[J].AsString := Data[I].Split([','])[J]; // Assumes fields are comma-separated
    MemTable.Post;
  end;

  // Create a DataSource and link it to the MemTable
  DataSource := TDataSource.Create(nil);
  DataSource.DataSet := MemTable;

  // Create a DatabaseAdapter and link it to the DataSource
  DBAdapter := TTMSFNCGridDatabaseAdapter.Create(nil);
  DBAdapter.DataSource := DataSource;

  // Link the grid to the DatabaseAdapter
  Grid.BeginUpdate;
  try
    Grid.Adapter := DBAdapter;
  finally
    Grid.EndUpdate;
  end;

  Data.Free;
  MemTable.Free;
  DataSource.Free;
  DBAdapter.Free;
end;









end.

