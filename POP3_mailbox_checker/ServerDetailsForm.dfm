object formServerDetails: TformServerDetails
  Left = 242
  Top = 211
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Server Details'
  ClientHeight = 125
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 12
    Top = 48
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label3: TLabel
    Left = 188
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label4: TLabel
    Left = 284
    Top = 16
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object editHost: TEdit
    Left = 76
    Top = 12
    Width = 193
    Height = 21
    TabOrder = 0
  end
  object editUsername: TEdit
    Left = 76
    Top = 44
    Width = 101
    Height = 21
    TabOrder = 2
  end
  object editPassword: TEdit
    Left = 244
    Top = 44
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object sedtPort: TSpinEdit
    Left = 324
    Top = 11
    Width = 45
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 110
  end
  object butnOk: TButton
    Left = 200
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 4
  end
  object butnCancel: TButton
    Left = 292
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
