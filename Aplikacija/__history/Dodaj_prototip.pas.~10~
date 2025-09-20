unit Dodaj_prototip;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FireDAC.Stan.Param;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Label8: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button1: TButton;
    ScrollBox1: TScrollBox;
    Rectangle2: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure LoadButtons;
    procedure ButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    IdejaID: Integer;
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

uses
Ideje_u;

procedure TForm4.LoadButtons;
var
  Btn: TButton;
  I: Integer;
begin

  for I := ScrollBox1.ControlsCount - 1 downto 0 do
    if ScrollBox1.Controls[I] is TButton then
      ScrollBox1.Controls[I].Free;

  Form1.FDQuery1.Close;
  Form1.FDQuery1.SQL.Text := 'SELECT ideja_id, ime FROM Ideje';
  Form1.FDQuery1.Open;

  I := 0;
  while not Form1.FDQuery1.Eof do
  begin
    Btn := TButton.Create(Self);
    Btn.Parent := ScrollBox1;

    Btn.Text := Form1.FDQuery1.FieldByName('ime').AsString;

    Btn.Position.Y := I * 35;
    Btn.Position.X := 10;
    Btn.Width := ScrollBox1.Width - 20;
    Btn.Height := 30;
    Btn.Tag := Form1.FDQuery1.FieldByName('ideja_id').AsInteger;

    Btn.OnClick := ButtonClick;

    Inc(I);
    Form1.FDQuery1.Next;
  end;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  Form4.Free;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Prototipi (ime, prototip, zaduzen, ideja_id) VALUES (:pIme, :pPrototip, :pZaduzen, :pIdeja_id)';

  Form1.FDQueryAction.ParamByName('pIme').AsString := Edit2.Text;
  Form1.FDQueryAction.ParamByName('pPrototip').AsString := Edit1.Text;
  Form1.FDQueryAction.ParamByName('pZaduzen').AsString := Edit3.Text;
  Form1.FDQueryAction.ParamByName('pIdeja_id').AsInteger := IdejaID;

  try
    Form1.FDQueryAction.ExecSQL;
    ShowMessage('Prototip je uspesno dodan.');
    Form4.Free;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm4.ButtonClick(Sender: TObject);
var
  Btn: TButton;
begin
  Btn := Sender as TButton;
  IdejaID := Btn.Tag;
  Label5.Text := Btn.Text;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  LoadButtons;
end;

end.
