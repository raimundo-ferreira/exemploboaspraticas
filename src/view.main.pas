unit view.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    edtProduto: TLabeledEdit;
    edtQtde: TLabeledEdit;
    edtValor: TLabeledEdit;
    edtDesconto: TLabeledEdit;
    memImpressao: TMemo;
    btnIncluir: TButton;
    edtTotal: TLabeledEdit;
    procedure btnIncluirClick(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
  private
    procedure PreencheDisplay(aValue: string);
    procedure PreencheCabecalho;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses service.vendaitem;

procedure TfrmMain.btnIncluirClick(Sender: TObject);
var
  Item: TVendaItem;
begin
  try
    Item.New
      .SetProduto(edtProduto.Text)
      .SetQuantidade(StrToIntDef(edtQtde.Text,0))
      .SetValor(StrToFloatDef(edtValor.Text, 0))
      .SetDesconto(StrToFloatDef(edtDesconto.Text, 0))
      .Executar(PreencheDisplay);
  except on E: Exception do
    MessageDlg(E.Message, mtWarning, [mbOk], 0);
  end;
end;

procedure TfrmMain.edtValorChange(Sender: TObject);
var
  Total: Double;
begin
  Total := (StrToIntDef(edtQtde.Text,0) * StrToFloatDef(edtValor.Text, 0)) - StrToFloatDef(edtDesconto.Text, 0);
  edtTotal.Text := FormatFloat('R$ ,0.00', Total);
end;

procedure TfrmMain.PreencheCabecalho;
begin
  memImpressao.Lines.Add('                     VENDA 0001                     ');
  memImpressao.Lines.Add('                    FORTES TECNOLOGIA               ');
  memImpressao.Lines.Add('----------------------------------------------------');
  memImpressao.Lines.Add('ITEM                  QTD     VLR     DESC     TOTAL');
end;

procedure TfrmMain.PreencheDisplay(aValue: string);
begin
  if (memImpressao.Lines.Count = 0) then
    PreencheCabecalho;
  memImpressao.Lines.Add(aValue);
end;

end.
