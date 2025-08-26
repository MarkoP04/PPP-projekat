unit CoffeeFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFrame1 = class(TFrame)
    Espresso: TButton;
    Domaca: TButton;
    procedure EspressoClick(Sender: TObject);
    procedure DomacaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
Naruci_u;

procedure TFrame1.DomacaClick(Sender: TObject);
var
  NewItemName: string;
  NewQty, Price: Integer;
  ExistingParts: TArray<string>;
  ExistingQty, ExistingPrice: Integer;

begin
  NewItemName := 'Domaca';
  NewQty := 1;
  Price := 120;

  if Form2.FItems.IndexOfName(NewItemName) <> -1 then
  begin
    ExistingParts := Form2.FItems.Values[NewItemName].Split([',']);
    if Length(ExistingParts) = 2 then
    begin
      ExistingQty := StrToIntDef(ExistingParts[0], 0);
      ExistingPrice := StrToIntDef(ExistingParts[1], 0);
      NewQty := ExistingQty + NewQty;
      Price := ExistingPrice + Price;
    end;
  end;

  Form2.FItems.Values[NewItemName] := IntToStr(NewQty) + ',' + IntToStr(Price);
  Form2.AddItemsDisplay;
end;

procedure TFrame1.EspressoClick(Sender: TObject);
var
  NewItemName: string;
  NewQty, Price: Integer;
  ExistingParts: TArray<string>;
  ExistingQty, ExistingPrice: Integer;

begin
  NewItemName := 'Espresso';
  NewQty := 1;
  Price := 140;

  if Form2.FItems.IndexOfName(NewItemName) <> -1 then
  begin
    ExistingParts := Form2.FItems.Values[NewItemName].Split([',']);
    if Length(ExistingParts) = 2 then
    begin
      ExistingQty := StrToIntDef(ExistingParts[0], 0);
      ExistingPrice := StrToIntDef(ExistingParts[1], 0);
      NewQty := ExistingQty + NewQty;
      Price := ExistingPrice + Price;
    end;
  end;

  Form2.FItems.Values[NewItemName] := IntToStr(NewQty) + ',' + IntToStr(Price);
  Form2.AddItemsDisplay;
end;

end.
