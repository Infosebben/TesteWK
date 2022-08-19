unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DBXMySql, FMTBcd, ExtCtrls, DB, SqlExpr, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, DBCtrls, Mask;

type
  TFormPrincipal = class(TForm)
    PnlTitulo: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    PageControlPedido: TPageControl;
    TbsConsulta: TTabSheet;
    TbsCadastro: TTabSheet;
    EdtConsulta: TEdit;
    DBGrdConsultaPedido: TDBGrid;
    BtnIncluirPedido: TBitBtn;
    Panel1: TPanel;
    PnlProdutosPedido: TPanel;
    Panel4: TPanel;
    PnlDadosPedido: TPanel;
    Panel6: TPanel;
    DBLkpCBxCliente: TDBLookupComboBox;
    DBEdtCodigoProduto: TDBEdit;
    lblcodigo_produto: TLabel;
    DBEdtQuantidade: TDBEdit;
    Label1: TLabel;
    DBText1: TDBText;
    DBEdtValorUnitario: TDBEdit;
    Label2: TLabel;
    BtnAdicionarProduto: TBitBtn;
    DBGrdProdutos: TDBGrid;
    Label3: TLabel;
    DBText2: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    DBText3: TDBText;
    BtnAdicionaPedido: TBitBtn;
    BtnSalvarPedido: TBitBtn;
    BtnVoltar: TBitBtn;
    Label6: TLabel;
    LblTotalPedido: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BtnIncluirPedidoClick(Sender: TObject);
    procedure BtnAdicionarProdutoClick(Sender: TObject);
    procedure BtnAdicionaPedidoClick(Sender: TObject);
    procedure BtnSalvarPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBEdtCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrdConsultaPedidoDblClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure EdtConsultaChange(Sender: TObject);
    procedure DBGrdProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function retornaIncrem:integer;
    function retornaNumeroPedido:integer;
    procedure atualizaTotalPedido;
    procedure acionaCadastro;
    function validaCamposPedido:Boolean;
    function validaCamposProduto:Boolean;
    procedure DBGrdConsultaPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    TotalPedido:double;
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses UDMPrincipal;

{$R *.dfm}

procedure TFormPrincipal.acionaCadastro;
begin

  PnlDadosPedido.Enabled    := True;
  PnlProdutosPedido.Visible := False;
  PnlProdutosPedido.Enabled := Enabled;
  BtnSalvarPedido.Visible   := true;
  BtnVoltar.Visible         := false;

end;

procedure TFormPrincipal.atualizaTotalPedido;
begin

  with DMPrincipal do
  Begin
    CDSPedidoProduto.DisableControls;
    CDSPedidoProduto.First;
    TotalPedido :=0;
    while not CDSPedidoProduto.Eof do
    Begin
      TotalPedido := TotalPedido + CDSPedidoProdutovalor_total.AsFloat;
      CDSPedidoProduto.Next;
    End;
    CDSPedidoProduto.EnableControls;
    LblTotalPedido.Caption := 'R$ ' + FormatFloat('#,##0.00',TotalPedido);
  End;

end;

procedure TFormPrincipal.BitBtn1Click(Sender: TObject);
begin

  Close;

end;

procedure TFormPrincipal.BtnAdicionarProdutoClick(Sender: TObject);
begin

  if validaCamposProduto then
  Begin
    with DMPrincipal do
    Begin
      if CDSPedidoProduto.State = dsedit then
      Begin
        CDSPedidoProdutovalor_total.Value := (CDSPedidoProdutoquantidade.Value * CDSPedidoProdutovalor_unit.Value);
        CDSPedidoProduto.Post;
        CDSPedidoProduto.ApplyUpdates(0);      
        atualizaTotalPedido;
      End
      else if CDSPedidoProduto.State = dsinsert then
      Begin
        CDSPedidoProdutoautoincrem.Value := retornaIncrem;
        CDSPedidoProdutonumero_pedido.Value := CDSPedidonumero_pedido.Value;
        CDSPedidoProdutovalor_total.Value := (CDSPedidoProdutoquantidade.Value * CDSPedidoProdutovalor_unit.Value);
        CDSPedidoProduto.Post;
        CDSPedidoProduto.ApplyUpdates(0);

        atualizaTotalPedido;
      
        CDSPedidoProduto.Append;
        DBEdtCodigoProduto.SetFocus;
      End;
    End;
  End;

end;

procedure TFormPrincipal.BtnVoltarClick(Sender: TObject);
begin

  BtnVoltar.Visible := false;
  TbsConsulta.Show;


end;

procedure TFormPrincipal.BtnSalvarPedidoClick(Sender: TObject);
begin

  with DMPrincipal do
  Begin
    CDSPedidoProduto.Cancel;
    CDSPedido.Edit;
    CDSPedidovalor_total.Value := TotalPedido;
    CDSPedido.Post;
    CDSPedido.ApplyUpdates(0);        
  End;
  
  TbsConsulta.Show;
  BtnSalvarPedido.Enabled := True;
  PnlProdutosPedido.Visible := false;

end;

procedure TFormPrincipal.BtnAdicionaPedidoClick(Sender: TObject);
begin

  if validaCamposPedido then
  Begin
    DMPrincipal.CDSPedido.Post;
    DMPrincipal.CDSPedido.ApplyUpdates(0);
    PnlProdutosPedido.Show;
    DBEdtCodigoProduto.SetFocus;
    BtnAdicionaPedido.Enabled := false;
  End;

