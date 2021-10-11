program POPsicle;

uses
  Forms,
  MainForm in 'MainForm.pas' {formMain},
  ServerDetailsForm in 'ServerDetailsForm.pas' {formServerDetails};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformServerDetails, formServerDetails);
  Application.Run;
end.
