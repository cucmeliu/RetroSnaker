unit UnitSnakeMap;

interface

uses MyGraphi,Graphics,Types;

type
  TSnakeMap = class(TMyGraph)

  protected
    procedure DrawMap(MyCanvas: TCanvas; DrawRect: TRect); override;
  end;

implementation

{ TSnakeMap }

procedure TSnakeMap.DrawMap(MyCanvas: TCanvas; DrawRect: TRect);
begin
  inherited;

end;

end.
