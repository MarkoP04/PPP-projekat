unit Izvestaj_prodaje;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FireDAC.Stan.Param;

type
  TForm7 = class(TForm)
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    Edit1: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LoadButtons;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}

uses
Program_u;

procedure TForm7.LoadButtons;
var
  Btn: TButton;
  I: Integer;
begin

  for I := ScrollBox1.ControlsCount - 1 downto 0 do
    if ScrollBox1.Controls[I] is TButton then
      ScrollBox1.Controls[I].Free;

  Form1.FDQuery1.Close;
  Form1.FDQuery1.SQL.Text := 'SELECT datum FROM Izvestaji WHERE vrsta = 0';
  Form1.FDQuery1.Open;

  I := 0;
  while not Form1.FDQuery1.Eof do
  begin
    Btn := TButton.Create(Self);
    Btn.Parent := ScrollBox1;

    Btn.Text := Form1.FDQuery1.FieldByName('datum').AsString;

    Btn.Position.Y := I * 35;
    Btn.Position.X := 10;
    Btn.Width := ScrollBox1.Width - 20;
    Btn.Height := 30;

    Btn.OnClick := ButtonClick;

    Inc(I);
    Form1.FDQuery1.Next;
  end;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  Edit1.Text := '';
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Izvestaji (vrsta, izvestaj, datum) VALUES (:pVrsta, :pIzvestaj, :pDatum)';

  Form1.FDQueryAction.ParamByName('pVrsta').AsInteger := 0;
  Form1.FDQueryAction.ParamByName('pIzvestaj').AsString := Edit1.Text;
  Form1.FDQueryAction.ParamByName('pDatum').AsDateTime := Now;

  try
    Form1.FDQueryAction.ExecSQL;
    ShowMessage('Izvestaj je uspesno sacuvan!');
    LoadButtons;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm7.ButtonClick(Sender: TObject);
var
  Btn: TButton;
begin
  Btn := Sender as TButton;

  Form1.FDQuery1.SQL.Text := 'SELECT izvestaj FROM Izvestaji WHERE datum = :pDatum';
  Form1.FDQuery1.ParamByName('pDatum').AsString := Btn.Text;
  Form1.FDQuery1.Open;

  Edit1.Text := Form1.FDQuery1.FieldByName('izvestaj').AsString;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  Form7.Free;
end;

end.
