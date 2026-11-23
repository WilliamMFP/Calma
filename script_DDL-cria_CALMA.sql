BEGIN TRANSACTION;

ROLLBACK; -- Volta

COMMIT; -- Salva


CREATE DATABASE DB_CALMA;

USE DB_CALMA;

sp_help


/*
====================================================================

REGRAS DE DOMÍNIO:

TB_CAL_ASSINATURA.st_assinatura
    A  = Ativo
    N  = Não ativo

TB_CAL_PAGAMENTO.tp_pagamento
    PX  = Pix
    CC  = Cartão de Crédito
    CD  = Cartão de Débito
    BLT = Boleto

====================================================================
*/

/* ================================================================
   1. CRIAÇÃO DAS TABELAS
================================================================ */

CREATE TABLE TB_CAL_PSICOLOGO (
    id_psicologo INT NOT NULL,
    nm_psicologo VARCHAR(150) NOT NULL,
    cpf_psicologo CHAR(11) NOT NULL,
    nr_telefone CHAR(14) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL
);


CREATE TABLE TB_CAL_USUARIOS (
    id_usuario INT NOT NULL,
    nm_usuario VARCHAR(150) NOT NULL,
    email_usuario VARCHAR(100) NOT NULL,
    senha_usuario NVARCHAR(21) NOT NULL,
    nr_telefone CHAR(14) NOT NULL,
    dt_nacimento DATE NOT NULL,
    dt_cadastro DATETIME NOT NULL
);


CREATE TABLE TB_CAL_CRP (
    id_crp INT NOT NULL,
    id_psicologo INT NOT NULL,
    nr_crp CHAR(7) NOT NULL,
    ds_estado CHAR(2) NOT NULL,
    dt_emissao DATE NOT NULL
);


CREATE TABLE TB_CAL_AVALIACAO (
    id_avaliacao INT NOT NULL,
    id_usuario INT NOT NULL,
    id_psicologo INT NOT NULL,
    nr_avaliacao CHAR(5) NOT NULL,
    ds_avaliacao VARCHAR(150) NOT NULL
);


CREATE TABLE TB_CAL_AVALIACAO_EMOCIONAL (
    id_avaliacao INT NOT NULL,
    id_usuario INT NOT NULL,
    dt_avaliacao DATE NOT NULL,
    nr_ansiedade INT NOT NULL,
    nr_estresse INT NOT NULL,
    nr_bem_estar INT NOT NULL
);


CREATE TABLE TB_CAL_ATENDIMENTO (
    id_atendimento INT NOT NULL,
    id_usuario INT NOT NULL,
    id_psicologo INT NOT NULL,
    dt_consulta DATETIME NOT NULL,
    st_agendamento VARCHAR(30) NOT NULL,
    observacao TEXT NOT NULL
);


CREATE TABLE TB_CAL_EXERCICIO_BEM_ESTAR (
    id_exercicio INT NOT NULL,
    nm_exercicio VARCHAR(100) NOT NULL,
    ds_exercicio VARCHAR(250) NOT NULL,
    tp_exercicio VARCHAR(50) NOT NULL,
    nr_duracao VARCHAR(100) NOT NULL
);


CREATE TABLE TB_CAL_A_EXERCICIO_USUARIO (
    id_exercicio INT NOT NULL,
    id_usuario INT NOT NULL
);


CREATE TABLE TB_CAL_CONTATO_DE_CONFIANCA (
    id_contato INT NOT NULL,
    id_usuario INT NOT NULL,
    nm_contato VARCHAR(150) NOT NULL,
    nr_telefone CHAR(14) NOT NULL,
    parentesco_contato VARCHAR(50) NOT NULL
);


CREATE TABLE TB_CAL_TAG (
    id_tag TINYINT NOT NULL,
    nm_tag VARCHAR(30) NOT NULL
);


