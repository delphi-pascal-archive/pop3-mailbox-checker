unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, Menus, ActnList, IniFiles,
  IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdPOP3, IdMessage;

type
  TformMain = class(TForm)
    lstvMessages: TListView;
    memoLog: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    cboxServerList: TComboBox;
    actnlstMain: TActionList;
    actnConnect: TAction;
    actnDisconnect: TAction;
    actnHeaders: TAction;
    actnEditServer: TAction;
    actnNewServer: TAction;
    actnDeleteServer: TAction;
    pmenuServers: TPopupMenu;
    New1: TMenuItem;
    Edit1: TMenuItem;
    Delete1: TMenuItem;
    POP: TIdPOP3;
    IdAntiFreeze1: TIdAntiFreeze;
    Msg: TIdMessage;
    procedure actnNewServerExecute(Sender: TObject);
    procedure actnEditServerExecute(Sender: TObject);
    procedure actnDeleteServerExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actnlstMainUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure actnConnectExecute(Sender: TObject);
    procedure actnDisconnectExecute(Sender: TObject);
    procedure actnHeadersExecute(Sender: TObject);
  private
    { Private declarations }
    FConnected: Boolean;
    procedure LogMsg(const AMsg: string);
  public
    { Public declarations }
  end;

  TServers = class
  private
    FData: TIniFile;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadServerByName(const AServer: string; var AUsername, APassword: string;
      var APort: Integer);
    procedure SaveServer(const AServer, AUsername, APassword: string; const APort: Integer);
    procedure DeleteServer(const AServer: string);
    procedure GetServerList(AList: TStrings);
  end;

var
  GServerList: TServers;
  formMain: TformMain;

implementation

uses ServerDetailsForm;

{$R *.dfm}

procedure TformMain.actnNewServerExecute(Sender: TObject);
begin
  with formServerDetails do begin
    editHost.Text := '';
    sedtPort.Value := 110;
    editUsername.Text := '';
    editPassword.Text := '';
    if ShowModal = mrOk then begin
      GServerList.SaveServer(editHost.Text, editUsername.Text, editPassword.Text,
        sedtPort.Value);
      cboxServerList.Items.Add(editHost.Text);
    end;
  end;

end;

{ TServers }

constructor TServers.Create;
begin
  FData := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
end;

procedure TServers.DeleteServer(const AServer: string);
begin
  FData.EraseSection(AServer);
end;

destructor TServers.Destroy;
begin
  FreeAndNil(FData);
  inherited;
end;

procedure TServers.GetServerList(AList: TStrings);
begin
  FData.ReadSections(AList);
end;

procedure TServers.LoadServerByName(const AServer: string; var AUsername,
  APassword: string; var APort: Integer);
begin
  AUsername := FData.ReadString(AServer, 'Username', '');
  APassword := FData.ReadString(AServer, 'Password', '');
  APort := FData.ReadInteger(AServer, 'Port', 110);
end;

procedure TServers.SaveServer(const AServer, AUsername, APassword: string;
  const APort: Integer);
begin
  FData.WriteString(AServer, 'Username', AUSername);
  FData.WriteString(AServer, 'Password', APassword);
  FData.WriteInteger(AServer, 'Port', APort);
end;

procedure TformMain.actnEditServerExecute(Sender: TObject);
var
  LUsername: string;
  LPassword: string;
  LPort: Integer;
begin
  if cboxServerList.ItemIndex >= 0 then begin
    GServerList.LoadServerByName(cboxServerList.Text,
      LUsername, LPassword, LPort);
    with formServerDetails do begin
      editHost.Text := cboxServerList.Text;
      editUsername.Text := LUSername;
      editPassword.Text := LPassword;
      sedtPort.Value := LPort;
      if ShowModal = mrOk then begin
        if not AnsiSameText(cboxServerList.Text, editHost.Text) then begin
          GServerList.DeleteServer(cboxServerList.Text);
          GServerList.SaveServer(editHost.Text, editUsername.Text, editPassword.Text,
            sedtPort.Value);
          cboxServerList.Items[cboxServerList.ItemIndex] := editHost.Text;
        end else begin
          GServerList.SaveServer(editHost.Text, editUsername.Text, editPassword.Text,
            sedtPort.Value);
        end;
      end;
    end;
  end;
end;

