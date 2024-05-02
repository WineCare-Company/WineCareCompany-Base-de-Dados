create database wineCare;

use wineCare;

-- Criação da tabela de cadastro de empresas
create table cadastro(
idCadastro int primary key auto_increment, -- id
nomeEmpresa varchar (45) not null unique, -- Nome da Empresa
CNPJ varchar(45) not null unique, -- CNPJ
atualRepresentante varchar (45) not null, -- Nome do representante da Empresa
emailContato varchar(45) not null unique, -- E-mail do representante
telefoneCel varchar(45) not null unique, -- Telefone celular para contato com a empresa
telefoneFixo varchar(45) unique, -- Telefone fixo para contato com a empresa
senha varchar (45)not null -- Senha para cadastro e login de cada empresa
);

-- Inserção de dados de empresas na tabela cadastro
insert into Cadastro values 
(null, 'Vinho Fino', '11.111.111/0001-11', 'Fernando', 'vinhosfinos@gmail.com', '11 12345-6789', null, 'vinho123'),
(null, 'Vinhos do Sul', '11.222.111/0001-11', 'Ferdinando', 'vinhosdosuls@gmail.com', '11 12345-6712', null, 'vinho321'),
(null, 'Sabor unico', '22.111.111/0001-11', 'Fernanda', 'saborunico@gmail.com', '11 12345-8389', null, 'Vin213');

select * from cadastroJuridico;

-- Cadastro das vinicolas de cada cadastro
create table vinicola(
idVinicola int primary key auto_increment, -- id
nome varchar(45), -- nome vinicola
CEP varchar(11), -- endereco da vinicola dividido em 3 partes
numero varchar(45),
complemento varchar(45),
qtdBarril int, -- Quantidade de barris da vinicola

fkCadastro int, -- fk para puxar as informações da tabela Cadastro
constraint fkCadastroVinicolas foreign key (fkCadastro) references cadastro (idCadastro) 
);

-- Inserção de dados na tabela vinicola de cada vinicola do cadastro
insert into vinicola values 
(null, 'Dom vinho', '11111-111', '12', null, 232, 1),
(null, 'Lis vinho', '11112-111', '1A', null, 234, 2),
(null, 'Canteiro da uva', '11111-121', '1023', null, 123, 3);

select * from vinicola;

-- Tabela contendo os parametros ideias para a produção do vinho
create table parametros(
idParametros int primary key auto_increment, 
tempMax float, -- temperatura maxima da vinicola
tempMin float, -- temperatura minima da vinicola 
umidadeMax float,  -- unidade minima da vinicola 
umidadeMin float  -- unidade minima da vinicola 
);

-- Inserção de dados ideias para a produção
insert into parametros values 
(null, 20, 15, 80, 60);

select * from parametros;

-- Tabela para inserir todos os  nossos sensores que estão instalados em cada vinícola
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

--  inserção das condições atuais de cada sensor e atualização de suas fks
insert into sensor values 
(null, 'DHT11', 12, 'Sim', 1, 1),
(null, 'DHT11', 130, 'Sim', 2, 1),
(null, 'DHT11', 125, 'Não', 3, 1);

select * from sensor;

-- Tabela interligada com os dados recebidos do arduino para implantação no Banco de dados 
create table dadosCaptados(
idDados int primary key auto_increment, 
temperaturaAmbiente float, -- temperatura ambiente captada pelo sensor DH11 e inserida no banco
umidadeAmbiente float, -- umidade ambiente captada pelo sensor DH11 e inserida no banco
horarioData datetime default current_timestamp, -- horario que as informações foram inseridas

fkSensor int, -- fk para puxar informações da tabela sensor 
constraint fkDadosSensor foreign key (fkSensor) references sensor(idSensor)
);

select * from dadosCaptados;


-- Selecionando todas as informações da tabela vinicola e da tabela cadastro onde a fkCadastro seja igual ao idCadastro
select * from vinicola
join cadastro
on vinicola.fkCadastro = Cadastro.idCadastro;

-- Selecionando todas as informações da tabela sensor e da tabela parametros onde a fkParamettros tem que ser igual ao idParametros
select * from sensor 
join parametros
on sensor.fkParametros = parametros.idParametros;


-- Selecionando o nome da empresa, nome da vinicola e a quantidade de barris que cada vinicola possui onde a fkCadastro seja igual ao idCadastro
select Cadastro.nomeEmpresa as NomeDaEmpresa,
vinicola.nome as NomeVinicola,
vinicola.qtdBarril
from cadastro as Cadastro
join vinicola
on vinicola.fkCadastro = Cadastro.idCadastro;

-- Selecionando o nome do sensor e todos os dados da tabela parametros onde o idParametros seja igual a fkParametros 
select sensor.nomeSensor as NomeSensor,
parametros.*
from sensor
join parametros
on parametros.idParametros = sensor.fkParametros;