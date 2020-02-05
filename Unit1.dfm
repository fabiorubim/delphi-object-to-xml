object FormObjectToXML: TFormObjectToXML
  Left = 0
  Top = 0
  ClientHeight = 451
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonSerialize: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Serialize'
    TabOrder = 0
    OnClick = ButtonSerializeClick
  end
  object MemoSerialize: TMemo
    Left = 8
    Top = 56
    Width = 441
    Height = 281
    TabOrder = 1
  end
  object ButtonDeSerialize: TButton
    Left = 104
    Top = 8
    Width = 75
    Height = 25
    Caption = 'DeSerialize'
    TabOrder = 2
    OnClick = ButtonDeSerializeClick
  end
  object XMLSerializer: TJvgXMLSerializer
    ExcludeEmptyValues = False
    ExcludeDefaultValues = False
    ReplaceReservedSymbols = False
    IgnoreUnknownTags = False
    Left = 112
    Top = 24
  end
end
