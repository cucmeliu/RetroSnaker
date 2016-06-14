unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, Buttons, ExtCtrls, ComCtrls, ActnList,
  ToolWin, Menus, MPlayer, iniFiles, ExtDlgs, Math, unitMedia, mmSystem,
  UnitSnakeWithFood, unitSnakeDefine, shellapi;

type
  TBmpPattern = record
    BackGround, Snake, Food: byte;
  end;
  
  TMainForm = class(TForm)
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    actStart: TAction;
    actStop: TAction;
    actPause: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    actExit: TAction;
    N2: TMenuItem;
    E1: TMenuItem;
    actGameNew: TAction;
    N3: TMenuItem;
    C1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    actUp: TAction;
    actDown: TAction;
    actLeft: TAction;
    actRight: TAction;
    actOption: TAction;
    mnuSet: TMenuItem;
    N8: TMenuItem;
    mnuSetLever: TMenuItem;
    mnuLever1: TMenuItem;
    mnuLever2: TMenuItem;
    mnuLever3: TMenuItem;
    mnuLever4: TMenuItem;
    mnuSetPattern: TMenuItem;
    ptBG2: TMenuItem;
    ptBG3: TMenuItem;
    ptBG4: TMenuItem;
    N18: TMenuItem;
    ptBG1: TMenuItem;
    mnuSetMusic0: TMenuItem;
    mnuSetMusic1: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    actThroughWall: TAction;
    actHighScore: TAction;
    N25: TMenuItem;
    N26: TMenuItem;
    actAbout: TAction;
    A1: TMenuItem;
    actLever: TAction;
    mnuLever5: TMenuItem;
    actPatternBG: TAction;
    actSaveGrapic: TAction;
    N10: TMenuItem;
    N11: TMenuItem;
    spd: TSavePictureDialog;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    mnuSetPixSize: TMenuItem;
    mnuPixSize3: TMenuItem;
    mnuPixSize2: TMenuItem;
    mnuPixSize1: TMenuItem;
    actPixSize: TAction;
    mnuPixSize4: TMenuItem;
    actSaveParam: TAction;
    actPlayerName: TAction;
    actPlayerName1: TMenuItem;
    actPlayMusic: TAction;
    mnuSetMusic2: TMenuItem;
    N7: TMenuItem;
    actOnTop: TAction;
    Timer2: TTimer;
    Panel1: TPanel;
    lblScore1: TLabel;
    lblLever1: TLabel;
    Panel2: TPanel;
    lblScore2: TLabel;
    lblLever2: TLabel;
    lblName2: TLabel;
    lblName1: TLabel;
    N9: TMenuItem;
    N14: TMenuItem;
    actPlayerName2: TAction;
    T1: TMenuItem;
    N19: TMenuItem;
    actTopic: TAction;
    N20: TMenuItem;
    N21: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    ActUseMap: TAction;
    ActLoadMap: TAction;
    ActMakeMap: TAction;
    N29: TMenuItem;
    N30: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure actGameNewExecute(Sender: TObject);
    procedure actUpExecute(Sender: TObject);
    procedure actDownExecute(Sender: TObject);
    procedure actLeftExecute(Sender: TObject);
    procedure actRightExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actStartExecute(Sender: TObject);
    procedure actPauseExecute(Sender: TObject);
    procedure actThroughWallExecute(Sender: TObject);
    procedure actHighScoreExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actLeverExecute(Sender: TObject);
    procedure actPatternBGExecute(Sender: TObject);
    procedure actSaveGrapicExecute(Sender: TObject);
    procedure actOptionExecute(Sender: TObject);
    procedure actPixSizeExecute(Sender: TObject);
    procedure actPlayerNameExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actPlayMusicExecute(Sender: TObject);
    procedure actOnTopExecute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure actPlayerName2Execute(Sender: TObject);
    procedure actTopicExecute(Sender: TObject);
//    procedure N21Click(Sender: TObject);
    procedure ActUseMapExecute(Sender: TObject);
    procedure ActLoadMapExecute(Sender: TObject);
    procedure ActMakeMapExecute(Sender: TObject);
  private
    { Private declarations }
    fSnake: TSnakeWithFood;
    fSnake2:TSnakeWithFood;     

    fGameParam: TGameParam;
    fSnakeParam: TSnakeParam;
    fSnakeParam2: TSnakeParam;

    BufBmp: TBitmap;            //双缓冲背景中的绘图区
    BGBmp: TBitmap;             //背景图案
    FoodBmp: TBitmap;           //存储食物的图案
    BlockBmp: TBitmap;
    SnakeSecBmp, SnakeSecBmp2: TBitmap;       //存储蛇的一节的图案
    mapRect: TRect;
    patternRect: TRect;         //图案的区域（因为蛇的一节与食物区域设为相同，故共用之）
//    pixPerBlock: integer;       //田字形表示，坐标点为中间交点，一个田字为四个block组成
    //  _____
    // |  |  |
    // |__.__|
    // |  |  |
    // |__|__|
    pixMatrix: TRect;           //点阵区域
    foodPoint: TPoint;          //食物所在点阵位置

    //以下为添加障碍物
    FMatrix: array of array of byte;
    FGridNum: integer;

    procedure ClearSnakeTail(ASnake: TSnakeWithFood);
    procedure CreateASnake;  
    procedure ChangeMusic;
    procedure CheckASnake(ASnake: TSnakeWithFood);

    procedure DrawBG;
    procedure DrawSnake(ASnake: TSnakeWithFood); overload;
    procedure DrawSnake(ASnake: TSnakeWithFood;
        patternBmp: TBitmap; ACanvas: TCanvas); overload;
    procedure DrawSnakeHead(ASnake: TSnakeWithFood); overload;
    procedure DrawSnakeHead(ASnake: TSnakeWithFood;
        patternBmp: TBitmap; ACanvas: TCanvas); overload;
    procedure DrawSnake1;
    procedure DrawSnake2;
    procedure DrawSnakeHead1;
    procedure DrawSnakeHead2;
    procedure DrawFood;
