(********************************************************************
//  Unit Name   : UnitSnakeWithFood
//  Description : 继承自TSnake的 TSnakeWithFood，将食物也封装起来了
//                这样
                1). 一只蛇时的游戏，判断蛇是否吃到食物的方法也就封装起来了，
                        无需另作判断语句
                2). 两只蛇时，使用 TSnakeWithFood 的对象谁吃到食物就以谁的
                        食物作为共同的食物
//  Copyright   : 2005 by KaiHui Corp。All rights reserved。
//  Author      ：Loafer.Liu @ 2005.
//  Notes       ：
//  Update      ：
//******************************************************************)

unit UnitSnakeWithFood;

interface

uses Types, Math, unitSnake;

type

  TSnakeWithFood = class(TSnake)
  private
    FTheFood: TPoint;
    procedure SetTheFood(const Value: TPoint);
    

  public     
    function IsEatFood: boolean;

    procedure CreateFood;
    function StepOnEx: boolean;

  published
    property TheFood: TPoint read FTheFood write SetTheFood;

  end;

implementation

{ TSnakeWithFood }

(*********************************************************************
//  func：CreateFood
//  Desc：生成一个食物，不用详说，自己看吧
//  Parm：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//*******************************************************************)
procedure TSnakeWithFood.CreateFood;
var
  i: integer;
  aPoint: TPoint;
begin
        Randomize;
        FTheFood.X := Random(fCreepRect.Right);
        FTheFood.Y := Random(fCreepRect.Bottom);

        for i:= fBodyList.Count-1 downto 0 do
        begin
                aPoint.X := PPoint(fBodyList.Items[i]).X;
                aPoint.Y := PPoint(fBodyList.Items[i]).Y;

                if (FTheFood.X = aPoint.X)
                        and (FTheFood.Y = aPoint.Y) then
                        begin
                                CreateFood;
                                break;
                        end;
        end;
end;

(*********************************************************************
//  func：IsEatFood
//  Desc：判断是否吃到食物的方法
//  Parm：
//  Rslt：
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function TSnakeWithFood.IsEatFood: boolean;
begin
        result := false;
        if (HeadPoint.X = FTheFood.X)
                and (HeadPoint.Y = FTheFood.Y) then
                        result := true;  //吃到了
end;

procedure TSnakeWithFood.SetTheFood(const Value: TPoint);
begin
  FTheFood := Value;
end;

(*********************************************************************
//  func：StepOnEx
//  Desc：前进一步，且判断是否吃到食物
//  Parm：
//  Rslt：true: 吃到 false: 没吃
//  Note：
//  Auth：Loafer.Liu @ 2005.
//  Updt：
//********************************************************************)
function TSnakeWithFood.StepOnEx: boolean;
begin
        StepOn;
        result := false;
        if IsEatFood then
        begin
                EatOne;
                inc(fScore, fLever*10);
                if (fScore >= power(fLever, 2)*100) then LeverUp;
                CreateFood;
                result := true;
        end;
end;

end.
