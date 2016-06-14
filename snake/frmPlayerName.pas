unit frmPlayerName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, unitSnakeDefine;

type
  TPlayerNameForm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    lblGrade: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    FPlayerName: string;
    fSnakeParam: TSnakeParam;

    procedure SetPlayerName(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure LoadParam(Player: string);

    property PlayerName: string read FPlayerName write SetPlayerName;

  end;

var
  PlayerNameForm: TPlayerNameForm;

implementation

uses unitSnakePub;

{$R *.dfm}

{ TPlayerNameForm }

procedure TPlayerNameForm.SetPlayerName(const Value: string);
begin
        FPlayerName := Value;
end;

procedure TPlayerNameForm.BitBtn1Click(Sender: TObject);
begin
        fSnakeparam.Name := Trim(edit1.Text);
        SaveSnakeParam(FPlayerName, fSnakeParam);
        close;
end;  

procedure TPlayerNameForm.LoadParam(Player: string);
begin
        FPlayerName := Player;
        fSnakeParam := LoadSnakeParam(FPlayerName);
        edit1.Text := fSnakeparam.Name;        
end;

end.