//    procedure DrawASec(APoint: TPoint; patternBmp: TBitmap; ACanvas: TCanvas);

    procedure InitUI;
    procedure InitParams;
    procedure InitSnakes;

    procedure LoadBmps;
    procedure LoadParams;

    procedure ResetLever;
    procedure RegScore(AScore: integer; AName: string); overload;
    procedure RegScore(ASnake: TSnakeWithFood); overload;
    procedure RegScore(ASnake, BSnake: TSnakeWithFood); overload;

    procedure ShowScore1;
    procedure ShowLever1;
    procedure ShowScore2;
    procedure ShowLever2;
    procedure SaveParams;

    //以下为增加了障碍物功能
    function CheckFoodBlock(FoodPoint: TPoint): boolean;
    procedure CreateMatrix(gridNum: integer);
    procedure LoadMap(mapFile: string);
    procedure ResetGridNum(BlockSize: integer);
    function HitBlock(SnakeHead: TPoint): boolean; 

  public
    { Public declarations }
  end;

  procedure MyAboutWin(AHandle: THandle; appName, appVersion: PChar); stdcall; external 'myCommDialogs.dll';


var
  MainForm: TMainForm;

implementation

uses frmOption, frmHighScore, unitSnakePub, frmPlayerName, frmTopic;

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
        self.Caption := AppName;

        BufBmp := TBitmap.Create;
        BGBmp := TBitmap.Create;
        FoodBmp := TBitmap.Create;
        BlockBmp := TBitmap.Create;
        SnakeSecBmp := TBitmap.Create;
        SnakeSecBmp2 := TBitmap.Create;

        fSnakeParam.StartPt := Point(2, 2);
        fSnakeParam2.StartPt := Point(2, 5);

        InitParams;           

        if fGameParam.UseMap then
        begin
                LoadMap(fGameParam.MapFile);
//                InitSnakes;
        end;
        InitSnakes;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        fSnake.Free;
        BufBmp.Free;
        FoodBmp.Free;
        BlockBmp.Free;
        SnakeSecBmp.Free;
        SnakeSecBmp2.Free;     
        //fmThread.Free;
//        if Assigned(fSnake) then fSnake.Free;
//        if Assigned(fSnake2) then fSnake2.Free;

        action := cafree;

end;  

