-- crear base de datos
CREATE DATABASE TP_2_BD;

-- crear tablas
CREATE TABLE departamento
(
	id int not null IDENTITY(1,1),
	descripcion varchar(30) not null,
	primary key(id)
);

CREATE TABLE superior
(
	id int not null IDENTITY(1,1),
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	primary key(id)
);

CREATE TABLE usuario
(
	legajo int not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	ubicacionFisica varchar(30) not null,
	idDepartamento int not null,
	idSuperior int not null,
	estado bit not null default 1,
	primary key(legajo),
	foreign key(idDepartamento) references departamento(id),
	foreign key(idSuperior) references superior(id)
);

CREATE TABLE sector
(
	id int not null IDENTITY(1,1),
	descripcion varchar(30) not null,
	primary key(id)
);

CREATE TABLE operador
(
	id int not null IDENTITY(1,1),
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	primary key(id)
);

CREATE TABLE estado
(
	id int not null IDENTITY(1,1),
	descripcion varchar(30) not null,
	primary key(id)
);

CREATE TABLE n2
(
	id int not null IDENTITY(1,1),
	descripcion varchar(30) not null,
	primary key(id)
);

CREATE TABLE n1
(
	id int not null IDENTITY(1,1),
	descripcion varchar(30) not null,
	idN2 int not null,
	primary key(id),
	foreign key(idN2) references n2(id)
);

CREATE TABLE derivacion
(
	nro int not null IDENTITY(1,1),
	idEstado int not null,
	idSectorOrigen int not null,
	idSectorDestino int not null,
	primary key(nro),
	foreign key(idEstado) references estado(id),
	foreign key(idSectorOrigen) references sector(id),
	foreign key(idSectorDestino) references sector(id),	
);

CREATE TABLE incidencia
(
	nro int not null IDENTITY(1,1),
	legajo int not null,
	idN1 int not null,
	aprobada bit not null default 0,
	fechaHora datetime not null,
	idEstadoActual int not null,
	idEstadoProximo int not null,
	primary key(nro),
	foreign key(legajo) references usuario(legajo),
	foreign key(idN1) references n1(id),
	foreign key(idEstadoActual) references estado(id),
	foreign key(idEstadoProximo) references estado(id)	
);

CREATE TABLE comentario
(
	nro int not null IDENTITY(1,1),
	fecha date not null,
	hora time not null,
	texto text not null,
	idOperador int null,
	nroIncidencia int not null,
	primary key(nro),
	foreign key(idOperador) references operador(id),
	foreign key(nroIncidencia) references incidencia(nro)
);

-- cargar registros
insert into departamento(descripcion) values
('Comunicación'),
('RRHH'),
('Comercio'),
('Finanzas'),
('Dirección'),
('Administración'),
('Gerencia'),
('Compras'),
('Producción'),
('Control de Gestión'),
('Ventas'),
('Marketing');

insert into superior(nombre, apellido) values
('Fabián','Escobar'),
('Pablo','López'),
('Gustavo','Ayvar'),
('Martín','Arcángeli'),
('Erik','Aguilera'),
('Juan','Milla'),
('David','López'),
('Pablo','Meme'),
('Marcos','Paz'),
('Ramón','Ramírez'),
('Lucas','Secchi');

insert into usuario(legajo, nombre, apellido, ubicacionFisica, idDepartamento, idSuperior) values
(1000, 'José', 'López', 'Merlo', 1, 1),
(1010, 'Cristina', 'Macri', 'Laferrere', 11, 2),
(1020, 'Lionel', 'Messi', 'Morón', 9, 3),
(1030, 'Roberto', 'Bolaño', 'Merlo', 2, 3),
(1040, 'Héctor', 'Diarralde', 'San Antonio de Padua', 2, 2),
(1050, 'Esther', 'Piscore', 'Merlo', 10, 9),
(1060, 'Luis', 'Alberto', 'Ituzaingó', 4, 5),
(1070, 'Dante', 'Spinetta', 'Castelar', 5, 3),
(1080, 'Romina', 'Martínez', 'San Justo', 6, 7),
(1090, 'Carolina', 'Reynoso', 'Once', 7, 7),
(1100, 'Agostina', 'Marina', 'Ramos Mejía', 3, 3),
(1110, 'Alberto', 'Fajín', 'Moreno', 8, 8),
(1120, 'Evelyn', 'Cardozo', 'Paso Del Rey', 4, 2),
(1130, 'Martina', 'Paso', 'San Justo', 2, 10),
(1140, 'Rubén', 'Amadeo', 'Tigre', 3, 1),
(1150, 'Lara', 'Scorzo', 'Caballito', 12, 1);

