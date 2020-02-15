  unit Funcionarios;

  interface

  uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
    Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask;

  type
    TFrmFuncionarios = class(TForm)
      rbNome: TRadioButton;
      rbCPF: TRadioButton;
      EdtBuscarCPF: TMaskEdit;
      Label1: TLabel;
      Label2: TLabel;
      EdtNome: TEdit;
      Label3: TLabel;
      EdtCPF: TMaskEdit;
      Label4: TLabel;
      EdtTel: TMaskEdit;
      Label5: TLabel;
      EdtEndereco: TEdit;
      Label6: TLabel;
      cbCargo: TComboBox;
      DBGrid1: TDBGrid;
      btnNovo: TSpeedButton;
      btnSalvar: TSpeedButton;
      BtnEditar: TSpeedButton;
      BtnExcluir: TSpeedButton;
    SpeedButton1: TSpeedButton;
    edtBuscaNome: TEdit;
      procedure FormShow(Sender: TObject);
      procedure btnNovoClick(Sender: TObject);
      procedure btnSalvarClick(Sender: TObject);
      procedure DBGrid1CellClick(Column: TColumn);
      procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure EdtBuscarCPFChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCPFClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtBuscaNomeChange(Sender: TObject);
    private
      { Private declarations }

      procedure limpar;
      procedure habilitarCampos;
      procedure desabilitarCampos;

      procedure associarCampos;
      procedure listar;

      procedure carregarCombobox;
      procedure buscarNome;
      procedure buscarCpf;



    public
      { Public declarations }
    end;

  var
    FrmFuncionarios: TFrmFuncionarios;
    id : string;
    cpfAntigo: string;
  implementation

  {$R *.dfm}

  uses Modulo;

  { TFrmFuncionarios }

  procedure TFrmFuncionarios.associarCampos;
  begin
   dm.tb_func.FieldByName('nome').Value := edtNome.Text;
   dm.tb_func.FieldByName('cpf').Value := edtCpf.Text;
   dm.tb_func.FieldByName('telefone').Value := edtTel.Text;
   dm.tb_func.FieldByName('endereco').Value := EdtEndereco.Text;
   dm.tb_func.FieldByName('cargo').Value := cbCargo.Text;
   dm.tb_func.FieldByName('data').Value := DateToStr(Date);
  end;

  procedure TFrmFuncionarios.BtnEditarClick(Sender: TObject);
  var
  cpf : string;
  begin

      if Trim(EdtNome.Text) = '' then
       begin
           MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
           EdtNome.SetFocus;
           exit;
       end;

        if Trim(EdtCpf.Text) = '' then
       begin
           MessageDlg('Preencha o CPF!', mtInformation, mbOKCancel, 0);
           EdtCpf.SetFocus;
           exit;
       end;


       if cpfAntigo <> edtCpf.Text then
           begin
            //VERIFICAR SE O cpf JÁ ESTÁ CADASTRADO
           dm.query_func.Close;
           dm.query_func.SQL.Clear;
           dm.query_func.SQL.Add('SELECT * from funcionarios where cpf = ' + QuotedStr(Trim(edtCpf.Text)));
           dm.query_func.Open;

           if not dm.query_func.isEmpty then
           begin
             cpf :=  dm.query_func['cpf'];
             MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
             edtCpf.Text := '';
             edtCpf.SetFocus;
             exit;
           end;

       end;

       associarCampos;
       dm.query_func.Close;
       dm.query_func.SQL.Clear;
       dm.query_func.SQL.Add('UPDATE funcionarios set nome = :nome, cpf = :cpf, endereco = :endereco, telefone = :telefone, cargo = :cargo where id = :id');
       dm.query_func.ParamByName('nome').Value := edtNome.Text;
       dm.query_func.ParamByName('cpf').Value := edtCpf.Text;
       dm.query_func.ParamByName('endereco').Value := EdtEndereco.Text;
       dm.query_func.ParamByName('telefone').Value := edtTel.Text;
       dm.query_func.ParamByName('cargo').Value := cbCargo.Text;
       dm.query_func.ParamByName('id').Value := id;
       dm.query_func.ExecSQL;



       //EDITAR O CARGO DO USUÁRIO
       dm.query_usuarios.Close;
       dm.query_usuarios.SQL.Clear;
       dm.query_usuarios.SQL.Add('UPDATE usuarios set cargo = :cargo where id_funcionario = :id');
       dm.query_usuarios.ParamByName('cargo').Value := cbCargo.Text;
       dm.query_usuarios.ParamByName('id').Value := id;
       dm.query_usuarios.ExecSQL;


       listar;
       MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
       btnEditar.Enabled := false;
       BtnExcluir.Enabled := false;
       limpar;
       desabilitarCampos;





  end;

  procedure TFrmFuncionarios.BtnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_func.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    btnEditar.Enabled := false;
    BtnExcluir.Enabled := false;
    edtNome.Text := '';
  end;


//DELETAR TAMBÉM O USUÁRIO ASSOCIADO A ELE

  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('DELETE from usuarios where id_funcionario = :id');
  dm.query_usuarios.ParamByName('id').Value := id;
  dm.query_usuarios.Execute;
  listar;
end;

