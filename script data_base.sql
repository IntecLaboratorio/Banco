CREATE DATABASE tcc;

USE tcc;


-- tabela de endereço -- 
CREATE TABLE address_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  type_address VARCHAR(10) NOT NULL,
  address VARCHAR(255) NOT NULL,
  number_address INT NOT NULL,
  complement VARCHAR(100) NULL,
  neighborhood VARCHAR(45) NOT NULL,
  city VARCHAR(45) NOT NULL,
  state CHAR(2) NOT NULL,
  zip_code VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`)
  );


-- tabela de instituição --
CREATE TABLE Instruction_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_address INT NOT NULL,
  corporate_name VARCHAR(45) NOT NULL UNIQUE,
  cnpj VARCHAR(19) NOT NULL UNIQUE,
  phone VARCHAR(45) NOT NULL UNIQUE,
  email VARCHAR(45) NOT NULL UNIQUE,
  responsable VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_instruction_tbl_address_tbl
    FOREIGN KEY (`fk_address`)
    REFERENCES address_tbl (`id`)
);


-- tabela de usuários -- 
CREATE TABLE users_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_id_corporate INT NOT NULL,
  fk_address INT NOT NULL,
  name_user VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  cpf VARCHAR(15) NOT NULL UNIQUE,
  rg VARCHAR(12) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(45) NOT NULL UNIQUE,
  senha VARCHAR(45) NOT NULL,
  verify TINYINT NULL,
  
  PRIMARY KEY (id),
  CONSTRAINT fk_id_corporate
    FOREIGN KEY (fk_id_corporate)
    REFERENCES instruction_tbl(id),
  
  CONSTRAINT fk_users_tbl_address_tbl
    FOREIGN KEY (fk_address)
    REFERENCES address_tbl (id)
);


-- tabela de funcionários -- 
CREATE TABLE employee_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_user INT NOT NULL,
  employee_role VARCHAR(45) NOT NULL,
  rm VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  
  CONSTRAINT fk_teachers_tbl_users_tbl
    FOREIGN KEY (`fk_user`)
    REFERENCES users_tbl (`id`)
);


-- tabela de  laboratórios --
CREATE TABLE Labs_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_instruction INT NOT NULL,
  name_lab VARCHAR(45) NOT NULL,
  room_index VARCHAR(100) NOT NULL,
  floor_lab VARCHAR(45) NOT NULL,
  
  PRIMARY KEY (`id`),
  CONSTRAINT fk_Labs_tbl_Instituicao_tbl
    FOREIGN KEY (`fk_instruction`)
    REFERENCES Instruction_tbl (`id`)
);


-- tabela de patrimonios -- 
CREATE TABLE FixedAssent_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  assent_number VARCHAR(6) NULL,
  serial_number VARCHAR(50) NOT NULL,
  assent_name VARCHAR(45) NOT NULL,
  brand VARCHAR(45) NOT NULL,
  model VARCHAR(45) NOT NULL,
  product_batch VARCHAR(6) NULL,
  tax_invoice VARCHAR(6) NULL,
  complement TEXT NULL,
  value_assent DECIMAL(10,2) NULL,
  verify TINYINT NOT NULL,
  color VARCHAR(45) NOT NULL,
  fk_labs INT NOT NULL,
  
  PRIMARY KEY (`id`),
  
  CONSTRAINT fk_FixedAssent_tbl_Labs_tbl
    FOREIGN KEY (`fk_labs`)
    REFERENCES Labs_tbl (`id`)
);


-- tabela de patrimonios nos laboratórios --
CREATE TABLE labs_FixedAssent_tbl (
  fk_labs INT NOT NULL,
  fk_fixed_assent INT NOT NULL,
  
  PRIMARY KEY (fk_labs, fk_fixed_assent),
  
  CONSTRAINT fk_labs_has_patrimonios_tbl #maybe it has to use _lab
		FOREIGN KEY (fk_labs)
		REFERENCES labs_tbl (id),
    
	CONSTRAINT fk_Labs_has_Patrimonios_tbl_Patrimonios_tbl
		FOREIGN KEY (fk_fixed_assent)
		REFERENCES fixedAssent_tbl (id)
);


-- tabela do eixo educacional -- 
CREATE TABLE educationHub_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  type_hub VARCHAR(80) NOT NULL,
  PRIMARY KEY (id)
);


-- tabelas dos cursos -- 
CREATE TABLE courses_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_instruction INT NOT NULL,
  fk_type_hub INT NOT NULL,
  name_course VARCHAR(45) NOT NULL,
  course_time VARCHAR(45) NOT NULL,
  initial_date DATE NOT NULL,
  final_date DATE NOT NULL,
  
  PRIMARY KEY (id),
  
  CONSTRAINT fk_Cursos_tbl_Instituicao_tbl
    FOREIGN KEY (fk_instruction)
    REFERENCES instruction_tbl (id),
    
  CONSTRAINT fk_Courses_tbl_EixoTecnologico_tbl
    FOREIGN KEY (fk_type_hub)
    REFERENCES educationHub_tbl (id)
);


-- tabela das disciplinas escolares --
CREATE TABLE schoolSubject_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  name_school_subjetc VARCHAR(45) NOT NULL,
  abbreviation VARCHAR(5) NOT NULL,
  SchoolModule INT NOT NULL,
  PRIMARY KEY (id)
);


-- tabela de alunos -- 
CREATE TABLE students_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_user INT NOT NULL,
  rm INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_alunos_tbl_usuarios_tbl
    FOREIGN KEY (fk_user)
    REFERENCES users_tbl (id)
);



-- tabela de agendamento de laboratório -- 
CREATE TABLE labsRequirement_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_teacher INT NOT NULL,
  fk_labs INT NOT NULL,
  fk_discipline INT NOT NULL,
  date_required DATE NOT NULL,
  inital_time VARCHAR(45) NOT NULL,
  final_time VARCHAR(45) NOT NULL,
  
  PRIMARY KEY (id),
  CONSTRAINT fk_labsRequirement_tbl_teachers_tbl
    FOREIGN KEY (fk_teacher)
    REFERENCES employee_tbl (id),
    
  CONSTRAINT fk_labsRequirement_tbl_Labs_tbl
    FOREIGN KEY (fk_labs)
    REFERENCES labs_tbl (id),
    
  CONSTRAINT fk_labsRequirement_tbl_schoolSubject_tbl
    FOREIGN KEY (fk_discipline)
    REFERENCES schoolSubject_tbl (id)
);


-- tabela de reserva da quadra -- 
CREATE TABLE appointmentSquare_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  date_required VARCHAR(45) NOT NULL,
  inital_time VARCHAR(45) NOT NULL,
  final_time VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);


-- tabela de alunos tem agendamento de quarda --
CREATE TABLE studentsHasAppoitmentSquare_tbl(
  fk_student INT NOT NULL,
  fk_scheduling INT NOT NULL,
  status TINYINT NOT NULL,
  
  PRIMARY KEY (fk_student, fk_scheduling),
  
  CONSTRAINT fk_students_tbl_has_appoinmentSquare_tbl_students_tbl
    FOREIGN KEY (fk_student)
    REFERENCES students_tbl (id),
  
  CONSTRAINT fk_students_tbl_has_appoinmentSquare_tbl #maybe I need to use this_AgendamentosQuadra_t1
    FOREIGN KEY (fk_scheduling)
    REFERENCES appointmentSquare_tbl (id)
    );



-- tabela de professores tem agendamento de quadra --
CREATE TABLE teacherHasAppoinmetSquare_tbl (
  fk_teachers INT NOT NULL,
  fk_scheduling INT NOT NULL,
  status VARCHAR(45) NULL,
  
  PRIMARY KEY (fk_teachers, fk_scheduling),
  
  CONSTRAINT fk_teachers_tbl_has_AppoinmetSquare_tbl_teachers_tbl
    FOREIGN KEY (fk_teachers)
    REFERENCES employee_tbl (id),
 
 CONSTRAINT fk_teacher_tbl_has_appoinmetSquare_tbl #_AgendamentosQua
    FOREIGN KEY (fk_scheduling)
    REFERENCES appointmentSquare_tbl (id)
    );


-- tabela solicitação de armário escolar -- 
CREATE TABLE requirementSchoolLocker_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  fk_id_user INT NOT NULL,
  required_date DATE NOT NULL,
  status TINYINT NOT NULL,
  inital_date DATE NOT NULL,
  devolution_date DATE NOT NULL,
  school_locker_num INT NOT NULL,
  value DECIMAL NOT NULL,

  PRIMARY KEY (id),

  CONSTRAINT fk_requirementSchoolLocker_tbl_users_tbl
    FOREIGN KEY (fk_id_user)
    REFERENCES users_tbl (id)
    );


-- Tabela de solicitação de manutenção --
CREATE TABLE maintananceRequerement_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  requerement_date DATE NOT NULL,
  observation TEXT NOT NULL,
  fk_fixed_assent INT NOT NULL,
  fk_teacher INT NOT NULL,
  
  PRIMARY KEY (id),
  
  CONSTRAINT fk_maintananceRequerement_tbl_assent_tbl
    FOREIGN KEY (fk_fixed_assent)
    REFERENCES fixedAssent_tbl (id),
    
  CONSTRAINT fk_maintananceRequerement_tbl_teachers_tbl
    FOREIGN KEY (fk_teacher)
    REFERENCES employee_tbl (id)
);


-- tabela de histórico de manuetenção --
CREATE TABLE maintananceSchedule_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  description TEXT NOT NULL,
  fk_requered INT NOT NULL,
  fk_responsable INT NOT NULL,
  
  PRIMARY KEY (`id`),
  
  CONSTRAINT fk_maintananceSchedule_tbl_maintananceRequerement_tbl
    FOREIGN KEY (fk_requered)
    REFERENCES maintananceRequerement_tbl (id),
    
  CONSTRAINT fk_maintananceSchedule_tbl_teachers_tbl
    FOREIGN KEY (fk_responsable)
    REFERENCES employee_tbl (id)
);


-- tabela de estoque --
CREATE TABLE stock_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  address VARCHAR(45) NOT NULL UNIQUE DEFAULT 'area do estoque',
  fk_responsable INT NOT NULL,
  
  PRIMARY KEY (id),
  
  CONSTRAINT fk_stock_tbl_users_tbl
    FOREIGN KEY (fk_responsable)
    REFERENCES users_tbl (id)
);


-- tabela de professores e disciplinas -- 
CREATE TABLE teachersHasDisciplene_tbl (
  fk_teacher INT NOT NULL,
  fk_school_subject INT NOT NULL,
  
  PRIMARY KEY (fk_teacher, fk_school_subject),
  
  CONSTRAINT fk_teachers_tbl_has_disciplane_tbl_teachers_tbl
    FOREIGN KEY (fk_teacher)
    REFERENCES employee_tbl (id),
    
  CONSTRAINT fk_teachers_tbl_has_disciplane_tbl_disciplane_tbl
    FOREIGN KEY (fk_school_subject)
    REFERENCES schoolSubject_tbl (id)
);


-- tabela de itens  -- 
CREATE TABLE Itens_tbl (
  id INT NOT NULL AUTO_INCREMENT,
  serial_number VARCHAR(20) NOT NULL UNIQUE,
  product_batch INT NOT NULL,
  name_item VARCHAR(45) NOT NULL,
  brand VARCHAR(45) NOT NULL,
  model VARCHAR(45) NOT NULL,
  description TEXT NOT NULL,
  
  PRIMARY KEY (id)
);




-- tabela itens em estoque --  
CREATE TABLE itensInStock_tbl (
  fk_address_stock INT NOT NULL,
  fk_item INT NOT NULL,
  amount INT NOT NULL,
  
  PRIMARY KEY (fk_address_stock, fk_item),
  
  CONSTRAINT fk_stock_tbl_has_ItensInStock_tbl_stock_tbl
    FOREIGN KEY (fk_address_stock)
    REFERENCES stock_tbl (id),
    
  CONSTRAINT fk_stock_tbl_has_ItensInStock_tbl_ItensInStock_tbl
    FOREIGN KEY (fk_item)
    REFERENCES Itens_tbl (id)
);



-- tabela de historico de manutenção dos itens -- 
CREATE TABLE itensHasMaintananceSchedule_tbl (
  fk_item INT NOT NULL,
  fk_schedule INT NOT NULL,
  
  PRIMARY KEY (fk_item, fk_schedule),
  
  CONSTRAINT fk_itensInStock_tbl_has_maintananceSchedule_tbl
    FOREIGN KEY (fk_item)
    REFERENCES Itens_tbl (id),
    
  -- CONSTRAINT fk_itensInStock_tbl_has_maintananceSchedule_tbl
    FOREIGN KEY (fk_schedule)
    REFERENCES maintananceSchedule_tbl (id)
);


-- tabela de estoque de patrimonios -- 
CREATE TABLE assentInStock_tbl (
  fk_stock_id INT NOT NULL,
  fk_assent_id INT NOT NULL,
  
  PRIMARY KEY (fk_stock_id, fk_assent_id),
  
  CONSTRAINT fk_stock_tbl_has_assent_tbl_stock_tbl
    FOREIGN KEY (fk_stock_id)
    REFERENCES stock_tbl (id),
    
  CONSTRAINT fk_stock_tbl_has_assent_tbl_assent_tbl
    FOREIGN KEY (fk_assent_id)
    REFERENCES fixedAssent_tbl (id)
);


-- tabela de alunos tem cursos --
CREATE TABLE studentsHasCourses_tbl (
  fk_students INT NOT NULL,
  fk_courses INT NOT NULL,
  
  PRIMARY KEY (fk_students, fk_courses),

	CONSTRAINT fk_Students_tbl_has_Courses_tbl_Students_tbl
		FOREIGN KEY (fk_students)
		REFERENCES students_tbl (id),
        
  CONSTRAINT fk_Students_tbl_has_Courses_tbl_Courses_tbl
    FOREIGN KEY (fk_courses)
    REFERENCES courses_tbl (id)
);


-- tabela de curso e disciplina escolar -- 
CREATE TABLE coursesHasSchoolSubjetc_tbl (
  fk_courses INT NOT NULL,
  fk_discipline INT NOT NULL,
  
  PRIMARY KEY (fk_courses, fk_discipline),
  
  CONSTRAINT fk_Courses_tbl_has_Discipline_tbl_Courses_tbl
    FOREIGN KEY (fk_courses)
    REFERENCES courses_tbl (id),
    
  CONSTRAINT fk_Courses_tbl_has_Discipline_tbl_Discipline_tbl
    FOREIGN KEY (fk_discipline)
    REFERENCES schoolSubject_tbl (id)
);


-- tabela de eixo educacional e instituição -- 
CREATE TABLE educationHubHasInstruction_tbl (
  fk_fixed_assent INT NOT NULL,
  fk_instruction INT NOT NULL,
  
  PRIMARY KEY (fk_fixed_assent, fk_instruction),
  
  CONSTRAINT fk_EixoTecnologico_tbl_has_Instruction_tbl_EixoTecnologico_tbl
    FOREIGN KEY (fk_fixed_assent)
    REFERENCES educationHub_tbl (id),
    
  CONSTRAINT fk_EixoTecnologico_tbl_has_Instruction_tbl_Instruction_tbl
    FOREIGN KEY (fk_instruction)
    REFERENCES instruction_tbl (id)
);