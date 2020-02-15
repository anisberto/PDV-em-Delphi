unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Ca1: TMenuItem;
    Produtos1: TMenuItem;
    Fornecedores1: TMenuItem;
    Estoque1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Usurios1: TMenuItem;
    Funcionrios1: TMenuItem;
    Cargos1: TMenuItem;
    Sair2: TMenuItem;
    Chargeback: TMenuItem;
    procedure Usurios1Click(Sender: TObject);
    procedure Funcionrios1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure ChargebackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses Usuarios, Funcionarios, Cargos, Modulo, Fornecedores, Chargeback;

procedure TFrmMenu.Cargos1Click(Sender: TObject);
begin
FrmCargos := TFrmCargos.Create(self);
FrmCargos.ShowModal;
end;

procedure TFrmMenu.ChargebackClick(Sender: TObject);
begin
FrmChargeback := TfrmChargeback.Create(self);
FrmChargeback.ShowModal;
end;

procedure TFrmMenu.FormShow(Sender: TObject);
begin
if (cargoUsuario = 'admin') or (cargoUsuario = 'Gerente') then
begin
      Usurios1.Enabled := true;
end;

end;

procedure TFrmMenu.Fornecedores1Click(Sender: TObject);
begin
FrmFornecedores := TFrmFornecedores.Create(self);
FrmFornecedores.ShowModal;
end;

procedure TFrmMenu.Funcionrios1Click(Sender: TObject);
begin
FrmFuncionarios := TFrmFuncionarios.Create(self);
FrmFuncionarios.ShowModal;
end;

procedure TFrmMenu.Sair2Click(Sender: TObject);
begin
close;
end;

procedure TFrmMenu.Usurios1Click(Sender: TObject);
begin
FrmUsuarios := TFrmUsuarios.Create(self);
FrmUsuarios.ShowModal;
end;

end.
