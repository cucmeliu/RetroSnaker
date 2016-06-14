unit unitSnakeDefine;

interface

uses Messages, Types;

const AppName = '贪食蛇 ';
const AppVersion = ' V3.0.1';

const HitWallStr = '走进一间房，四面都是墙～';
const BitSelfStr = '自虐而死，惨不忍睹～～';
const BitEachStr = '两蛇相斗，一死一伤！';
const HitBlckStr = '路有巨石，近视了吧，嘿嘿~~~';
const DieMistStr = '不明死法';


type
  TScoreRec = record
    Grade: byte;
    Name: string[30];
    Score: integer;
  end;

  TSnakeParam = record
    Name: string;       //蛇的名称
    Pattern: integer;   //蛇的图案
    StartPt: TPoint;
    upKey, downKey, leftKey, rightKey, startKey: byte; //按键
  end;

  TGameParam = record
    Mode: byte;                 //游戏模式 1: 单人 2: 双人
    StartLever: integer;        //起始等级(难度)
    pixPerBlock: integer;       //方块大小
    CanThrghWall: boolean;      //能否穿墙
    CanPassEachOther: boolean;  //能否交叉（两蛇时）
    BGPattern,                  //背景图案
    FoodPattern,                //食物图案
    BlockPattern: integer;      //障碍物图案
    MusicName: string;          //音乐

    UseMap: boolean;            //是否使用
    MapFile: wideString;
  end;

  TDieType = (dtHitWall, dtBiteSelf, dtBitEach, dtHitBlock);
  //死亡的类型，撞墙、咬自己、互咬

implementation


end.
