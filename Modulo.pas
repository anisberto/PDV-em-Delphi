unit Modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TDataModule)
    fd: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    tb_Cargos: TFDTable;
    query_cargos: TFDQuery;
    query_cargosid: TFDAutoIncField;
    query_cargoscargo: TStringField;
    DSCargos: TDataSource;
    tb_func: TFDTable;
    query_func: TFDQuery;
    DSFunc: TDataSource;
    query_funcid: TFDAutoIncField;
    query_funcnome: TStringField;
    query_funccpf: TStringField;
    query_functelefone: TStringField;
    query_funcendereco: TStringField;
    query_funccargo: TStringField;
    query_funcdata: TDateField;
    tb_usuarios: TFDTable;
    query_usuarios: TFDQuery;
    query_usuariosid: TFDAutoIncField;
    query_usuariosnome: TStringField;
    query_usuariosusuario: TStringField;
    query_usuariossenha: TStringField;
    query_usuarioscargo: TStringField;
    query_usuariosid_funcionario: TIntegerField;
    DSUsuarios: TDataSource;
    tb_forn: TFDTable;
    query_forn: TFDQuery;
    DSForn: TDataSource;
    query_fornid: TFDAutoIncField;
    query_fornnome: TStringField;
    query_fornproduto: TStringField;
    query_fornendereco: TStringField;
    query_forntelefone: TStringField;
    query_forndata: TDateField;
    query_chargeback: TFDQuery;
    DSchargeback: TDataSource;
    tb_chargeback: TFDTable;
    query_chargebacknome: TStringField;
    query_chargebackpedido: TIntegerField;
    query_chargebackemail: TStringField;
    query_chargebackempresa: TStringField;
    query_chargebackid: TFDAutoIncField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

  //DECLARAÇÃO DAS VARIAVEIS GLOBAIS
  idFunc : string;
  nomeFunc : string;
  cargoFunc : string;

  chamada : string;


  nomeUsuario : string;
  cargoUsuario: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Chargeback;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
fd.Connected := True;
end;

end.
