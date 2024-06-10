CREATE DATABASE wineCare;
USE wineCare;

CREATE TABLE Usuario (
  idUsuario INT NOT NULL AUTO_INCREMENT,
  nomeEmpresa VARCHAR(45) NOT NULL,
  CNPJ VARCHAR(20) NOT NULL,
  atualRepresentante VARCHAR(45) NOT NULL,
  telefone1 VARCHAR(20) NOT NULL,
  emailContato VARCHAR(45) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  PRIMARY KEY (idUsuario)
);

CREATE TABLE Endereco (
  idEndereco INT NOT NULL AUTO_INCREMENT,
  logradouro VARCHAR(45) NOT NULL,
  numero VARCHAR(6) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  uf CHAR(2) NOT NULL,
  cep CHAR(8) NOT NULL,
  complemento VARCHAR(45) NULL,
  PRIMARY KEY (idEndereco)
);

CREATE TABLE Vinicola (
  idVinícolas INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  qtdBarril INT NOT NULL,
  fkUsuario INT NOT NULL,
  fkEndereco INT NOT NULL,
  PRIMARY KEY (idVinícolas),
  CONSTRAINT fk_Vinícolas_CadastroJuridico1
    FOREIGN KEY (fkUsuario)
    REFERENCES Usuario (idUsuario),
  CONSTRAINT fk_Vinicola_Endereco1
    FOREIGN KEY (fkEndereco)
    REFERENCES Endereco (idEndereco)
);

CREATE TABLE Sensor (
  idSensor INT NOT NULL AUTO_INCREMENT,
  fkVinicola INT NOT NULL,
  nomeSensor VARCHAR(45) NULL,
  PRIMARY KEY (idSensor),
  UNIQUE (idSensor),
  CONSTRAINT fk_Sensor_Vinícolas1
    FOREIGN KEY (fkVinicola)
    REFERENCES Vinicola (idVinícolas)
);

CREATE TABLE parametrosIdeais (
  idparametrosIdeais INT NOT NULL AUTO_INCREMENT,
  tempMax FLOAT NOT NULL,
  tempMin FLOAT NOT NULL,
  umidadeMax FLOAT NOT NULL,
  umidadeMin FLOAT NOT NULL,
  PRIMARY KEY (idparametrosIdeais)
);

CREATE TABLE dadosCaptados (
  idDados INT,
  temperaturaAmbiente FLOAT NULL,
  umidadeAmbiente FLOAT NULL,
  horarioData DATETIME,
  fkSensor INT,
  fkParametros INT,
  PRIMARY KEY (idDados, fkSensor),
  CONSTRAINT fk_dadosCaptados_Sensor1
    FOREIGN KEY (fkSensor)
    REFERENCES Sensor (idSensor),
  CONSTRAINT fk_dadosCaptados_parametrosIdeais1
    FOREIGN KEY (fkParametros)
    REFERENCES parametrosIdeais (idparametrosIdeais)
);

CREATE TABLE Aviso (
  idAviso INT NOT NULL,
  descricaoAviso VARCHAR(45) NOT NULL,
  horarioAviso DATETIME NULL,
  fkDados INT NOT NULL,
  fkSensor INT NOT NULL,
  PRIMARY KEY (idAviso, fkDados, fkSensor),
  CONSTRAINT fk_Aviso_dadosCaptados1
    FOREIGN KEY (fkDados, fkSensor)
    REFERENCES dadosCaptados (idDados, fkSensor)
);

CREATE TABLE Barril (
  idBarril INT NOT NULL AUTO_INCREMENT,
  numeroBarril INT NULL,
  numeroSensor INT NULL,
  fkSensor INT NOT NULL,
  PRIMARY KEY (idBarril),
  CONSTRAINT fk_Barril_Sensor1
    FOREIGN KEY (fkSensor)
    REFERENCES Sensor (idSensor)
);

INSERT INTO Usuario VALUES
(1, 'SPtech', '12345678000100', 'Fernanda', '(11) 96070-4268', 'sptech@gmail.com', '1234567');

INSERT INTO Endereco VALUES
(1, 'Haddock Lobo', '100', 'Boa Vista', 'São Paulo', 'SP', '09572000', null);

INSERT INTO Vinicola VALUES
(1, 'WineVinicola', 12, 1, 1);

INSERT INTO Sensor VALUES
(1, 1, 'DTH11'),
(2, 1, 'DTH11'),
(3, 1, 'DTH11'),
(4, 1, 'DTH11'),
(5, 1, 'DTH11'),
(6, 1, 'DTH11'),
(7, 1, 'DTH11'),
(8, 1, 'DTH11'),
(9, 1, 'DTH11'),
(10, 1, 'DTH11'),
(11, 1, 'DTH11'),
(12, 1, 'DTH11');

