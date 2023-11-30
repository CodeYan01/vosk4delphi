object Form1: TForm1
  Left = 276
  Top = 126
  Width = 1044
  Height = 540
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Shape3: TShape
    Left = 552
    Top = 16
    Width = 65
    Height = 65
  end
  object Label2: TLabel
    Left = 264
    Top = 72
    Width = 121
    Height = 57
    Alignment = taCenter
    Caption = 'Label2'
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 424
    Top = 120
    Width = 265
    Height = 161
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 265
      Height = 161
    end
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 265
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Label1'
    end
  end
  object VoskModel1: TVoskModel
    Left = 232
    Top = 168
  end
  object VoskRecognizer1: TVoskRecognizer
    Model = VoskModel1
    Left = 280
    Top = 168
  end
end
