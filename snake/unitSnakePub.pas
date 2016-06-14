unit unitSnakePub;

interface

uses Windows, types, Graphics, SysUtils, iniFiles, forms,
   unitSnakeDefine,  UnitSnakeWithFood; 

function GetAScore(AScStr: string): TScoreRec;

procedure DrawASec(APoint: TPoint; patternBmp: TBitmap;
        ApixPerBlock: integer; ACanvas: TCanvas);

function LoadGameParam: TGameParam;
procedure SaveGameParam(AGameParam: TGameParam);

function LoadSnakeParam(ASnake: string): TSnakeParam;
procedure SaveSnakeParam(ASnake: string; ASnakeParam: TSnakeParam);

function CheckCross(ASnake, BSnake: TSnakeWithFood): Boolean;

function KeyToChar(Key: word): string;

implementation


function KeyToChar(Key: word): string;
begin
case Key of
  VK_LEFT: result := 'LEFT';
  VK_UP: result := 'UP';
  VK_RIGHT: result := 'RIGHT';
  VK_DOWN: result := 'DOWN';

  VK_NUMPAD0: result := 'NUMPAD0';
  VK_NUMPAD1: result := 'NUMPAD1';
  VK_NUMPAD2: result := 'NUMPAD2';
  VK_NUMPAD3: result := 'NUMPAD3';
  VK_NUMPAD4: result := 'NUMPAD4';
  VK_NUMPAD5: result := 'NUMPAD5';
  VK_NUMPAD6: result := 'NUMPAD6';
  VK_NUMPAD7: result := 'NUMPAD7';
  VK_NUMPAD8: result := 'NUMPAD8';
  VK_NUMPAD9: result := 'NUMPAD9';
  VK_MULTIPLY: result := 'NUMPAD9';
  VK_ADD: result := 'ADD';
  VK_SEPARATOR: result := 'SEPARATOR';
  VK_SUBTRACT: result := 'SUBTRACT';
  VK_DECIMAL: result := 'DECIMAL';
  VK_DIVIDE: result := 'DIVIDE';
  else result := Chr(Key);
end;

end;

(*********************************************************************
//  func：GetAScore
//  Desc：解释一条排行榜记录来
//  Parm：
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function GetAScore(AScStr: string): TScoreRec;
var
  p: integer;
begin
        result.Grade := 1;
        result.Name := '无名氏';
        result.Score := 0;

        AScStr := Trim(AScStr);
        p := pos(' ', AScStr);
        result.Grade := StrToInt(Trim(copy(AScStr, 0, p-1)));

        AScStr := Trim(copy(AScStr, p, Length(AScStr)-p+1));  
        p := pos(' ', AScStr);
        result.Name := copy(AScStr, 0, p-1);

        AScStr := Trim(copy(AScStr, p, Length(AScStr)-p+1));

        result.Score := StrToInt(AScStr);

end;

procedure DrawASec(APoint: TPoint; patternBmp: TBitmap;
        ApixPerBlock: integer; ACanvas: TCanvas);
var
  ARect: TRect;
  dblBlock: integer;
begin
        dblBlock := ApixPerBlock*2;
        ARect.Left := APoint.X * dblBlock;
        ARect.Right := APoint.X * dblBlock + dblBlock;
        ARect.Top := (APoint.Y * dblBlock);   // 400 -
        ARect.Bottom := (APoint.Y * dblBlock + dblBlock );   //400 -
        //ACanvas.Rectangle(ARect);
        ACanvas.CopyMode := cmSrcCopy;
        ACanvas.CopyRect(ARect, patternBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1));
end;

