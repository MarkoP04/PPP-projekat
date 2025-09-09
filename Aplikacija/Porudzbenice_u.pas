unit Porudzbenice_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FireDAC.Stan.Param;

type
  TForm8 = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure LoadButtons;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.fmx}

uses
Program_u;

procedure TForm8.LoadButtons;
var
  Btn: TButton;
  I: Integer;
begin

  for I := ScrollBox1.ControlsCount - 1 downto 0 do
    if ScrollBox1.Controls[I] is TButton then
      ScrollBox1.Controls[I].Free;

  Form1.FDQuery1.Close;
  Form1.FDQuery1.SQL.Text := 'SELECT datum FROM Porudzbenice';
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

procedure TForm8.Button2Click(Sender: TObject);
begin
Edit1.Text := '';
end;

procedure TForm8.Button3Click(Sender: TObject);
var
DobavljacID: Integer;

begin
  Form1.FDQuery1.SQL.Text := 'SELECT dobavljac_id FROM Dobavljac WHERE ime = :pIme';
  Form1.FDQuery1.ParamByName('pIme').AsString := Edit2.Text;
  Form1.FDQuery1.Open;
  DobavljacID := Form1.FDQuery1.FieldByName('dobavljac_id').AsInteger;

  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Porudzbenice (dobavljac_id, porudzbenica, datum) VALUES (:pDobavljac_id, :pPorudzbenica, :pDatum)';

  Form1.FDQueryAction.ParamByName('pDobavljac_id').AsInteger := DobavljacID;
  Form1.FDQueryAction.ParamByName('pPorudzbenica').AsString := Edit1.Text;
  Form1.FDQueryAction.ParamByName('pDatum').AsDateTime := Now;

  try
    Form1.FDQueryAction.ExecSQL;
    ShowMessage('Porudzbenica je uspesno napravljena!');
    LoadButtons;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm8.ButtonClick(Sender: TObject);
var
  Btn: TButton;
begin
  Btn := Sender as TButton;

  Form1.FDQuery1.SQL.Text := 'SELECT porudzbenica, dobavljac_id FROM Porudzbenice WHERE datum = :pDatum';
  Form1.FDQuery1.ParamByName('pDatum').AsString := Btn.Text;
  Form1.FDQuery1.Open;

  Edit1.Text := Form1.FDQuery1.FieldByName('porudzbenica').AsString;
  Label4.Text := Form1.FDQuery1.FieldByName('dobavljac_id').AsString;
end;

procedure TForm8.Button1Click(Sender: TObject);
begin
Form8.Free;
end;

end.