INSERT INTO parametrosIdeais VALUES
(1, 20, 15, 80, 60);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(1, null, null, null, 1, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(101, 15.5, 60.2, '2024-06-01 10:00:00', 12, 1),
(102, 16.7, 61.7, '2024-06-01 11:00:00', 12, 1),
(103, 17.2, 63.1, '2024-06-01 12:00:00', 12, 1),
(104, 18.1, 64.5, '2024-06-01 13:00:00', 12, 1),
(105, 19.4, 65.9, '2024-06-01 14:00:00', 12, 1),
(106, 20.6, 67.3, '2024-06-01 15:00:00', 12, 1),
(107, 14.8, 68.7, '2024-06-01 16:00:00', 12, 1),
(108, 15.9, 70.1, '2024-06-01 17:00:00', 12, 1),
(109, 16.3, 71.5, '2024-06-01 18:00:00', 12, 1),
(110, 17.8, 72.9, '2024-06-01 19:00:00', 12, 1),
(111, 19.1, 74.3, '2024-06-01 20:00:00', 12, 1),
(112, 20.3, 75.7, '2024-06-01 21:00:00', 12, 1),
(113, 14.7, 77.1, '2024-06-01 22:00:00', 12, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(201, 14.9, 59.8, '2024-06-01 10:30:00', 2, 1),
(202, 16.0, 61.2, '2024-06-01 11:30:00', 2, 1),
(203, 17.1, 62.6, '2024-06-01 12:30:00', 2, 1),
(204, 18.2, 64.0, '2024-06-01 13:30:00', 2, 1),
(205, 19.3, 65.4, '2024-06-01 14:30:00', 2, 1),
(206, 20.4, 66.8, '2024-06-01 15:30:00', 2, 1),
(207, 14.5, 68.2, '2024-06-01 16:30:00', 2, 1),
(208, 15.6, 69.6, '2024-06-01 17:30:00', 2, 1),
(209, 16.7, 71.0, '2024-06-01 18:30:00', 2, 1),
(210, 17.8, 72.4, '2024-06-01 19:30:00', 2, 1),
(211, 18.9, 73.8, '2024-06-01 20:30:00', 2, 1),
(212, 20.0, 75.2, '2024-06-01 21:30:00', 2, 1),
(213, 14.6, 76.6, '2024-06-01 22:30:00', 2, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(301, 15.0, 60.1, '2024-06-01 10:00:00', 3, 1),
(302, 16.2, 61.5, '2024-06-01 11:00:00', 3, 1),
(303, 17.4, 62.9, '2024-06-01 12:00:00', 3, 1),
(304, 18.6, 64.3, '2024-06-01 13:00:00', 3, 1),
(305, 19.8, 65.7, '2024-06-01 14:00:00', 3, 1),
(306, 14.9, 67.1, '2024-06-01 15:00:00', 3, 1),
(307, 16.1, 68.5, '2024-06-01 16:00:00', 3, 1),
(308, 17.3, 69.9, '2024-06-01 17:00:00', 3, 1),
(309, 18.5, 71.3, '2024-06-01 18:00:00', 3, 1),
(310, 19.7, 72.7, '2024-06-01 19:00:00', 3, 1),
(311, 15.2, 74.1, '2024-06-01 20:00:00', 3, 1),
(312, 16.4, 75.5, '2024-06-01 21:00:00', 3, 1),
(313, 17.6, 76.9, '2024-06-01 22:00:00', 3, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(401, 14.6, 59.2, '2024-06-01 10:30:00', 4, 1),
(402, 15.8, 60.6, '2024-06-01 11:30:00', 4, 1),
(403, 17.0, 62.0, '2024-06-01 12:30:00', 4, 1),
(404, 18.2, 63.4, '2024-06-01 13:30:00', 4, 1),
(405, 19.4, 64.8, '2024-06-01 14:30:00', 4, 1),
(406, 20.6, 66.2, '2024-06-01 15:30:00', 4, 1),
(407, 14.8, 67.6, '2024-06-01 16:30:00', 4, 1),
(408, 16.0, 69.0, '2024-06-01 17:30:00', 4, 1),
(409, 17.2, 70.4, '2024-06-01 18:30:00', 4, 1),
(410, 18.4, 71.8, '2024-06-01 19:30:00', 4, 1),
(411, 19.6, 73.2, '2024-06-01 20:30:00', 4, 1),
(412, 14.7, 74.6, '2024-06-01 21:30:00', 4, 1),
(413, 15.9, 76.0, '2024-06-01 22:30:00', 4, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(515, 21.1, 82.0, '2024-06-01 23:59:00', 5, 1),
(516, 25.1, 83.0, '2024-06-01 23:59:01', 5, 1);

UPDATE dadosCaptados SET horarioData = '2024-06-01 23:00:00' WHERE idDados = 514;

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(501, 15.4, 60.5, '2024-06-01 10:00:00', 5, 1),
(502, 16.6, 62.0, '2024-06-01 11:00:00', 5, 1),
(503, 17.8, 63.5, '2024-06-01 12:00:00', 5, 1),
(504, 19.0, 65.0, '2024-06-01 13:00:00', 5, 1),
(505, 14.9, 66.5, '2024-06-01 14:00:00', 5, 1),
(506, 16.1, 68.0, '2024-06-01 15:00:00', 5, 1),
(507, 17.3, 69.5, '2024-06-01 16:00:00', 5, 1),
(508, 18.5, 71.0, '2024-06-01 17:00:00', 5, 1),
(509, 19.7, 72.5, '2024-06-01 18:00:00', 5, 1),
(510, 14.7, 74.0, '2024-06-01 19:00:00', 5, 1),
(511, 15.9, 75.5, '2024-06-01 20:00:00', 5, 1),
(512, 17.1, 77.0, '2024-06-01 21:00:00', 5, 1),
(513, 18.3, 78.5, '2024-06-01 22:00:00', 5, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(601, 15.2, 60.4, '2024-06-01 10:30:00', 6, 1),
(602, 16.4, 61.8, '2024-06-01 11:30:00', 6, 1),
(603, 17.6, 63.2, '2024-06-01 12:30:00', 6, 1),
(604, 18.8, 64.6, '2024-06-01 13:30:00', 6, 1),
(605, 20.0, 66.0, '2024-06-01 14:30:00', 6, 1),
(606, 14.9, 67.4, '2024-06-01 15:30:00', 6, 1),
(607, 16.1, 68.8, '2024-06-01 16:30:00', 6, 1),
(608, 17.3, 70.2, '2024-06-01 17:30:00', 6, 1),
(609, 18.5, 71.6, '2024-06-01 18:30:00', 6, 1),
(610, 19.7, 73.0, '2024-06-01 19:30:00', 6, 1),
(611, 14.8, 74.4, '2024-06-01 20:30:00', 6, 1),
(612, 16.0, 75.8, '2024-06-01 21:30:00', 6, 1),
(613, 17.2, 77.2, '2024-06-01 22:30:00', 6, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(701, 15.3, 60.3, '2024-06-01 10:00:00', 7, 1),
(702, 16.5, 61.7, '2024-06-01 11:00:00', 7, 1),
(703, 17.7, 63.1, '2024-06-01 12:00:00', 7, 1),
(704, 18.9, 64.5, '2024-06-01 13:00:00', 7, 1),
(705, 14.8, 65.9, '2024-06-01 14:00:00', 7, 1),
(706, 16.0, 67.3, '2024-06-01 15:00:00', 7, 1),
(707, 17.2, 68.7, '2024-06-01 16:00:00', 7, 1),
(708, 18.4, 70.1, '2024-06-01 17:00:00', 7, 1),
(709, 19.6, 71.5, '2024-06-01 18:00:00', 7, 1),
(710, 14.9, 72.9, '2024-06-01 19:00:00', 7, 1),
(711, 16.1, 74.3, '2024-06-01 20:00:00', 7, 1),
(712, 17.3, 75.7, '2024-06-01 21:00:00', 7, 1),
(713, 18.5, 77.1, '2024-06-01 22:00:00', 7, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(801, 15.1, 60.6, '2024-06-01 10:30:00', 8, 1),
(802, 16.3, 62.0, '2024-06-01 11:30:00', 8, 1),
(803, 17.5, 63.4, '2024-06-01 12:30:00', 8, 1),
(804, 18.7, 64.8, '2024-06-01 13:30:00', 8, 1),
(805, 14.9, 66.2, '2024-06-01 14:30:00', 8, 1),
(806, 16.1, 67.6, '2024-06-01 15:30:00', 8, 1),
(807, 17.3, 69.0, '2024-06-01 16:30:00', 8, 1),
(808, 18.5, 70.4, '2024-06-01 17:30:00', 8, 1),
(809, 19.7, 71.8, '2024-06-01 18:30:00', 8, 1),
(810, 14.8, 73.2, '2024-06-01 19:30:00', 8, 1),
(811, 16.0, 74.6, '2024-06-01 20:30:00', 8, 1),
(812, 17.2, 76.0, '2024-06-01 21:30:00', 8, 1),
(813, 18.4, 77.4, '2024-06-01 22:30:00', 8, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(901, 15.4, 60.0, '2024-06-01 09:00:00', 9, 1),
(902, 16.8, 61.5, '2024-06-01 10:00:00', 9, 1),
(903, 17.3, 62.9, '2024-06-01 11:00:00', 9, 1),
(904, 18.0, 64.3, '2024-06-01 12:00:00', 9, 1),
(905, 19.2, 65.8, '2024-06-01 13:00:00', 9, 1),
(906, 20.1, 67.2, '2024-06-01 14:00:00', 9, 1),
(907, 21.0, 68.6, '2024-06-01 15:00:00', 9, 1),
(908, 14.5, 70.0, '2024-06-01 16:00:00', 9, 1),
(909, 15.9, 71.4, '2024-06-01 17:00:00', 9, 1),
(910, 17.4, 72.8, '2024-06-01 18:00:00', 9, 1),
(911, 18.6, 74.2, '2024-06-01 19:00:00', 9, 1),
(912, 19.8, 75.6, '2024-06-01 20:00:00', 9, 1),
(913, 20.7, 77.0, '2024-06-01 21:00:00', 9, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(1001, 14.9, 58.4, '2024-06-01 09:30:00', 10, 1),
(1002, 15.8, 59.8, '2024-06-01 10:30:00', 10, 1),
(1003, 16.7, 61.2, '2024-06-01 11:30:00', 10, 1),
(1004, 17.5, 62.6, '2024-06-01 12:30:00', 10, 1),
(1005, 18.9, 64.0, '2024-06-01 13:30:00', 10, 1),
(1006, 19.3, 65.4, '2024-06-01 14:30:00', 10, 1),
(1007, 20.5, 66.8, '2024-06-01 15:30:00', 10, 1),
(1008, 21.0, 68.2, '2024-06-01 16:30:00', 10, 1),
(1009, 14.3, 69.6, '2024-06-01 17:30:00', 10, 1),
(1010, 15.4, 71.0, '2024-06-01 18:30:00', 10, 1),
(1011, 16.6, 72.4, '2024-06-01 19:30:00', 10, 1),
(1012, 18.1, 73.8, '2024-06-01 20:30:00', 10, 1),
(1013, 19.4, 75.2, '2024-06-01 21:30:00', 10, 1);

INSERT INTO dadosCaptados (idDados, temperaturaAmbiente, umidadeAmbiente, horarioData, fkSensor, fkParametros) VALUES
(1101, 14.5, 59.1, '2024-06-01 10:00:00', 11, 1),
(1102, 15.2, 60.6, '2024-06-01 11:00:00', 11, 1),
(1103, 16.1, 62.0, '2024-06-01 12:00:00', 11, 1),
(1104, 17.3, 63.4, '2024-06-01 13:00:00', 11, 1),
(1105, 18.0, 64.9, '2024-06-01 14:00:00', 11, 1),
(1106, 19.2, 66.3, '2024-06-01 15:00:00', 11, 1),
(1107, 20.0, 67.7, '2024-06-01 16:00:00', 11, 1),
(1108, 21.0, 69.2, '2024-06-01 17:00:00', 11, 1),
(1109, 14.6, 70.6, '2024-06-01 18:00:00', 11, 1),
(1110, 15.9, 72.0, '2024-06-01 19:00:00', 11, 1),
(1111, 17.1, 73.4, '2024-06-01 20:00:00', 11, 1),
(1112, 18.4, 74.8, '2024-06-01 21:00:00', 11, 1),
(1113, 19.6, 76.2, '2024-06-01 22:00:00', 11, 1);

SELECT * FROM Sensor;

SELECT umidadeAmbiente AS 'umidadeHoras', horarioData AS 'HoraTemp'
FROM dadosCaptados
WHERE fkSensor = 5
ORDER BY horarioData DESC
LIMIT 12;

SELECT temperaturaAmbiente AS 'temperaturaAtual'
FROM dadosCaptados
WHERE fkSensor = 5
ORDER BY horarioData DESC
LIMIT 1;

SELECT umidadeAmbiente
FROM dadosCaptados
WHERE fkSensor = 5
ORDER BY horarioData DESC
LIMIT 12;

SELECT umidadeAmbiente AS 'umidadeAtual'
FROM dadosCaptados
WHERE fkSensor = 5
ORDER BY horarioData DESC
LIMIT 1;

SELECT COUNT(*) AS numBarrisNull
FROM (
    SELECT fkSensor
    FROM dadosCaptados
    WHERE temperaturaAmbiente IS NULL OR umidadeAmbiente IS NULL
    GROUP BY fkSensor
) AS barrisNull;

SELECT COUNT(*) AS UmidadeBaixa
FROM (
    SELECT fkSensor, umidadeAmbiente
    FROM dadosCaptados
    WHERE (fkSensor, horarioData) IN (
        SELECT fkSensor, MAX(horarioData)
        FROM dadosCaptados
        GROUP BY fkSensor
    )
    AND umidadeAmbiente < 60
) AS barrisUmidadeAlta;
