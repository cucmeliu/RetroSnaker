unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ToolWin, ActnList, Menus,
  ImgList, unitMapDefine;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet3: TTabSheet;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    ActionNewMap: TAction;
    ActionOpenMap: TAction;
    ActionExit: TAction;
    ActionOpenMap1: TMenuItem;
    N3: TMenuItem;
    ActionExit1: TMenuItem;
    H1: TMenuItem;
    A1: TMenuItem;
    ImageList1: TImageList;
    ActionSave: TAction;
    StatusBar1: TStatusBar;
    S1: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ImageList2: TImageList;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ActionSaveAs: TAction;
    ActionSaveAs1: TMenuItem;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ActionNewMapExecute(Sender: TObject);
    procedure ActionOpenMapExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FBGBmp,
    FBlockBmp,
    FSnakeBmp,
    FBufBmp: TBitmap;

    fBlockSize: integer;  //ÿ����Ԫ�񷽿�Ĵ�С (ȡһ���С)
    FGridNum: integer;    //����ĳ�����Ԫ����Ŀ

    FMatrix: array of array of byte;  //���� 0��ʾ���� 1��ʾ�ϰ� ***2��ʾ��

    FSnake1Point,
    FSnake2Point: TPoint;

    FDrawMode: TDrawMode;

    FPaintRect: TRect;

    FMousePoint,
    FLastPoint: TPoint;

    FNewFile: boolean;
    FFileName: Widestring;
    FStateChange: boolean; //�޸�״̬����ͼ�иĶ�Ϊtrue������Ϊfalse;

    procedure LoadBMP;
    procedure CreateMatrix(gridNum: integer);
    procedure ResetGridNum(BlockSize: integer);
    procedure NewMap;
    procedure SaveMap(mapFile: string);
    procedure LoadMap(mapFile: string);

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses frmMapSize;

{$R *.dfm}

procedure TMainForm.FormPaint(Sender: TObject);
var
  i, j, dblBlock: integer;
  ARect: TRect;
begin
        dblBlock := fBlockSize*2;
        FBufBmp.Canvas.Brush.Color := clWhite;
        FBufBmp.Canvas.FillRect(FBufBmp.Canvas.ClipRect);
        FBufBmp.Canvas.CopyMode := cmSrcCopy;
        for i:= 0 to (FGridNum-1) do
                for j:= 0 to (FGridNum-1) do
                begin
                        ARect.Left := i * dblBlock;
                        ARect.Right := ARect.Left + dblBlock - 1;
                        ARect.Top := (j * dblBlock);
                        ARect.Bottom := ARect.Top + dblBlock - 1;

                        if FMatrix[i][j] = 0 then        //����
                                FBufBmp.Canvas.CopyRect(ARect, FBGBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1))  
                        else if FMatrix[i][j] = 1 then   //�ϰ�
                                FBufBmp.Canvas.CopyRect(ARect, FBlockBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1));
                        //else if FMatrix[i][j] = 2 then   //��
                        //        FBufBmp.Canvas.CopyRect(ARect, FSnakeBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1));

                end;

        //������λ��
        ARect.Left := FSnake1Point.X * dblBlock;
        ARect.Right := ARect.Left + dblBlock - 1;
        ARect.Top := FSnake1Point.Y * dblBlock;
        ARect.Bottom := ARect.Top + dblBlock - 1;
        FBufBmp.Canvas.CopyRect(ARect, FSnakeBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1));

        ARect.Left := FSnake2Point.X * dblBlock;
        ARect.Right := ARect.Left + dblBlock - 1;
        ARect.Top := FSnake2Point.Y * dblBlock;
        ARect.Bottom := ARect.Top + dblBlock - 1;
        FBufBmp.Canvas.CopyRect(ARect, FSnakeBmp.Canvas, Rect(0, 0, dblBlock-1, dblBlock-1));

        Self.Canvas.CopyRect(FPaintRect, FBufBmp.Canvas, FBufBmp.Canvas.ClipRect);

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
        FBGBmp := TBitmap.Create;
        FBlockBmp := TBitmap.Create;
        FSnakeBmp := TBitmap.Create;
        FBufBmp := TBitmap.Create;

        FBufBmp.Width := 400;
        FBufBmp.Height := 400; 

        FPaintRect.Left := PageControl1.Left + PageControl1.Width + 10;
        FPaintRect.Right := FPaintRect.Left + 400;
        FPaintRect.Top := ToolBar2.Top + ToolBar2.Height + 10;
        FPaintRect.Bottom := FPaintRect.Top + 400;

        FMousePoint := Point(0, 0);
        SetLength(FMatrix, 0);
        FSnake1Point := Point(2, 2);
        FSnake2Point := Point(2, 5);
        
        FDrawMode := dmBlock;
        FFileName := '';
        FNewFile := True;
        FStateChange := false;

        fBlockSize := 8;
        ResetGridNum(fBlockSize);
        NewMap;

