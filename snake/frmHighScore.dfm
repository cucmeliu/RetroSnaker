object HighScoreForm: THighScoreForm
  Left = 422
  Top = 189
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #25490#34892#27036
  ClientHeight = 233
  ClientWidth = 227
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
  object SpeedButton1: TSpeedButton
    Left = 152
    Top = 200
    Width = 65
    Height = 22
    Caption = #30693#36947#20102
    Flat = True
    OnClick = SpeedButton1Click
  end
  object lbHighScore: TListBox
    Left = 0
    Top = 0
    Width = 227
    Height = 193
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 20
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9')
    ParentFont = False
    TabOrder = 0
  end
end
