(********************************************************************
//  Unit Name   : unitSnake
//  Description : 蛇类

//  Copyright   : 2005 by KaiHui Corp。All rights reserved。
//  Author      ：Loafer.Liu @ 2004.9.
//  Notes       ：
//  Update      ：
2005.3.10: 将蛇身链表中最后一个链，即原蛇尾位置保留，用作更新背景之用
        这样不必每次重绘背景，只需用背景图案绘制这个链
        蛇每走一步，在蛇前进方向增加一个节点，并绘出该节点，
        同时判断是否吃到食物及是否撞墙等事件
        如果没有吃食物，则将尾节点删除，否则就不删除，这要蛇就长长了一截
//******************************************************************)

unit unitSnake;

interface

uses Graphics, Classes, Types, Messages, math, unitSnakeDefine;

const WM_Hit_WALL = WM_USER + 110;

type

  TOnePoint = record
    aPoint: TPoint;   //标志位置，并不一定是绝对坐标
    cColor: TColor;
  end;

//  TDieType = (dtHitWall, dtBiteSelf); //死亡的类型，撞墙或是咬自己了

  TSnake = class
  private
    FWindDirection: byte;       //存储运行方向：上1，左2，下4，右8
    ptOffset: TPoint;           //标志x, y方向的偏移量
//    fLastPoint: TPoint;       //更新之前蛇头的位置
    fIsEatOne: boolean;         //是否吃了东东
    fIsSnakeAlive: boolean;     //蛇是否还活着

    FThroughWall: boolean;
    FDieType: TDieType;

    FSteped: Boolean;           //改变方向后是否行走了，此判断为连续两次转弯时

    FName: string;
    FIsLeverUp: boolean;
    FLeverUpScore: double;
    FParams: TSnakeParam;

    ///////////////////////////////////////////
    function BiteSelf: boolean;
    function HitWall: boolean;
    procedure InitSnake; overload;
    procedure InitSnake(StartPoint: TPoint); overload;
    procedure InitPrivateParam;
    procedure ResetSpeed(Lever: integer);

    procedure HitWallMsg(var message: TMessage); message WM_Hit_WALL;
    procedure SetThroughWall(const Value: boolean);
    procedure SetIsSnakeAlive(const Value: boolean);
    procedure SetDieType(const Value: TDieType);
    procedure SetHeadPoint(const Value: TPoint);
    procedure SetLever(const Value: integer);
    procedure SetScore(const Value: integer);
    procedure SetName(const Value: string);
    procedure SetSpeed(const Value: integer);
    procedure SetIsLeverUp(const Value: boolean);
    procedure SetLeverUpScore(const Value: double);
    procedure SetParams(const Value: TSnakeParam);


  protected
    fCreepRect: TRect;          //蛇行走的空间范围
    FHeadPoint: TPoint;         //蛇头的位置
    FSpeed: integer;
    FLever: integer;
    FScore: integer;
    
    procedure LeverUp;
    
  public
    fBodyList: TList;           //存储蛇身坐标
    
    constructor Create(CreepRect: TRect); overload;
    constructor Create(CreepRect: TRect; StartPoint: TPoint); overload;
    destructor Destroy; override;

    procedure TurnLeft;         //向左
    procedure TurnRight;        //向右
    procedure TurnUp;           //向上
    procedure TurnDown;         //向下

    procedure StepOn;           //向当前方向前进一步
    procedure EatOne;           //吃一个食物
    
  published
    property ThroughWall: boolean read FThroughWall write SetThroughWall;
    //是否允许穿墙
    property IsSnakeAlive: boolean read FIsSnakeAlive write SetIsSnakeAlive;
    property DieType: TDieType read FDieType write SetDieType;
    property HeadPoint: TPoint read FHeadPoint write SetHeadPoint;  //当前蛇头的位置
    property Lever: integer read FLever write SetLever;  //等级
    property Score: integer read FScore write SetScore;  //分数宜设为只读
    property LeverUpScore: double read FLeverUpScore write SetLeverUpScore;
    property Speed: integer read FSpeed write SetSpeed;
    property Name: string read FName write SetName;      //名称，实为玩家名
    property IsLeverUp: boolean read FIsLeverUp write SetIsLeverUp;
    property Params: TSnakeParam read FParams write SetParams;

  end;

implementation

{ TSnake }

(*********************************************************************
//  func：BiteSelf
//  Desc：判断蛇是否咬到自己了
//  Parm：
//  Rslt：true: 咬到自己了
//  Note：
//  Auth：Loafer.Liu @ 20045.
//  Updt：
//********************************************************************)
function TSnake.BiteSelf: boolean;
var
  i: integer;
  ptHead: TPoint;
begin
        result := false;
        ptHead.X := PPoint(fBodyList.Items[0]).X;
        ptHead.Y := PPoint(fBodyList.Items[0]).Y;

        if fBodyList.Count < 4 then exit;

        //此处为优化算法
        //画出来的蛇其它比　fBodyList　存储的节点少一
        //这样蛇每走一步，只需重绘第一个节点和最后一个节点。
        //否则需重绘整个背景和整个蛇身
        for i := 3 to fBodyList.Count - 2 do
                if (PPoint(fBodyList.Items[i]).X = ptHead.X)
                        and (PPoint(fBodyList.Items[i]).Y = ptHead.Y) then
                begin 
                        result := true;
                        break;
                end;

end;

(*********************************************************************
//  func：
//  Desc：
//  Parm：CreepRect: 活动范围，以内部坐标指示
        CreepRect(Left, top, bottom, right) = (0, VStep, 0, HStep)
                                                VStep: 垂直方向步数
                                                HStep: 水平方向步数
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
constructor TSnake.Create(CreepRect: TRect);
begin
        fBodyList := TList.Create;
        InitSnake;

        fCreepRect := CreepRect;
end;

(*********************************************************************
//  func：
//  Desc：
//  Parm：CreepRect: 活动范围，以内部坐标指示
        CreepRect(Left, top, bottom, right) = (0, VStep, 0, HStep)
                                                VStep: 垂直方向步数
                                                HStep: 水平方向步数
        StartPoint: 初始位置，以内部坐标指示
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
constructor TSnake.Create(CreepRect: TRect; StartPoint: TPoint);
begin
        fBodyList := TList.Create;
        InitSnake(StartPoint);

        fCreepRect := CreepRect;

end;

destructor TSnake.Destroy;
var
  i: integer;
begin
        for i:=0 to fBodyList.Count-1 do
                Dispose(fBodyList.Items[i]); //fBodyList.Delete(i);

        fBodyList.Free;
  inherited;
end;

(*********************************************************************
//  func：EatOne
//  Desc：吃一口食物
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TSnake.EatOne;
begin
        fIsEatOne := true; 
end;

(*********************************************************************
//  func：HitWall
//  Desc：判断是否撞墙
//  Parm：
//  Rslt：true: 撞墙了
//  Note：
//  Auth：Loafer.Liu @ 20045.
//  Updt：
//********************************************************************)
function TSnake.HitWall: boolean;
var
  ptHead: TPoint;
begin
        result := false;
        ptHead.X := PPoint(fBodyList.Items[0]).X;
        ptHead.Y := PPoint(fBodyList.Items[0]).Y;

        if (ptHead.X < 0) or (ptHead.Y < 0)
                or (ptHead.X > (fCreepRect.Right-fCreepRect.Left))
                or (ptHead.Y > (fCreepRect.Bottom-fCreepRect.Top)) then
                        result := true;
                
end;

procedure TSnake.HitWallMsg(var message: TMessage);
begin
        fIsSnakeAlive := false;
end;

(*********************************************************************
//  func：InitSnake
//  Desc：初始化蛇身，起始位置
//  Parm：
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 20045.
//  Updt：
//********************************************************************)
procedure TSnake.InitSnake;
var
  ptNew: PPoint;
  i: integer;
begin
        for i:= 1 to 3 do
        begin
                new(ptNew);
                ptNew^.X := i;
                ptNew^.Y := 1;
                fBodyList.Insert(0, ptNew);
        end;
        ptOffset.x := 1;
        ptOffset.y := 0;

        FHeadPoint.X := 3;
        FHeadPoint.Y := 1;
        
        InitPrivateParam;

end;

(*********************************************************************
//  func：InitSnake
//  Desc：初始化蛇身，起始位置
//  Parm：StartPoint,起始放蛇位置，这样游戏可以定制，指定放蛇位置
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 20045.
//  Updt：
//********************************************************************)
procedure TSnake.InitSnake(StartPoint: TPoint);
var
  ptNew: PPoint;
  i: integer;
begin
        for i:= 1 downto 0 do
        begin
                new(ptNew);
                ptNew^.X := StartPoint.X + i;
                ptNew^.Y := StartPoint.Y;
                fBodyList.Insert(0, ptNew);
        end;
        ptOffset.x := 1;
        ptOffset.y := 0;

        FHeadPoint.X := StartPoint.X;
        FHeadPoint.Y := StartPoint.Y;   

        InitPrivateParam;
end;

(*********************************************************************
//  func：InitPrivateParam
//  Desc：初始化蛇类的变量值
//  Parm：
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
procedure TSnake.InitPrivateParam;
begin
        FDieType := dtHitWall;
        fIsEatOne := false;
        fIsSnakeAlive := true;
        FThroughWall := false;
        FSteped := false;
        FIsLeverUp := false;

        fSpeed := 1000;
end;

(*********************************************************************
//  func：LeverUp
//  Desc：升级
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TSnake.LeverUp;
begin
        Inc(fLever);
        FLeverUpScore := power(fLever, 2)*100;
        FIsLeverUp := true;

        resetSpeed(fLever);
end;

procedure TSnake.SetDieType(const Value: TDieType);
begin
  FDieType := Value;
end;

procedure TSnake.SetHeadPoint(const Value: TPoint);
begin
  FHeadPoint := Value;
end;

procedure TSnake.SetIsLeverUp(const Value: boolean);
begin
  FIsLeverUp := Value;
end;

procedure TSnake.SetIsSnakeAlive(const Value: boolean);
begin
  FIsSnakeAlive := Value;
end;

procedure TSnake.SetLever(const Value: integer);
begin
  FLever := Value;
  FLeverUpScore := power(Lever, 2)*100;
  ResetSpeed(FLever);
end;

procedure TSnake.SetLeverUpScore(const Value: double);
begin
  FLeverUpScore := Value;
end;

procedure TSnake.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TSnake.SetScore(const Value: integer);
begin
  FScore := Value;
end;

procedure TSnake.SetSpeed(const Value: integer);
begin
  FSpeed := Value;
end;

procedure TSnake.SetThroughWall(const Value: boolean);
begin
  FThroughWall := Value;
end;

(*********************************************************************
//  func：StepOn
//  Desc：蛇朝运行方向前进一步
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TSnake.StepOn;
var
  ptNew: PPoint;
begin
        if not fIsSnakeAlive then exit;

        //向前走，蛇头的方向上增加一个节点
        new(ptNew);
        ptNew^.X := FHeadPoint.X + ptOffset.X;
        ptNew^.Y := FHeadPoint.Y + ptOffset.Y;

        if FThroughWall then
        begin
                if ptNew^.X < fCreepRect.Left then ptNew^.X := fCreepRect.Right;
                if ptNew^.X > fCreepRect.Right then ptNew^.X := fCreepRect.Left;

                if ptNew^.Y < fCreepRect.Top then ptNew^.Y := fCreepRect.Bottom;
                if ptNew^.Y > fCreepRect.Bottom then ptNew^.Y := fCreepRect.Top;
        end ;
        
        fBodyList.Insert(0, ptNew);

        //如果没吃到食物，蛇尾就删除一个节点
        if not fIsEatOne then
        begin
        fBodyList.Delete(fBodyList.Count-1);
        end else fIsEatOne := false;

        FHeadPoint.X := ptNew^.X;
        FHeadPoint.Y := ptNew^.Y;

        FSteped := true;

        //判断蛇是否咬到自己了
        if BiteSelf then
        begin
                fIsSnakeAlive := false;
                fDieType := dtBiteSelf;
        end;

        //判断是否撞到墙了
        if HitWall and not FThroughWall then
        begin
                fIsSnakeAlive := false;
                fDieType := dtHitWall;
        end;

end;

procedure TSnake.TurnDown;
begin
//下4
        if FWindDirection = 1 then exit; //不允许直接向后转
        if not FSteped then exit;
        FWindDirection := 4;
        ptOffset.X := 0;
        ptOffset.Y := 1;//-1;
        FSteped := false;
end;

procedure TSnake.TurnLeft;
begin
//左2
        if FWindDirection = 8 then exit; //不允许直接向后转
        if not FSteped then exit;
        FWindDirection := 2;
        ptOffset.X := -1;
        ptOffset.Y := 0;
        FSteped := false;
end;

procedure TSnake.TurnRight;
begin
//右8
        if FWindDirection = 2 then exit; //不允许直接向后转
        if not FSteped then exit;
        FWindDirection := 8;
        ptOffset.X := 1;
        ptOffset.Y := 0;
        FSteped := false;
end;

procedure TSnake.TurnUp;
begin
//上1
        if FWindDirection = 4 then exit; //不允许直接向后转
        if not FSteped then exit;
        FWindDirection := 1;
        ptOffset.X := 0;
        ptOffset.Y := -1;
        FSteped := false;
end;

procedure TSnake.ResetSpeed(Lever: integer);
begin
        if fSpeed <= 5 then exit;

        if fLever <= 10 then fSpeed := 500 - (fLever-1)*50
        else fSpeed := fSpeed - 5;
end;

procedure TSnake.SetParams(const Value: TSnakeParam);
begin
  FParams := Value;
end;

end.