end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        FBGBmp.Free;
        FBlockBmp.Free;
        FSnakeBmp.Free;
        FBufBmp.Free;
        SetLength(FMatrix, 0);
        Action := cafree;
end;

procedure TMainForm.LoadBMP;
var
  tmpBmp: TBitmap;
  cpRect: TRect;
  dbBlock: integer;
begin
        tmpBmp := TBitmap.Create;
        tmpBmp.Width := 256;
        tmpBmp.Height := 256;
        tmpBmp.LoadFromFile(ExtractFilePath(application.ExeName) + '\img\Pat_Sample.bmp');

        dbBlock := self.fBlockSize*2;
        FBGBmp.Width := dbBlock;
        FBGBmp.Height := dbBlock;
        FBlockBmp.Width := dbBlock;
        FBlockBmp.Height := dbBlock;
        FSnakeBmp.Width := dbBlock;
        FSnakeBmp.Height := dbBlock;

        cpRect := Rect(12*16, 0, 12*16+dbBlock-1, dbBlock-1);
        FBGBmp.Canvas.CopyMode := cmSrcCopy;
        FBGBmp.Canvas.CopyRect(Rect(0, 0, dbBlock-1, dbBlock-1), tmpBmp.Canvas, cpRect);

        cpRect := Rect(2*16, 0, 2*16+dbBlock-1, dbBlock-1);
        FBlockBmp.Canvas.CopyMode := cmSrcCopy;
        FBlockBmp.Canvas.CopyRect(Rect(0, 0, dbBlock-1, dbBlock-1), tmpBmp.Canvas, cpRect);

        cpRect := Rect(5*16, 0, 5*16+dbBlock-1, dbBlock-1);
        FSnakeBmp.Canvas.CopyMode := cmSrcCopy;
        FSnakeBmp.Canvas.CopyRect(Rect(0, 0, dbBlock-1, dbBlock-1), tmpBmp.Canvas, cpRect);

        tmpBmp.Free;

end;

procedure TMainForm.CreateMatrix(gridNum: integer);
var
  i, j: integer;
begin
        //��ʼ������
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

procedure TMainForm.ToolButton1Click(Sender: TObject);
begin
        FDrawMode := dmBG;
        StatusBar1.Panels[0].Text := '����ϰ�';
end;

procedure TMainForm.ToolButton4Click(Sender: TObject);
begin
        FDrawMode := dmBlock;
        StatusBar1.Panels[0].Text := '�����ϰ�';
end;

procedure TMainForm.ToolButton7Click(Sender: TObject);
begin
        FDrawMode := dmSnake1;
        StatusBar1.Panels[0].Text := '������1';
end;

procedure TMainForm.ToolButton8Click(Sender: TObject);
begin
        FDrawMode := dmSnake2;
        StatusBar1.Panels[0].Text := '������2';
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  aRect: TRect;
  fixBlock: integer;
