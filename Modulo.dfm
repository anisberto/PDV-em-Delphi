object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 397
  Width = 756
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 8
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Cursos\PDV-em-Delphi\libs\libmySQL.dll'
    Left = 712
  end
  object tb_Cargos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.cargos'
    TableName = 'pdv.cargos'
    Left = 408
    Top = 72
  end
  object query_cargos: TFDQuery
    Active = True
    Connection = fd
    SQL.Strings = (
      'select * from cargos order by cargo asc')
    Left = 496
    Top = 72
    object query_cargosid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_cargoscargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 20
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
  end
  object DSCargos: TDataSource
    DataSet = query_cargos
    Left = 568
    Top = 72
  end
  object tb_func: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.funcionarios'
    TableName = 'pdv.funcionarios'
    Left = 408
    Top = 160
  end
  object query_func: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from funcionarios')
    Left = 496
    Top = 160
    object query_funcid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_funcnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_funccpf: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
    end
    object query_functelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 15
    end
    object query_funcendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 50
    end
    object query_funccargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_funcdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object DSFunc: TDataSource
    DataSet = query_func
    Left = 568
    Top = 160
  end
  object tb_usuarios: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.usuarios'
    TableName = 'pdv.usuarios'
    Left = 408
    Top = 224
  end
  object query_usuarios: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from usuarios')
    Left = 496
    Top = 224
    object query_usuariosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_usuariosnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_usuariosusuario: TStringField
      DisplayLabel = 'Usuario'
      DisplayWidth = 15
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 25
    end
    object query_usuariossenha: TStringField
      DisplayLabel = 'Senha'
      DisplayWidth = 10
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object query_usuarioscargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_usuariosid_funcionario: TIntegerField
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      Required = True
      Visible = False
    end
  end
  object DSUsuarios: TDataSource
    DataSet = query_usuarios
    Left = 568
    Top = 224
  end
  object tb_forn: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.fornecedores'
    TableName = 'pdv.fornecedores'
    Left = 408
    Top = 112
  end
  object query_forn: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from fornecedores')
    Left = 496
    Top = 112
    object query_fornid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_fornnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 13
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 25
    end
    object query_fornproduto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 15
      FieldName = 'produto'
      Origin = 'produto'
      Required = True
      Size = 25
    end
    object query_fornendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 17
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 30
    end
    object query_forntelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 16
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      Size = 15
    end
    object query_forndata: TDateField
      DisplayLabel = 'Data de Cadastro'
      DisplayWidth = 12
      FieldName = 'data'
      Origin = 'data'
      Required = True
    end
  end
  object DSForn: TDataSource
    DataSet = query_forn
    Left = 568
    Top = 112
  end
  object query_chargeback: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from chargeback')
    Left = 504
    Top = 280
    object query_chargebacknome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 23
    end
    object query_chargebackempresa: TStringField
      DisplayLabel = 'Web Empresa'
      FieldName = 'empresa'
      Origin = 'empresa'
      Required = True
      Size = 34
    end
    object query_chargebackpedido: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'pedido'
      Origin = 'pedido'
      Required = True
    end
    object query_chargebackemail: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 34
    end
    object query_chargebackid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
  end
  object DSchargeback: TDataSource
    DataSet = query_chargeback
    Left = 568
    Top = 280
  end
  object tb_chargeback: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.chargeback'
    TableName = 'pdv.chargeback'
    Left = 408
    Top = 280
  end
end