CREATE TABLE TB_CAL_MEMORIA_AFETIVA (
    id_memoria INT NOT NULL,
    id_usuario INT NOT NULL,
    id_tag TINYINT NOT NULL,
    titulo_memoria VARCHAR(100) NOT NULL,
    ds_memoria TEXT NOT NULL,
    dt_registro DATETIME NOT NULL,
    tp_memoria CHAR(1) NOT NULL
);


CREATE TABLE TB_CAL_REGISTRO_EMOCIONAL (
    id_registro INT NOT NULL,
    id_usuario INT NOT NULL,
    emocao_registro VARCHAR(50) NOT NULL,
    intensidade_registro INT NOT NULL,
    dt_registro DATETIME NOT NULL,
    obs_registro TEXT NOT NULL
);


CREATE TABLE TB_CAL_CRISE (
    id_crise INT NOT NULL,
    id_usuario INT NOT NULL,
    ds_nivel VARCHAR(50) NOT NULL,
    ds_crise TEXT NOT NULL,
    dt_crise DATETIME NOT NULL
);


CREATE TABLE TB_CAL_PEDIDOS_DE_AJUDA (
    id_pedido INT NOT NULL,
    id_usuario INT NOT NULL,
    mensagem_pedido TEXT NOT NULL,
    dt_pedido DATETIME NOT NULL,
    st_pedido VARCHAR(30) NOT NULL,
    nl_urgencia VARCHAR(20) NOT NULL
);


CREATE TABLE TB_CAL_PLANOS (
    id_plano INT NOT NULL,
    nm_plano VARCHAR(50) NOT NULL,
    vl_plano DECIMAL(10,2) NOT NULL,
    ds_beneficio VARCHAR(150) NOT NULL
);


CREATE TABLE TB_CAL_PAGAMENTO (
    id_pagamento INT NOT NULL,
    tp_pagamento CHAR(3) NOT NULL
);


CREATE TABLE TB_CAL_ASSINATURA (
    id_assinatura INT NOT NULL,
    id_usuario INT NOT NULL,
    id_plano INT NOT NULL,
    id_pagamento INT NOT NULL,
    dt_inicio DATE NOT NULL,
    dt_fim DATE NOT NULL,
    st_assinatura CHAR(1) NOT NULL
);


CREATE TABLE TB_CAL_DIARIO_EMOCIONAL (
    id_diario INT NOT NULL,
    id_usuario INT NOT NULL,
    dt_registro DATE NOT NULL,
    nr_nivel_emocao VARCHAR(200) NOT NULL,
    ds_observacao VARCHAR(200) NOT NULL
);


/* ================================================================
   2. PRIMARY KEY
================================================================ */

ALTER TABLE TB_CAL_PSICOLOGO
ADD CONSTRAINT PK_TB_CAL_PSICOLOGO
PRIMARY KEY (id_psicologo);


ALTER TABLE TB_CAL_USUARIOS
ADD CONSTRAINT PK_TB_CAL_USUARIOS
PRIMARY KEY (id_usuario);


ALTER TABLE TB_CAL_CRP
ADD CONSTRAINT PK_TB_CAL_CRP
PRIMARY KEY (id_crp);


ALTER TABLE TB_CAL_AVALIACAO
ADD CONSTRAINT PK_TB_CAL_AVALIACAO
PRIMARY KEY (id_avaliacao);


ALTER TABLE TB_CAL_AVALIACAO_EMOCIONAL
ADD CONSTRAINT PK_TB_CAL_AVALIACAO_EMOCIONAL
PRIMARY KEY (id_avaliacao);


ALTER TABLE TB_CAL_ATENDIMENTO
ADD CONSTRAINT PK_TB_CAL_ATENDIMENTO
PRIMARY KEY (id_atendimento);


ALTER TABLE TB_CAL_EXERCICIO_BEM_ESTAR
ADD CONSTRAINT PK_TB_CAL_EXERCICIO_BEM_ESTAR
PRIMARY KEY (id_exercicio);


