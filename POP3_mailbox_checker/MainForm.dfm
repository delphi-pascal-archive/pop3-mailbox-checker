object formMain: TformMain
  Left = 243
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'POP3 mailbox checker'
  ClientHeight = 439
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object lstvMessages: TListView
    Left = 0
    Top = 25
    Width = 800
    Height = 287
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Caption = 'From'
        Width = 185
      end
      item
        Caption = 'Recipients'
        Width = 185
      end
      item
        Caption = 'Subject'
        Width = 246
      end
      item
        Caption = 'Size'
        Width = 74
      end
      item
        Caption = 'Priority'
        Width = 74
      end>
    ColumnClick = False
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object memoLog: TMemo
    Left = 0
    Top = 312
    Width = 800
    Height = 127
    Align = alBottom
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 800
    Height = 25
    ButtonHeight = 24
    ButtonWidth = 83
    Caption = 'ToolBar1'
    Flat = True
    ShowCaptions = True
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actnConnect
    end
    object ToolButton2: TToolButton
      Left = 83
      Top = 0
      Action = actnDisconnect
    end
    object ToolButton8: TToolButton
      Left = 166
      Top = 0
      Width = 8
      Caption = 'ToolButton8'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 174
      Top = 0
      Action = actnHeaders
    end
    object ToolButton7: TToolButton
      Left = 257
      Top = 0
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object cboxServerList: TComboBox
      Left = 265
      Top = 0
      Width = 145
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
    end
    object ToolButton9: TToolButton
      Left = 410
      Top = 0
      Width = 8
      Caption = 'ToolButton9'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 418
      Top = 0
      Caption = 'Servers'
      DropdownMenu = pmenuServers
      ImageIndex = 5
      Style = tbsDropDown
    end
  end
  object actnlstMain: TActionList
    OnUpdate = actnlstMainUpdate
    Left = 80
    Top = 56
    object actnConnect: TAction
      Category = 'Disconnected'
      Caption = '&Connect'
      OnExecute = actnConnectExecute
    end
    object actnDisconnect: TAction
      Category = 'Connected'
      Caption = '&Disconnect'
      OnExecute = actnDisconnectExecute
    end
    object actnHeaders: TAction
      Category = 'Connected'
      Caption = '&Headers'
      OnExecute = actnHeadersExecute
    end
    object actnEditServer: TAction
      Category = 'Disconnected'
      Caption = '&Edit'
      OnExecute = actnEditServerExecute
    end
    object actnNewServer: TAction
      Category = 'Disconnected'
      Caption = '&New'
      OnExecute = actnNewServerExecute
    end
    object actnDeleteServer: TAction
      Category = 'Disconnected'
      Caption = 'Dele&te'
      OnExecute = actnDeleteServerExecute
    end
  end
  object pmenuServers: TPopupMenu
    Left = 48
    Top = 56
    object New1: TMenuItem
      Action = actnNewServer
    end
    object Edit1: TMenuItem
      Action = actnEditServer
    end
    object Delete1: TMenuItem
      Action = actnDeleteServer
    end
  end
  object POP: TIdPOP3
    MaxLineAction = maException
    ReadTimeout = 0
    Left = 144
    Top = 56
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 16
    Top = 56
  end
  object Msg: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 112
    Top = 56
  end
end
