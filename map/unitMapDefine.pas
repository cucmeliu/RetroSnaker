unit unitMapDefine;

interface

uses types, Graphics;

type
  TMapParam = record
    BlockSize: integer;
  end;

  TDrawMode = (dmBG, dmBlock, dmSnake1, dmSnake2);

procedure DrawASec(APoint: TPoint; patternBmp: TBitmap;
        ApixPerBlock: integer; ACanvas: TCanvas);

procedure MyAboutWin(AHandle: THandle; appName, appVersion: PChar); stdcall; external 'myCommDialogs.dll';

const AppName = 'ÉßÐÐÇ§Àï ';
const AppVersion = ' (µØÍ¼±à¼­Æ÷)V1.0.1';

implementation



procedure DrawASec(APoint: TPoint; patternBmp: TBitmap;
        ApixPerBlock: integer; ACanvas: TCanvas);
var
  ARect: TRect;
  dblBlock: integer;
begin
        dblBlock := ApixPerBlock*2;
        ARect.Left := APoint.X * dblBlock;
        ARect.Right := APoint.X * dblBlock + dblBlock;
        ARect.Top := 400 - (APoint.Y * dblBlock);
        ARect.Bottom := 400 - (APoint.Y * dblBlock + dblBlock );
        //ACanvas.Rectangle(ARect);
        ACanvas.CopyMode := cmSrcCopy;
        ACanvas.CopyRect(ARect, patternBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1));
end;

end.
