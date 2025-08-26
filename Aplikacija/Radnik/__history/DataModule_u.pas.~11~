unit DataModule_u;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, System.Threading, FMX.Dialogs, System.JSON;

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
  private
    ListenThread: TListenThread;
  public
    procedure StartClientConnection;
    procedure SendMessageToServer(const Msg: string);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
Login_u;

constructor TListenThread.Create(AClient: TIdTCPClient);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FClient := AClient;
end;

procedure TListenThread.Execute;
var
  Msg, MsgType: string;
  JSONObj: TJSONObject;
begin
  while not Terminated do
  begin
    try
      Msg := FClient.IOHandler.ReadLn;

      JSONObj := TJSONObject.ParseJSONValue(Msg) as TJSONObject;
      if Assigned(JSONObj) then
      begin
      MsgType := JSONObj.GetValue<string>('type');

      TThread.Synchronize(nil,
        procedure
        begin
        if MsgType = 'login' then
            Form2.HandleLoginResponse(JSONObj)
            else if MsgType = 'order_status' then
            begin
              ShowMessage('Order received successfully!');
            end;
        end);
        JSONObj.Free;
      end;
    except
      on E: Exception do
       begin
        TThread.Synchronize(nil,
          procedure
          begin
            ShowMessage('Lost connection: ' + E.Message);
          end);
         Break;
    end;
  end;
end;
end;

procedure TDataModule1.StartClientConnection;
begin
  try
    if not IdTCPClient1.Connected then
    begin
      IdTCPClient1.Host := 'localhost';
      IdTCPClient1.Port := 6000;
      IdTCPClient1.Connect;

      ListenThread := TListenThread.Create(IdTCPClient1);
    end;
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
