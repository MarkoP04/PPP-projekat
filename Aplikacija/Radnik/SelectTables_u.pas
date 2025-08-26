unit SelectTables_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Radnik_u,
  FMX.Controls.Presentation, FMX.StdCtrls, System.JSON, System.Generics.Collections;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
DataModule_u;

procedure TForm1.Button1Click(Sender: TObject);
var
JsonObj: TJSONObject;
i: Integer;
SelectedTables: TList<Integer>;
cb: TCheckBox;
TablesArray: TJSONArray;

begin

SelectedTables := TList<Integer>.Create;
  try
    for i := 0 to Self.ComponentCount - 1 do
    begin
      if Components[i] is TCheckBox then
      begin
        cb := TCheckBox(Components[i]);
        if cb.IsChecked then
          SelectedTables.Add(cb.Tag);
      end;
    end;

    JsonObj := TJSONObject.Create;
    TablesArray := TJSONArray.Create;
    try
    for i in SelectedTables do
      TablesArray.AddElement(TJSONNumber.Create(i));
      JsonObj.AddPair('type', 'selectTables');
      JsonObj.AddPair('worker_id', TJSONNumber.Create(MainForm.WorkerID));
      JsonObj.AddPair('tables', TablesArray);

      DataModule1.SendMessageToServer(JsonObj.ToString);

    finally
      JsonObj.Free;
    end;

  finally
    SelectedTables.Free;
  end;

MainForm.Show;
Form1.Free;
end;

end.