procedure TformMain.actnDeleteServerExecute(Sender: TObject);
begin
  if cboxServerList.ItemIndex >= 0 then begin
    GServerList.DeleteServer(cboxServerList.Text);
    cboxServerList.Items.Delete(cboxServerList.ItemIndex);
    cboxServerList.Repaint;
  end;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  GServerList.GetServerList(cboxServerList.Items);
  FConnected := False;
end;

procedure TformMain.actnlstMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  i: Integer;
begin
  for i := 0 to actnlstMain.ActionCount - 1 do begin
    if actnlstMain.Actions[i].Category = 'Connected' then begin
      TAction(actnlstMain.Actions[i]).Enabled := FConnected;
    end else begin
      TAction(actnlstMain.Actions[i]).Enabled := not FConnected;
    end;
  end;
  cboxServerList.Enabled := not FConnected;
  Handled := True;
end;

procedure TformMain.actnConnectExecute(Sender: TObject);
var
  LUsername: string;
  LPassword: string;
  LPort: Integer;
begin
  if cboxServerList.ItemIndex >= 0 then begin
    GServerList.LoadServerByName(cboxServerList.Text, LUSername, LPassword, LPOrt);
    POP.Host := cboxServerList.Text;
    POP.Port := LPort;
    // IF with your version of Indy this gives you an "undeclared identifier: Username"
    // replace POP.Username with POP.UserID
    POP.Username := LUsername;
    POP.Password := LPassword;
    try
      LogMsg('Connecting to ' + POP.Host + ':' + IntToStr(POP.Port));
      POP.Connect;
      LogMsg('Connected');
      FConnected := True;
    except
      on E:Exception do begin
        LogMsg('Exception Occurred: ' + E.Message);
      end;
    end;
  end;
end;

procedure TformMain.actnDisconnectExecute(Sender: TObject);
var
  LDel: Boolean;
  i: Integer;
begin
  LDel := False;
  for i := 0 to lstvMessages.Items.Count - 1 do begin
    if lstvMessages.Items[i].Checked then begin
      LDel := True;
      POP.Delete(i+1);
    end;
  end;
  if LDel then begin
    if MessageDlg('You have marked messages to delete. Do you want to delete them on disconnect?',
      mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
      POP.Reset;
    end else begin
      LogMsg('Messages marked for deleting will be purged');
    end;
  end;
  POP.Disconnect;
  LogMsg('Disconnected');
  FConnected := False;
end;

procedure TformMain.actnHeadersExecute(Sender: TObject);
var
  LNumMsg: Integer;
  i: Integer;
  LMsgSize: Integer;
begin
  lstvMessages.Items.Clear;
  try
    LogMsg('Checking number of messages');
    LNumMsg := POP.CheckMessages;
    if LNumMsg > 0 then begin
      LogMsg(IntToStr(LNumMsg) + ' found on server');
      LogMsg('Total Mailbox size: ' + IntToStr(POP.RetrieveMailBoxSize));
      LogMsg('Retrieving ' + IntToStr(LNumMsg) + ' headers');
      for i := 1 to LNumMsg do begin
        LogMsg('Retrieving header for message ' + IntToStr(i));
        Msg.Clear;
        POP.RetrieveHeader(i, Msg);
        with lstvMessages.Items.Add do begin
          Caption := Msg.From.Text;
          SubItems.Add(Msg.Recipients.EMailAddresses);
          SubItems.Add(Msg.Subject);
          LMsgSize := POP.RetrieveMsgSize(i);
          SubItems.Add(IntToStr(LMsgSize));
          case Msg.Priority of
            mpHighest: SubItems.Add('Very High');
            mpHigh: SubItems.Add('High');
            mpNormal: SubItems.Add('Normal');
            mpLow: SubItems.Add('Low');
            mpLowest: SubItems.Add('Very Low');
          end;
        end;
      end;
    end else begin
      LogMsg('No messages found on server');
    end;
  except
    on E:Exception do begin
      LogMsg('Exception Occurred: ' + E.Message);
    end;
  end;
end;

procedure TformMain.LogMsg(const AMsg: string);
begin
  // We do a StringReplace since some Indy Exceptions included CR's and we
  // want the exception to be displayed all on one line
  memoLog.Lines.Add(FormatDateTime('hh:nn:ss', Time) + ' - ' +
     StringReplace(AMsg, #13#10, ' ', [rfReplaceALl]));
end;


initialization
  GServerList := TServers.Create;

finalization
  FreeAndNil(GServerList);

end.
