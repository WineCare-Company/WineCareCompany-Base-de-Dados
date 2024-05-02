create database wineCare;

use wineCare;

create table CadastroJuridico(
idCadastroJuridico int primary key auto_increment, -- id
nomeEmpresa varchar (45) not null unique, -- Nome da Empresa
CNPJ varchar(45) not null unique, -- CNPJ
atualRepresentante varchar (45) not null, -- Nome do representante da Empresa
emailContato varchar(45) not null unique, -- E-mail do representante
telefoneContato varchar(45) not null unique, -- telefone do representante disponivel para contato
senha varchar (45)not null, 
CEP varchar(45) not null,
numero varchar (45) not null,
complemento varchar(45)
);

insert into CadastroJuridico values 
(null, 'Vinho Fino', '11.111.111/0001-11', 'Fernando', 'vinhosfinos@gmail.com', '11 12345-6789', 'vinho123', '11111-111', '12', null),
(null, 'Vinhos do Sul', '11.222.111/0001-11', 'Ferdinando', 'vinhosdosuls@gmail.com', '11 12345-6712','vinho321', '11112-111', '1A', null),
(null, 'Sabor unico', '22.111.111/0001-11', 'Fernanda', 'saborunico@gmail.com', '11 12345-8389', 'Vin213', '11111-121', '1023', null);

select * from cadastroJuridico;

create table vinicola(
idVinicola int primary key auto_increment,
nome varchar(45), -- nome vinicola
CEP varchar(11), -- endereco da vinicola dividido em 3 partes
numero varchar(45),
complemento varchar(45),
qtdBarril int, -- Quantidade de barris da vinicola

fkCadastro int, -- fk para puxar as informações da tabela CadastroJuridico
constraint fkCadastroVinicolas foreign key (fkCadastro) references CadastroJuridico (idCadastroJuridico) 
);

insert into vinicola values 
(null, 'Dom vinho', '11111-111', '12', null, 40, 1),
(null, 'Lis vinho', '11112-111', '1A', null, 56, 2),
(null, 'Canteiro da uva', '11111-121', '1023', null, 70, 3);

select * from vinicola;

create table parametros(
idParametros int primary key auto_increment, 
tempMax float, -- temperatura maxima da vinicola
tempMin float, -- temperatura minima da vinicola 
umidadeMax float,  -- unidade minima da vinicola 
umidadeMin float  -- unidade minima da vinicola 
);

insert into parametros values 
(null, 20, 15, 80, 60);

select * from parametros;

create table sensor(
idSensor int primary key auto_increment,
nomeSensor varchar(45), -- nome do sensor
numeroBarril int, -- numero do barril
ligado char(3), -- sim ou não

fkVinicola int, -- fk para puxar informações da tabela vinicola
fkParametros int, -- fk para puxar informações da tabela parametros
constraint fkVinicolaSensor foreign key (fkVinicola) references vinicola (idVinicola),
constraint fkParametrosSensor foreign key (fkParametros) references parametros (idParametros)
);

insert into sensor values 
(null, 'DHT11', 1, 'Sim', 1, 1),
(null, 'DHT11', 30, 'Sim', 2, 1),
(null, 'DHT11', 12, 'Não', 3, 1);

select * from sensor;

create table dadosCaptados(
idDados int primary key auto_increment, 
tempAmbiente float, -- temperatura ambiente captada pelo sensor DH11 e inserida no banco
umidadeAmbiente float, -- umidade ambiente captada pelo sensor DH11 e inserida no banco
horarioData datetime default current_timestamp, -- horario que as informações foram inseridas

fkSensor int, -- fk para puxar informações da tabela sensor 
constraint fkDadosSensor foreign key (fkSensor) references sensor(idSensor)
);

select * from dadosCaptados;

select * from vinicola
join CadastroJuridico
on vinicola.fkCadastro = CadastroJuridico.idCadastroJuridico;

select * from sensor 
join parametros
on sensor.fkParametros = parametros.idParametros;

select Cadastro.nomeEmpresa as NomeDaEmpresa,
vinicola.nome as NomeVinicola,
vinicola.qtdBarril
from cadastroJuridico as Cadastro
join vinicola
on vinicola.fkCadastro = Cadastro.idCadastroJuridico;


select sensor.nomeSensor as NomeSensor,
parametros.*
from sensor
join parametros
on parametros.idParametros = sensor.fkParametros;

select sensor.*,
dadosCaptados.*
from sensor
join dadosCaptados
on sensor.idSensor = dadosCaptados.fkSensor;
