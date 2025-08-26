unit CocktailFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TFrame2 = class(TFrame)
    Mojito: TButton;
    Moscow_mule: TButton;
    procedure MojitoClick(Sender: TObject);
    procedure Moscow_muleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
Naruci_u;

procedure TFrame2.MojitoClick(Sender: TObject);
var
  NewItemName: string;
  NewQty, Price: Integer;
  ExistingParts: TArray<string>;
  ExistingQty, ExistingPrice: Integer;

begin
  NewItemName := 'Mojito';
  NewQty := 1;
  Price := 480;

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

procedure TFrame2.Moscow_muleClick(Sender: TObject);
var
  NewItemName: string;
  NewQty, Price: Integer;
  ExistingParts: TArray<string>;
  ExistingQty, ExistingPrice: Integer;

begin
  NewItemName := 'Moscow Mule';
  NewQty := 1;
  Price := 520;

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
