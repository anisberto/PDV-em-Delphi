unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    Panel1: TPanel;
    imgFundo: TImage;
    pnlLogin: TPanel;
    imgLogin: TImage;
    EdtUsuario: TEdit;
    EdtSenha: TEdit;
    btnLogin: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    procedure centralizarPainel;
    procedure Login;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

uses Menu, Modulo, Usuarios, Funcionarios;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin

  if Trim(EdtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usuário!', mtInformation, mbOKCancel, 0);
    EdtUsuario.SetFocus;
    exit;
  end;

  if Trim(EdtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
    EdtSenha.SetFocus;
    FrmMenu.ShowModal;
    exit;
  end;
  FrmMenu := TFrmMenu.Create(FrmMenu);
  FrmMenu.ShowModal;

end;

procedure TFrmLogin.centralizarPainel;
begin
  pnlLogin.Top := (self.Height div 2) - (pnlLogin.Height div 2);
  pnlLogin.Left := (self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  centralizarPainel;
end;

procedure TFrmLogin.Login;
begin
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add
    ('SELECT * from usuarios where usuario = :usuario and senha = :senha');
  dm.query_usuarios.ParamByName('usuario').Value := EdtUsuario.Text;
  dm.query_usuarios.ParamByName('senha').Value := EdtSenha.Text;
  dm.query_usuarios.Open;

  if not dm.query_usuarios.isEmpty then
  begin
    nomeUsuario := dm.query_usuarios['usuario'];
    cargoUsuario := dm.query_usuarios['cargo'];
    FrmMenu := TFrmMenu.Create(FrmLogin);
    EdtSenha.Text := '';
    FrmMenu.ShowModal;

  end
  else
  begin
    MessageDlg('Os dados estão incorretos!!', mtInformation, mbOKCancel, 0);
    EdtUsuario.Text := '';
    EdtSenha.Text := '';
    EdtUsuario.SetFocus;
  end;
end;

end.
