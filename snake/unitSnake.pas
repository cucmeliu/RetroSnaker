(********************************************************************
//  Unit Name   : unitSnake
//  Description : ����

//  Copyright   : 2005 by KaiHui Corp��All rights reserved��
//  Author      ��Loafer.Liu @ 2004.9.
//  Notes       ��
//  Update      ��
2005.3.10: ���������������һ��������ԭ��βλ�ñ������������±���֮��
        ��������ÿ���ػ汳����ֻ���ñ���ͼ�����������
        ��ÿ��һ��������ǰ����������һ���ڵ㣬������ýڵ㣬
        ͬʱ�ж��Ƿ�Ե�ʳ�Ｐ�Ƿ�ײǽ���¼�
        ���û�г�ʳ���β�ڵ�ɾ��������Ͳ�ɾ������Ҫ�߾ͳ�����һ��
//******************************************************************)

unit unitSnake;

interface

uses Graphics, Classes, Types, Messages, math, unitSnakeDefine;

const WM_Hit_WALL = WM_USER + 110;

type

  TOnePoint = record
    aPoint: TPoint;   //��־λ�ã�����һ���Ǿ�������
    cColor: TColor;
  end;

//  TDieType = (dtHitWall, dtBiteSelf); //���������ͣ�ײǽ����ҧ�Լ���

  TSnake = class
  private
    FWindDirection: byte;       //�洢���з�����1����2����4����8
    ptOffset: TPoint;           //��־x, y�����ƫ����
//    fLastPoint: TPoint;       //����֮ǰ��ͷ��λ��
    fIsEatOne: boolean;         //�Ƿ���˶���
    fIsSnakeAlive: boolean;     //���Ƿ񻹻���

    FThroughWall: boolean;
    FDieType: TDieType;

    FSteped: Boolean;           //�ı䷽����Ƿ������ˣ����ж�Ϊ��������ת��ʱ

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
    fCreepRect: TRect;          //�����ߵĿռ䷶Χ
    FHeadPoint: TPoint;         //��ͷ��λ��
    FSpeed: integer;
    FLever: integer;
    FScore: integer;
    
    procedure LeverUp;
    
  public
    fBodyList: TList;           //�洢��������
    
    constructor Create(CreepRect: TRect); overload;
    constructor Create(CreepRect: TRect; StartPoint: TPoint); overload;
    destructor Destroy; override;

    procedure TurnLeft;         //����
    procedure TurnRight;        //����
    procedure TurnUp;           //����
    procedure TurnDown;         //����

    procedure StepOn;           //��ǰ����ǰ��һ��
    procedure EatOne;           //��һ��ʳ��
    
  published
    property ThroughWall: boolean read FThroughWall write SetThroughWall;
    //�Ƿ�����ǽ
    property IsSnakeAlive: boolean read FIsSnakeAlive write SetIsSnakeAlive;
    property DieType: TDieType read FDieType write SetDieType;
    property HeadPoint: TPoint read FHeadPoint write SetHeadPoint;  //��ǰ��ͷ��λ��
    property Lever: integer read FLever write SetLever;  //�ȼ�
    property Score: integer read FScore write SetScore;  //��������Ϊֻ��
    property LeverUpScore: double read FLeverUpScore write SetLeverUpScore;
    property Speed: integer read FSpeed write SetSpeed;
    property Name: string read FName write SetName;      //���ƣ�ʵΪ�����
    property IsLeverUp: boolean read FIsLeverUp write SetIsLeverUp;
    property Params: TSnakeParam read FParams write SetParams;

  end;

implementation

{ TSnake }

(*********************************************************************
//  func��BiteSelf
//  Desc���ж����Ƿ�ҧ���Լ���
//  Parm��
//  Rslt��true: ҧ���Լ���
//  Note��
//  Auth��Loafer.Liu @ 20045.
//  Updt��
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

        //�˴�Ϊ�Ż��㷨
        //���������������ȡ�fBodyList���洢�Ľڵ���һ
        //������ÿ��һ����ֻ���ػ��һ���ڵ�����һ���ڵ㡣
        //�������ػ�������������������
        for i := 3 to fBodyList.Count - 2 do
                if (PPoint(fBodyList.Items[i]).X = ptHead.X)
                        and (PPoint(fBodyList.Items[i]).Y = ptHead.Y) then
                begin 
                        result := true;
                        break;
                end;

end;

(*********************************************************************
//  func��
//  Desc��
//  Parm��CreepRect: ���Χ�����ڲ�����ָʾ
        CreepRect(Left, top, bottom, right) = (0, VStep, 0, HStep)
                                                VStep: ��ֱ������
                                                HStep: ˮƽ������
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
//*******************************************************************)
constructor TSnake.Create(CreepRect: TRect);
begin
        fBodyList := TList.Create;
        InitSnake;

        fCreepRect := CreepRect;
end;

(*********************************************************************
//  func��
//  Desc��
//  Parm��CreepRect: ���Χ�����ڲ�����ָʾ
        CreepRect(Left, top, bottom, right) = (0, VStep, 0, HStep)
                                                VStep: ��ֱ������
                                                HStep: ˮƽ������
        StartPoint: ��ʼλ�ã����ڲ�����ָʾ
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
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
//  func��EatOne
//  Desc����һ��ʳ��
//  Parm��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
//*******************************************************************)
procedure TSnake.EatOne;
begin
        fIsEatOne := true; 
end;

(*********************************************************************
//  func��HitWall
//  Desc���ж��Ƿ�ײǽ
//  Parm��
//  Rslt��true: ײǽ��
//  Note��
//  Auth��Loafer.Liu @ 20045.
//  Updt��
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
//  func��InitSnake
//  Desc����ʼ��������ʼλ��
//  Parm��
//  Rslt��
//  Note��
//  Auth��Loafer.Liu @ 20045.
//  Updt��
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
//  func��InitSnake
//  Desc����ʼ��������ʼλ��
//  Parm��StartPoint,��ʼ����λ�ã�������Ϸ���Զ��ƣ�ָ������λ��
//  Rslt��
//  Note��
//  Auth��Loafer.Liu @ 20045.
//  Updt��
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
//  func��InitPrivateParam
//  Desc����ʼ������ı���ֵ
//  Parm��
//  Rslt��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
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
//  func��LeverUp
//  Desc������
//  Parm��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
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
//  func��StepOn
//  Desc���߳����з���ǰ��һ��
//  Parm��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
//*******************************************************************)
procedure TSnake.StepOn;
var
  ptNew: PPoint;
begin
        if not fIsSnakeAlive then exit;

        //��ǰ�ߣ���ͷ�ķ���������һ���ڵ�
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

        //���û�Ե�ʳ���β��ɾ��һ���ڵ�
        if not fIsEatOne then
        begin
        fBodyList.Delete(fBodyList.Count-1);
        end else fIsEatOne := false;

        FHeadPoint.X := ptNew^.X;
        FHeadPoint.Y := ptNew^.Y;

        FSteped := true;

        //�ж����Ƿ�ҧ���Լ���
        if BiteSelf then
        begin
                fIsSnakeAlive := false;
                fDieType := dtBiteSelf;
        end;

        //�ж��Ƿ�ײ��ǽ��
        if HitWall and not FThroughWall then
        begin
                fIsSnakeAlive := false;
                fDieType := dtHitWall;
        end;

end;

procedure TSnake.TurnDown;
begin
//��4
        if FWindDirection = 1 then exit; //������ֱ�����ת
        if not FSteped then exit;
        FWindDirection := 4;
        ptOffset.X := 0;
        ptOffset.Y := 1;//-1;
        FSteped := false;
end;

procedure TSnake.TurnLeft;
begin
//��2
        if FWindDirection = 8 then exit; //������ֱ�����ת
        if not FSteped then exit;
        FWindDirection := 2;
        ptOffset.X := -1;
        ptOffset.Y := 0;
        FSteped := false;
end;

procedure TSnake.TurnRight;
begin
//��8
        if FWindDirection = 2 then exit; //������ֱ�����ת
        if not FSteped then exit;
        FWindDirection := 8;
        ptOffset.X := 1;
        ptOffset.Y := 0;
        FSteped := false;
end;

procedure TSnake.TurnUp;
begin
//��1
        if FWindDirection = 4 then exit; //������ֱ�����ת
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
