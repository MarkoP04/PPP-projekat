unit Change_log;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FireDAC.Stan.Param;

type
  TForm10 = class(TForm)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure LoadButtons;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.fmx}

uses
Program_u;

procedure TForm10.LoadButtons;
var
  Btn: TButton;
  I: Integer;
begin

  for I := ScrollBox1.ControlsCount - 1 downto 0 do
    if ScrollBox1.Controls[I] is TButton then
      ScrollBox1.Controls[I].Free;

  Form1.FDQuery1.Close;
  Form1.FDQuery1.SQL.Text := 'SELECT datum FROM Change_log';
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

procedure TForm10.Button1Click(Sender: TObject);
begin
  Form10.Free;
end;

procedure TForm10.Button2Click(Sender: TObject);
begin
Edit1.Text := '';
end;

procedure TForm10.Button3Click(Sender: TObject);
begin

  Form1.FDQueryAction.Close;
  Form1.FDQueryAction.SQL.Text :=
    'INSERT INTO Change_log (log, datum) VALUES (:pLog, :pDatum)';

  Form1.FDQueryAction.ParamByName('pLog').AsString := Edit1.Text;
  Form1.FDQueryAction.ParamByName('pDatum').AsDateTime := Now;

  try
    Form1.FDQueryAction.ExecSQL;
    ShowMessage('Change log je uspesno napravljen!');
    LoadButtons;
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;

procedure TForm10.ButtonClick(Sender: TObject);
var
  Btn: TButton;
begin
  Btn := Sender as TButton;

  Form1.FDQuery1.SQL.Text := 'SELECT log FROM Change_log WHERE datum = :pDatum';
  Form1.FDQuery1.ParamByName('pDatum').AsString := Btn.Text;
  Form1.FDQuery1.Open;

  Edit1.Text := Form1.FDQuery1.FieldByName('log').AsString;
end;

end.
