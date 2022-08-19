unit UDMPrincipal;

interface

uses
  SysUtils, Classes, FMTBcd, WideStrings, DBXMySql, DB, SqlExpr, DBClient, Provider;

type
  TDMPrincipal = class(TDataModule)
    Conexao: TSQLConnection;
    TblCliente: TSQLDataSet;
    TblClientecodigo: TIntegerField;
    TblClientenome: TStringField;
    TblClientecidade: TStringField;
    TblClienteUF: TStringField;
    DspCliente: TDataSetProvider;
    CdsCliente: TClientDataSet;
    CdsClientecodigo: TIntegerField;
    CdsClientenome: TStringField;
    CdsClientecidade: TStringField;
    CdsClienteUF: TStringField;
    DSCliente: TDataSource;
    TblProduto: TSQLDataSet;
    DSPProduto: TDataSetProvider;
    CdsProduto: TClientDataSet;
    DSProduto: TDataSource;
    TblPedido: TSQLDataSet;
    DSPPedido: TDataSetProvider;
    CDSPedido: TClientDataSet;
    DSPedido: TDataSource;
    TblPedidoProdutos: TSQLDataSet;
    DSPPedidoProduto: TDataSetProvider;
    CDSPedidoProduto: TClientDataSet;
    DSPedidoProduto: TDataSource;
    TblProdutocodigo: TIntegerField;
    TblProdutoDescricao: TStringField;
    TblProdutopreco: TSingleField;
    TblPedidonumero_pedido: TIntegerField;
    TblPedidodata_emissao: TSQLTimeStampField;
    TblPedidocodigo_cliente: TIntegerField;
    TblPedidovalor_total: TSingleField;
    QryNumeroPedido: TSQLQuery;
    QryNumeroPedidoProximo: TLargeintField;
    qryRetornaProduto: TSQLQuery;
    qryRetornaProdutocodigo: TIntegerField;
    qryRetornaProdutoDescricao: TStringField;
    qryRetornaProdutopreco: TSingleField;
    CdsProdutocodigo: TIntegerField;
    CdsProdutoDescricao: TStringField;
    CdsProdutopreco: TSingleField;
    CDSPedidonumero_pedido: TIntegerField;
    CDSPedidodata_emissao: TSQLTimeStampField;
    CDSPedidocodigo_cliente: TIntegerField;
    CDSPedidovalor_total: TSingleField;
    CDSPedidoCliente: TStringField;
    QryRetornaIncrem: TSQLQuery;
    TblPedidoProdutosautoincrem: TIntegerField;
    TblPedidoProdutosnumero_pedido: TIntegerField;
    TblPedidoProdutoscodigo_produto: TIntegerField;
    TblPedidoProdutosquantidade: TIntegerField;
    TblPedidoProdutosvalor_unit: TSingleField;
    TblPedidoProdutosvalor_total: TSingleField;
    CDSPedidoProdutoautoincrem: TIntegerField;
    CDSPedidoProdutonumero_pedido: TIntegerField;
    CDSPedidoProdutocodigo_produto: TIntegerField;
    CDSPedidoProdutoquantidade: TIntegerField;
    CDSPedidoProdutovalor_unit: TSingleField;
    CDSPedidoProdutovalor_total: TSingleField;
    CDSPedidoProdutoProduto: TStringField;
    QryRetornaIncremProximo: TLargeintField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{$R *.dfm}

end.
