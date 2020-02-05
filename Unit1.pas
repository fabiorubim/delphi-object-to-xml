unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvComponentBase, JvgXMLSerializer,
  Vcl.StdCtrls;

type
  TTelefones = class;
  TTelefone = class;

  TFormObjectToXML = class(TForm)
    XMLSerializer: TJvgXMLSerializer;
    ButtonSerialize: TButton;
    MemoSerialize: TMemo;
    ButtonDeSerialize: TButton;
    procedure ButtonSerializeClick(Sender: TObject);
    procedure ButtonDeSerializeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPessoa = class(TPersistent)
  private
    FNome: string;
    FEndereco: string;
    FTelefones: TTelefones;
    procedure SetEndereco(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetTelefones(const Value: TTelefones);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  published
    property Nome: string read FNome write SetNome;
    property Endereco: string read FEndereco write SetEndereco;
    property Telefones: TTelefones read FTelefones write SetTelefones;
  end;

  TTelefone = class(TCollectionItem)
  private
    FDDD: String;
    FNumero: String;
    procedure SetDDD(const Value: String);
    procedure SetNumero(const Value: String);
  published
    property DDD: String read FDDD write SetDDD;
    property Numero: String read FNumero write SetNumero;
  end;

  TTelefones = class(TCollection)
  private
    function GetItem(Index: Integer): TTelefone;
    procedure SetItem(Index: Integer; const Value: TTelefone);
  public
    function Add: TTelefone;
    function Insert(Index: Integer): TTelefone;
    property Items[Index: Integer]: TTelefone read GetItem
      write SetItem; default;
  end;

var
  FormObjectToXML: TFormObjectToXML;
  LPessoa: TPessoa;

implementation

{$R *.dfm}

procedure TFormObjectToXML.ButtonDeSerializeClick(Sender: TObject);
var
  LPessoaDes: TPessoa;
  LStringStream: TStringStream;
begin
  // LPessoa.Telefones.Clear;
  LPessoaDes := TPessoa.Create(Self);
  LStringStream := TStringStream.Create;
  try
    MemoSerialize.Lines.SaveToStream(LStringStream);
    // LStringStream.Position := 0;
    XMLSerializer.DeSerialize(LPessoaDes, LStringStream);
  finally
    LStringStream.Free;
    LPessoaDes.Free;
  end;
end;

procedure TFormObjectToXML.ButtonSerializeClick(Sender: TObject);
var
  LStringStream: TStringStream;
  I: Integer;
begin
  LStringStream := TStringStream.Create;
  try
    LPessoa.Nome := 'Fabio Biasi Mello Rubim';
    LPessoa.Endereco := 'Rua Giovani Fabri, 126';

    for I := 0 to 5 do
    begin
      with LPessoa.Telefones.Add do
      begin
        DDD := '01' + I.ToString;
        Numero := '3228-001' + I.ToString;
      end;
    end;

    XMLSerializer.Serialize(LPessoa, LStringStream);
    MemoSerialize.Lines.Clear;
    MemoSerialize.Lines.Add(LStringStream.DataString);

  finally
    LStringStream.Free;
  end;
end;

procedure TFormObjectToXML.FormCreate(Sender: TObject);
begin
  LPessoa := TPessoa.Create(Self);
end;

procedure TFormObjectToXML.FormDestroy(Sender: TObject);
begin
  LPessoa.Free;
end;

{ TPessoa }

constructor TPessoa.Create(AOwner: TComponent);
begin
  Telefones := TTelefones.Create(TTelefone);
end;

destructor TPessoa.Destroy;
begin
  inherited;
  Telefones.Free;
end;

procedure TPessoa.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TPessoa.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessoa.SetTelefones(const Value: TTelefones);
begin
  FTelefones := Value;
end;

{ TTelefone }

procedure TTelefone.SetDDD(const Value: String);
begin
  FDDD := Value;
end;

procedure TTelefone.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

{ TTelefones }

function TTelefones.Add: TTelefone;
begin
  Result := TTelefone(inherited Add);
end;

function TTelefones.GetItem(Index: Integer): TTelefone;
begin
  Result := TTelefone(inherited Items[Index]);
end;

function TTelefones.Insert(Index: Integer): TTelefone;
begin
  Result := TTelefone(inherited Insert(Index));
end;

procedure TTelefones.SetItem(Index: Integer; const Value: TTelefone);
begin
  Items[Index].Assign(Value);
end;

end.
