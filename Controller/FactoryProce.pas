unit FactoryProce;

interface

uses
  Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Forms, System.Classes, uDashboard, uInventory;

type
  TControlFactory = class
  public
    class function CreateAndSetupPageControl(Parent: TWinControl): TPageControl;
    class function CreateAndSetupTabSheet(PageControl: TPageControl; const Caption: string): TTabSheet;
    class function CreateAndSetupForm(Parent: TWinControl; FormClass: TFormClass): TForm;
  end;

implementation

class function TControlFactory.CreateAndSetupPageControl(Parent: TWinControl): TPageControl;
begin
  Result := TPageControl.Create(Parent);
  Result.Parent := Parent;
  Result.Align := alClient;
end;

class function TControlFactory.CreateAndSetupTabSheet(PageControl: TPageControl; const Caption: string): TTabSheet;
begin
  Result := TTabSheet.Create(PageControl);
  Result.PageControl := PageControl;
  Result.Caption := Caption;
  //Result.Visible := False;
end;

class function TControlFactory.CreateAndSetupForm(Parent: TWinControl; FormClass: TFormClass): TForm;
begin
  Result := FormClass.Create(Parent);
  Result.Parent := Parent;
  Result.Align := alClient;
  //Result.BorderStyle := bsNone;
  Result.Visible := true;
end;

end.


end.
