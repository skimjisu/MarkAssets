object Loginfrm: TLoginfrm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Loginfrm'
  ClientHeight = 302
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 274
    Height = 302
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 270
    ExplicitHeight = 301
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 274
      Height = 128
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 270
      object VirtualImage1: TVirtualImage
        Left = 88
        Top = 16
        Width = 105
        Height = 105
        ImageWidth = 0
        ImageHeight = 0
        ImageIndex = -1
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 128
      Width = 274
      Height = 174
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      ExplicitWidth = 270
      ExplicitHeight = 173
      object LoginButton: TSpeedButton
        Left = 8
        Top = 109
        Width = 257
        Height = 49
        Caption = 'Login'
        OnClick = LoginButtonClick
      end
      object PasswordField: TLabeledEdit
        Left = 8
        Top = 72
        Width = 257
        Height = 23
        EditLabel.Width = 50
        EditLabel.Height = 15
        EditLabel.Caption = 'Password'
        PasswordChar = '*'
        TabOrder = 1
        Text = '1111'
      end
      object UsernameField: TLabeledEdit
        Left = 8
        Top = 24
        Width = 257
        Height = 23
        EditLabel.Width = 53
        EditLabel.Height = 15
        EditLabel.Caption = 'Username'
        TabOrder = 0
        Text = 'kdhs'
      end
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 16
    Top = 16
  end
end
