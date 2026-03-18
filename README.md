# Diseño e Implementación de Infraestructura de Datos para HealthPulse

## Descripción
Este repositorio contiene el desarrollo del taller enfocado en el diseño e implementación de una **infraestructura de datos modular, cohesiva y con acoplamiento controlado** para un entorno de salud.  

El caso de estudio corresponde a la red de clínicas **HealthPulse**, la cual necesita modernizar su sistema de gestión para mejorar el seguimiento de pacientes, la programación de citas médicas y el almacenamiento histórico de signos vitales mediante telemetría médica.

El trabajo se desarrolló en tres fases:

- **Fase 1:** Modelado arquitectónico en **DBML** usando **dbdiagram.io**
- **Fase 2:** Implementación del modelo relacional en **PostgreSQL (DDL)** usando **SQLiteOnline**
- **Fase 3:** Reflexión arquitectónica sobre **modularidad, acoplamiento y cohesión**

---

## Objetivo del Taller
Diseñar e implementar una base de datos que permita gestionar la información clínica de manera organizada, auditable y escalable, aplicando principios de arquitectura de software como:

- **Alta cohesión**
- **Bajo acoplamiento**
- **Integridad referencial**
- **Separación clara de responsabilidades entre módulos**

---

## Contexto del Negocio
La red de clínicas **HealthPulse** requiere un sistema que permita administrar:

- Pacientes
- Personal médico
- Citas médicas
- Historias clínicas
- Monitoreo de signos vitales

El reto principal consiste en construir una estructura de datos donde cada módulo esté bien definido y no se mezcle innecesariamente con otros, facilitando así su mantenimiento, auditoría y futura escalabilidad.

---

## Requerimientos Funcionales

### 1. Pacientes
Se debe registrar la siguiente información:
- Cédula única
- Nombre completo
- Fecha de nacimiento
- Tipo de sangre

### 2. Personal Médico
Se debe registrar:
- Nombre completo
- Tarjeta profesional única
- Especialidad médica

### 3. Citas Médicas
Cada cita debe vincular:
- Un paciente
- Un médico
- Fecha y hora de atención
- Motivo de consulta

### 4. Historias Clínicas
Cada cita debe generar una entrada en la historia clínica con:
- Diagnóstico
- Tratamiento formulado

### 5. Monitoreo de Signos Vitales
Se debe registrar de forma automática:
- Frecuencia cardíaca
- Temperatura
- Fecha y hora de lectura
- Paciente relacionado

---

## Herramientas Utilizadas

- [dbdiagram.io](https://dbdiagram.io/)  
  Para el modelado conceptual y lógico en DBML.

- [SQLiteOnline](https://sqliteonline.com/)  
  Para la implementación y prueba del script DDL utilizando el motor PostgreSQL.

- **GitHub**  
  Para documentar, versionar y entregar el desarrollo del taller.


## Fase 3

## ¿qué tan fácil es separarlo del resto de la base de datos según su diseño?
- Dependeria de como se estructure la tabla, si esta es diseñada netamente para depender una llave foranea (id_paciente), la separación seria trivial, es decir que es de bajo acomplamiento.

## ¿Qué tabla es el "punto central" del sistema? ¿Qué pasaría si esa tabla sufre un cambio estructural profundo?
- El punto central es la tabla "Citas_medicas", esto se deba a que es quien vincula al paciente con el medico y es el origen de la creación de la historia clinica.
- Tendrian que cambiarse demasiadas cosas dentro de la tabla. Si tomamos como ejemplo que una cita puede ser tomada por varios doctores, se romperia la cardinalidad actual y habria que refactorizar llaves foraneas.

## ¿Por qué es un error de diseño poner el diagnóstico médico directamente en la tabla de la Cita Médica en lugar de una tabla de Historia Clínica?
- Por que se estaría violando el principio de alta cohesión. Esto se debe a que una entidad debe de tener una única responsabilidad. Hay que tener en cuenta que ambos tienen funciones diferentes:
- Una cita media es un evento administrativo (motivo de consulta), mientras que una historia media es un registro medico que evoluciona (diagnostico y tratamiento).
- Si se mezcla ambas tablas, abría una tabla con baja cohesión.

---