begin
        fixBlock := fBlockSize * 2;
        
        aRect.Left := FPaintRect.Left+FMousePoint.X*fixBlock;
        aRect.Right := aRect.Left + fixBlock;
        aRect.Top := FPaintRect.Top+FMousePoint.Y*fixBlock;
        aRect.Bottom := aRect.Top + fixBlock;

        if PtInRect(aRect, point(x, y)) then exit;

        FLastPoint := FMousePoint;
        FMousePoint.X := (X-FPaintRect.Left) div fixBlock;
        FMousePoint.Y := (Y-FPaintRect.Top) div fixBlock;

        //������켣
        if not PtInRect(Bounds(0, 0, FGridNum, FGridNum), FLastPoint) then exit;

        aRect.Left := FPaintRect.Left+(FLastPoint.X)*fixBlock;
        aRect.Right := aRect.Left + fixBlock - 1;
        aRect.Top := FPaintRect.Top+(FLastPoint.Y)*fixBlock;
        aRect.Bottom := aRect.Top + fixBlock - 1;

        if FMatrix[FLastPoint.X, FLastPoint.Y] = 0 then
                Canvas.CopyRect(aRect, fBGBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1))
        else if FMatrix[FLastPoint.X, FLastPoint.Y] = 1 then
                Canvas.CopyRect(aRect, fBlockBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1));

        if ((FLastPoint.X = FSnake1Point.X) and (FLastPoint.Y = FSnake1Point.Y))
                or ((FLastPoint.X = FSnake2Point.X) and (FLastPoint.Y = FSnake2Point.Y)) then
                begin
                        Canvas.CopyRect(aRect, fSnakeBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1)) ;
                        exit; //�ߵ㣬��֧�ֱ�Ļ��ƣ��ʲ�ִ��֮��Ĳ���
                end;   

        if ((FMousePoint.X = FSnake1Point.X) and (FMousePoint.Y = FSnake1Point.Y))
                or ((FMousePoint.X = FSnake2Point.X) and (FMousePoint.Y = FSnake2Point.Y)) then
                begin
                        //Canvas.CopyRect(aRect, fSnakeBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1)) ;
                        exit; //�ߵ㣬��֧�ֱ�Ļ��ƣ��ʲ�ִ��֮��Ĳ���
                end;

        //�õ�ǰͼ��������굽���Rect   
        if not PtInRect(Bounds(0, 0, FGridNum, FGridNum), FMousePoint) then exit;
        
        aRect.Left := FPaintRect.Left+(FMousePoint.X)*fixBlock;
        aRect.Right := aRect.Left + fixBlock - 1;
        aRect.Top := FPaintRect.Top+(FMousePoint.Y)*fixBlock;
        aRect.Bottom := aRect.Top + fixBlock - 1;

        if FDrawMode = dmBG then
                Canvas.CopyRect(aRect, fBGBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1))
        else if FDrawMode = dmBlock then
                Canvas.CopyRect(aRect, fBlockBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1))
        else Canvas.CopyRect(aRect, fSnakeBmp.Canvas, Rect(0, 0, fixBlock-1, fixBlock-1));

        StatusBar1.Panels[1].Text := ' ['+IntToStr(FMousePoint.X+1)+', '+IntToStr(FMousePoint.Y+1)+']';
        //StatusBar1.Panels[2].Text := ' ['+IntToStr(FLastPoint.X+1)+', '+IntToStr(FLastPoint.Y+1)+']';

end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
        if not PtInRect(Bounds(0, 0, FGridNum, FGridNum), FMousePoint) then exit;
        
        FStateChange := true;
        
        if FDrawMode = dmBG then
                FMatrix[FMousePoint.X, FMousePoint.Y] := 0
        else if FDrawMode = dmBlock then
                FMatrix[FMousePoint.X, FMousePoint.Y] := 1
        else if FDrawMode = dmSnake1 then
        begin
                FSnake1Point := FMousePoint;
                Invalidate;
        end
        else if FDrawMode = dmSnake2 then
        begin
                FSnake2Point := FMousePoint;
                Invalidate;
        end;
                
        //self.Invalidate;

end;

procedure TMainForm.ActionNewMapExecute(Sender: TObject);
var
  frm: TMapSizeForm;
begin
        frm := TMapSizeForm.Create(nil);
        try
                if frm.ShowModal = mrOk then
                begin
                        fBlockSize := frm.BlockSize;
                        NewMap;
                        FSnake1Point := Point(2, 3);
                        FSnake2Point := Point(2, 5);
                        FFileName := '';
                        FNewFile := true;
                        FStateChange := false;
                end;
        finally
        frm.Free;
        end;
end;

