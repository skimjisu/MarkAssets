object AddFrm: TAddFrm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'AddFrm'
  ClientHeight = 397
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  TextHeight = 15
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 397
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      534
      397)
    object AssetCode_lb: TLabel
      Left = 18
      Top = 137
      Width = 71
      Height = 17
      Alignment = taCenter
      Caption = 'AssetCode *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 372
      Width = 335
      Height = 15
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Type the item you want to add and press the Add or Cancel key.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 900850
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Serial_lb: TLabel
      Left = 18
      Top = 209
      Width = 89
      Height = 17
      Alignment = taCenter
      Caption = 'SerialNumber *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Model_lb: TLabel
      Left = 18
      Top = 276
      Width = 79
      Height = 17
      Alignment = taCenter
      Caption = 'Modelname *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object AssetID_lb: TLabel
      Left = 18
      Top = 68
      Width = 117
      Height = 17
      Alignment = taCenter
      Caption = 'Asset ID (Automatic)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Type_lb: TLabel
      Left = 290
      Top = 68
      Width = 71
      Height = 17
      Alignment = taCenter
      Caption = 'Asset Type *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Contract_lb: TLabel
      Left = 290
      Top = 137
      Width = 58
      Height = 17
      Alignment = taCenter
      Caption = 'Contract *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EndDate_lb: TLabel
      Left = 290
      Top = 209
      Width = 58
      Height = 17
      Alignment = taCenter
      Caption = 'EndDate *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object pnl_Top: TPanel
      Left = 0
      Top = 0
      Width = 534
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      OnMouseMove = pnl_TopMouseMove
      object Label1: TLabel
        Left = 18
        Top = 13
        Width = 176
        Height = 37
        Caption = 'Add Inventory'
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
        Width = 534
        Height = 1
        Align = alBottom
        TabOrder = 0
      end
    end
    object AssetCodePanel: TPanel
      Left = 18
      Top = 160
      Width = 261
      Height = 38
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object AssetEdit: TEdit
        Left = 0
        Top = 0
        Width = 261
        Height = 38
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
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
      end
    end
    object SerialPanel: TPanel
      Left = 18
      Top = 232
      Width = 261
      Height = 38
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object SerialEdit: TEdit
        Left = 0
        Top = 0
        Width = 261
        Height = 38
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
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
      end
    end
    object ModelPanel: TPanel
      Left = 17
      Top = 301
      Width = 262
      Height = 38
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Shape3: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object ModelEdit: TEdit
        Left = 0
        Top = 0
        Width = 262
        Height = 38
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
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
      end
    end
    object AssetIDPanel: TPanel
      Left = 18
      Top = 91
      Width = 261
      Height = 38
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object Shape4: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object Edit4: TEdit
        Left = 0
        Top = 0
        Width = 261
        Height = 38
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 16183529
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object TypePanel: TPanel
      Left = 290
      Top = 91
      Width = 221
      Height = 38
      BevelOuter = bvNone
      Color = 16183529
      ParentBackground = False
      TabOrder = 5
      object TypeCombo: TTMSFNCComboBox
        Left = 0
        Top = 0
        Width = 221
        Height = 38
        Align = alClient
        ParentDoubleBuffered = False
        Color = 16183529
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Segoe UI'
        Font.Style = []
        TabOrder = 0
        DropDownWidth = 150.000000000000000000
        Items.Strings = (
          #45936#49828#53356#53457
          #47784#45768#53552
          #45432#53944#48513
          #50500#51060#47589
          #50500#51060#54056#46300)
        ItemHeight = 16.000000000000000000
        Style = csDropDownList
        Text = 'Category...'
        ItemAppearance.ShowFocus = False
        ItemAppearance.ExpandColumn = -1
        ItemAppearance.FixedHeight = 16.000000000000000000
        ItemAppearance.VariableMinimumHeight = 25.000000000000000000
        ItemAppearance.ShowLines = False
        ItemAppearance.Font.Charset = DEFAULT_CHARSET
        ItemAppearance.Font.Color = 8026746
        ItemAppearance.Font.Height = -13
        ItemAppearance.Font.Name = 'Segoe UI'
        ItemAppearance.Font.Style = []
        ItemAppearance.TitleFont.Charset = DEFAULT_CHARSET
        ItemAppearance.TitleFont.Color = clBlack
        ItemAppearance.TitleFont.Height = -11
        ItemAppearance.TitleFont.Name = 'Segoe UI'
        ItemAppearance.TitleFont.Style = []
        ItemAppearance.SelectedFontColor = 4539717
        ItemAppearance.DisabledFontColor = 16183529
        ItemAppearance.SelectedTitleFontColor = 16183529
        ItemAppearance.DisabledTitleFontColor = 16183529
        ItemAppearance.ExtendedFontColor = 4539717
        ItemAppearance.ExtendedSelectedFontColor = 16183529
        ItemAppearance.ExtendedDisabledFontColor = 16183529
        ItemAppearance.SelectedFill.Color = 16578806
        ItemAppearance.SelectedStroke.Color = 15702829
        ItemAppearance.SelectedStroke.Width = 2.000000000000000000
        ItemAppearance.SelectionArea = tsaFull
        ItemAppearance.ExtendedFont.Charset = DEFAULT_CHARSET
        ItemAppearance.ExtendedFont.Color = clWindowText
        ItemAppearance.ExtendedFont.Height = -11
        ItemAppearance.ExtendedFont.Name = 'Segoe UI'
        ItemAppearance.ExtendedFont.Style = []
        ItemAppearance.ExpandNodeIcon.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D494844520000000B0000
          000B080200000026CEE071000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
          1874455874536F667477617265007061696E742E6E657420342E302E36FC8C63
          DF000000334944415478DA63ACAEAD66C00B18812A5A9A5A7049D7D4D5A0ABF0
          F6F3DEBA692B8D540025301D01544A6F7710080FFC610A005ADF3FFDA83755DB
          0000000049454E44AE426082}
        ItemAppearance.CollapseNodeIcon.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D494844520000000B0000
          000B080200000026CEE071000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
          1874455874536F667477617265007061696E742E6E657420342E302E36FC8C63
          DF0000002C4944415478DA63ACAEAD66C00B18812A5A9A5A7049D7D4D5D05B85
          B79F37B2DCD64D5B07C61DF854E00F53005DBC2DFDD89D52A70000000049454E
          44AE426082}
        ItemAppearance.ExpandNodeIconLarge.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000160000
          001608020000004BD6FB6C000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
          1874455874536F667477617265007061696E742E6E657420342E302E36FC8C63
          DF000000404944415478DA63ACAEAD66A00C3052CD8896A6163234D7D4D5D0C5
          086F3F6F20B975D3D6512306C40888066200C450DA183138C262D488C1535E50
          02A8600400AA8F7FF987EC13380000000049454E44AE426082}
        ItemAppearance.CollapseNodeIconLarge.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000160000
          001608020000004BD6FB6C0000000467414D410000B18F0BFC61050000000970
          48597300000EC200000EC20115284A800000001874455874536F667477617265
          007061696E742E6E657420342E302E36FC8C63DF000000384944415478DA63AC
          AEAD66A00C3052CD8896A6163234D7D4D58C1A31628CF0F6F3C6A36DEBA6AD74
          31627084C5A81183C1084A00158C000071065BF9A44132100000000049454E44
          AE426082}
        Appearance.Stroke.Color = 11119017
        Appearance.Fill.Color = 15329769
        Appearance.StrokeHover.Color = 10061943
        Appearance.FillHover.Color = 13419707
        Appearance.StrokeDown.Color = 9470064
        Appearance.FillDown.Color = 13156536
        Appearance.StrokeSelected.Color = 5197615
        Appearance.FillSelected.Color = 13156536
        Appearance.StrokeDisabled.Color = 11119017
        Appearance.FillDisabled.Color = clSilver
        Appearance.SeparatorStroke.Color = 11119017
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = clWindowText
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Segoe UI'
        Appearance.Font.Style = []
      end
    end
    object ContractPanel: TPanel
      Left = 290
      Top = 160
      Width = 221
      Height = 38
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object Shape5: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object ContractEdit: TEdit
        Left = 0
        Top = 0
        Width = 221
        Height = 38
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
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
      end
    end
    object EndDatePanel: TPanel
      Left = 290
      Top = 232
      Width = 221
      Height = 38
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
      object Shape6: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object EndDateEdit: TEdit
        Left = 0
        Top = 0
        Width = 221
        Height = 38
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
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
      end
    end
    object Button2: TButton
      Left = 408
      Top = 295
      Width = 103
      Height = 57
      Caption = 'CANCEL'
      TabOrder = 8
      OnClick = Button2Click
    end
  end
  object Button1: TButton
    Left = 290
    Top = 295
    Width = 103
    Height = 57
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
end
