unit Oceni;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FireDAC.Stan.Param,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit;

type
  TForm5 = class(TForm)
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label7: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit2: TEdit;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure LoadStavke;
    procedure ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function GetSelectedOcena: Integer;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    PrototipID, StavkaID: Integer;
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

uses
Ideje_u, Prototipi;

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Free;
end;

procedure TForm5.LoadStavke;
var
  Btn: TButton;
  I: Integer;
begin

  for I := ScrollBox1.ControlsCount - 1 downto 0 do
    if ScrollBox1.Controls[I] is TButton then
      ScrollBox1.Controls[I].Free;

  Form1.FDQuery1.Close;
  Form1.FDQuery1.SQL.Text :=
    'SELECT stavka_id, stavka FROM Stavke';
  Form1.FDQuery1.Open;

  I := 0;
  while not Form1.FDQuery1.Eof do
  begin
    Btn := TButton.Create(Self);
    Btn.Parent := ScrollBox1;

    Btn.Text := Form1.FDQuery1.FieldByName('stavka').AsString;

    Btn.Position.Y := I * 35;
    Btn.Position.X := 10;
    Btn.Width := ScrollBox1.Width - 20;
    Btn.Height := 30;
    Btn.Tag := Form1.FDQuery1.FieldByName('stavka_id').AsInteger;

    Btn.OnClick := ButtonClick;

    Inc(I);
    Form1.FDQuery1.Next;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  Ocena: Integer;
begin
  Ocena := GetSelectedOcena;

  if Ocena = 0 then
  begin
    ShowMessage('Zaboravili ste da ocenite prototip! (1–10)');
    Exit;
  end;

  if PrototipID = 0 then
  begin
    ShowMessage('Niste odabrali prototip koji ocenjujete, kliknite na prototip u proslom prozoru pa zatim otvorite ovaj.');
    Exit;
  end;

  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Ocene (prototip_id, stavka_id, ocenio, ocena) VALUES (:pPrototip_id, :pStavka_id, :pOcenio, :pOcena)';

  Form1.FDQueryAction.ParamByName('pPrototip_id').AsInteger := PrototipID;
  Form1.FDQueryAction.ParamByName('pStavka_id').AsInteger := StavkaID;
  Form1.FDQueryAction.ParamByName('pOcenio').AsString := Edit1.Text;
  Form1.FDQueryAction.ParamByName('pOcena').AsInteger := Ocena;

  try
    Form1.FDQueryAction.ExecSQL;
    ShowMessage('Prototip je uspesno ocenjen.');
    Form5.Free;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Stavke (stavka) VALUES (:pStavka)';

  Form1.FDQueryAction.ParamByName('pStavka').AsString := Edit2.Text;

  try
    Form1.FDQueryAction.ExecSQL;
    ShowMessage('Stavka je uspesno dodata.');
    LoadStavke;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  try
    Form1.FDQueryAction.Close;
    Form1.FDQueryAction.SQL.Text :=
      'DELETE FROM Ocene WHERE stavka_id = :pID';
    Form1.FDQueryAction.ParamByName('pID').AsInteger := StavkaID;
    Form1.FDQueryAction.ExecSQL;

    Form1.FDQueryAction.Close;
    Form1.FDQueryAction.SQL.Text :=
      'DELETE FROM Stavke WHERE stavka_id = :pID';
    Form1.FDQueryAction.ParamByName('pID').AsInteger := StavkaID;
    Form1.FDQueryAction.ExecSQL;

    ShowMessage('Stavka je uspesno obrisana.');
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm5.ButtonClick(Sender: TObject);
var
  Btn: TButton;
begin
  Btn := Sender as TButton;
  Label2.Text := Btn.Text;
  StavkaID := Btn.Tag;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  PrototipID := Form3.PrototipID;
  Label6.Text := IntToStr(PrototipID);
  LoadStavke;
end;

function TForm5.GetSelectedOcena: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ComponentCount - 1 do
    if (Components[I] is TRadioButton) then
      if TRadioButton(Components[I]).IsChecked then
        Exit(TRadioButton(Components[I]).Tag);
end;


end.
