object formMain: TformMain
  Left = 277
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pinball'
  ClientHeight = 353
  ClientWidth = 462
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCC0
    000CCCC0000000000CCCC8888CCCCCCC0000CCCC00000000CCCC8888CCCCCCCC
    C0000CCCCCCCCCCCCCC8888CCCCC0CCCCC0000CCCCCCCCCCCC8888CCCCC800CC
    C00CCCC0000000000CCCC88CCC88000C0000CCCC00000000CCCC8888C8880000
    00000CCCC000000CCCC888888888C000C00000CCCC0000CCCC88888C888CCC00
    CC00000CCCCCCCCCC88888CC88CCCCC0CCC000CCCCC00CCCCC888CCC8CCCCCCC
    CCCC0CCCCCCCCCCCCCC8CCCCCCCCCCCC0CCCCCCCCCCCCCCCCCCCCCC8CCC80CCC
    00CCCCCCCC0CC0CCCCCCCC88CC8800CC000CCCCCC000000CCCCCC888CC8800CC
    0000CCCC00000000CCCC8888CC8800CC0000C0CCC000000CCC8C8888CC8800CC
    0000C0CCC000000CCC8C8888CC8800CC0000CCCC00000000CCCC8888CC8800CC
    000CCCCCC000000CCCCCC888CC8800CC00CCCCCCCC0CC0CCCCCCCC88CC880CCC
    0CCCCCCCCCCCCCCCCCCCCCC8CCC8CCCCCCCC0CCCCCCCCCCCCCC8CCCCCCCCCCC0
    CCC000CCCCC00CCCCC888CCC8CCCCC00CC00000CCCCCCCCCC88888CC88CCC000
    C00000CCCC0000CCCC88888C888C000000000CCCC000000CCCC888888888000C
    0000CCCC00000000CCCC8888C88800CCC00CCCC0000000000CCCC88CCC880CCC
    CC0000CCCCCCCCCCCC8888CCCCC8CCCCC0000CCCCCCCCCCCCCC8888CCCCCCCCC
    0000CCCC00000000CCCC8888CCCCCCC0000CCCC0000000000CCCC8888CCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object PanelGame: TPanel
    Left = 0
    Top = 0
    Width = 462
    Height = 353
    Align = alClient
    BevelOuter = bvLowered
    Color = clGray
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object ShapeUser: TShape
      Left = 240
      Top = 336
      Width = 49
      Height = 15
      Brush.Color = clYellow
      Shape = stRoundRect
    end
    object ShapeBall: TShape
      Left = 257
      Top = 324
      Width = 13
      Height = 12
      Brush.Color = clYellow
      Shape = stCircle
    end
  end
  object MainMenu1: TMainMenu
    Left = 236
    Top = 20
    object miGame: TMenuItem
      Caption = '&Game'
      object miNew: TMenuItem
        Caption = '&New'
        object miTakeItEasy: TMenuItem
          Caption = '&Take it easy'
          OnClick = miTakeItEasyClick
        end
        object miBringThemOn: TMenuItem
          Caption = '&Bring them on'
          OnClick = miBringThemOnClick
        end
        object miHurtMe: TMenuItem
          Caption = '&Hurt me'
          OnClick = miHurtMeClick
        end
        object miFoolsPlay: TMenuItem
          Caption = '&Fools play'
          OnClick = miFoolsPlayClick
        end
      end
      object miPauze: TMenuItem
        Caption = '&Pauze'
      end
      object miN1: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = '&Exit'
      end
    end
    object miHelp: TMenuItem
      Caption = '&Help'
      object miKeys: TMenuItem
        Caption = '&Keys'
        OnClick = miKeysClick
      end
      object miAbout: TMenuItem
        Caption = '&About'
        OnClick = miAboutClick
      end
    end
  end
end
