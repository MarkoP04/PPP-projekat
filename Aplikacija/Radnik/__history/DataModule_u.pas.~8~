unit DataModule_u;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, System.Threading, FMX.Dialogs;

type

TListenThread = class(TThread)
  private
    FClient: TIdTCPClient;
  protected
    procedure Execute; override;
  public
    constructor Create(AClient: TIdTCPClient);
  end;

  TDataModule1 = class(TDataModule)
    IdTCPClient1: TIdTCPClient;
    procedure StartClientConnection;
  private
    ListenThread: TListenThread;
  public
    procedure SendMessageToServer(const Msg: string);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TListenThread.Create(AClient: TIdTCPClient);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FClient := AClient;
end;

procedure TListenThread.Execute;
var
  Msg: string;
begin
  while not Terminated do
  begin
    try
      Msg := FClient.IOHandler.ReadLn;

      TThread.Synchronize(nil,
        procedure
        begin
          // Handle message from server here (example: show message)
          ShowMessage('Received from server: ' + Msg);
        end);
    except
      on E: Exception do
      begin
        ShowMessage('Lost connection with the server, error msg: ' + E.Message);
        Break;
      end;
    end;
  end;
end;

procedure TDataModule1.StartClientConnection;
begin
  try
    IdTCPClient1.Host := 'localhost';
    IdTCPClient1.Port := 6000;
    IdTCPClient1.Connect;

    //ListenThread := TListenThread.Create(IdTCPClient1);
  except
    on E: Exception do
      ShowMessage('Failed to connect: ' + E.Message);
  end;
end;

procedure TDataModule1.SendMessageToServer(const Msg: string);
begin
  if IdTCPClient1.Connected then
    IdTCPClient1.IOHandler.WriteLn(Msg);
end;

end.
