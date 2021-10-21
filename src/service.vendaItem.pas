unit service.vendaItem;

interface

uses
  System.SysUtils;

type
  IVendaItem = interface
    ['{BEB37C6B-6E50-4493-B516-AB7130281201}']
    function SetProduto(const aValue: string): IVendaItem;
    function SetQuantidade(const aValue: Integer): IVendaItem;
    function SetValor(const aValue: Double): IVendaItem;
    function SetDesconto(const aValue: Double): IVendaItem;
    procedure Executar(const aMetodo: TProc<string>);
  end;


  TVendaItem = class(TInterfacedObject, IVendaItem)
  private
    fProduto: string;
    fQuantidade: Integer;
    fValor: Double;
    fDesconto: Double;
    fDisplay: TProc<string>;
    procedure Validacao;
    function GetDisplay: string;
  public
    class function New: TVendaItem;
    function SetProduto(const aValue: string): IVendaItem;
    function SetQuantidade(const aValue: Integer): IVendaItem;
    function SetValor(const aValue: Double): IVendaItem;
    function SetDesconto(const aValue: Double): IVendaItem;
    procedure Executar(const aMetodo: TProc<string>);
  end;

implementation

function TVendaItem.SetDesconto(const aValue: Double): IVendaItem;
begin
  Result := Self;
  fDesconto := aValue;
end;

procedure TVendaItem.Executar(const aMetodo: TProc<string>);
begin
  Validacao;
  aMetodo(GetDisplay);
end;

function TVendaItem.GetDisplay: string;
var
  Total: Double;
begin
  Total := (fQuantidade * fValor) - fDesconto;
  Result := Copy(fProduto, 0, 22) + StringOfChar(' ', 22 - Length(fProduto)) +
    fQuantidade.ToString + StringOfChar(' ', 8 - Length(fQuantidade.ToString)) +
    FormatFloat(',0.00', fValor) + StringOfChar(' ', 8 - Length(FormatFloat(',0.00', fValor))) +
    FormatFloat(',0.00', fDesconto) + StringOfChar(' ', 9 - Length(FormatFloat(',0.00', fDesconto))) +
    FormatFloat(',0.00', Total) + StringOfChar(' ', 8 - Length(FormatFloat(',0.00', Total)));
end;

class function TVendaItem.New: TVendaItem;
begin
  Result := TVendaItem.Create;
end;

function TVendaItem.SetProduto(const aValue: string): IVendaItem;
begin
  Result := Self;
  fProduto := aValue;
end;

function TVendaItem.SetQuantidade(const aValue: Integer): IVendaItem;
begin
  Result := Self;
  fQuantidade:= aValue;
end;

procedure TVendaItem.Validacao;
begin
  if (fProduto.IsEmpty) then
    raise Exception.Create('Produto tem que ser diferente de vazio.');
  if (fQuantidade <= 0) then
    raise Exception.Create('Quantidade tem que ser maior que zero.');
  if (fValor <= 0) then
    raise Exception.Create('Valor tem que ser maior que zero.');
  if (fDesconto >= (fQuantidade * fValor)) then
    raise Exception.Create('Desconto tem que ser menor que o total.');
end;

function TVendaItem.SetValor(const aValue: Double): IVendaItem;
begin
  Result := Self;
  fValor := aValue;
end;

end.
