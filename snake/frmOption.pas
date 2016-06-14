unit frmOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, IniFiles, ExtCtrls, unitSnakeDefine;

type
  TOptionForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    cbbPatternBG: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbbPatternSnake1: TComboBox;
    cbbPatternFood: TComboBox;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    cbbStartLever: TComboBox;
    Label9: TLabel;
    cbbPatternSnake2: TComboBox;
    Label4: TLabel;
    rgGameMode: TRadioGroup;
    GroupBox4: TGroupBox;
    editUp: TEdit;
    editDown: TEdit;
    editLeft: TEdit;
    editRight: TEdit;
    GroupBox5: TGroupBox;
    EditUp2: TEdit;
    EditDown2: TEdit;
    EditLeft2: TEdit;
    EditRight2: TEdit;
    Label5: TLabel;
    cbbPixSize: TComboBox;
    cbThroughWall: TCheckBox;
    cbPassEach: TCheckBox;
    Panel1: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    cbbPatternBlock: TComboBox;
    procedure cbbPatternBGDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure cbbPatternSnake1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbbPatternFoodDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbbPatternBGChange(Sender: TObject);
    procedure cbbPatternSnake1Change(Sender: TObject);
    procedure cbbPatternFoodChange(Sender: TObject);
    procedure cbbStartLeverChange(Sender: TObject);
    procedure cbbPatternSnake2DrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cbbPatternSnake2Change(Sender: TObject);
    procedure cbbPixSizeChange(Sender: TObject);
    procedure rgGameModeClick(Sender: TObject);
    procedure cbThroughWallClick(Sender: TObject);
    procedure cbPassEachClick(Sender: TObject);
    procedure editUpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editDownKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editLeftKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editRightKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditUp2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditDown2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditLeft2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditRight2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbbPatternBlockChange(Sender: TObject);
    procedure cbbPatternBlockDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    //fPatternBg, fPatternSnake, fPatternFood: byte;
    GameParam: TGameParam;
    SnakeParam1: TSnakeParam;
    SnakeParam2: TSnakeParam;
//    fStartLever: integer;

    procedure LoadParams;
    procedure InitUI;
    procedure DrawCBB(Control: TWinControl;
        Index: Integer; Rect: TRect; State: TOwnerDrawState);

    function CheckPattern: boolean;
  public
    { Public declarations }
  end;

var
  OptionForm: TOptionForm;

implementation

uses unitSnakePub;

{$R *.dfm}       

procedure TOptionForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
        cbbPatternBG.Clear;
        cbbPatternFood.Clear;
        cbbPatternBlock.Clear;
        cbbPatternSnake1.Clear;
        cbbPatternSnake2.Clear;
        cbbStartLever.Clear;
        for i:= 0 to 9 do
                cbbStartLever.Items.Add(IntToStr(i+1));

        for i:=0 to 15 do
        begin
                cbbPatternBG.Items.Add(IntToStr(i+1));
                cbbPatternFood.Items.Add(IntToStr(i+1));
                cbbPatternBlock.Items.Add(IntToStr(i+1));

                cbbPatternSnake1.Items.Add(IntToStr(i+1));
                cbbPatternSnake2.Items.Add(IntToStr(i+1));
        end;                                            
        LoadParams;
        InitUI;
        
end;

procedure TOptionForm.cbbPatternBGDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
        DrawCBB(Control, Index, Rect, State);
end;

procedure TOptionForm.cbbPatternSnake1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
        DrawCBB(Control, Index, Rect, State);
end;

procedure TOptionForm.cbbPatternSnake2DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
        DrawCBB(Control, Index, Rect, State);
end;

procedure TOptionForm.cbbPatternFoodDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
        DrawCBB(Control, Index, Rect, State);
end;  

procedure TOptionForm.cbbPatternBlockDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
        DrawCBB(Control, Index, Rect, State);
end;

procedure TOptionForm.BitBtn1Click(Sender: TObject);
begin
        if not CheckPattern then exit;
        
        SaveGameParam(GameParam);
        SaveSnakeParam('Snake1', SnakeParam1);
        SaveSnakeParam('Snake2', SnakeParam2);

        self.ModalResult := mrOK; 
end;

function TOptionForm.CheckPattern: boolean;
begin
        result := true;
        if (GameParam.BGPattern = SnakeParam1.Pattern)
                or (GameParam.BGPattern = SnakeParam2.Pattern) then
        begin
                showmessage('老大，蛇与背景图案相同，你能看见蛇吗？^_^');
                result := false;
                exit;
        end;

        if (GameParam.BGPattern = GameParam.FoodPattern) then
        begin
                showmessage('老大，食物与背景图案相同，你能看见食物吗？^_^');
                result := false;
                exit;
        end;

        if (GameParam.BGPattern = GameParam.BlockPattern) then
        begin
                showmessage('老大，障碍与背景图案相同，你能看见障碍吗？^_^');
                result := false;
                exit;
        end;

end;

procedure TOptionForm.LoadParams;
begin
        GameParam := LoadGameParam;
        SnakeParam1 := LoadSnakeParam('Snake1');
        SnakeParam2 := LoadSnakeParam('Snake2');

end;

