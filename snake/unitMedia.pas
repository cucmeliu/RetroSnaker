unit unitMedia;

interface

uses Classes, mmSystem, SysUtils, Variants;

type
  TMediaThread = class(TThread)
  private
    FmmFileName: string;
    procedure SetmmFileName(const Value: string);
//    MediaPlayer: TMediaPlayer;
  protected
    procedure Execute; override;
  public
    property mmFileName: string read FmmFileName write SetmmFileName;
  end;

implementation


procedure TMediaThread.Execute;
begin
//  while not Terminated do
  begin
        PlaySound(PAnsiChar(FmmFileName), 0,snd_Async);
  end;
end;

procedure TMediaThread.SetmmFileName(const Value: string);
begin
  FmmFileName := Value;
end;

end.
