unit unitSnakeDefine;

interface

uses Messages, Types;

const AppName = '̰ʳ�� ';
const AppVersion = ' V3.0.1';

const HitWallStr = '�߽�һ�䷿�����涼��ǽ��';
const BitSelfStr = '��Ű�������Ҳ��̶á���';
const BitEachStr = '�����භ��һ��һ�ˣ�';
const HitBlckStr = '·�о�ʯ�������˰ɣ��ٺ�~~~';
const DieMistStr = '��������';


type
  TScoreRec = record
    Grade: byte;
    Name: string[30];
    Score: integer;
  end;

  TSnakeParam = record
    Name: string;       //�ߵ�����
    Pattern: integer;   //�ߵ�ͼ��
    StartPt: TPoint;
    upKey, downKey, leftKey, rightKey, startKey: byte; //����
  end;

  TGameParam = record
    Mode: byte;                 //��Ϸģʽ 1: ���� 2: ˫��
    StartLever: integer;        //��ʼ�ȼ�(�Ѷ�)
    pixPerBlock: integer;       //�����С
    CanThrghWall: boolean;      //�ܷ�ǽ
    CanPassEachOther: boolean;  //�ܷ񽻲棨����ʱ��
    BGPattern,                  //����ͼ��
    FoodPattern,                //ʳ��ͼ��
    BlockPattern: integer;      //�ϰ���ͼ��
    MusicName: string;          //����

    UseMap: boolean;            //�Ƿ�ʹ��
    MapFile: wideString;
  end;

  TDieType = (dtHitWall, dtBiteSelf, dtBitEach, dtHitBlock);
  //���������ͣ�ײǽ��ҧ�Լ�����ҧ

implementation


end.
