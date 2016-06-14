(********************************************************************
//  Unit Name   : UnitSnakeWithFood
//  Description : �̳���TSnake�� TSnakeWithFood����ʳ��Ҳ��װ������
//                ����
                1). һֻ��ʱ����Ϸ���ж����Ƿ�Ե�ʳ��ķ���Ҳ�ͷ�װ�����ˣ�
                        ���������ж����
                2). ��ֻ��ʱ��ʹ�� TSnakeWithFood �Ķ���˭�Ե�ʳ�����˭��
                        ʳ����Ϊ��ͬ��ʳ��
//  Copyright   : 2005 by KaiHui Corp��All rights reserved��
//  Author      ��Loafer.Liu @ 2005.
//  Notes       ��
//  Update      ��
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
//  func��CreateFood
//  Desc������һ��ʳ�������˵���Լ�����
//  Parm��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
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
//  func��IsEatFood
//  Desc���ж��Ƿ�Ե�ʳ��ķ���
//  Parm��
//  Rslt��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
//********************************************************************)
function TSnakeWithFood.IsEatFood: boolean;
begin
        result := false;
        if (HeadPoint.X = FTheFood.X)
                and (HeadPoint.Y = FTheFood.Y) then
                        result := true;  //�Ե���
end;

procedure TSnakeWithFood.SetTheFood(const Value: TPoint);
begin
  FTheFood := Value;
end;

(*********************************************************************
//  func��StepOnEx
//  Desc��ǰ��һ�������ж��Ƿ�Ե�ʳ��
//  Parm��
//  Rslt��true: �Ե� false: û��
//  Note��
//  Auth��Loafer.Liu @ 2005.
//  Updt��
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
