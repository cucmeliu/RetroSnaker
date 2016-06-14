object MainForm: TMainForm
  Left = 309
  Top = 153
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #36138#39135#34503'V0.9'
  ClientHeight = 473
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 454
    Width = 398
    Height = 19
    Panels = <
      item
        Text = '<1'#34503#19978#19979#24038#21491'><2'#34503'w,a,s,d><'#31354#26684#38190#24320#22987#25110#26242#20572'>'
        Width = 300
      end
      item
        Width = 50
      end>
    ExplicitTop = 435
  end
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 398
    Height = 14
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 421
    object lblScore1: TLabel
      Left = 0
      Top = 0
      Width = 398
      Height = 14
      Align = alTop
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblLever1: TLabel
      Left = 128
      Top = 0
      Width = 105
      Height = 17
      AutoSize = False
      Caption = '0'
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblName1: TLabel
      Left = 8
      Top = 0
      Width = 105
      Height = 13
      AutoSize = False
      Caption = #26410#24320#22987
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 424
    Width = 398
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 405
    object lblScore2: TLabel
      Left = 0
      Top = 0
      Width = 398
      Height = 14
      Align = alTop
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblLever2: TLabel
      Left = 128
      Top = 0
      Width = 105
      Height = 17
      AutoSize = False
      Caption = '0'
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lblName2: TLabel
      Left = 8
      Top = 0
      Width = 105
      Height = 13
      AutoSize = False
      Caption = #26410#24320#22987
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 24
    Top = 48
  end
  object ActionList1: TActionList
    Left = 16
    Top = 8
    object actStart: TAction
      Caption = #24320#22987
      OnExecute = actStartExecute
    end
    object actPause: TAction
      Caption = #26242#20572
      OnExecute = actPauseExecute
    end
    object actStop: TAction
      Caption = #20572#27490
    end
    object actExit: TAction
      Caption = #36864#20986'(&E)'
      OnExecute = actExitExecute
    end
    object actGameNew: TAction
      Caption = #26032#28216#25103
      OnExecute = actGameNewExecute
    end
    object actUp: TAction
      Caption = #19978
      OnExecute = actUpExecute
    end
    object actDown: TAction
      Caption = #19979
      OnExecute = actDownExecute
    end
    object actLeft: TAction
      Caption = #24038
      OnExecute = actLeftExecute
    end
    object actRight: TAction
      Caption = #21491
      OnExecute = actRightExecute
    end
    object actOption: TAction
      Caption = #36873#39033'(&O)...'
      OnExecute = actOptionExecute
    end
    object actThroughWall: TAction
      Caption = #31359#22681
      Checked = True
      OnExecute = actThroughWallExecute
    end
    object actHighScore: TAction
      Caption = #25490#34892#27036'...'
      OnExecute = actHighScoreExecute
    end
    object actAbout: TAction
      Caption = #20851#20110'(&A)...'
      OnExecute = actAboutExecute
    end
    object actLever: TAction
      Caption = #31561#32423
      OnExecute = actLeverExecute
    end
    object actPatternBG: TAction
      Caption = #32972#26223#22270#26696
      OnExecute = actPatternBGExecute
    end
    object actSaveGrapic: TAction
      Caption = #25293#29031#30041#24565
      OnExecute = actSaveGrapicExecute
    end
    object actPixSize: TAction
      Caption = #26041#22359#22823#23567
      OnExecute = actPixSizeExecute
    end
    object actSaveParam: TAction
      Caption = #20445#23384#35774#32622
    end
    object actPlayerName: TAction
      Caption = #31614#20010#21517
      OnExecute = actPlayerNameExecute
    end
    object actPlayerName2: TAction
      Caption = #20063#31614#21517
      OnExecute = actPlayerName2Execute
    end
    object actPlayMusic: TAction
      Caption = #25773#25918
      OnExecute = actPlayMusicExecute
    end
    object actOnTop: TAction
      Caption = 'actOnTop'
      OnExecute = actOnTopExecute
    end
    object actTopic: TAction
      Caption = #20027#39064'(&T)...'
      OnExecute = actTopicExecute
    end
    object ActUseMap: TAction
      Caption = #20351#29992#22320#22270
      Checked = True
      OnExecute = ActUseMapExecute
    end
    object ActLoadMap: TAction
      Caption = 'ActLoadMap'
      OnExecute = ActLoadMapExecute
    end
    object ActMakeMap: TAction
      Caption = #22320#22270#32534#36753#22120
      OnExecute = ActMakeMapExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 56
    Top = 8
    object N1: TMenuItem
      Caption = #28216#25103'(&G)'
      object N3: TMenuItem
        Action = actGameNew
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object actPlayerName1: TMenuItem
        Action = actPlayerName
      end
      object N14: TMenuItem
        Action = actPlayerName2
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object N10: TMenuItem
        Action = actSaveGrapic
      end
      object N25: TMenuItem
        Action = actHighScore
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object E1: TMenuItem
        Action = actExit
      end
    end
    object N20: TMenuItem
      Caption = #22320#22270
      object N21: TMenuItem
        Action = ActLoadMap
        Caption = #21152#36733#22320#22270
      end
      object N28: TMenuItem
        Caption = '-'
      end
      object N27: TMenuItem
        Action = ActUseMap
      end
      object N30: TMenuItem
        Caption = '-'
      end
      object N29: TMenuItem
        Action = ActMakeMap
      end
    end
    object C1: TMenuItem
      Caption = #25511#21046'(&C)'
      object N4: TMenuItem
        Action = actStart
      end
      object N5: TMenuItem
        Action = actPause
      end
      object N6: TMenuItem
        Action = actStop
        Visible = False
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N13: TMenuItem
        Action = actUp
      end
      object N15: TMenuItem
        Action = actDown
      end
      object N16: TMenuItem
        Action = actLeft
      end
      object N17: TMenuItem
        Action = actRight
      end
    end
    object mnuSet: TMenuItem
      Caption = #35774#32622
      object mnuSetLever: TMenuItem
        Caption = #28216#25103#38590#24230
        Visible = False
        object mnuLever1: TMenuItem
          Caption = #19968#32423
          Checked = True
          RadioItem = True
          OnClick = actLeverExecute
        end
        object mnuLever2: TMenuItem
          Caption = #20108#32423
          RadioItem = True
          OnClick = actLeverExecute
        end
        object mnuLever3: TMenuItem
          Caption = #19977#32423
          RadioItem = True
          OnClick = actLeverExecute
        end
        object mnuLever4: TMenuItem
          Caption = #22235#32423
          RadioItem = True
          OnClick = actLeverExecute
        end
        object mnuLever5: TMenuItem
          Caption = #20116#32423
          RadioItem = True
          OnClick = actLeverExecute
        end
      end
      object mnuSetPattern: TMenuItem
        Caption = #32972#26223#22270#26696
        Visible = False
        object ptBG1: TMenuItem
          Caption = #26080
          Checked = True
          RadioItem = True
          OnClick = actPatternBGExecute
        end
        object ptBG2: TMenuItem
          Caption = #22825#31354
          RadioItem = True
          OnClick = actPatternBGExecute
        end
        object ptBG3: TMenuItem
          Caption = #26862#26519
          RadioItem = True
          OnClick = actPatternBGExecute
        end
        object ptBG4: TMenuItem
          Caption = #28023#27915
          RadioItem = True
          OnClick = actPatternBGExecute
        end
      end
      object mnuSetPixSize: TMenuItem
        Caption = #26041#22359#22823#23567
        Visible = False
        object mnuPixSize4: TMenuItem
          Caption = #29305#22823
          RadioItem = True
          OnClick = actPixSizeExecute
        end
        object mnuPixSize3: TMenuItem
          Caption = #22823
          Checked = True
          RadioItem = True
          OnClick = actPixSizeExecute
        end
        object mnuPixSize2: TMenuItem
          Caption = #20013
          RadioItem = True
          OnClick = actPixSizeExecute
        end
        object mnuPixSize1: TMenuItem
          Caption = #23567
          RadioItem = True
          OnClick = actPixSizeExecute
        end
      end
      object N18: TMenuItem
        Caption = #32972#26223#38899#20048
        Visible = False
        object mnuSetMusic0: TMenuItem
          Caption = #26080
          Checked = True
          RadioItem = True
        end
        object mnuSetMusic1: TMenuItem
          Caption = #29983#26085#27468
          RadioItem = True
          OnClick = actPlayMusicExecute
        end
        object mnuSetMusic2: TMenuItem
          Caption = #21486#21486#38107
        end
      end
      object N22: TMenuItem
        Caption = '-'
        Visible = False
      end
      object N24: TMenuItem
        Action = actThroughWall
        Visible = False
      end
      object N7: TMenuItem
        Action = actOnTop
        Caption = #24635#22312#26368#21069
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Action = actOption
      end
    end
    object N26: TMenuItem
      Caption = #20851#20110'(&A)'
      object T1: TMenuItem
        Action = actTopic
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object A1: TMenuItem
        Action = actAbout
      end
    end
  end
  object spd: TSavePictureDialog
    DefaultExt = '.bmp'
    Left = 64
    Top = 48
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer2Timer
    Left = 64
    Top = 152
  end
end
