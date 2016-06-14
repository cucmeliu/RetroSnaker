object PlayerNameForm: TPlayerNameForm
  Left = 382
  Top = 240
  BorderStyle = bsNone
  Caption = #36755#20837#22823#21517
  ClientHeight = 144
  ClientWidth = 170
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 97
    Height = 13
    AutoSize = False
    Caption = #36755#20837#20320#30340#22823#21517
  end
  object lblGrade: TLabel
    Left = 16
    Top = 104
    Width = 145
    Height = 25
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 16
    Top = 40
    Width = 137
    Height = 21
    TabOrder = 1
    Text = #26080#21517#27663
  end
  object BitBtn1: TBitBtn
    Left = 80
    Top = 72
    Width = 75
    Height = 25
    Caption = #23601#26159#25105#20102
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
  end
end
