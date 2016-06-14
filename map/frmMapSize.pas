unit frmMapSize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TMapSizeForm = class(TForm)
    rgBlockSize: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    spBox: TShape;
    procedure FormCreate(Sender: TObject);
    procedure rgBlockSizeClick(Sender: TObject);
  private
    FBlockSize: integer;
    procedure SetBlockSize(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    property BlockSize: integer read FBlockSize write SetBlockSize;
    //方块的大小，4级，分别为2，4，6，8
    
  end;

var
  MapSizeForm: TMapSizeForm;

implementation

{$R *.dfm}

{ TMapSizeForm }

procedure TMapSizeForm.SetBlockSize(const Value: integer);
begin
  FBlockSize := Value;
end;

procedure TMapSizeForm.FormCreate(Sender: TObject);
begin
        FBlockSize := 8;
        rgBlockSize.ItemIndex := 3;
end;

procedure TMapSizeForm.rgBlockSizeClick(Sender: TObject);
begin
        FBlockSize := 2* (rgBlockSize.ItemIndex+1);
        spBox.Width := FBlockSize*2;
        spBox.Height := FBlockSize*2; 
end;

end.
