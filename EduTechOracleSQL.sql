CREATE TABLESPACE tbEduTech
DATAFILE 'C:\Users\Usuario\Desktop\EduTechOracle\tnEduTech.dbf' SIZE 100M
AUTOEXTEND ON NEXT 10M MAXSIZE 1000M;
CREATE TABLE ESTUDIANTES (
 ID_ESTUDIANTE NUMBER PRIMARY KEY,
 NOMBRE VARCHAR2(100),
 APELLIDO VARCHAR2(100),
 EMAIL VARCHAR2(100) UNIQUE,
 FECHA_NACIMIENTO DATE
);
CREATE TABLE CURSOS (
 ID_CURSO NUMBER PRIMARY KEY,
 NOMBRE_CURSO VARCHAR2(100),
 DESCRIPCION VARCHAR2(255),
 DURACION NUMBER, -- Duración en horas
 PRECIO NUMBER(10, 2)
);
CREATE TABLE INSCRIPCIONES (
 ID_INSCRIPCION NUMBER PRIMARY KEY,
 ID_ESTUDIANTE NUMBER,
 ID_CURSO NUMBER,
 FECHA_INSCRIPCION DATE,
 CALIFICACION NUMBER,
 CONSTRAINT FK_ESTUDIANTE FOREIGN KEY (ID_ESTUDIANTE) REFERENCES
ESTUDIANTES(ID_ESTUDIANTE),
 CONSTRAINT FK_CURSO FOREIGN KEY (ID_CURSO) REFERENCES CURSOS(ID_CURSO)
);

-- Agregar una columna a ESTUDIANTES:
ALTER TABLE ESTUDIANTES ADD DIRECCION VARCHAR2(200);

-- Modificar el tipo de datos en CURSOS: 
ALTER TABLE CURSOS MODIFY DURACION NUMBER(5, 1);

-- Agregar una restricción NOT NULL a INSCRIPCIONES:
ALTER TABLE INSCRIPCIONES MODIFY FECHA_INSCRIPCION CONSTRAINT
NN_FECHA_INSCRIPCION NOT NULL;

-- Agregar una restricción UNIQUE a CURSOS:
ALTER TABLE CURSOS ADD CONSTRAINT UQ_NOMBRE_CURSO UNIQUE (NOMBRE_CURSO);

-- Agregar una restricción CHECK a ESTUDIANTES:
ALTER TABLE ESTUDIANTES ADD CONSTRAINT CK_FECHA_NACIMIENTO CHECK
(FECHA_NACIMIENTO <= DATE '2007-05-15');

-- V03
-- Modificar una clave foránea en INSCRIPCIONES:
ALTER TABLE INSCRIPCIONES ADD CONSTRAINT FK_ESTUDIANTE_2 FOREIGN KEY (ID_ESTUDIANTE) REFERENCES ESTUDIANTES (ID_ESTUDIANTE) ON UPDATE CASCADE;

-- Modificar una restricción existente en CURSOS:
ALTER TABLE CURSOS MODIFY PRECIO NUMBER(10, 2) CONSTRAINT CK_PRECIO CHECK
(PRECIO >= 0);

-- Eliminar una columna en ESTUDIANTES:
ALTER TABLE ESTUDIANTES DROP COLUMN FECHA_NACIMIENTO;

-- Cambiar el nombre de una columna en INSCRIPCIONES:
ALTER TABLE INSCRIPCIONES RENAME COLUMN CALIFICACION TO PUNTUACION;

-- Deshabilitar y habilitar una restricción en CURSOS:

ALTER TABLE CURSOS DISABLE CONSTRAINT UQ_NOMBRE_CURSO;
ALTER TABLE CURSOS ENABLE CONSTRAINT UQ_NOMBRE_CURSO;



