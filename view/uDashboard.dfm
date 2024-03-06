object DashbdFrm: TDashbdFrm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'DashbdFrm'
  ClientHeight = 478
  ClientWidth = 1019
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 1019
    Height = 421
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 1019
      Height = 421
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Home'
      end
      object TabSheet2: TTabSheet
        Caption = 'Details'
        ImageIndex = 1
        object Memo2: TMemo
          Left = 0
          Top = 0
          Width = 1011
          Height = 391
          Align = alClient
          Lines.Strings = (
            'Memo2')
          TabOrder = 0
        end
      end
    end
  end
  object pnl_Top: TPanel
    Left = 0
    Top = 0
    Width = 1019
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Label6: TLabel
      Left = 24
      Top = 9
      Width = 140
      Height = 37
      Caption = 'Dash Board'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -27
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 0
      Top = 56
      Width = 1019
      Height = 1
      Align = alBottom
      TabOrder = 0
    end
  end
end
