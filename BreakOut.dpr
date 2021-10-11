program BreakOut;

uses
  Forms,
  frmMain in 'frmMain.pas' {formMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
