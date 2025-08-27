unit Sank_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, System.JSON, System.Generics.Collections, DataModule_u;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ScrollBox1: TScrollBox;
    procedure AddOrder(const JsonObj: TJSONObject);
    procedure AddOrderButton(const Table: Integer; const OrderText: string);
    procedure OrderButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  SelectedButton: TButton;

implementation

{$R *.fmx}

procedure TForm1.AddOrder(const JsonObj: TJSONObject);
var
  ItemsArray: TJSONArray;
  ItemObj: TJSONObject;
  i: Integer;
  TableNum: Integer;
  BtnText: string;
begin
  try
    TableNum := JsonObj.GetValue<Integer>('table');
    ItemsArray := JsonObj.GetValue<TJSONArray>('items');

    BtnText := Format('Table %d', [TableNum]) + sLineBreak;

    for i := 0 to ItemsArray.Count - 1 do
    begin
      ItemObj := ItemsArray.Items[i] as TJSONObject;
      BtnText := BtnText + Format('%s x%d  %d RSD',
        [ItemObj.GetValue<string>('name'),
         ItemObj.GetValue<Integer>('quantity'),
         ItemObj.GetValue<Integer>('price')]) + sLineBreak;
    end;
    AddOrderButton(TableNum, BtnText);
  finally
    JsonObj.Free;
  end;
end;

procedure TForm1.AddOrderButton(const Table: Integer; const OrderText: string);
var
  Btn: TButton;
begin
  Btn := TButton.Create(ScrollBox1);
  Btn.Parent := ScrollBox1;
  Btn.Align := TAlignLayout.Top;
  Btn.Text := OrderText;
  Btn.Tag := Table;
  Btn.WordWrap := True;
  Btn.Height := 100;
  Btn.OnClick := OrderButtonClick;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if Assigned(SelectedButton) then
  begin
    SelectedButton.Parent := nil;
    SelectedButton.Free;
    SelectedButton := nil;
  end
  else
    ShowMessage('No order selected!');
end;

procedure TForm1.OrderButtonClick(Sender: TObject);
begin
  if Sender is TButton then
  begin
    if Assigned(SelectedButton) then
      SelectedButton.StyleLookup := 'buttonstyle';

    SelectedButton := TButton(Sender);
    SelectedButton.StyleLookup := 'listboxitemselectedstyle';
  end;
end;

end.