ALTER TABLE TB_CAL_A_EXERCICIO_USUARIO
ADD CONSTRAINT PK_TB_CAL_A_EXERCICIO_USUARIO
PRIMARY KEY (id_exercicio, id_usuario);


ALTER TABLE TB_CAL_CONTATO_DE_CONFIANCA
ADD CONSTRAINT PK_TB_CAL_CONTATO_DE_CONFIANCA
PRIMARY KEY (id_contato);


ALTER TABLE TB_CAL_TAG
ADD CONSTRAINT PK_TB_CAL_TAG
PRIMARY KEY (id_tag);


ALTER TABLE TB_CAL_MEMORIA_AFETIVA
ADD CONSTRAINT PK_TB_CAL_MEMORIA_AFETIVA
PRIMARY KEY (id_memoria);


ALTER TABLE TB_CAL_REGISTRO_EMOCIONAL
ADD CONSTRAINT PK_TB_CAL_REGISTRO_EMOCIONAL
PRIMARY KEY (id_registro);


ALTER TABLE TB_CAL_CRISE
ADD CONSTRAINT PK_TB_CAL_CRISE
PRIMARY KEY (id_crise);


ALTER TABLE TB_CAL_PEDIDOS_DE_AJUDA
ADD CONSTRAINT PK_TB_CAL_PEDIDOS_DE_AJUDA
PRIMARY KEY (id_pedido);


ALTER TABLE TB_CAL_PLANOS
ADD CONSTRAINT PK_TB_CAL_PLANOS
PRIMARY KEY (id_plano);


ALTER TABLE TB_CAL_PAGAMENTO
ADD CONSTRAINT PK_TB_CAL_PAGAMENTO
PRIMARY KEY (id_pagamento);


ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT PK_TB_CAL_ASSINATURA
PRIMARY KEY (id_assinatura);


ALTER TABLE TB_CAL_DIARIO_EMOCIONAL
ADD CONSTRAINT PK_TB_CAL_DIARIO_EMOCIONAL
PRIMARY KEY (id_diario);


/* ================================================================
   3. FOREIGN KEY
================================================================ */

ALTER TABLE TB_CAL_CRP
ADD CONSTRAINT FK_TB_CAL_CRP_TB_CAL_PSICOLOGO
FOREIGN KEY (id_psicologo)
REFERENCES TB_CAL_PSICOLOGO(id_psicologo);


ALTER TABLE TB_CAL_AVALIACAO
ADD CONSTRAINT FK_TB_CAL_AVALIACAO_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_AVALIACAO
ADD CONSTRAINT FK_TB_CAL_AVALIACAO_TB_CAL_PSICOLOGO
FOREIGN KEY (id_psicologo)
REFERENCES TB_CAL_PSICOLOGO(id_psicologo);


ALTER TABLE TB_CAL_AVALIACAO_EMOCIONAL
ADD CONSTRAINT FK_TB_CAL_AVALIACAO_EMOCIONAL_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_ATENDIMENTO
ADD CONSTRAINT FK_TB_CAL_ATENDIMENTO_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_ATENDIMENTO
ADD CONSTRAINT FK_TB_CAL_ATENDIMENTO_TB_CAL_PSICOLOGO
FOREIGN KEY (id_psicologo)
REFERENCES TB_CAL_PSICOLOGO(id_psicologo);


ALTER TABLE TB_CAL_A_EXERCICIO_USUARIO
ADD CONSTRAINT PF_TB_CAL_A_EXERCICIO_USUARIO_TB_CAL_EXERCICIO_BEM_ESTAR
FOREIGN KEY (id_exercicio)
REFERENCES TB_CAL_EXERCICIO_BEM_ESTAR(id_exercicio);