(*********************************************************************
//  func：LoadGameParam
//  Desc：读取游戏设置，将游戏设置，蛇的设置分开，代码比较整洁，呵呵
//  Parm：
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function LoadGameParam: TGameParam;
var
  f: TiniFile;
begin
        f := TiniFile.Create(ExtractFilePath(application.ExeName)+'\snake.ini');
        try
        result.Mode := f.ReadInteger('Game', 'Mode', 1);
        result.StartLever := f.ReadInteger('Game', 'StartLever', 5);
        result.pixPerBlock := f.ReadInteger('Game', 'pixPerBlock', 8);
        result.CanThrghWall := f.ReadBool('Game', 'ThroughWall', true);
        result.CanPassEachOther := f.ReadBool('Game', 'PassEachOther', true);
        result.BGPattern := f.ReadInteger('Game', 'BG', 13);
        result.FoodPattern := f.ReadInteger('Game', 'Food', 14);
        result.BlockPattern := f.ReadInteger('Game', 'Block', 7);

        result.UseMap := f.ReadBool('Game', 'UseMap', false);
        result.MapFile := f.ReadString('Game', 'MapFile', '');

        result.MusicName := f.ReadString('Game', 'Music', 'Music0');


        finally
        f.Free;
        end;
end;

(*********************************************************************
//  func：SaveGameParam(AGameParam: TGameParam);
//  Desc：保存游戏设置
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure SaveGameParam(AGameParam: TGameParam);
var
  f: TiniFile;
begin
        f := TiniFile.Create(ExtractFilePath(application.ExeName)+'\snake.ini');
        try
        f.WriteInteger('Game', 'Mode', AGameParam.Mode);
        f.WriteInteger('Game', 'StartLever', AGameParam.StartLever);
        f.WriteInteger('Game', 'pixPerBlock', AGameParam.pixPerBlock);
        f.WriteBool('Game', 'ThroughWall', AGameParam.CanThrghWall);
        f.WriteBool('Game', 'PassEachOther', AGameParam.CanPassEachOther);

        f.WriteInteger('Game', 'BG', AGameParam.BGPattern);
        f.WriteInteger('Game', 'Food', AGameParam.FoodPattern);

        f.WriteInteger('Game', 'Block', AGameParam.BlockPattern);
        f.WriteBool('Game', 'UseMap', AGameParam.UseMap);
        f.WriteString('Game', 'MapFile', AGameParam.MapFile);

        f.ReadString('Game', 'Music', AGameParam.MusicName);          
        finally
        f.Free;
        end;
end;

(*********************************************************************
//  func：LoadSnakeParam(ASnake: string)
//  Desc：读取蛇的参数设置
//  Parm：ASnake：enum{'Snake1', 'Snake2'}
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function LoadSnakeParam(ASnake: string): TSnakeParam;
var
  f: TiniFile;
begin
        f := TiniFile.Create(ExtractFilePath(application.ExeName)+'\snake.ini');
        try
        result.Name := f.ReadString(ASnake, 'Name', '白蛇');
        result.Pattern := f.ReadInteger(ASnake, 'Pattern', 1);
        result.upKey := f.ReadInteger(ASnake, 'Up', VK_UP);
        result.downKey := f.ReadInteger(ASnake, 'Down', VK_DOWN);
        result.leftKey := f.ReadInteger(ASnake, 'Left', VK_LEFT);
        result.rightKey := f.ReadInteger(ASnake, 'Right', VK_RIGHT); 
        finally
        f.Free;
        end;
end;

(*********************************************************************
//  func：SaveSnakeParam
//  Desc：保存蛇参数设置
//  Parm： ASnake：enum{'Snake1', 'Snake2'}
          ASnakeParam: 参数记录
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure SaveSnakeParam(ASnake: string; ASnakeParam: TSnakeParam);
var
  f: TiniFile;
begin
        f := TiniFile.Create(ExtractFilePath(application.ExeName)+'\snake.ini');
        try
        f.WriteInteger(ASnake, 'Pattern', ASnakeParam.Pattern);
        f.WriteString(ASnake, 'Name', ASnakeParam.Name);
        f.WriteInteger(ASnake, 'Up', ASnakeParam.upKey);
        f.WriteInteger(ASnake, 'Down', ASnakeParam.downKey);
        f.WriteInteger(ASnake, 'Left', ASnakeParam.leftKey);
        f.WriteInteger(ASnake, 'Right', ASnakeParam.rightKey);
        finally
        f.Free;
        end;
end;

(*********************************************************************
//  func：CheckCross(ASnake, BSnake: TSnakeWithFood)
//  Desc：判断两只蛇是否相互碰到一起了
//  Parm：ASnake, BSnake 两只蛇
//  Rslt：true: 碰到了  false：没碰到
//  Note：判断ASnake主动碰BSnake的情况
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function CheckCross(ASnake, BSnake: TSnakeWithFood): Boolean;
var
  i: integer;
begin
        result := false;   {
        for i := 0 to ASnake.fBodyList.Count - 2 do
                if (PPoint(ASnake.fBodyList.Items[i]).X = BSnake.HeadPoint.X)
                        and (PPoint(ASnake.fBodyList.Items[i]).Y = BSnake.HeadPoint.Y) then
                begin
                        result := true;
                        exit;
                end;      }

        for i := 0 to BSnake.fBodyList.Count - 2 do
                if (PPoint(BSnake.fBodyList.Items[i]).X = ASnake.HeadPoint.X)
                        and (PPoint(BSnake.fBodyList.Items[i]).Y = ASnake.HeadPoint.Y) then
                begin
                        result := true;
                        break;
                end;
end;   

end.