procedure TFrmFuncionarios.btnNovoClick(Sender: TObject);
  begin
  habilitarCampos;
  dm.tb_func.Insert;
  btnSalvar.Enabled := true;
  end;

  procedure TFrmFuncionarios.btnSalvarClick(Sender: TObject);
  var
  cpf : string;
  begin

      if Trim(EdtNome.Text) = '' then
       begin
           MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
           EdtNome.SetFocus;
           exit;
       end;

        if Trim(EdtCpf.Text) = '' then
       begin
           MessageDlg('Preencha o CPF!', mtInformation, mbOKCancel, 0);
           EdtCpf.SetFocus;
           exit;
       end;

       //VERIFICAR SE O cpf JÁ ESTÁ CADASTRADO
       dm.query_func.Close;
       dm.query_func.SQL.Clear;
       dm.query_func.SQL.Add('SELECT * from funcionarios where cpf = ' + QuotedStr(Trim(edtCpf.Text)));
       dm.query_func.Open;

       if not dm.query_func.isEmpty then
       begin
         cpf :=  dm.query_func['cpf'];
         MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
         edtCpf.Text := '';
         edtCpf.SetFocus;
         exit;
       end;



  associarCampos;
  dm.tb_func.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

  end;

  procedure TFrmFuncionarios.buscarCpf;
  begin
       dm.query_func.Close;
       dm.query_func.SQL.Clear;
       dm.query_func.SQL.Add('SELECT * from funcionarios where cpf = :cpf order by nome asc');
       dm.query_func.ParamByName('cpf').Value := EdtBuscarCpf.Text;
       dm.query_func.Open;
  end;

  procedure TFrmFuncionarios.buscarNome;
  begin
       dm.query_func.Close;
       dm.query_func.SQL.Clear;
       dm.query_func.SQL.Add('SELECT * from funcionarios where nome LIKE :nome order by nome asc');
       dm.query_func.ParamByName('nome').Value := EdtBuscaNome.Text + '%';
       dm.query_func.Open;
  end;

  procedure TFrmFuncionarios.carregarCombobox;
  begin

      dm.query_cargos.Close;
      dm.query_cargos.Open;

  if not dm.query_cargos.isEmpty then
  begin
    while not dm.query_cargos.Eof do
    begin
      cbCargo.Items.Add(dm.query_cargos.FieldByName('cargo').AsString);
      dm.query_cargos.Next;
    end;

  end;

  end;

  procedure TFrmFuncionarios.DBGrid1CellClick(Column: TColumn);
  begin
  habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  dm.tb_func.Edit;

  if dm.query_func.FieldByName('nome').Value <> null then
  edtNome.Text := dm.query_func.FieldByName('nome').Value;

  edtCpf.Text := dm.query_func.FieldByName('cpf').Value;

  cbCargo.Text := dm.query_func.FieldByName('cargo').Value;

  if dm.query_func.FieldByName('telefone').Value <> null then
  edtTel.Text := dm.query_func.FieldByName('telefone').Value;

  if dm.query_func.FieldByName('endereco').Value <> null then
  EdtEndereco.Text := dm.query_func.FieldByName('endereco').Value;

  id := dm.query_func.FieldByName('id').Value;

  cpfAntigo := dm.query_func.FieldByName('cpf').Value;

  end;

  procedure TFrmFuncionarios.DBGrid1DblClick(Sender: TObject);
begin
if chamada = 'Func' then
begin
  idFunc := dm.query_func.FieldByName('id').Value;
  nomeFunc := dm.query_func.FieldByName('nome').Value;
  cargoFunc := dm.query_func.FieldByName('cargo').Value;
  Close;
  chamada := '';
end;
end;

procedure TFrmFuncionarios.desabilitarCampos;
  begin
  edtNome.Enabled := false;
  edtCPF.Enabled := false;
  EdtEndereco.Enabled := false;
  EdtTel.Enabled := false;
  cbCargo.Enabled := false;
  end;

procedure TFrmFuncionarios.edtBuscaNomeChange(Sender: TObject);
begin
buscarNome;
end;

procedure TFrmFuncionarios.EdtBuscarCPFChange(Sender: TObject);
begin
  buscarCpf;
end;

procedure TFrmFuncionarios.EdtBuscarNomeChange(Sender: TObject);
begin
buscarNome;
end;

procedure TFrmFuncionarios.FormCreate(Sender: TObject);
begin
edtBuscarCPF.Visible := false;
end;

procedure TFrmFuncionarios.FormShow(Sender: TObject);
  begin
  desabilitarCampos;
  dm.tb_func.Active := true;
  listar;
  carregarCombobox;
  cbCargo.ItemIndex := 0;
  rbNome.Checked := true;
  end;

  procedure TFrmFuncionarios.habilitarCampos;
  begin
  edtNome.Enabled := true;
  edtCPF.Enabled := true;
  EdtEndereco.Enabled := true;
  EdtTel.Enabled := true;
  cbCargo.Enabled := true;
  end;

  procedure TFrmFuncionarios.limpar;
  begin
  edtNome.Text := '';
  edtCPF.Text := '';
  EdtEndereco.Text := '';
  EdtTel.Text := '';
  end;

  procedure TFrmFuncionarios.listar;
  begin
       dm.query_func.Close;
       dm.query_func.SQL.Clear;
       dm.query_func.SQL.Add('SELECT * from funcionarios order by nome asc');
       dm.query_func.Open;
  end;

  procedure TFrmFuncionarios.rbCPFClick(Sender: TObject);
begin
listar;
edtBuscarCpf.Visible := true;
edtBuscaNome.Visible := false;
end;

procedure TFrmFuncionarios.rbNomeClick(Sender: TObject);
begin
listar;
edtBuscarCpf.Visible := false;
edtBuscaNome.Visible := true;

end;

procedure TFrmFuncionarios.SpeedButton1Click(Sender: TObject);
begin
rbNome.Visible := true;
rbCPF.Visible := true;
rbNome.Checked := false;
rbCPF.Checked := false;
edtBuscaNome.Visible := false;
edtBuscarCPF.Visible := false;
end;

end.
