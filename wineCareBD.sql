-- Criação do banco de dados wineCare
CREATE DATABASE wineCare;

-- Seleção do banco de dados wineCare para uso
USE wineCare;

-- Criação da tabela de cadastro de empresas
CREATE TABLE cadastro(
    idCadastro INT PRIMARY KEY AUTO_INCREMENT, -- ID do cadastro, chave primária
    nomeEmpresa VARCHAR(45) NOT NULL UNIQUE, -- Nome da Empresa, deve ser único
    CNPJ CHAR(14) NOT NULL UNIQUE, -- CNPJ da empresa, formato fixo de 14 caracteres, deve ser único
    atualRepresentante VARCHAR(45) NOT NULL, -- Nome do representante atual da empresa
    telefone1 CHAR(11) NOT NULL UNIQUE, -- Telefone celular para contato
    telefone2 CHAR(11), -- Segundo número de telefone, ou telefone reserva
    emailContato VARCHAR(45) NOT NULL UNIQUE, -- E-mail do representante, deve ser único
    senha VARCHAR(45) NOT NULL -- Senha para acesso ao sistema
);

-- Inserção de dados na tabela de cadastro de empresas
INSERT INTO cadastro(nomeEmpresa, CNPJ, atualRepresentante, telefone1, emailContato, senha) VALUES 
    ('Vinho Fino', '11111111000111', 'Fernando', '11123456789', 'vinhosfinos@gmail.com', 'vinho123'),
    ('Vinhos do Sul', '11222111000111', 'Ferdinando', '11123456712', 'vinhosdosuls@gmail.com', 'vinho321'),
    ('Sabor Unico', '22111111000111', 'Fernanda', '11123458389', 'saborunico@gmail.com', 'Vin213');

-- Exibição dos dados da tabela cadastro
SELECT * FROM cadastro;

-- Criação da tabela de endereços
CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT, -- ID do endereço, chave primária e auto-incremental
    logradouro VARCHAR(45), -- Logradouro do endereço
    numero VARCHAR(6), -- Número no endereço
    bairro VARCHAR(45), -- Bairro
    cidade VARCHAR(45), -- Cidade
    uf CHAR(2), -- Unidade Federativa (Estado), 2 caracteres
    cep CHAR(8), -- CEP, formato fixo de 8 caracteres
    complemento VARCHAR(45) -- Complemento do endereço
);

-- Criação da tabela de vinícolas
CREATE TABLE vinicola(
    idVinicola INT PRIMARY KEY AUTO_INCREMENT, -- ID da vinícola, chave primária e auto-incremental
    nome VARCHAR(45), -- Nome da vinícola
    qtdBarril INT, -- Quantidade de barris na vinícola
    fkEndereco INT, -- Chave estrangeira referenciando o ID do endereço
    fkCadastro INT, -- Chave estrangeira referenciando o ID do cadastro da empresa
    CONSTRAINT fkEnderecoVinicolas FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco),
    CONSTRAINT fkCadastroVinicolas FOREIGN KEY (fkCadastro) REFERENCES cadastro (idCadastro)
);

-- Criação da tabela de parâmetros ideais para a produção do vinho
CREATE TABLE parametros(
    idParametros INT PRIMARY KEY AUTO_INCREMENT, 
    tempMax FLOAT, -- Temperatura máxima ideal
    tempMin FLOAT, -- Temperatura mínima ideal
    umidadeMax FLOAT, -- Umidade máxima ideal
    umidadeMin FLOAT -- Umidade mínima ideal
);

-- Inserção de dados na tabela de parâmetros ideais
INSERT INTO parametros VALUES 
    (NULL, 20, 15, 80, 60);

-- Exibição dos dados da tabela parametros
SELECT * FROM parametros;

-- Criação da tabela de sensores instalados nas vinícolas
CREATE TABLE sensor(
    idSensor INT PRIMARY KEY AUTO_INCREMENT, 
    numeroBarril INT, -- Número do barril onde o sensor está instalado
    ligado CHAR(3), -- Status do sensor ('Sim' ou 'Não')
    fkVinicola INT, -- Chave estrangeira para a vinícola
    fkParametros INT, -- Chave estrangeira para os parâmetros
    CONSTRAINT fkVinicolaSensor FOREIGN KEY (fkVinicola) REFERENCES vinicola (idVinicola),
    CONSTRAINT fkParametrosSensor FOREIGN KEY (fkParametros) REFERENCES parametros (idParametros)
);

-- Inserção de dados na tabela de sensores
INSERT INTO sensor VALUES 
    (DEFAULT, 1, 'Sim', 1, 1),
    (DEFAULT, 2, 'Sim', 2, 1),
    (DEFAULT, 3, 'Não', 3, 1);

-- Exibição dos dados da tabela sensor
SELECT * FROM sensor;

-- Criação da tabela de dados captados pelos sensores
CREATE TABLE dadosCaptados(
    idDados INT PRIMARY KEY AUTO_INCREMENT,
    temperaturaAmbiente FLOAT, -- Temperatura ambiente captada pelo sensor
    umidadeAmbiente FLOAT, -- Umidade ambiente captada pelo sensor
    horarioData DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora da captura dos dados
    fkSensor INT, -- Chave estrangeira referenciando o ID do sensor
    CONSTRAINT fkDadosSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);

-- Exibição dos dados captados
SELECT * FROM dadosCaptados;

-- Consulta interligada das informações das vinícolas com os cadastros das empresas
SELECT * FROM vinicola
JOIN cadastro
ON vinicola.fkCadastro = cadastro.idCadastro;

-- Consulta interligada das informações dos sensores com os parâmetros
SELECT * FROM sensor 
JOIN parametros
ON sensor.fkParametros = parametros.idParametros;

-- Consulta específica para nome da empresa, vinícola e quantidade de barris
SELECT cadastro.nomeEmpresa AS NomeDaEmpresa,
vinicola.nome AS NomeVinicola,
vinicola.qtdBarril
FROM cadastro
JOIN vinicola
ON vinicola.fkCadastro = cadastro.idCadastro;

-- Consulta específica para nome do sensor e todos os dados de parâmetros
SELECT sensor.idSensor AS NomeSensor,
parametros.*
FROM sensor
JOIN parametros
ON parametros.idParametros = sensor.fkParametros;
