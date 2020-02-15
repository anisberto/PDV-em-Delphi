unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TFrmUsuarios = class(TForm)
    Label2: TLabel;
    EdtNome: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    EdtBuscarNome: TEdit;
    Label1: TLabel;
    btnBuscarFunc: TSpeedButton;
    Label3: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Label4: TLabel;
    procedure btnBuscarFuncClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnExcluirClick(Sender: TObject);
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;
    procedure buscarNome;
  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  usuarioAntigo: string;

implementation

{$R *.dfm}

uses Modulo, Funcionarios;

procedure TFrmUsuarios.associarCampos;
begin
  dm.tb_usuarios.FieldByName('nome').Value := EdtNome.Text;
  dm.tb_usuarios.FieldByName('usuario').Value := edtUsuario.Text;
  dm.tb_usuarios.FieldByName('senha').Value := edtSenha.Text;
  dm.tb_usuarios.FieldByName('cargo').Value := cargoFunc;
  dm.tb_usuarios.FieldByName('id_funcionario').Value := idFunc;
end;

procedure TFrmUsuarios.btnBuscarFuncClick(Sender: TObject);
begin
  chamada := 'Func';
  FrmFuncionarios := TFrmFuncionarios.Create(self);
  FrmFuncionarios.Show;
end;

procedure TFrmUsuarios.BtnEditarClick(Sender: TObject);
var
  usuario: string;
begin

  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  if Trim(edtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usuario!', mtInformation, mbOKCancel, 0);
    edtUsuario.SetFocus;
    exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
    edtSenha.SetFocus;
    exit;
  end;

  if usuarioAntigo <> edtUsuario.Text then
  begin
    // VERIFICAR SE O usuário JÁ ESTÁ CADASTRADO
    dm.query_usuarios.Close;
    dm.query_usuarios.SQL.Clear;
    dm.query_usuarios.SQL.Add('SELECT * from usuarios where usuario = ' +
      QuotedStr(Trim(edtUsuario.Text)));
    dm.query_usuarios.Open;

    if not dm.query_usuarios.isEmpty then
    begin
      usuario := dm.query_usuarios['usuario'];
      MessageDlg('O Usuário ' + usuario + ' já está cadastrado!', mtInformation,
        mbOKCancel, 0);
      edtUsuario.Text := '';
      edtUsuario.SetFocus;
      exit;
    end;

  end;

  // associarCampos;
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add
    ('UPDATE usuarios set nome = :nome, usuario = :usuario, senha = :senha where id = :id');
  dm.query_usuarios.ParamByName('nome').Value := EdtNome.Text;
  dm.query_usuarios.ParamByName('usuario').Value := edtUsuario.Text;
  dm.query_usuarios.ParamByName('senha').Value := edtSenha.Text;

  dm.query_usuarios.ParamByName('id').Value := id;
  dm.query_usuarios.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
  BtnEditar.Enabled := false;
  BtnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmUsuarios.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    dm.tb_usuarios.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    listar;

    BtnEditar.Enabled := false;
    BtnExcluir.Enabled := false;
    EdtNome.Text := '';

  end;
end;

procedure TFrmUsuarios.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tb_usuarios.Insert;
  btnSalvar.Enabled := true;
  edtNome.Enabled := true;
end;

procedure TFrmUsuarios.btnSalvarClick(Sender: TObject);
var
  usuario: string;
begin

  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  if Trim(edtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usuario!', mtInformation, mbOKCancel, 0);
    edtUsuario.SetFocus;
    exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
    edtSenha.SetFocus;
    exit;
  end;

  // VERIFICAR SE O usuário JÁ ESTÁ CADASTRADO
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('SELECT * from usuarios where usuario = ' +
    QuotedStr(Trim(edtUsuario.Text)));
  dm.query_usuarios.Open;

  if not dm.query_usuarios.isEmpty then
  begin
    usuario := dm.query_usuarios['usuario'];
    MessageDlg('O Usuário ' + usuario + ' já está cadastrado!', mtInformation,
      mbOKCancel, 0);
    edtUsuario.Text := '';
    edtUsuario.SetFocus;
    exit;
  end;

  associarCampos;
  dm.tb_usuarios.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmUsuarios.buscarNome;
begin
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add
    ('SELECT * from usuarios where nome LIKE :nome and cargo <> :cargo order by nome asc');
  dm.query_usuarios.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  dm.query_usuarios.ParamByName('cargo').Value := 'admin';
  dm.query_usuarios.Open;
end;

procedure TFrmUsuarios.DBGrid1CellClick(Column: TColumn);
begin

  habilitarCampos;
  BtnEditar.Enabled := true;
  BtnExcluir.Enabled := true;

  dm.tb_usuarios.Edit;

  EdtNome.Text := dm.query_usuarios.FieldByName('nome').Value;

  edtUsuario.Text := dm.query_usuarios.FieldByName('usuario').Value;
  edtSenha.Text := dm.query_usuarios.FieldByName('senha').Value;

  id := dm.query_usuarios.FieldByName('id').Value;

  usuarioAntigo := dm.query_usuarios.FieldByName('usuario').Value;

end;

procedure TFrmUsuarios.desabilitarCampos;
begin
  EdtNome.Enabled := false;
  edtUsuario.Enabled := false;
  edtSenha.Enabled := false;
  btnBuscarFunc.Enabled := false;
end;

procedure TFrmUsuarios.EdtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
  EdtNome.Text := nomeFunc;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_usuarios.Active := true;
  listar;
end;

procedure TFrmUsuarios.habilitarCampos;
begin

  edtUsuario.Enabled := true;
  edtSenha.Enabled := true;
  btnBuscarFunc.Enabled := true;
end;

procedure TFrmUsuarios.limpar;
begin
  EdtNome.Text := '';
  edtUsuario.Text := '';
  edtSenha.Text := '';
end;

procedure TFrmUsuarios.listar;
begin
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add
    ('SELECT * from usuarios where cargo <> :cargo order by nome asc');
  dm.query_usuarios.ParamByName('cargo').Value := 'admin';
  dm.query_usuarios.Open;
end;

end.