ALTER TABLE TB_CAL_A_EXERCICIO_USUARIO
ADD CONSTRAINT PF_TB_CAL_A_EXERCICIO_USUARIO_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_CONTATO_DE_CONFIANCA
ADD CONSTRAINT FK_TB_CAL_CONTATO_DE_CONFIANCA_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_MEMORIA_AFETIVA
ADD CONSTRAINT FK_TB_CAL_MEMORIA_AFETIVA_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_MEMORIA_AFETIVA
ADD CONSTRAINT FK_TB_CAL_MEMORIA_AFETIVA_TB_CAL_TAG
FOREIGN KEY (id_tag)
REFERENCES TB_CAL_TAG(id_tag);


ALTER TABLE TB_CAL_REGISTRO_EMOCIONAL
ADD CONSTRAINT FK_TB_CAL_REGISTRO_EMOCIONAL_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_CRISE
ADD CONSTRAINT FK_TB_CAL_CRISE_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_PEDIDOS_DE_AJUDA
ADD CONSTRAINT FK_TB_CAL_PEDIDOS_DE_AJUDA_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT FK_TB_CAL_ASSINATURA_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT FK_TB_CAL_ASSINATURA_TB_CAL_PLANOS
FOREIGN KEY (id_plano)
REFERENCES TB_CAL_PLANOS(id_plano);


ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT FK_TB_CAL_ASSINATURA_TB_CAL_PAGAMENTO
FOREIGN KEY (id_pagamento)
REFERENCES TB_CAL_PAGAMENTO(id_pagamento);


ALTER TABLE TB_CAL_DIARIO_EMOCIONAL
ADD CONSTRAINT FK_TB_CAL_DIARIO_EMOCIONAL_TB_CAL_USUARIOS
FOREIGN KEY (id_usuario)
REFERENCES TB_CAL_USUARIOS(id_usuario);


/* ================================================================
   4. UNIQUE
================================================================ */

ALTER TABLE TB_CAL_USUARIOS
ADD CONSTRAINT UN_TB_CAL_USUARIOS_EMAIL
UNIQUE (email_usuario);


ALTER TABLE TB_CAL_PSICOLOGO
ADD CONSTRAINT UN_TB_CAL_PSICOLOGO_CPF
UNIQUE (cpf_psicologo);


ALTER TABLE TB_CAL_CRP
ADD CONSTRAINT UN_TB_CAL_CRP_NR_CRP
UNIQUE (nr_crp);


/* ================================================================
   5. CHECK
================================================================ */

/*
   E-MAIL
   Verifica uma estrutura básica de e-mail.
*/
ALTER TABLE TB_CAL_USUARIOS
ADD CONSTRAINT CK_TB_CAL_USUARIOS_EMAIL
CHECK (email_usuario LIKE '%_@_%._%');


/*
   SENHA
   Deve possuir pelo menos 8 caracteres.
*/
ALTER TABLE TB_CAL_USUARIOS
ADD CONSTRAINT CK_TB_CAL_USUARIOS_SENHA
CHECK (LEN(senha_usuario) >= 8);


/*
   CPF
   Permite somente números.
*/
ALTER TABLE TB_CAL_PSICOLOGO
ADD CONSTRAINT CK_TB_CAL_PSICOLOGO_CPF
CHECK (cpf_psicologo NOT LIKE '%[^0-9]%');


/*
   CRP
   Permite somente números.
*/
ALTER TABLE TB_CAL_CRP
ADD CONSTRAINT CK_TB_CAL_CRP_NUMERO
CHECK (nr_crp NOT LIKE '%[^0-9]%');


/*
   ESTADO
   Permite somente letras.
*/
ALTER TABLE TB_CAL_CRP
ADD CONSTRAINT CK_TB_CAL_CRP_ESTADO
CHECK (ds_estado NOT LIKE '%[^A-Za-z]%');


/*
   AVALIAÇÃO
   Aceita somente 1, 2, 3, 4 ou 5.
*/
ALTER TABLE TB_CAL_AVALIACAO
ADD CONSTRAINT CK_TB_CAL_AVALIACAO_NOTA
CHECK (nr_avaliacao IN ('1','2','3','4','5'));


