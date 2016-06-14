unit frmHighScore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, inifiles, Buttons;

type
  THighScoreForm = class(TForm)
    lbHighScore: TListBox;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure LoadHighScore;
  public
    { Public declarations }
  end;

var
  HighScoreForm: THighScoreForm;

implementation

uses unitSnakeDefine;

{$R *.dfm}

{ THighScoreForm }

procedure THighScoreForm.LoadHighScore;
begin
        lbHighScore.Clear;
        //µÇ¼Ç·ÖÊý
        lbHighScore.Items.LoadFromFile(ExtractFilePath(application.ExeName)+'\HighScore.hsc');

end;

procedure THighScoreForm.FormCreate(Sender: TObject);
begin
        LoadHighScore;
end;

procedure THighScoreForm.SpeedButton1Click(Sender: TObject);
begin
        close;
end;

end.
