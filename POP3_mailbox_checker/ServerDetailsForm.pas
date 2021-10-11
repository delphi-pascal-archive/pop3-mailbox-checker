unit ServerDetailsForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TformServerDetails = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    editHost: TEdit;
    editUsername: TEdit;
    editPassword: TEdit;
    sedtPort: TSpinEdit;
    butnOk: TButton;
    butnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formServerDetails: TformServerDetails;

implementation

{$R *.dfm}

end.
