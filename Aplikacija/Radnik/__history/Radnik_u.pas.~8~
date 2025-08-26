unit Radnik_u;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.JSON;

type
  TMainForm = class(TForm)
    btnLogout: TButton;
    procedure btnLogoutClick(Sender: TObject);
  private
    { Private declarations }
  public
    WorkerID, ShiftID, TotalCash, TotalCard, Total: Integer;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
Login_u, DataModule_u;

procedure TMainForm.btnLogoutClick(Sender: TObject);
var
JsonObj: TJSONObject;
begin
 JsonObj := TJSONObject.Create;
    try
      JsonObj.AddPair('type', 'logout');
      JsonObj.AddPair('worker_id', WorkerID);
      JsonObj.AddPair('shift_id', ShiftID);
      JsonObj.AddPair('total_cash', TotalCash);
      JsonObj.AddPair('total_card', TotalCard);
      JsonObj.AddPair('total', Total);

      DataModule1.SendMessageToServer(JsonObj.ToString);
    finally
      JsonObj.Free;
    end;
    Form2 := TForm2.Create(nil);
    Form2.Show;
    MainForm.Free;
end;

end.
