-- Scripts de BD para o sistema Xtreme Service Request

CREATE TABLE tipodeacesso
(
  id numeric(5) primary key,
  nome varchar(20) not null,
  tela1 numeric(1),
  tela2 numeric(1),
  tela3 numeric(1),
  tela4 numeric(1),
  tela5 numeric(1),
  tela6 numeric(1),
  tela7 numeric(1),
  tela8 numeric(1),
  tela9 numeric(1)
);

CREATE TABLE usuario
(
  id numeric(5) primary key,
  tipodeacesso numeric(5) not null,
  nome varchar(30) not null,
  cnpj numeric(13),
  contato varchar(30),
  cpf numeric(11),
  login varchar(15) not null,
  senha varchar(10) not null,
  constraint tipo_usu_fk foreign key (tipodeacesso) references tipodeacesso(id)
);

CREATE TABLE endereco
(
  id numeric(5) primary key,
  cep numeric (8) not null,
  num numeric(10) not null,
  compl varchar(20),
  usuario numeric(5) not null,
  constraint usuario_end_fk foreign key (usuario) references usuario(id)
);

CREATE TABLE telefone
(
  id numeric(5) primary key,
  ddd numeric(3) not null,
  numero numeric(8) not null,
  tipo varchar(3) not null,
  usuario numeric(5) not null,
  constraint usuario_tel_fk foreign key (usuario) references usuario(id)
);

CREATE TABLE categoria
(
  id numeric(5) primary key,
  nome varchar(20),
  pai numeric(3)
);

CREATE TABLE severidade
(
  id numeric(5) primary key,
  nome varchar(15) not null,
  tempo numeric(3) not null
);

CREATE TABLE status
(
  id numeric(5) primary key,
  nome varchar(30) not null
);

CREATE TABLE ticket
(
  id numeric(5) primary key,
  titulo varchar(30) not null,
  descricao varchar(300) not null,
  categoria numeric(5) not null,
  severidade numeric(5) not null,
  status varchar(20) not null,
  responsavel numeric(5),
  cliente numeric(5) not null,
  data_abertura varchar(10) not null,
  constraint categoria_tic_fk foreign key (categoria) references categoria(id),
  constraint severidade_tic_fk foreign key (severidade) references severidade(id),
  constraint responsavel_tic_fk foreign key (responsavel) references usuario(id),
  constraint cliente_tic_fk foreign key (cliente) references usuario(id)
);

CREATE TABLE report
(
  id numeric(5) primary key,
  ticket numeric(5) not null,
  descricao varchar(500) not null,
  solucao_final varchar(500),
  data_hora varchar(15),
  status numeric(5) not null,
  responsavel numeric(5) not null,
  constraint ticket_rep_fk foreign key (ticket) references ticket(id),
  constraint status_rep_fk foreign key (status) references status(id)
);

create sequence seq_tip;
create sequence seq_usu;
create sequence seq_end;
create sequence seq_tel;
create sequence seq_cat;
create sequence seq_sev;
create sequence seq_sta;
create sequence seq_tic;
create sequence seq_rep;

insert into tipodeacesso values (nextval('seq_tip'),'Admin',1,0,0,1,1,0,0,0,1);
insert into usuario values (nextval('seq_usu'),(select id from tipodeacesso where nome like '%dmin'),'Hawking',null,null,11111111111,'admin','123');