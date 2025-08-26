unit Naruci_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, System.JSON, FMX.Layouts, FMX.ListBox;

type
  TForm2 = class(TForm)
    btnDomaca: TButton;
    IdTCPClient1: TIdTCPClient;
    listBoxItems: TListBox;
    btnNaruci: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnDomacaClick(Sender: TObject);
    procedure SendItems;
    procedure AddItemsDisplay;
    procedure btnNaruciClick(Sender: TObject);
    procedure ClearItems;
  private
    FItems: TStringList;
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses
Gost_u;

procedure TForm2.btnDomacaClick(Sender: TObject);
var
  NewItemName: string;
  NewQty, Price: Integer;
  ExistingParts: TArray<string>;
  ExistingQty, ExistingPrice: Integer;
begin
  NewItemName := 'Domaca';
  NewQty := 1;
  Price := 120;

  if FItems.IndexOfName(NewItemName) <> -1 then
  begin
    ExistingParts := FItems.Values[NewItemName].Split([',']);
    if Length(ExistingParts) = 2 then
    begin
      ExistingQty := StrToIntDef(ExistingParts[0], 0);
      ExistingPrice := StrToIntDef(ExistingParts[1], 0);
      NewQty := ExistingQty + NewQty;
      Price := ExistingPrice + Price;
    end;
  end;

  FItems.Values[NewItemName] := IntToStr(NewQty) + ',' + IntToStr(Price);
  AddItemsDisplay;
end;

procedure TForm2.btnNaruciClick(Sender: TObject);
begin
Form1.Show;
Form2.Hide;
SendItems;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  IdTCPClient1.Connect;
  FItems := TStringList.Create;
  FItems.NameValueSeparator := ',';
end;

procedure TForm2.AddItemsDisplay;
var
  i: Integer;
  Parts: TArray<string>;
begin
  listBoxItems.Clear;
  for i := 0 to FItems.Count - 1 do
  begin
    Parts := FItems.ValueFromIndex[i].Split([',']);
    if Length(Parts) = 2 then
      listBoxItems.Items.Add(FItems.Names[i] + ' x ' + Parts[0] + '     ' + Parts[1] + ' RSD');
  end;
end;

procedure TForm2.SendItems;
var
  JSONObject: TJSONObject;
  ItemsArray: TJSONArray;
  ItemObj: TJSONObject;
  i: Integer;
  Parts: TArray<string>;
begin
  JSONObject := TJSONObject.Create;
  ItemsArray := TJSONArray.Create;
  try
    JSONObject.AddPair('type', 'order');
    JSONObject.AddPair('table', Form1.TableNum);
    for i := 0 to FItems.Count - 1 do
    begin
      Parts := FItems.ValueFromIndex[i].Split([',']);
      if Length(Parts) < 2 then
        Continue;

      ItemObj := TJSONObject.Create;
      ItemObj.AddPair('name', FItems.Names[i]);
      ItemObj.AddPair('quantity', TJSONNumber.Create(StrToIntDef(Parts[0], 0)));
      ItemObj.AddPair('price', TJSONNumber.Create(StrToIntDef(Parts[1], 0)));
      ItemsArray.Add(ItemObj);
    end;
    JSONObject.AddPair('items', ItemsArray);

    IdTCPClient1.IOHandler.WriteLn(JSONObject.ToString);
  finally
    JSONObject.Free;
  end;
end;

procedure TForm2.ClearItems;
begin
  FItems.Clear;
  listBoxItems.Clear;
end;

end.
