object MapSizeForm: TMapSizeForm
  Left = 480
  Top = 249
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #26032#24314#22320#22270
  ClientHeight = 161
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object spBox: TShape
    Left = 184
    Top = 24
    Width = 16
    Height = 16
    Brush.Color = clYellow
  end
  object rgBlockSize: TRadioGroup
    Left = 8
    Top = 8
    Width = 137
    Height = 145
    Caption = #21333#20803#26684#22823#23567
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ItemIndex = 3
    Items.Strings = (
      #26368#23567'(2*2)'
      #20013#31561'(4*4)'
      #36739#22823'(8*8)'
      #26368#22823'(16*16)')
    ParentFont = False
    TabOrder = 0
    OnClick = rgBlockSizeClick
  end
  object BitBtn1: TBitBtn
    Left = 160
    Top = 80
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 160
    Top = 120
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 2
    Kind = bkCancel
  end
end
