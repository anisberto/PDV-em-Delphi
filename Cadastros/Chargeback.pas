unit Chargeback;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFrmChargeback = class(TForm)
    dbGrid: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNome: TEdit;
    edtEmail: TEdit;
    edtPedido: TEdit;
    edtEmpresa: TEdit;
    btnNovo: TSpeedButton;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnSalvar: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure limpar;
    procedure listar;
    procedure desabilitarCampos;
    procedure habilitarCampos;
    procedure carregarCombobox;
  public
    { Public declarations }
  end;

var
  FrmChargeback: TFrmChargeback;
  pedidoAntigo: string;

implementation

{$R *.dfm}

uses Modulo;

procedure TFrmChargeback.associarCampos;
begin
  dm.query_chargeback.FieldByName('nome').AsString := edtNome.Text;
  dm.query_chargeback.FieldByName('pedido').AsString := edtPedido.Text;
  dm.query_chargeback.FieldByName('email').AsString := edtEmail.Text;
  dm.query_chargeback.FieldByName('empresa').AsString := edtNome.Text;
end;

procedure TFrmChargeback.desabilitarCampos;
begin

end;

procedure TFrmChargeback.FormClick(Sender: TObject);
begin
  listar;
end;

procedure TFrmChargeback.FormCreate(Sender: TObject);
begin
  dm.tb_chargeback.Active := true;
  listar;
end;

procedure TFrmChargeback.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_chargeback.Active := true;
  listar;
  carregarCombobox;
end;

procedure TFrmChargeback.habilitarCampos;
begin
  btnNovo.Enabled := true;
  btnSalvar.Enabled := true;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;
end;

procedure TFrmChargeback.limpar;
begin
  edtNome.Text := '';
  edtPedido.Text := '';
  edtEmpresa.Text := '';
  edtEmail.Text := '';
end;

procedure TFrmChargeback.listar;
begin
  dm.query_chargeback.Close;
  dm.query_chargeback.SQL.Clear;
  dm.query_chargeback.SQL.Add('SELECT * from chargeback ');
  dm.query_chargeback.Open;
end;

procedure TFrmChargeback.btnEditarClick(Sender: TObject);
var
  pedido: string;
  id: string;
begin

  if Trim(edtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    edtNome.SetFocus;
    exit;
  end;

  if Trim(edtPedido.Text) = '' then
  begin
    MessageDlg('Preencha o Pedido!', mtInformation, mbOKCancel, 0);
    edtPedido.SetFocus;
    exit;
  end;

  if pedidoAntigo <> edtPedido.Text then
  begin
    // VERIFICAR SE O pedido JÁ ESTÁ CADASTRADO
    dm.query_chargeback.Close;
    dm.query_chargeback.SQL.Clear;
    dm.query_chargeback.SQL.Add('SELECT * from funcionarios where cpf = ' +
      QuotedStr(Trim(edtPedido.Text)));
    dm.query_chargeback.Open;

    if not dm.query_chargeback.isEmpty then
    begin
      pedido := dm.query_chargeback['pedido'];
      MessageDlg('O CPF ' + pedido + ' já está cadastrado!', mtInformation,
        mbOKCancel, 0);
      edtPedido.Text := '';
      edtPedido.SetFocus;
      exit;
    end;

  end;

  associarCampos;
  dm.query_chargeback.Close;
  dm.query_chargeback.SQL.Clear;
  dm.query_chargeback.SQL.Add
    ('UPDATE funcionarios set nome = :nome, pedido = :pedido, email = :email where id = :id');
  dm.query_chargeback.ParamByName('nome').Value := edtNome.Text;
  dm.query_chargeback.ParamByName('pedido').Value := edtPedido.Text;
  dm.query_chargeback.ParamByName('endereco').Value := edtEmail.Text;
  dm.query_chargeback.ParamByName('telefone').Value := edtEmpresa.Text;
  dm.query_chargeback.ParamByName('id').Value := id;
  dm.query_chargeback.ExecSQL;

  dm.query_chargeback.Close;
  dm.query_chargeback.SQL.Clear;
  dm.query_chargeback.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
  btnEditar.Enabled := false;
  btnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmChargeback.btnNovoClick(Sender: TObject);
begin
  dm.query_chargeback.Insert;
  desabilitarCampos;
  btnSalvar.Enabled := true;
  edtNome.SetFocus;
  listar;
  limpar;
end;

procedure TFrmChargeback.btnSalvarClick(Sender: TObject);
var
  pedido: string;
begin
  // dm.query_chargeback.Insert;
  // dm.tb_chargeback.Insert;
  if Trim(edtPedido.Text) = '' then
  begin
    MessageDlg('Preencha o Pedido!', mtInformation, mbOKCancel, 0);
    edtPedido.SetFocus;
    exit;
  end;
  dm.query_chargeback.Insert;
  dm.query_chargeback.Open;

  associarCampos;
  dm.query_chargeback.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  habilitarCampos;
  btnSalvar.Enabled := true;
  listar;

end;

procedure TFrmChargeback.carregarCombobox;
begin

end;

end.
