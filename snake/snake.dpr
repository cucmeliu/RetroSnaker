program snake;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainForm},
  unitSnake in 'unitSnake.pas',
  unitSnakeDefine in 'unitSnakeDefine.pas',
  frmOption in 'frmOption.pas' {OptionForm},
  frmHighScore in 'frmHighScore.pas' {HighScoreForm},
  frmPlayerName in 'frmPlayerName.pas' {PlayerNameForm},
  unitMedia in 'unitMedia.pas',
  UnitSnakeThread in 'UnitSnakeThread.pas',
  UnitSnakeWithFood in 'UnitSnakeWithFood.pas',
  unitSnakePub in 'unitSnakePub.pas',
  frmTopic in 'frmTopic.pas' {TopicForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ì°Ê³Éß';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
