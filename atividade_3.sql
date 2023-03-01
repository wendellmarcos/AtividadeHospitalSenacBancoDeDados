CREATE DATABASE atividade_3;

use atividade_3;

CREATE TABLE medico(
	
	idMedico INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(65) NOT NULL,
	endereco VARCHAR(65) NOT NULL,
	uf char(2) NOT NULL,
	telefone VARCHAR(20) NOT NULL,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	crm VARCHAR(45) NOT NULL UNIQUE,
	idPacientesMedico INT,
	
	FOREIGN KEY (idPacientesMedico) REFERENCES medico(idMedico) ON UPDATE CASCADE ON DELETE CASCADE

);

create TABLE pacientes(

	idPacientes INT PRIMARY KEY  AUTO_INCREMENT ,
	nome VARCHAR(65),
	endereco VARCHAR(65),
	cpf VARCHAR(14) UNIQUE,
	rg VARCHAR (14),
	telefone VARCHAR(45),
	dataNascimento date,
	email VARCHAR(45)UNIQUE,
	idMedicoPacientes INT,
	idConvenioPacientes INT NULL,
	FOREIGN KEY (idMedicoPacientes) REFERENCES medico(idMedico)
	ON UPDATE CASCADE ON DELETE CASCADE,
	
	FOREIGN KEY (idConvenioPacientes) REFERENCES convenio(idConvenio)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE convenio(
	idConvenio INT AUTO_INCREMENT PRIMARY KEY,
	numeroDaCarteira VARCHAR(45) UNIQUE,
	nome VARCHAR(65) NOT NULL,
	cnpj VARCHAR(25) UNIQUE,
	tempoDeCarencia DATE

);

CREATE TABLE receita(
	
	idReceita INT AUTO_INCREMENT PRIMARY KEY,
	medicamentoReceitado VARCHAR(45) NOT NULL,
	instrucoesDeUso LONGTEXT NOT NULL,
	idConsultaReceita INT,
	FOREIGN KEY (idConsultaReceita)REFERENCES consulta(idConsulta) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE especialidade(
	idEspecialidade INT AUTO_INCREMENT PRIMARY KEY,
	especialidadeMedica varchar(45),
	idEspecialidadeAreaDeAtuacao INT,
	FOREIGN KEY (idEspecialidadeAreaDeAtuacao) references area_de_atuacao(idAreaDeAtuacao)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE consulta(
	idConsulta INT AUTO_INCREMENT PRIMARY KEY,
	dataHora DATETIME NOT NULL,
	valor DOUBLE,
	idPacientesConsulta INT,
	idMedicoConsulta INT,
	idConvenioConsulta INT,	
	FOREIGN KEY (idConvenioConsulta) REFERENCES convenio(idConvenio) ON DELETE SET NULL,
	FOREIGN KEY (idPacientesConsulta) REFERENCES pacientes(idPacientes) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idMedicoConsulta)REFERENCES medico(idMedico) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE quarto(
	idQuarto INT AUTO_INCREMENT PRIMARY KEY,
	numero VARCHAR(3) NOT NULL,
	tipo VARCHAR(45) NOT NULL,
	idTipoDeQuarto INT,
	FOREIGN KEY (idTipoDeQuarto) REFERENCES tipo_de_quarto(idTipoDeQuarto)
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tipo_de_quarto(

	idTipoDeQuarto INT AUTO_INCREMENT PRIMARY KEY,
	numero INT UNIQUE,
	descricao longtext NOT NULL
);

CREATE TABLE area_de_atuacao(
	idAreaDeAtuacao INT AUTO_INCREMENT PRIMARY KEY ,
	areaDeAtuacao VARCHAR(30) NOT NULL,
	idMedico_area_atuacao INT,
	
	FOREIGN KEY (idMedico_area_atuacao) REFERENCES medico(idMedico) 
	ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE enfermeiro(
	idEnfermeiro INT AUTO_INCREMENT PRIMARY KEY, 
	nome VARCHAR(45) NOT NULL,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	cre varchar(45) NOT NULL UNIQUE,
	procedimento LONGTEXT NOT NULL
);

CREATE TABLE internacao(
	idInternacao INT AUTO_INCREMENT PRIMARY KEY,
	dataEntrada datetime NOT NULL,
	dataPrevAlta datetime NOT NULL,
	dataAlta datetime NOT NULL,
	descricao longtext NOT NULL,
	idQuartoInternacao INT,
	idPacientesInternacao INT,
	idMedicoInternacao INT,
	FOREIGN KEY (idQuartoInternacao) REFERENCES quarto(idQuarto) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idPacientesInternacao) REFERENCES pacientes(idPacientes) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (idMedicoInternacao) REFERENCES medico(idMedico) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE internacao_enfermeiro(
	 idInternacaoEnfermeiro INT PRIMARY KEY AUTO_INCREMENT,
	 idEnfermeiroInternacao INT,
	 FOREIGN KEY (idInternacaoEnfermeiro) REFERENCES enfermeiro(idEnfermeiro)
	 ON UPDATE CASCADE ON DELETE CASCADE,
	 FOREIGN KEY (idEnfermeiroInternacao) REFERENCES internacao(idInternacao)
	 ON UPDATE CASCADE ON DELETE CASCADE
);