/*
   AVALIAÇÃO EMOCIONAL
   Os valores não podem ser negativos.
*/
ALTER TABLE TB_CAL_AVALIACAO_EMOCIONAL
ADD CONSTRAINT CK_TB_CAL_AVALIACAO_EMOCIONAL_VALORES
CHECK (
    nr_ansiedade >= 0
    AND nr_estresse >= 0
    AND nr_bem_estar >= 0
);


/*
   REGISTRO EMOCIONAL
   A intensidade não pode ser negativa.
*/
ALTER TABLE TB_CAL_REGISTRO_EMOCIONAL
ADD CONSTRAINT CK_TB_CAL_REGISTRO_EMOCIONAL_INTENSIDADE
CHECK (intensidade_registro >= 0);


/*
   PLANO
   O valor não pode ser negativo.
*/
ALTER TABLE TB_CAL_PLANOS
ADD CONSTRAINT CK_TB_CAL_PLANOS_VALOR
CHECK (vl_plano >= 0);


/*
   ASSINATURA
   A data final deve ser igual ou posterior à data inicial.
*/
ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT CK_TB_CAL_ASSINATURA_DATAS
CHECK (dt_fim >= dt_inicio);



/*
   ASSINATURA
   A = Ativo
   N = Não ativo
*/
ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT CK_TB_CAL_ASSINATURA_STATUS
CHECK (st_assinatura IN ('A','N'));


/*
   FORMA DE PAGAMENTO

   PX  = Pix
   CC  = Cartão de Crédito
   CD  = Cartão de Débito
   BLT = Boleto
*/
ALTER TABLE TB_CAL_PAGAMENTO
ADD CONSTRAINT CK_TB_CAL_PAGAMENTO_TIPO
CHECK (tp_pagamento IN ('PX','CC','CD','BLT'));


/* ================================================================
   6. DEFAULT
================================================================ */

ALTER TABLE TB_CAL_USUARIOS
ADD CONSTRAINT DF_TB_CAL_USUARIOS_DT_CADASTRO
DEFAULT GETDATE() FOR dt_cadastro;



ALTER TABLE TB_CAL_MEMORIA_AFETIVA
ADD CONSTRAINT DF_TB_CAL_MEMORIA_AFETIVA_DT_REGISTRO
DEFAULT GETDATE() FOR dt_registro;


ALTER TABLE TB_CAL_REGISTRO_EMOCIONAL
ADD CONSTRAINT DF_TB_CAL_REGISTRO_EMOCIONAL_DT_REGISTRO
DEFAULT GETDATE() FOR dt_registro;


ALTER TABLE TB_CAL_CRISE
ADD CONSTRAINT DF_TB_CAL_CRISE_DT_CRISE
DEFAULT GETDATE() FOR dt_crise;


ALTER TABLE TB_CAL_PEDIDOS_DE_AJUDA
ADD CONSTRAINT DF_TB_CAL_PEDIDOS_DE_AJUDA_DT_PEDIDO
DEFAULT GETDATE() FOR dt_pedido;


ALTER TABLE TB_CAL_ASSINATURA
ADD CONSTRAINT DF_TB_CAL_ASSINATURA_STATUS
DEFAULT 'A' FOR st_assinatura;


/* ================================================================
   7. MASCARAMENTO DE DADOS SENSÍVEIS
================================================================ */

/*
   E-MAIL
   Dynamic Data Masking para usuários sem permissão
   de visualização do dado original.
*/
ALTER TABLE TB_CAL_USUARIOS
ALTER COLUMN email_usuario VARCHAR(100)
MASKED WITH (FUNCTION = 'email()') NOT NULL;


/*
   SENHA
   Dynamic Data Masking.

   OBSERVAÇÃO:
   Mascaramento não substitui HASH de senha em
   um sistema real.
*/
ALTER TABLE TB_CAL_USUARIOS
ALTER COLUMN senha_usuario NVARCHAR(21)
MASKED WITH (FUNCTION = 'partial(1,"XXXX",0)') NOT NULL;