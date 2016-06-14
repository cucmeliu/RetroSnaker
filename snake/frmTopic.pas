unit frmTopic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TTopicForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    Memo2: TMemo;
    Memo3: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TopicForm: TTopicForm;

implementation

{$R *.dfm}

end.