procedure TMainForm.ActionOpenMapExecute(Sender: TObject);
var
  od: TOpenDialog;
begin
        od := TOpenDialog.Create(nil);
        od.Filter := 'Snake Map File|*.smp';
        od.InitialDir := ExtractFilePath(Application.ExeName);
        if od.Execute then
        begin
                FFileName := ExtractFileName(od.FileName);
                LoadMap(FFileName);
                FNewFile := false;
                FStateChange := false;
        end;
        od.Free;
end;

procedure TMainForm.ActionExitExecute(Sender: TObject);
begin
        Close;
end;

procedure TMainForm.ActionSaveExecute(Sender: TObject);
var
  sd: TSaveDialog;
begin
        if FNewFile then
        begin
                sd := TSaveDialog.Create(nil);
                sd.Options := sd.Options + [ofOverwritePrompt];
                sd.Filter := 'Snake Map File|*.smp';
                sd.DefaultExt := 'smp';
                sd.InitialDir := ExtractFilePath(Application.ExeName);
                if sd.Execute then
                begin
                        FFileName := ExtractFileName(sd.FileName);
                        FNewFile := false; 
                        SaveMap(FFileName);
                end;
                sd.Free;
        end else SaveMap(FFileName);
        FStateChange := false;
        
end;

procedure TMainForm.NewMap;
begin
        ResetGridNum(fBlockSize);
        CreateMatrix(FGridNum);
        LoadBMP;
        self.Invalidate;
end;

procedure TMainForm.LoadMap(mapFile: string);
var
  s: TFileStream;
  a: array of byte;
  i, j: integer;
begin
        s := TFileStream.Create(mapFile, fmOpenRead);
        try
                s.Read(fBlockSize, Sizeof(integer));
                s.Read(FSnake1Point, SizeOf(TPoint));
                s.Read(FSnake2Point, SizeOf(TPoint));
                                
                ResetGridNum(fBlockSize);
                setLength(a, FGridNum*FGridNum);
                
                s.Read(a[0], FGridNum*FGridNum*SizeOf(byte));
                NewMap;
                
                for i := 0 to FGridNum - 1 do
                        for j := 0 to FGridNum - 1 do
                                FMatrix[i, j] := a[FGridNum*i+j];
                Paint;   
        finally
        s.Free;
        end;
        
end;

procedure TMainForm.SaveMap(mapFile: string);
var
  s: TFileStream; 
  i, j: integer;
  a: array of byte;
begin
        s := TFileStream.Create(mapFile, fmCreate);
        try
                s.Write(fBlockSize, sizeof(integer));
                
                s.Write(FSnake1Point, SizeOf(TPoint));
                s.Write(FSnake2Point, SizeOf(TPoint));

                setLength(a, FGridNum*FGridNum);          
                for i :=  0 to FGridNum-1 do
                        for j := 0 to FGridNum-1 do
                                a[FGridNum*i+j] := FMatrix[i, j];
                s.WriteBuffer(a[0], FGridNum*FGridNum*sizeof(byte));
        finally
        s.Free;
        end;
end;

procedure TMainForm.A1Click(Sender: TObject);
begin
        MyAboutWin(application.Handle ,PChar(AppName), PChar(AppVersion)); 
end;

procedure TMainForm.ActionSaveAsExecute(Sender: TObject);
var
  sd: TSaveDialog;
begin
        sd := TSaveDialog.Create(nil);
        sd.Options := sd.Options + [ofOverwritePrompt];
        sd.Filter := 'Snake Map File|*.smp';
        sd.DefaultExt := 'smp';
        sd.InitialDir := ExtractFilePath(Application.ExeName);
        if sd.Execute then
        begin
                FFileName := ExtractFileName(sd.FileName);
                FNewFile := false;
                FStateChange := false;
                SaveMap(FFileName);
        end;
        sd.Free;

end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  mdt: Word;
begin
        if FStateChange then
        begin
                mdt := MessageDlg('��ͼ�����޸ģ�Ҫ������', mtConfirmation,
                        [mbYes, mbNo, mbCancel], 0);
                if mdt = mrYes then ActionSave.Execute
                else if mdt = mrCancel then CanClose := false;
        end;

end;

end.
