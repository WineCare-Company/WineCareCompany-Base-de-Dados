create database wineCare;

use wineCare;

create table CadastroJuridico(
idCadastroJuridico int primary key auto_increment,
nomeEmpresa varchar (45) not null unique,
CNPJ varchar(45) not null unique,
atualRepresentante varchar (45) not null,
emailContato varchar(45) not null unique,
telefoneContato varchar(45) not null unique,
senha varchar (45)not null,
CEP varchar(45) not null,
numero varchar (45) not null,
complemento varchar(45)
);

insert into CadastroJuridico values 
(null, 'Vinho Fino', '11.111.111/0001-11', 'Fernando', 'vinhosfinos@gmail.com', '11 12345-6789', 'vinho123', '11111-111', '12', null),
(null, 'Vinhos do Sul', '11.222.111/0001-11', 'Ferdinando', 'vinhosdosuls@gmail.com', '11 12345-6712','vinho321', '11112-111', '1A', null),
(null, 'Sabor unico', '22.111.111/0001-11', 'Fernanda', 'saborunico@gmail.com', '11 12345-8389', 'Vin213', '11111-121', '1023', null);

create table vinicola(
idVinicola int primary key auto_increment,
nome varchar(45),
CEP varchar(11),
numero varchar(45),
complemento varchar(45),
qntBarril int,

fkCadastro int,
constraint fkCadastroVinicolas foreign key (fkCadastro) references CadastroJuridico (idCadastroJuridico)
);

insert into vinicola values 
(null, 'Dom vinho', '11111-111', '12', null, 40, 1),
(null, 'Lis vinho', '11112-111', '1A', null, 56, 2),
(null, 'Canteiro da uva', '11111-121', '1023', null, 70, 3);

create table parametros(
idParametros int primary key auto_increment,
tempMax float,
tempMin float,
umidadeMax float,
umidadeMin float
);

insert into parametros values 
(null, 20, 15, 80, 50);

create table sensor(
idSensor int primary key auto_increment,
nomeSensor varchar(45),
numeroBarril int,
ligado char(3),

fkVinicola int,
fkParametros int,
constraint fkVinicolaSensor foreign key (fkVinicola) references vinicola (idVinicola),
constraint fkParametrosSensor foreign key (fkParametros) references parametros (idParametros)
);

insert into sensor values 
(null, 'DHT11', 1, 'Sim', 1, 1),
(null, 'DHT11', 30, 'Sim', 2, 1),
(null, 'DHT11', 12, 'Não', 3, 1);

create table dadosCaptados(
idDados int primary key auto_increment, 
tempAmbiente float,
umidadeAmbiente float,
horarioData datetime default current_timestamp,

fkSensor int,
constraint fkDadosSensor foreign key (fkSensor) references sensor(idSensor)
);

select * from vinicola
join CadastroJuridico
on vinicola.fkCadastro = CadastroJuridico.idCadastroJuridico;

select * from sensor 
join parametros
on sensor.fkParametros = parametros.idParametros;