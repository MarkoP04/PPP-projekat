unit Izvestaj_test;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FireDAC.Stan.Param;

type
  TForm6 = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure LoadButtons;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.fmx}

uses
Program_u;

procedure TForm6.Button1Click(Sender: TObject);
begin
  Form6.Free;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Edit1.Text := '';
end;

procedure TForm6.Button3Click(Sender: TObject);
begin

  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Izvestaji (vrsta, izvestaj, datum) VALUES (:pVrsta, :pIzvestaj, :pDatum)';

  Form1.FDQueryAction.ParamByName('pVrsta').AsInteger := 1;
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

procedure TForm6.LoadButtons;
var
  Btn: TButton;
  I: Integer;
begin

  for I := ScrollBox1.ControlsCount - 1 downto 0 do
    if ScrollBox1.Controls[I] is TButton then
      ScrollBox1.Controls[I].Free;

  Form1.FDQuery1.Close;
  Form1.FDQuery1.SQL.Text := 'SELECT datum FROM Izvestaji WHERE vrsta = 1';
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

procedure TForm6.ButtonClick(Sender: TObject);
var
  Btn: TButton;
begin
  Btn := Sender as TButton;

  Form1.FDQuery1.SQL.Text := 'SELECT izvestaj FROM Izvestaji WHERE datum = :pDatum';
  Form1.FDQuery1.ParamByName('pDatum').AsString := Btn.Text;
  Form1.FDQuery1.Open;

  Edit1.Text := Form1.FDQuery1.FieldByName('izvestaj').AsString;
end;

end.
