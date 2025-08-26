program Sank_p;

uses
  System.StartUpCopy,
  FMX.Forms,
  Sank_u in 'Sank_u.pas' {Form1},
  DataModule_u in 'DataModule_u.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