end;

procedure TFormPrincipal.BtnIncluirPedidoClick(Sender: TObject);
begin

  with DMPrincipal do
  Begin
    CDSPedido.Append;
    CDSPedidonumero_pedido.AsInteger := retornaNumeroPedido;
    CDSPedidodata_emissao.AsDateTime := Now;
    BtnAdicionaPedido.Enabled := True;
    TbsCadastro.Show;
    acionaCadastro;
  End;

end;

procedure TFormPrincipal.DBEdtCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
begin

  if((key =#13) or (key = #9))then
  Begin
    DMPrincipal.qryRetornaProduto.Close;
    DMPrincipal.qryRetornaProduto.ParamByName('pcodigo').AsString := DBEdtCodigoProduto.Text;
    DMPrincipal.qryRetornaProduto.open;

    if DMPrincipal.qryRetornaProduto.IsEmpty then
    Begin
      ShowMessage('Produto n�o encontrado!');
      DBEdtCodigoProduto.SetFocus;
    End
    else
    Begin
      DMPrincipal.CDSPedidoProdutovalor_unit.Value := DMPrincipal.qryRetornaProdutopreco.Value;
      DBEdtQuantidade.SetFocus;
    End;
  End;

end;

procedure TFormPrincipal.DBEdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin

  if((key =#13) or (key = #9))then
  Begin
    DBEdtValorUnitario.SetFocus;
    BtnAdicionarProdutoClick(nil);
  End;

end;

procedure TFormPrincipal.DBGrdConsultaPedidoDblClick(Sender: TObject);
begin

  TbsCadastro.Show;
  PnlDadosPedido.Enabled := false;
  PnlProdutosPedido.Visible := true;
  PnlProdutosPedido.Enabled := false;
  BtnVoltar.Visible := true;
  BtnSalvarPedido.Visible := false;
  BtnVoltar.Visible        := True;
  atualizaTotalPedido;

end;

procedure TFormPrincipal.DBGrdConsultaPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if key = VK_DELETE then
  Begin
    if application.MessageBox('Deseja excluir esse pedido?','Excluir',mb_YesNo+mb_IconInformation+mb_DefButton2) = idYes then
      DMPrincipal.CDSPedido.Delete;
      DMPrincipal.CDSPedido.ApplyUpdates(0);
  End;

end;

procedure TFormPrincipal.DBGrdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if key = VK_DELETE then
  Begin
    if application.MessageBox('Deseja excluir esse produto?','Excluir',mb_YesNo+mb_IconInformation+mb_DefButton2) = idYes then
    Begin
      DMPrincipal.CDSPedidoProduto.Delete;
      DMPrincipal.CDSPedidoProduto.ApplyUpdates(0);
      atualizaTotalPedido;
    End;
  End;

end;

procedure TFormPrincipal.DBGrdProdutosKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then
  Begin
    DMPrincipal.CDSPedidoProduto.Edit;
    DBEdtQuantidade.SetFocus;
  End;

end;

procedure TFormPrincipal.EdtConsultaChange(Sender: TObject);
begin

  with DMPrincipal do
  Begin
    if EdtConsulta.Text = '' then
      CDSPedido.Filtered := False
    Else
    Begin
      CDSPedido.Filtered := False;
      CDSPedido.Filter   := 'numero_pedido = ' + EdtConsulta.Text;
      CDSPedido.Filtered := True;
    End;
  End;

end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin

  with DMPrincipal do
  Begin
    Conexao.Open;
    CdsCliente.Open;
    CdsProduto.Open;
    CDSPedido.Open;
    CDSPedidoProduto.Open;
  End;

end;

function TFormPrincipal.retornaIncrem: integer;
begin

  with DMPrincipal do
  Begin
    qryRetornaIncrem.Close;
    qryRetornaIncrem.Open;
    result := QryRetornaIncremProximo.AsInteger;
  End;

end;

function TFormPrincipal.retornaNumeroPedido: integer;
begin

  with DMPrincipal do
  Begin
    QryNumeroPedido.close;
    QryNumeroPedido.Open; 

    Result:= QryNumeroPedidoProximo.AsInteger;
  End;

end;

function TFormPrincipal.validaCamposPedido: Boolean;
begin

  if DBLkpCBxCliente.Text='' then
  Begin
    ShowMessage('Precisa selecionar o cliente do pedido');
    DBLkpCBxCliente.SetFocus;    
    Result := False;
  End
  else
    Result := True;

end;

function TFormPrincipal.validaCamposProduto: Boolean;
begin

  if DBEdtCodigoProduto.Text='' then
  Begin
    ShowMessage('Precisa informar o c�digo do produto!');
    DBEdtCodigoProduto.SetFocus;    
    Result := False;
  End
  else if DBEdtQuantidade.Text='' then
       Begin
        ShowMessage('Precisainformar a quantidade do produto!');
        DBEdtQuantidade.SetFocus;    
        Result := False;      
       End
       else if DBEdtValorUnitario.Text='' then
            Begin
              ShowMessage('Precisa informar o valor unit�rio do produto!');
              DBEdtValorUnitario.SetFocus;    
              Result := False;            
            End
            else
              Result := True;
end;

end.