insert into sector(descripcion) values
('A'),
('B'),
('C'),
('D'),
('E'),
('F'),
('G'),
('H'),
('I'),
('Z');

insert into operador(nombre, apellido) values
('Leonardo','González'),
('Jéssica','Muñoz'),
('Agustín','Muñiz'),
('Valentina','Uriarte'),
('Nicolás','Matos'),
('Veronica','Galindo'),
('Rodrigo','Lussich'),
('Alberto','Catetas'),
('Tatiana','Robles'),
('Raúl','Romero'),
('Camila','Pingolo');

insert into estado(descripcion) values
('Recibido'),
('Atendido'),
('Procesado'),
('Suspendido'),
('Rechazado'),
('Cerrado');

insert into n2(descripcion) values
('Pantalla'),
('Teclado'),
('Monitor'),
('Tóner'),
('Cartucho'),
('Lectora'),
('Puerto'),
('Pila'),
('Pintura'),
('Respaldo'),
('Mouse');

insert into n1(descripcion,idN2) values
('Computadora de escritorio',1),
('Notebook',2),
('Silla',11),
('Impresora',4),
('Pared',10),
('Radio',8),
('Televisor',1),
('Computadora de escritorio',2),
('Notebook',2),
('Computadora de escritorio',3),
('Impresora',5),
('Computadora de escritorio',6),
('Computadora de escritorio',7),
('Computadora de escritorio',6),
('Notebook',2);

insert into derivacion(idEstado, idSectorOrigen, idSectorDestino) values
(1,1,2),
(2,2,1),
(3,3,1),
(4,4,2),
(5,6,7),
(6,3,1),
(1,2,4),
(2,5,6),
(3,2,3),
(4,1,7),
(5,9,10),
(6,3,8);

insert into incidencia(legajo, idN1, aprobada, fechaHora, idEstadoActual, idEstadoProximo) values
(1000, 1, 0, '01/02/2017',1,2),
(1010, 2, 1, '03/02/2017',1,3),
(1020, 3, 1, '01/04/2017',2,4),
(1030, 4, 0, '01/02/2017',3,6),
(1040, 4, 0, '05/02/2017',3,4),
(1050, 5, 0, '01/02/2017',4,5),
(1010, 2, 1, '05/02/2017',5,6),
(1020, 15, 0, '01/02/2017',1,2),
(1100, 14, 0, '01/09/2017',3,4),
(1050, 13, 1, '01/10/2017',2,6),
(1110, 1, 0, '15/9/2017',3,5),
(1150, 2, 0, '6/08/2017',3,4),
(1010, 4, 0, '4/01/2017',2,5),
(1060, 8, 1, '11/11/2017',3,5),
(1070, 9, 1, '13/12/2017',1,3),
(1010, 10, 1, '1/04/2017',1,5),
(1010, 12, 0, '04/05/2017',5,6),
(1010, 13, 0, '09/02/2017',5,2),
(1140, 6, 1, '17/10/2017',6,6),
(1130, 5, 0, '25/10/2017',1,2);

insert into comentario(fecha, hora, texto, idOperador, nroIncidencia) values
('01/01/2017', '01:01:55', 'No se que comentar', 3, 3),
('02/02/2017', '02:02:55', 'Pinte toda toda la pared', 5, 5),
('03/03/2017', '23:55:55', 'Me atendieron bastante bien che', 2, 6),
('04/04/2017', '15:16:21', 'Increíble, pero me  lo comí todo', 4, 4),
('05/05/2016', '13:17:55', 'Ya estoy pensando en el futuro', 9, 8),
('30/10/2017', '14:22:00', 'Martín no vino', 2, 12),
('02/11/2017', '02:02:55', 'Esta es la ultima tupla', 7, 13);

