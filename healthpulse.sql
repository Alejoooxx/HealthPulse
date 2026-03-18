CREATE TABLE pacientes (
  id SERIAL,
  cedula VARCHAR(20),
  nombre_completo VARCHAR(100),
  fecha_nacimiento DATE,
  tipo_sangre VARCHAR(5),
  
  CONSTRAINT pk_pacientes PRIMARY KEY (ID),
  CONSTRAINT uq_pacientes_cedula UNIQUE(cedula)
  );
  
  CREATE TABLE personal_medico (
    id SERIAL,
    nombre VARCHAR(100),
    tarjeta_profesional VARCHAR(50),
    especialidad VARCHAR(100),

    CONSTRAINT pk_medico PRIMARY KEY (id),
    CONSTRAINT uq_tarjeta_profesional UNIQUE (tarjeta_profesional)
);

CREATE TABLE citas_medicas (
    id SERIAL,
    paciente_id INTEGER,
    medico_id INTEGER,
    fecha_hora TIMESTAMP,
    motivo VARCHAR(500),

    CONSTRAINT pk_citas PRIMARY KEY (id),

    CONSTRAINT fk_citas_paciente
        FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_citas_medico
        FOREIGN KEY (medico_id)
        REFERENCES personal_medico(id)
        ON DELETE SET NULL
);

CREATE TABLE historias_clinicas (
    id SERIAL,
    cita_id INTEGER,
    diagnostico VARCHAR(500),
    tratamiento VARCHAR(500),

    CONSTRAINT pk_historia PRIMARY KEY (id),

    CONSTRAINT fk_historia_cita
        FOREIGN KEY (cita_id)
        REFERENCES citas_medicas(id)
        ON DELETE RESTRICT
);

CREATE TABLE signos_vitales (
    id SERIAL,
    paciente_id INTEGER,
    frecuencia_cardiaca INTEGER,
    temperatura DECIMAL(4,2),
    fecha_hora TIMESTAMP,

    CONSTRAINT pk_signos PRIMARY KEY (id),

    CONSTRAINT fk_signos_paciente
        FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id)
        ON DELETE RESTRICT
);
