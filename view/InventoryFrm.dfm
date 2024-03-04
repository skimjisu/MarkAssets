object InvFrm: TInvFrm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'InvFrm'
  ClientHeight = 533
  ClientWidth = 867
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
    Width = 867
    Height = 533
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      867
      533)
    object Label13: TLabel
      Left = 24
      Top = 66
      Width = 280
      Height = 17
      Alignment = taCenter
      Caption = 'Type what you'#39're looking for and press Enter.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 26
      Top = 466
      Width = 368
      Height = 15
      Anchors = [akLeft, akRight, akBottom]
      Caption = 
        'Select the line item you want to delete and press the Del or Del' +
        'ete key.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 900850
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object pnl_Top: TPanel
      Left = 0
      Top = 0
      Width = 867
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 24
        Top = 9
        Width = 119
        Height = 37
        Caption = 'Inventory'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -27
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object Panel2: TPanel
        Left = 0
        Top = 56
        Width = 867
        Height = 1
        Align = alBottom
        TabOrder = 0
      end
    end
    object Panel5: TPanel
      Left = 192
      Top = 91
      Width = 652
      Height = 38
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        652
        38)
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object Edit1: TEdit
        Left = 0
        Top = 0
        Width = 652
        Height = 38
        Margins.Left = 15
        Margins.Top = 15
        Margins.Right = 15
        Margins.Bottom = 15
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 16183529
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'Find Item'
      end
      object Panel7: TPanel
        Left = 565
        Top = 0
        Width = 87
        Height = 38
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'Search'
        Color = 15898113
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 26
      Top = 91
      Width = 148
      Height = 38
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = 'Add Product'
      Color = 15898113
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = Panel3Click
    end
    object StringGrid1: TStringGrid
      Left = 24
      Top = 147
      Width = 808
      Height = 275
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 3
    end
  end
end