-- 3.​ ​Realice​ ​un​ ​Stored​ ​Procedure​ ​que​ ​recibe​ ​como​ ​parámetro​ ​un​ ​identificador​ ​de​ ​usuario​ ​y nos​ ​devuelva​ ​las​ ​incidencias​ ​pendientes​
​-- (que​ ​ha​ ​generado​ ​y​ ​no​ ​están​ ​cerradas)​ ​que​ ​tiene​ ​al momento.

-- DROP PROCEDURE p_incidenciasPendientesDeUsuario

CREATE PROCEDURE p_incidenciasPendientesDeUsuario(@idUser INT)
AS
	SELECT I.nro FROM incidencia I
	INNER JOIN estado E ON I.idEstadoActual = E.id
	WHERE I.legajo = @idUser AND E.descripcion <> 'CERRADO'

-- Ejemplo de ejecución
EXECUTE p_incidenciasPendientesDeUsuario 1050

-- 4. Realice un Trigger que al eliminar un usuario se cierren todas las incidencias pendientes
-- que había generado. Igualmente el usuario no debe ser eliminado de la base de datos, sino
-- que debe indicarse como usuario “Inactivo” (realizar los cambios en la estructura que
-- considere necesarios para permitir este comportamiento).

DROP TRIGGER eliminarUsuario

CREATE TRIGGER eliminarUsuario ON usuario INSTEAD OF DELETE
AS
UPDATE incidencia
SET idEstadoActual = 6
WHERE legajo = (SELECT legajo FROM deleted)
UPDATE incidencia
SET idEstadoProximo = 6
WHERE legajo = (SELECT legajo FROM deleted)
UPDATE usuario
SET estado = 0
WHERE legajo = (SELECT legajo FROM deleted)

-- 5.​ ​Genere​ ​una​ ​función​ ​que​ ​nos​ ​permita​ ​conocer​ ​la​ ​antigüedad​ ​(en​ ​horas)​ ​de​ ​una​ ​solicitud que​ ​pasemos​ ​como​ ​parámetro. 

DROP FUNCTION f_antiguedadSolicitud

CREATE FUNCTION f_antiguedadSolicitud(@nroIncidencia INT)
RETURNS INT
AS
BEGIN
	RETURN (DATEDIFF(DAY, (SELECT fechaHora FROM incidencia WHERE nro = @nroIncidencia), GETDATE()) * 24)
END

-- Ejemplo de ejecución
SELECT dbo.f_antiguedadSolicitud(1) AS Antigüedad

-- 6. Realice las siguientes consultas:

-- Indique las incidencias pendientes con más de 5 días de antigüedad

SELECT I.nro FROM incidencia I
INNER JOIN estado E ON I.idEstadoActual = E.id
WHERE DATEDIFF(DAY, I.fechaHora, GETDATE()) > 5 AND E.descripcion <> 'CERRADO' -- Si no esta cerrada, significa que esta pendiente

-- Indique los usuarios que hayan solicitado todos los tipos de nivel 1 distintos.

DROP VIEW no_todos

CREATE VIEW no_todos
AS
(
SELECT U.legajo
FROM usuario U, n1 N1
WHERE NOT EXISTS (SELECT 1 FROM incidencia I WHERE I.legajo = U.legajo AND n1.id = I.idN1)
)

SELECT U.legajo
FROM usuario U
WHERE U.legajo NOT IN (SELECT * FROM no_todos)

-- Indique en orden descendente la cantidad de incidencias por cada tipificación (los 3 niveles completos).

SELECT * FROM
(SELECT I.idN1 AS Id_Nivel, 1 AS Nivel, COUNT(1) AS Cantidad_Incidencias
FROM Incidencia I
GROUP BY I.idN1
UNION
SELECT nivel2.id AS Id_Nivel, 2 AS Nivel, COUNT(1) AS Cantidad_Incidencias
FROM Incidencia I
INNER JOIN N1 nivel1 ON nivel1.id = I.idN1
INNER JOIN N2 nivel2 ON nivel2.id = nivel1.idN2
GROUP BY nivel2.id) T
ORDER BY T.Cantidad_Incidencias DESC