procedure TMainForm.FormPaint(Sender: TObject);
begin
        DrawBG;
        if Assigned(fSnake) then
                DrawSnake1;//DrawSnake(fSnake);
        if (fGameParam.Mode = 2)
                and Assigned(fSnake2) then
                        DrawSnake2;//DrawSnake(fSnake2);
        DrawFood;

        Canvas.CopyMode := cmSrcCopy;
        Canvas.CopyRect(mapRect, BufBmp.Canvas, mapRect);
        
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        if Key = VK_SPACE then actStart.Execute
        else if Key = fSnakeParam.upKey then fSnake.TurnUp
        else if Key = fSnakeParam.downKey then fSnake.TurnDown
        else if Key = fSnakeParam.leftKey then fSnake.TurnLeft
        else if Key = fSnakeParam.rightKey then fSnake.TurnRight

        else if Key = fSnakeParam2.upKey then
        begin
                if Assigned(fSnake2) then fSnake2.TurnUp;
        end else if Key = fSnakeParam2.downKey then
        begin
                if Assigned(fSnake2) then fSnake2.TurnDown;
        end  else if Key = fSnakeParam2.leftKey then
        begin
                if Assigned(fSnake2) then fSnake2.TurnLeft;
        end  else if Key = fSnakeParam2.rightKey then
        begin
                if Assigned(fSnake2) then fSnake2.TurnRight;
        end     
           {
        case Key of
          VK_Up: fSnake.TurnUp;
          VK_Down: fSnake.TurnDown;
          VK_Left: fSnake.TurnLeft;
          VK_Right: fSnake.TurnRight;

          VK_SPACE: actStart.Execute; //暂停

          ord('w'),
          ord('W'): if Assigned(fSnake2) then fSnake2.TurnUp;
          ord('s'),
          ord('S'): if Assigned(fSnake2) then fSnake2.TurnDown;
          ord('a'),
          ord('A'): if Assigned(fSnake2) then fSnake2.TurnLeft;
          ord('d'),
          ord('D'): if Assigned(fSnake2) then fSnake2.TurnRight;
                            {
          VK_ADD:
                begin
                        if Timer1.Interval > 6 then
                        begin
                                Timer1.Enabled := false;
                                Timer1.Interval := Timer1.Interval - 5; //加速
                                Timer1.Enabled := true;
                        end;
                end;
          VK_SUBTRACT:
                begin
                        Timer1.Enabled := false;
                        Timer1.Interval := Timer1.Interval + 10;
                        Timer1.Enabled := true;
                end;       
        else ;
        end;      }
end;  

(*********************************************************************
//  func：ClearSnakeTail
//  Desc：擦除蛇尾，即用背景图案填充蛇尾位置
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.ClearSnakeTail(ASnake: TSnakeWithFood);
var
  aPoint: TPoint;
begin
                aPoint.X := PPoint(ASnake.fBodyList.Items[ASnake.fBodyList.Count-1]).X;
                aPoint.Y := PPoint(ASnake.fBodyList.Items[ASnake.fBodyList.Count-1]).Y;
                if FMatrix[aPoint.X][aPoint.Y] = 0 then
                        DrawASec(aPoint, BGBmp, fGameParam.pixPerBlock, bufBmp.Canvas)
                else DrawASec(aPoint, BlockBmp, fGameParam.pixPerBlock, bufBmp.Canvas); 

                //DrawASec(aPoint, BGBmp, fGameParam.PixperBlock, bufBmp.Canvas);
end;

(*********************************************************************
//  func：CreateASnake
//  Desc：新游戏开始，创建蛇
                原来是单蛇的，所以用的CreateASnake，加了双蛇后也直接用这个名字：）
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.CreateASnake;
begin
        if Assigned(fSnake) then freeAndNil(fSnake);
        if Assigned(fSnake2) then freeAndNil(fSnake2);

        fSnake := TSnakeWithFood.Create(pixMatrix, fSnakeParam.StartPt);//, Point(5, 5));
        fSnake.Name := fSnakeParam.Name;
        fSnake.ThroughWall := fGameParam.CanThrghWall;
        fSnake.Lever := fGameParam.StartLever;
        fSnake.Params := fSnakeParam;

        lblName1.Caption := fSnakeParam.Name;
        ShowLever1;
        ShowScore1;

        if fGameParam.Mode = 2 then
        begin   
                fSnake2 := TSnakeWithFood.Create(pixMatrix, fSnakeParam2.StartPt);
                fSnake2.Name := fSnakeParam2.Name;
                fSnake2.ThroughWall := fGameParam.CanThrghWall;
                fSnake2.Lever := fGameParam.StartLever;
                fSnake2.Params := fSnakeParam2;

                lblName2.Caption := fSnakeParam2.Name;
                ShowLever2;
                ShowScore2;
        end;

end;

(*********************************************************************
//  func：DrawBG
//  Desc：画背景
                可写成通用函数，用作绘制类似的用矩阵表示的背景
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawBG;
var
  i, j: integer;
  apoint: TPoint;
begin
{
        for i := pixMatrix.Left to pixMatrix.Right do
                for j := pixMatrix.Top to pixMatrix.Bottom do
                begin
                        aPoint.X := i;
                        aPoint.Y := j;
                        DrawASec(aPoint, BGBmp, fGameParam.pixPerBlock, bufBmp.Canvas);
                end;      }

        for i:= 0 to (FGridNum-1) do
                for j:= 0 to (FGridNum-1) do
                begin
                        aPoint.X := i;
                        aPoint.Y := j;

                        if FMatrix[i][j] = 0 then
                                DrawASec(aPoint, BGBmp, fGameParam.pixPerBlock, bufBmp.Canvas)
                        else DrawASec(aPoint, BlockBmp, fGameParam.pixPerBlock, bufBmp.Canvas);
                end;      

end;

(*********************************************************************
//  func：DrawFood
//  Desc：绘制食物
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawFood;
begin
        DrawASec(foodPoint, FoodBmp, fGameParam.pixPerBlock, bufBmp.Canvas);
end;

(*********************************************************************
//  func：DrawSnake1
//  Desc：画蛇1
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawSnake1;
begin
        if Assigned(fSnake) then
                DrawSnake(fSnake, SnakeSecBmp, bufBmp.Canvas);
end;

procedure TMainForm.DrawSnake2;
begin
        if Assigned(fSnake2) then
                DrawSnake(fSnake2, SnakeSecBmp2, bufBmp.Canvas);
end;

(*********************************************************************
//  func：DrawSnakeHead1
//  Desc：画蛇1的头
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawSnakeHead1;
begin
        if Assigned(fSnake) then
                DrawSnakeHead(fSnake, SnakeSecBmp, bufBmp.Canvas);
end;

procedure TMainForm.DrawSnakeHead2;
begin
        if Assigned(fSnake2) then
                DrawSnakeHead(fSnake2, SnakeSecBmp2, bufBmp.Canvas);
end;

(*********************************************************************
//  func：DrawSnake
//  Desc：画蛇，将蛇整体重绘
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawSnake(ASnake: TSnakeWithFood);
var
  i: integer;
  aPoint: TPoint;
begin
        for i:= ASnake.fBodyList.Count-2 downto 0 do
        begin
                aPoint.X := PPoint(ASnake.fBodyList.Items[i]).X;
                aPoint.Y := PPoint(ASnake.fBodyList.Items[i]).Y;
                DrawASec(aPoint, SnakeSecBmp, fGameParam.pixPerBlock, BufBmp.Canvas);
        end; 
end;

(*********************************************************************
//  func：DrawSnake
//  Desc： 参考DrawSnake(ASnake: TSnakeWithFood)
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawSnake(ASnake: TSnakeWithFood;
        patternBmp: TBitmap; ACanvas: TCanvas);
var
  i: integer;
  aPoint: TPoint;
begin
        for i:= ASnake.fBodyList.Count-2 downto 0 do
        begin
                aPoint.X := PPoint(ASnake.fBodyList.Items[i]).X;
                aPoint.Y := PPoint(ASnake.fBodyList.Items[i]).Y;
                DrawASec(aPoint, patternBmp, fGameParam.pixPerBlock, ACanvas);
        end; 
end;

(*********************************************************************
//  func：DrawSnakeHead
//  Desc：画蛇头
                画蛇头蛇尾是为了加快速度的优化过程 (TSnake类有详细说明)
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawSnakeHead(ASnake: TSnakeWithFood);
var
  aPoint: TPoint;
begin
                aPoint.X := PPoint(ASnake.fBodyList.Items[0]).X;
                aPoint.Y := PPoint(ASnake.fBodyList.Items[0]).Y;
                DrawASec(aPoint, SnakeSecBmp, fGameParam.pixPerBlock, bufBmp.Canvas);
end;

(*********************************************************************
//  func：DrawSnakeHead
//  Desc：参考DrawSnakeHead(ASnake: TSnakeWithFood)
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TMainForm.DrawSnakeHead(ASnake: TSnakeWithFood;
  patternBmp: TBitmap; ACanvas: TCanvas);
var
  aPoint: TPoint;
begin
                aPoint.X := PPoint(ASnake.fBodyList.Items[0]).X;
                aPoint.Y := PPoint(ASnake.fBodyList.Items[0]).Y;
                DrawASec(aPoint, patternBmp, fGameParam.pixPerBlock, ACanvas);
end;
                  {
procedure TMainForm.DrawASec(APoint: TPoint; patternBmp: TBitmap; ACanvas: TCanvas);
var
  ARect: TRect;
  dblBlock: integer;
begin
        dblBlock := fGameParam.pixPerBlock*2;
        ARect.Left := APoint.X * dblBlock;
        ARect.Right := APoint.X * dblBlock + dblBlock;
        ARect.Top := 400 - (APoint.Y * dblBlock);
        ARect.Bottom := 400 - (APoint.Y * dblBlock + dblBlock );
        //ACanvas.Rectangle(ARect);
        ACanvas.CopyMode := cmSrcCopy;
        ACanvas.CopyRect(ARect, patternBmp.Canvas, patternRect);
end;    }

procedure TMainForm.InitParams;
var
  dblBlock: integer;
begin
        //读取存储的参数
        LoadParams;
        ResetGridNum(fGameParam.pixPerBlock);
        CreateMatrix(fGridNum);

        //初始化用户界面
        InitUI;
        ResetLever;

        Timer1.Enabled := false;
        Timer2.Enabled := false;

        dblBlock := fGameParam.pixPerBlock * 2;

        mapRect := Rect(0, 0, 400, 400);
        patternRect := Rect(0, 0, dblBlock-1, dblBlock-1);

        pixMatrix.Left := 0;
        pixMatrix.Top := 0;
        pixMatrix.Right := mapRect.Right div dblBlock-1;
        pixMatrix.Bottom := mapRect.Bottom div dblBlock-1;
        
        BufBmp.Width := mapRect.Right - mapRect.Left;
        BufBmp.Height := mapRect.Bottom - mapRect.Top; 
        
        BGBmp.Width := mapRect.Right - mapRect.Left;
        BGBmp.Height := mapRect.Bottom - mapRect.Top;

        FoodBmp.Width := dblBlock;
        FoodBmp.Height := dblBlock;

        BlockBmp.Width := dblBlock;
        BlockBmp.Height := dblBlock;

        SnakeSecBmp.Width := dblBlock;
        SnakeSecBmp.Height := dblBlock;

        SnakeSecBmp2.Width := dblBlock;
        SnakeSecBmp2.Height := dblBlock;
                
        LoadBmps;
              
end;


procedure TMainForm.InitSnakes;
begin
        CreateASnake;

        fSnake.CreateFood;
        while CheckFoodBlock(fSnake.TheFood) do
                fSnake.CreateFood;

        Timer1.Interval := fSnake.Speed;

        foodPoint := fSnake.TheFood;
        if (fGameParam.Mode = 2) and Assigned(fSnake2) then
        begin
                fSnake2.TheFood := foodPoint;
                Timer2.Interval := fSnake2.Speed;
        end;
end;

procedure TMainForm.InitUI;
begin
        actThroughWall.Checked := fGameParam.CanThrghWall;
        ActUseMap.Checked := fGameParam.UseMap;
end;

procedure TMainForm.LoadBmps;
var
  tmpBmp: TBitmap;
  cpRect: TRect;
  dbBlock: integer;
begin
        tmpBmp := TBitmap.Create;
        tmpBmp.Width := 256;
        tmpBmp.Height := 256;
        tmpBmp.LoadFromFile(ExtractFilePath(application.ExeName) + '\img\Pat_Sample.bmp');

        dbBlock := fGameParam.pixPerBlock*2;

        //加载背景图案
        {
        cpRect := Rect(fBmpPattern.BackGround*16, 0,
                fBmpPattern.BackGround*16+dbBlock-1, dbBlock-1);
        BGBmp.Canvas.CopyMode := cmSrcCopy;
        BGBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);
           }
        cpRect := Rect(fGameParam.BGPattern*16, 0,
                fGameParam.BGPattern*16+dbBlock-1, dbBlock-1);
        BGBmp.Canvas.CopyMode := cmSrcCopy;
        BGBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);

        //加载食物图案
        {
        cpRect := Rect(fBmpPattern.Food*16, 0,
                fBmpPattern.Food*16+dbBlock-1, dbBlock-1);
        FoodBmp.Canvas.CopyMode := cmSrcCopy;
        FoodBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);
         }
        cpRect := Rect(fGameParam.FoodPattern*16, 0,
                fGameParam.FoodPattern*16+dbBlock-1, dbBlock-1);
        FoodBmp.Canvas.CopyMode := cmSrcCopy;
        FoodBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);

        //障碍物图案
        cpRect := Rect(fGameParam.BlockPattern*16, 0,
                fGameParam.BlockPattern*16+dbBlock-1, dbBlock-1);
        BlockBmp.Canvas.CopyMode := cmSrcCopy;
        BlockBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);

        //加载蛇1图案
        cpRect := Rect(fSnakeParam.Pattern*16, 0,
                fSnakeParam.Pattern*16+dbBlock-1, dbBlock-1);
        SnakeSecBmp.Canvas.CopyMode := cmSrcCopy;
        SnakeSecBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);

        //加载蛇2图案
        cpRect := Rect(fSnakeParam2.Pattern*16, 0,
                fSnakeParam2.Pattern*16+dbBlock-1, dbBlock-1);
        SnakeSecBmp2.Canvas.CopyMode := cmSrcCopy;
        SnakeSecBmp2.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);
            {
        //
        cpRect := Rect(fSnakeParam.Pattern*16, 0,
                fSnakeParam.Pattern*16+dbBlock-1, dbBlock-1);
        SnakeSecBmp.Canvas.CopyMode := cmSrcCopy;
        SnakeSecBmp.Canvas.CopyRect(patternRect, tmpBmp.Canvas, cpRect);
            }
        tmpBmp.Free;
        
end;  

procedure TMainForm.LoadParams;
begin
        fGameParam := LoadGameParam;
        fSnakeParam := LoadSnakeParam('Snake1');
        fSnakeParam2 := LoadSnakeParam('Snake2');
end;

procedure TMainForm.RegScore(AScore: integer; AName: string);
var
  a: array[1..9] of TScoreRec;
  i: integer;
  hiScore: integer;
  aStrs: TStrings;
  RecCnt: integer;
  frm: TPlayerNameForm;
begin
        aStrs := TStringList.Create;
        aStrs.LoadFromFile(ExtractFilePath(application.ExeName)+'\HighScore.hsc');
        if aStrs.Count < 9 then
        begin
                for i:= 1 to 9 do
                begin
                        a[i].Grade := i;
                        a[i].Name := '无名氏';
                        a[i].Score := 0;
                end;
        end;

        if aStrs.Count > 9 then RecCnt := 9
        else RecCnt := aStrs.Count;

        for i := 1 to RecCnt do
                a[i] := GetAScore(aStrs[i-1]);
        
        hiScore := 0;
        for i:= 1 to 9 do
        begin
                if AScore >= a[i].Score then
                begin
                        a[i].Name := AName;
                        a[i].Score := AScore;
                        hiScore := i;
                        break;
                end;
        end;
        
        if hiScore <> 0 then
        begin
                frm := TPlayerNameForm.Create(nil);
                //frm.Edit1.Text := AName;//fPlayerName;
                frm.LoadParam('Snake1');
                frm.lblGrade.Caption := '你得了第' + IntToStr(hiScore) + '名';
                frm.ShowModal;
                //if trim(frm.PlayerName) <> '' then AName := trim(frm.PlayerName);
                //SaveParams;
                frm.Free;
        end;

        a[hiScore].Name := AName;
        a[hiScore].Score := AScore;
        aStrs.Clear;
        for i:=1 to 9 do
        begin
                aStrs.Add(IntToStr(a[i].Grade)
                        + '  ' + a[i].Name
                        + '  ' + IntToStr(a[i].Score));
        end;
        aStrs.SaveToFile(ExtractFilePath(application.ExeName)+'\HighScore.hsc');

end;   

procedure TMainForm.RegScore(ASnake: TSnakeWithFood);
var
  a: array[1..9] of TScoreRec;
//  hiSc: TScoreRec;
  i: integer;
  hiScore: integer;
  aStrs: TStrings;
  RecCnt: integer;
begin
        aStrs := TStringList.Create;
        aStrs.LoadFromFile(ExtractFilePath(application.ExeName)+'\HighScore.hsc');
        if aStrs.Count < 9 then
        begin
                for i:= 1 to 9 do
                begin
                        a[i].Grade := i;
                        a[i].Name := '无名氏';
                        a[i].Score := 0;
                end;
        end;

        if aStrs.Count > 9 then RecCnt := 9
        else RecCnt := aStrs.Count;

        for i := 1 to RecCnt do
                a[i] := GetAScore(aStrs[i-1]);
        
        hiScore := 0;
        for i:= 1 to RecCnt do
        begin
                if ASnake.Score >= a[i].Score then
                begin
                        //a[i].Name := ASnake.Name;
                        //a[i].Score := ASnake.Score;
                        hiScore := i;
                        break;
                end;
        end;
        
        if hiScore <> 0 then
        begin
        end else exit;

        for i:= 9 downto hiScore+1 do
        begin
                a[i].Name := a[i-1].Name;
                //a[i].Grade := a[i-1].Grade;
                a[i].Score := a[i-1].Score; 
        end;

        a[hiScore].Name := ASnake.Name;
        //a[hiScore].Grade:= hiScore;
        a[hiScore].Score := ASnake.Score;
        
        aStrs.Clear;
        for i:=1 to 9 do
        begin
                aStrs.Add(IntToStr(a[i].Grade)
                        + '  ' + a[i].Name
                        + '  ' + IntToStr(a[i].Score));
        end;
        try
        aStrs.SaveToFile(ExtractFilePath(application.ExeName)+'\HighScore.hsc');
        except
        end;

end;

procedure TMainForm.RegScore(ASnake, BSnake: TSnakeWithFood);
begin
        RegScore(ASnake);
        RegScore(BSnake);
end;

procedure TMainForm.ResetLever;
begin                   //5*N*N + 15*N
        Timer1.Enabled := false;
        Timer1.Interval := 500 - (fGameParam.StartLever-1)*50;
        Timer1.Enabled := true;
        if fGameParam.Mode = 2 then
        begin
        Timer2.Enabled := false;
        Timer2.Interval := 500 - (fGameParam.StartLever-1)*50;
        Timer2.Enabled := true;
        end;
end;

procedure TMainForm.SaveParams;
begin
        SaveGameParam(fGameParam);
        SaveSnakeParam('Snake1', fSnakeParam);
        SaveSnakeParam('Snake2', fSnakeParam2);
end;

procedure TMainForm.ShowScore1;
begin
        lblScore1.Caption := IntToStr(fSnake.Score) + '/' + FloatToStr(fSnake.LeverUpScore);
end;

procedure TMainForm.ShowLever1;
begin
        lblLever1.Caption := '等级：'+IntToStr(fSnake.Lever) + '级';
end;

procedure TMainForm.ShowScore2;
begin
        lblScore2.Caption := IntToStr(fSnake2.Score) + '/' + FloatToStr(fSnake2.LeverUpScore);
end;

procedure TMainForm.ShowLever2;
begin
        lblLever2.Caption := '等级：'+IntToStr(fSnake2.Lever) + '级';
end;

procedure TMainForm.actGameNewExecute(Sender: TObject);
begin
        InitParams;          
        if fGameParam.UseMap then
                LoadMap(fGameParam.MapFile);
        InitSnakes;
        self.Invalidate;
end;

procedure TMainForm.actUpExecute(Sender: TObject);
begin
        fSnake.TurnUp;
end;

procedure TMainForm.actDownExecute(Sender: TObject);
begin
        fSnake.TurnDown;
end;

procedure TMainForm.actLeftExecute(Sender: TObject);
begin
        fSnake.TurnLeft;
end;

procedure TMainForm.actRightExecute(Sender: TObject);
begin
        fSnake.TurnRight;
end;

procedure TMainForm.actStartExecute(Sender: TObject);
begin
        DrawBG;
        if (fGameParam.Mode = 1)
                and (fSnake.IsSnakeAlive) then
        begin
                DrawSnake1;//DrawSnake(fSnake);
                Timer1.Enabled := not Timer1.Enabled;
                fSnake.CreateFood;
                while CheckFoodBlock(fSnake.TheFood) do
                        fSnake.CreateFood;
                foodPoint := fSnake.TheFood;
        end else if (fGameParam.Mode = 2)
                and (fSnake.IsSnakeAlive or fSnake2.IsSnakeAlive) then
                begin
                        DrawSnake1;
                        if (fSnake.IsSnakeAlive) then
                        begin                                
                                Timer1.Enabled := not Timer1.Enabled;
                                fSnake.CreateFood;
                                while CheckFoodBlock(fSnake.TheFood) do
                                        fSnake.CreateFood;
                              foodPoint := fSnake.TheFood;
                        end;

                        //if Assigned(fSnake2) then
                        //begin
                        DrawSnake2;

                        if fSnake2.IsSnakeAlive then
                        begin
                                //DrawSnake(fSnake2);
                                Timer2.Enabled := not Timer2.Enabled;
                                if not fSnake.IsSnakeAlive then
                                begin
                                        fSnake2.CreateFood;
                                        while CheckFoodBlock(fSnake2.TheFood) do
                                                fSnake2.CreateFood;
                                        foodPoint := fSnake2.TheFood;
                                end;
                                fSnake2.TheFood := foodPoint;
                        end
                end
                else
                begin
                        showmessage('重开新游戏！');
                        actGameNew.Execute;
                        //actStart.Execute;
                end;
end;

procedure TMainForm.actPauseExecute(Sender: TObject);
begin
        Timer1.Enabled := not Timer1.Enabled;
        if fGameParam.Mode = 2 then  Timer2.Enabled := not Timer2.Enabled;
end;

procedure TMainForm.actThroughWallExecute(Sender: TObject);
begin
        actThroughwall.Checked := not actThroughwall.Checked;
        if Assigned(fSnake) then
        begin
                fSnake.ThroughWall := actThroughwall.Checked;
                fGameParam.CanThrghWall := fSnake.ThroughWall;
        end;
        SaveParams;
end;  

procedure TMainForm.actHighScoreExecute(Sender: TObject);
var
  frm: THighScoreForm;
begin
        frm := THighScoreForm.Create(nil);
        frm.ShowModal;
        frm.Free;
end;

procedure TMainForm.actAboutExecute(Sender: TObject);
begin
        MyAboutWin(application.Handle ,PChar(AppName), PChar(AppVersion));
end;

procedure TMainForm.actLeverExecute(Sender: TObject);
var
  mnuName: string;
begin
        mnuName := (Sender as TMenuItem).Name;
       // fLever := StrToInt(Copy(mnuName, Length(mnuName), 1));
        (Sender as TMenuItem).Checked := true;
        ResetLever;
        SaveParams;
        ShowLever1;
end;

procedure TMainForm.actPatternBGExecute(Sender: TObject);
var
  mnuName: string;
begin
        mnuName := (Sender as TMenuItem).Name;
        fGameParam.BGPattern := StrToInt(Copy(mnuName, Length(mnuName), 1))-1;
        (Sender as TMenuItem).Checked := true;
        LoadBmps;
        SaveParams;
end;

procedure TMainForm.actPixSizeExecute(Sender: TObject);
var
  mnuName: string;
begin
        if MessageDlg('这将重新开始游戏，确定要设置方块大小吗？',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
        mnuName := (Sender as TMenuItem).Name;
        fGameParam.pixPerBlock := StrToInt(Copy(mnuName, Length(mnuName), 1)) * 2;
        (Sender as TMenuItem).Checked := true;
        SaveParams;
        InitParams;
        InitSnakes;
        self.Invalidate;
        end;
end;

procedure TMainForm.actSaveGrapicExecute(Sender: TObject);
begin
        if spd.Execute then
                bufBmp.SaveToFile(ExtractFileName(spd.FileName));
end;

procedure TMainForm.actOptionExecute(Sender: TObject);
var
  frm: TOptionForm;
begin
        Timer1.Enabled := false;
        Timer2.Enabled := false;
        frm := TOptionForm.Create(nil);
        frm.ShowModal;
        if frm.ModalResult = mrOk then
        begin
                {
                LoadParams;
                LoadBmps;
                ResetLever;
                ShowLever1;   }
        end;
        frm.Free;
end;  

procedure TMainForm.actPlayerNameExecute(Sender: TObject);
var
  frm: TPlayerNameForm;
begin
        frm := TPlayerNameForm.Create(nil);
        frm.LoadParam('Snake1');
        frm.ShowModal;
        frm.Free;
end;

procedure TMainForm.actPlayerName2Execute(Sender: TObject);
var
  frm: TPlayerNameForm;
begin
        frm := TPlayerNameForm.Create(nil);
        frm.LoadParam('Snake2');
        frm.ShowModal;
        frm.Free;
end;

procedure TMainForm.actExitExecute(Sender: TObject);
begin
        close;
end;

procedure TMainForm.actPlayMusicExecute(Sender: TObject);
begin  {
        (Sender as TMenuItem).Checked := true;
        fMusicName := (Sender as TMenuItem).Name;
        fMusicName := 'Music' + Copy(fMusicName, Length(fMusicName), 1);
        SaveParams;
        ChangeMusic;          }

end;

procedure TMainForm.ChangeMusic;
//var
///  sName: string;
begin
 {       sName := ExtractFilePath(application.ExeName)+ '\music\'+fMusicName +'.mid';
        sName := ExtractShortPathName(sName);
        MCISendString(PAnsiChar('OPEN ' + sName + ' TYPE SEQUENCER ALIAS NN'), '', 0, 0);
        MCISendString('PLAY NN FROM 0', '', 0, 0);
        MCISendString('CLOSE ANIMATION', '', 0, 0);
             }
//        playsound(PChar(mfName), 0, SND_ASYNC and SND_LOOP);
//        sndplaysound(PChar(mfName), SND_LOOP);
end;

procedure TMainForm.actOnTopExecute(Sender: TObject);
begin
        actOnTop.Checked := not actOnTop.Checked;
        if actOnTop.Checked then self.FormStyle := fsStayOnTop
        else self.FormStyle := fsNormal;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  dt: string;
begin
        if (fGameParam.Mode = 2)
                and (not fGameParam.CanPassEachOther)
                and Assigned(fSnake2)
                and CheckCross(fSnake, fSnake2) then
        begin
                Timer1.Enabled := false;
                Timer2.Enabled := false;
                fSnake.DieType := dtBitEach;
                fSnake.IsSnakeAlive := false;
                fSnake2.IsSnakeAlive := false;
        end;

        if not fSnake.IsSnakeAlive then
        begin
                Timer1.Enabled := false;
                if fSnake.DieType = dtHitWall then
                        dt := HitWallStr
                else if fSnake.DieType = dtBiteSelf then
                        dt := BitSelfStr
                else if fSnake.DieType = dtBitEach then
                        dt := BitEachStr
                else if fSnake.DieType = dtHitBlock then
                        dt := HitBlckStr
                else dt := DieMistStr;                     
                
                if (fGameParam.Mode = 1)then
                begin
                        RegScore(fSnake);
                        showmessage(dt);
                end
                else if fSnake.DieType = dtBitEach then
                        begin
                                RegScore(fSnake, fSnake2);
                                showmessage(dt);
                        end;

                lblScore1.Caption := 'Game Over';

                exit;
        end;

        //向前一步走
        if fSnake.StepOnEx then
        begin
                //吃到食物了，重新产生食物
                while CheckFoodBlock(fSnake.TheFood) do
                        fSnake.CreateFood;
                foodPoint := fSnake.TheFood;
                if (fGameParam.Mode = 2) and assigned(fSnake2) then
                        fSnake2.TheFood := foodPoint;
                ShowScore1;
        end;

        if fGameParam.UseMap
                and HitBlock(fSnake.HeadPoint) then
        begin
                fSnake.IsSnakeAlive := false;
                fSnake.DieType := dtHitBlock;
                exit;
        end;

        ClearSnakeTail(fSnake);
        DrawSnakeHead1;//DrawSnakeHead(fSnake);
        DrawFood;

        Canvas.CopyMode := cmSrcCopy;
        Canvas.CopyRect(mapRect, BufBmp.Canvas, mapRect);

        if fSnake.IsLeverUp then
        begin
                Timer1.Enabled := false;
                Timer1.Interval := fSnake.Speed;
                Timer1.Enabled := true;
                fSnake.IsLeverUp := false;
                ShowLever1;
        end;

end;

procedure TMainForm.Timer2Timer(Sender: TObject);
var
  dt: string;
begin
        if not Assigned(fSnake2) then exit;

        if (not fGameParam.CanPassEachOther)
                and CheckCross(fSnake2, fSnake) then
        begin
                Timer1.Enabled := false;
                Timer2.Enabled := false;        
                fSnake2.DieType := dtBitEach;
                fSnake2.IsSnakeAlive := false;
                fSnake.IsSnakeAlive := false;
        end;

        if not fSnake2.IsSnakeAlive then
        begin
                Timer2.Enabled := false;
                if fSnake2.DieType = dtHitWall then
                        dt := HitWallStr
                else if fSnake2.DieType = dtBiteSelf then
                        dt := BitSelfStr
                else if fSnake2.DieType = dtBitEach then
                        dt := BitEachStr
                else if fSnake2.DieType = dtHitBlock then
                        dt := HitBlckStr
                else  dt := DieMistStr;
                
                if (fGameParam.Mode = 1) then
                begin
                         RegScore(fSnake2);
                         showmessage(dt);
                end
                else if fSnake.DieType = dtBitEach then
                        begin
                                RegScore(fSnake, fSnake2);
                                showmessage(dt);
                        end;

                lblScore2.Caption := 'Game Over';

                exit;
        end;

        if fSnake2.StepOnEx then
        begin
                while CheckFoodBlock(fSnake2.TheFood) do
                        fSnake2.CreateFood;
                foodPoint := fSnake2.TheFood;
                fSnake.TheFood := foodPoint;
                ShowScore2;
        end;

        if fGameParam.UseMap
                and HitBlock(fSnake2.HeadPoint) then
        begin
                fSnake2.IsSnakeAlive := false;
                fSnake2.DieType := dtHitBlock;
                exit;
        end;

        ClearSnakeTail(fSnake2);
        DrawSnakeHead2;
        DrawFood;       

        Canvas.CopyMode := cmSrcCopy;
        Canvas.CopyRect(mapRect, BufBmp.Canvas, mapRect);

        if fSnake2.IsLeverUp then
        begin
                Timer2.Enabled := false;
                Timer2.Interval := fSnake2.Speed;
                Timer2.Enabled := true;
                fSnake2.IsLeverUp := false;
                ShowLever2;
        end;
end;

procedure TMainForm.CheckASnake(ASnake: TSnakeWithFood);
begin

end;


procedure TMainForm.actTopicExecute(Sender: TObject);
var
  frm: TTopicForm;
begin
        frm := TTopicForm.Create(nil);
        frm.ShowModal;
        frm.Free;
end;

{ 下面增加了设置障碍的功能 }

procedure TMainForm.CreateMatrix(gridNum: integer);
var
  i, j: integer;
begin
        //初始化点阵
        SetLength(FMatrix, gridNum);
        for i:= Low(FMatrix) to High(FMatrix) do
        begin
                setLength(FMatrix[i], gridNum);
                for j:= Low(FMatrix[i]) to High(FMatrix[i]) do
                        FMatrix[i,j] := 0;
        end;
end;

procedure TMainForm.ResetGridNum(BlockSize: integer);
begin
        FGridNum := 400 div (BlockSize * 2);
end;

procedure TMainForm.LoadMap(mapFile: string);
var
  s: TFileStream;
  a: array of byte;
  i, j: integer;
begin
        if mapFile = '' then exit;
        if not FileExists(mapFile) then exit;
        
        s := TFileStream.Create(mapFile, fmOpenRead);
        try
                s.Read(fGameParam.pixPerBlock, Sizeof(integer));
                s.Read(fSnakeParam.StartPt, SizeOf(TPoint));
                s.Read(fSnakeParam2.StartPt, SizeOf(TPoint));
                SaveGameParam(fGameParam);
                ResetGridNum(fGameParam.pixPerBlock);
                CreateMatrix(FGridNum);
                setLength(a, FGridNum*FGridNum);

                s.Read(a[0], FGridNum*FGridNum*SizeOf(byte));

                for i := 0 to FGridNum - 1 do
                        for j := 0 to FGridNum - 1 do
                                FMatrix[i, j] := a[FGridNum*i+j];
                Canvas.Brush.Color := clWhite;
                Canvas.FillRect(Canvas.ClipRect);
                Paint;
        finally
        s.Free;
        end;
        
end;


(*********************************************************************
//  func：HitBlock
//  Desc：判断是否撞到墙了
//  Parm：
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function TMainForm.HitBlock(SnakeHead: TPoint): boolean;
begin
        result := false;
        if FMatrix[SnakeHead.X, SnakeHead.Y] = 1 then result := true;
end;

procedure TMainForm.ActUseMapExecute(Sender: TObject);
begin
        ActUseMap.Checked := not ActUseMap.Checked;
        fGameParam.UseMap := ActUseMap.Checked;
        SaveGameParam(fGameParam);
end;

procedure TMainForm.ActLoadMapExecute(Sender: TObject);
var
  od: TOpenDialog;
begin
        Timer1.Enabled := false;
        Timer2.Enabled := false;
        
        od := TOpenDialog.Create(nil);
        od.Filter := 'Snake Map File|*.smp';
        od.InitialDir := ExtractFilePath(Application.ExeName);
        if od.Execute then
        begin
                fGameParam.MapFile := od.FileName;
                fGameParam.UseMap := true;                   //

                SaveGameParam(fGameParam);
                if (MessageDlg('要重新开始游戏吗？', mtConfirmation,
                        [mbYes, mbNo], 0) = mrYes) then
                begin
                        LoadMap(fGameParam.MapFile);
                        InitParams;
                        LoadMap(fGameParam.MapFile);
                        InitSnakes;
                        self.Invalidate;

                end;
                
        end;
        od.Free;
end;

procedure TMainForm.ActMakeMapExecute(Sender: TObject);
begin
        ShellExecute(handle, 'Open', pChar(ExtractFilePath(Application.ExeName) + '\Map.exe'), nil, nil, SW_SHOW);
end;

function TMainForm.CheckFoodBlock(FoodPoint: TPoint): boolean;
begin
        result := false;

        //这一点有障碍物，不能产生食物
        if FMatrix[FoodPoint.X, FoodPoint.Y] = 1 then
                result := true;         

end;


end.
