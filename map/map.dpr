program map;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainForm},
  MyGraphi in '..\myGraph\MyGraphi.pas',
  sgr_misc in '..\myGraph\sgr_misc.pas',
  UnitSnakeMap in 'UnitSnakeMap.pas',
  frmMapSize in 'frmMapSize.pas' {MapSizeForm},
  unitMapDefine in 'unitMapDefine.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '…ﬂ––«ß¿Ô';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
