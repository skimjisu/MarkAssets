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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object InvPanel: TPanel
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
    object DecLB: TLabel
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
    object NoticeLB: TLabel
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
      object InvTitle: TLabel
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
      object LineHeader: TPanel
        Left = 0
        Top = 56
        Width = 867
        Height = 1
        Align = alBottom
        TabOrder = 0
      end
    end
    object FindPanel: TPanel
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
      object FindED_Shape: TShape
        Left = 0
        Top = 0
        Width = 537
        Height = 38
      end
      object FindED: TEdit
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
      object SearchBtm: TPanel
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
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = SearchBtmClick
      end
    end
    object AddBtn: TPanel
      Left = 26
      Top = 91
      Width = 148
      Height = 38
      Cursor = crHandPoint
      BevelOuter = bvNone
      Caption = 'Add Inventory'
      Color = 15898113
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      OnClick = AddBtnClick
    end
    object InvGrid: TTMSFNCGrid
      AlignWithMargins = True
      Left = 26
      Top = 147
      Width = 812
      Height = 296
      AdaptToStyle = True
      ParentDoubleBuffered = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      DoubleBuffered = True
      TabOrder = 3
      DefaultRowHeight = 40.000000000000000000
      FixedColumns = 0
      ColumnCount = 4
      Options.Bands.Enabled = True
      Options.ColumnSize.Stretch = True
      Options.ColumnSize.StretchAll = True
      Options.ColumnSize.SyncWithGrid = True
      Options.Editing.CalcFormat = '%g'
      Options.Grouping.CalcFormat = '%g'
      Options.Grouping.GroupCountFormat = '(%d)'
      Options.IO.XMLEncoding = 'ISO-8859-1'
      Options.Mouse.ClickMargin = 0
      Options.Mouse.ColumnSizeMargin = 6
      Options.Mouse.RowSizeMargin = 6
      Options.Selection.Mode = smSingleRow
      Columns = <
        item
          BorderWidth = 1
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = 4539717
          FixedFont.Height = -11
          FixedFont.Name = 'Segoe UI'
          FixedFont.Style = [fsBold]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8026746
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ID = ''
          Width = 198.250000000000000000
        end
        item
          BorderWidth = 1
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = 4539717
          FixedFont.Height = -11
          FixedFont.Name = 'Segoe UI'
          FixedFont.Style = [fsBold]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8026746
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ID = ''
          Width = 198.250000000000000000
        end
        item
          BorderWidth = 1
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = 4539717
          FixedFont.Height = -11
          FixedFont.Name = 'Segoe UI'
          FixedFont.Style = [fsBold]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8026746
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ID = ''
          Width = 198.250000000000000000
        end
        item
          BorderWidth = 1
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = 4539717
          FixedFont.Height = -11
          FixedFont.Name = 'Segoe UI'
          FixedFont.Style = [fsBold]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8026746
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ID = ''
          Width = 198.250000000000000000
        end
        item
          BorderWidth = 1
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = 4539717
          FixedFont.Height = -11
          FixedFont.Name = 'Segoe UI'
          FixedFont.Style = [fsBold]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 8026746
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ID = ''
          Width = 90.000000000000000000
        end>
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clBlack
      DefaultFont.Height = -11
      DefaultFont.Name = 'Segoe UI'
      DefaultFont.Style = []
      Stroke.Color = 15987699
      TopRow = 1
      Appearance.FixedLayout.Fill.Kind = gfkGradient
      Appearance.FixedLayout.Fill.Color = 16382457
      Appearance.FixedLayout.Fill.ColorTo = 16382457
      Appearance.FixedLayout.Stroke.Color = 15987699
      Appearance.FixedLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.FixedLayout.Font.Color = clBlack
      Appearance.FixedLayout.Font.Height = -13
      Appearance.FixedLayout.Font.Name = 'Segoe UI'
      Appearance.FixedLayout.Font.Style = [fsBold]
      Appearance.NormalLayout.Fill.Color = 16578806
      Appearance.NormalLayout.Stroke.Color = 15987699
      Appearance.NormalLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.NormalLayout.Font.Color = clBlack
      Appearance.NormalLayout.Font.Height = -11
      Appearance.NormalLayout.Font.Name = 'Segoe UI'
      Appearance.NormalLayout.Font.Style = []
      Appearance.GroupLayout.Fill.Kind = gfkGradient
      Appearance.GroupLayout.Fill.Color = 15385233
      Appearance.GroupLayout.Fill.ColorTo = 15385233
      Appearance.GroupLayout.Stroke.Color = 15987699
      Appearance.GroupLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.GroupLayout.Font.Color = clBlack
      Appearance.GroupLayout.Font.Height = -11
      Appearance.GroupLayout.Font.Name = 'Segoe UI'
      Appearance.GroupLayout.Font.Style = []
      Appearance.SummaryLayout.Fill.Kind = gfkGradient
      Appearance.SummaryLayout.Fill.Color = 15385233
      Appearance.SummaryLayout.Fill.ColorTo = 15385233
      Appearance.SummaryLayout.Stroke.Color = 15987699
      Appearance.SummaryLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.SummaryLayout.Font.Color = clBlack
      Appearance.SummaryLayout.Font.Height = -11
      Appearance.SummaryLayout.Font.Name = 'Segoe UI'
      Appearance.SummaryLayout.Font.Style = []
      Appearance.SelectedLayout.Fill.Kind = gfkGradient
      Appearance.SelectedLayout.Fill.Color = 15385233
      Appearance.SelectedLayout.Fill.ColorTo = 15385233
      Appearance.SelectedLayout.Stroke.Color = 15987699
      Appearance.SelectedLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.SelectedLayout.Font.Color = clBlack
      Appearance.SelectedLayout.Font.Height = -11
      Appearance.SelectedLayout.Font.Name = 'Segoe UI'
      Appearance.SelectedLayout.Font.Style = []
      Appearance.FocusedLayout.Fill.Kind = gfkGradient
      Appearance.FocusedLayout.Fill.Color = 15385233
      Appearance.FocusedLayout.Fill.ColorTo = 15385233
      Appearance.FocusedLayout.Stroke.Color = 15987699
      Appearance.FocusedLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.FocusedLayout.Font.Color = clBlack
      Appearance.FocusedLayout.Font.Height = -11
      Appearance.FocusedLayout.Font.Name = 'Segoe UI'
      Appearance.FocusedLayout.Font.Style = []
      Appearance.FixedSelectedLayout.Fill.Kind = gfkGradient
      Appearance.FixedSelectedLayout.Fill.Color = 15385233
      Appearance.FixedSelectedLayout.Fill.ColorTo = 15385233
      Appearance.FixedSelectedLayout.Stroke.Color = 15987699
      Appearance.FixedSelectedLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.FixedSelectedLayout.Font.Color = clBlack
      Appearance.FixedSelectedLayout.Font.Height = -11
      Appearance.FixedSelectedLayout.Font.Name = 'Segoe UI'
      Appearance.FixedSelectedLayout.Font.Style = []
      Appearance.BandLayout.Fill.Color = 16711679
      Appearance.BandLayout.Stroke.Color = 15987699
      Appearance.BandLayout.Font.Charset = DEFAULT_CHARSET
      Appearance.BandLayout.Font.Color = 8026746
      Appearance.BandLayout.Font.Height = -11
      Appearance.BandLayout.Font.Name = 'Segoe UI'
      Appearance.BandLayout.Font.Style = []
      Appearance.ProgressLayout.Color = 15385233
      Appearance.ProgressLayout.Format = '%.0f%%'
      LeftCol = 0
      ScrollMode = scmItemScrolling
      GlobalFont.Scale = 1.000000000000000000
      GlobalFont.Style = []
      DesignTimeSampleData = True
      ExplicitWidth = 818
      ExplicitHeight = 302
    end
  end
end