procedure TOptionForm.InitUI;
begin
        //常规
        rgGameMode.ItemIndex := GameParam.Mode - 1;
        cbbStartLever.ItemIndex := GameParam.StartLever - 1;    //难度
        cbbPixSize.ItemIndex := GameParam.pixPerBlock div 2 - 1;
        cbThroughWall.Checked := GameParam.CanThrghWall;
        cbPassEach.Checked := GameParam.CanPassEachOther;
        //键盘
        editUp.Text := KeyToChar(SnakeParam1.upKey);
        editDown.Text := KeyToChar(SnakeParam1.downKey);
        editLeft.Text := KeyToChar(SnakeParam1.leftKey);
        editRight.Text := KeyToChar(SnakeParam1.rightKey);

        editUp2.Text := KeyToChar(SnakeParam2.upKey);
        editDown2.Text := KeyToChar(SnakeParam2.downKey);
        editLeft2.Text := KeyToChar(SnakeParam2.leftKey);
        editRight2.Text := KeyToChar(SnakeParam2.rightKey);   

        //图案
        cbbPatternBG.ItemIndex := GameParam.BGPattern;
        cbbPatternFood.ItemIndex := GameParam.FoodPattern;
        cbbPatternBlock.ItemIndex := GameParam.BlockPattern;
        cbbPatternSnake1.ItemIndex := SnakeParam1.Pattern;
        cbbPatternSnake2.ItemIndex := SnakeParam2.Pattern;
        
end;

{ 常规 }

procedure TOptionForm.rgGameModeClick(Sender: TObject);
begin
        GameParam.Mode := rgGameMode.ItemIndex + 1;
end;

procedure TOptionForm.cbbStartLeverChange(Sender: TObject);
begin
        GameParam.StartLever := cbbStartLever.ItemIndex + 1;
end;

procedure TOptionForm.cbbPixSizeChange(Sender: TObject);
begin
        GameParam.pixPerBlock := (cbbPixSize.ItemIndex+1)*2;
end;

procedure TOptionForm.cbThroughWallClick(Sender: TObject);
begin
        GameParam.CanThrghWall := cbThroughWall.Checked;
end;

procedure TOptionForm.cbPassEachClick(Sender: TObject);
begin
        GameParam.CanPassEachOther := cbPassEach.Checked;
end;    

{ 图案 }

procedure TOptionForm.cbbPatternBGChange(Sender: TObject);
begin
        GameParam.BGPattern := cbbPatternBG.ItemIndex;
end;

procedure TOptionForm.cbbPatternFoodChange(Sender: TObject);
begin
        GameParam.FoodPattern := cbbPatternFood.ItemIndex;
end;

procedure TOptionForm.cbbPatternBlockChange(Sender: TObject);
begin
        GameParam.BlockPattern := cbbPatternBlock.ItemIndex;
end;

procedure TOptionForm.cbbPatternSnake1Change(Sender: TObject);
begin
        SnakeParam1.Pattern := cbbPatternSnake1.ItemIndex;
end;

procedure TOptionForm.cbbPatternSnake2Change(Sender: TObject);
begin
        SnakeParam2.Pattern := cbbPatternSnake2.ItemIndex;
end;

procedure TOptionForm.DrawCBB(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  tmpBmp: TBitmap;
  srcRect, destRect: TRect;
  i: integer;
begin
        tmpBmp := TBitmap.Create;
        tmpBmp.Width := 256;
        tmpBmp.Height := 256;
        tmpBmp.LoadFromFile(ExtractFilePath(application.ExeName) +'\img\Pat_Sample.bmp');

        srcRect := Bounds(Index*16, 0, 16, 16);  

        for i:= 0 to (Rect.Right-Rect.Left) div 16 - 1 do
        begin
                destRect := Bounds(Rect.Left+16*i, Rect.Top, 16, 16);
                (Control as TComboBox).Canvas.BrushCopy(destRect, tmpBmp,
                        srcRect, clRed);
        end;
        (Control as TComboBox).Canvas.TextOut(destRect.Right, destRect.Top,
                (Control as TComboBox).Items.Strings[Index]); 

        tmpBmp.Free;
end;


{ 键盘配置 }

procedure TOptionForm.editUpKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam1.upKey := Key;
        editUp.Text := KeyToChar(Key);
end;

procedure TOptionForm.editDownKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam1.downKey := Key;
        editDown.Text := KeyToChar(Key);
end;

procedure TOptionForm.editLeftKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam1.leftKey := Key;
        editLeft.Text := KeyToChar(Key);
end;

procedure TOptionForm.editRightKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam1.rightKey := Key;
        editRight.Text := KeyToChar(Key);
end;

procedure TOptionForm.EditUp2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam2.upKey := Key;
        EditUp2.Text := KeyToChar(Key);
end;

procedure TOptionForm.EditDown2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam2.downKey := Key;
        EditDown2.Text := KeyToChar(Key);
end;

procedure TOptionForm.EditLeft2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam2.leftKey := Key;
        EditLeft2.Text := KeyToChar(Key);
end;

procedure TOptionForm.EditRight2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        SnakeParam2.rightKey := Key;
        EditRight2.Text := KeyToChar(Key);
end;

end.
