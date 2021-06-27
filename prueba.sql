--Borrando datos anteriores 

DROP DATABASE biblioteca;

-- Creando nuestra base de datos 

CREATE DATABASE biblioteca;

-- ingresando en nuestra base de datos 

\c biblioteca;

-- Creando las tablas solicitadas

CREATE TABLE socios(
    rut VARCHAR(15),
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    PRIMARY KEY (rut)
);

CREATE TABLE libros(
    isbn VARCHAR(15),
    titulo VARCHAR(100),
    paginas INT,
    dias_prestamo INT,
    PRIMARY KEY (isbn)
);

CREATE TABLE autor(
    codigo_autor INT,
    nombre_autor VARCHAR(30),
    apellido_autor VARCHAR(30),
    nacimiento INT,
    muerte INT,
    tipo_autor VARCHAR(10),
    PRIMARY KEY (codigo_autor)
);

CREATE TABLE historial_prestamos(
    socios_rut VARCHAR(15),
    libros_isbn VARCHAR (15),
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (socios_rut)
    REFERENCES socios(rut),
    FOREIGN KEY (libros_isbn)
    REFERENCES libros(isbn)
);

CREATE TABLE libro_autor(
    libros_isbn VARCHAR(15),
    aut_codigo_autor INT,
    FOREIGN KEY (libros_isbn)
    REFERENCES libros(isbn),
    FOREIGN KEY (aut_codigo_autor)
    REFERENCES autor(codigo_autor)    
);

-- ingresando valores a las tablas 

INSERT INTO socios 
(rut, nombre, apellido, direccion, telefono)
VALUES
('1111111-1', 'Juan', 'Soto', 'avenida 1, santiago', '911111111'
);

INSERT INTO socios 
(rut, nombre, apellido, direccion, telefono)
VALUES
('2222222-2', 'Ana', 'Perez', 'pasaje 2, santiago', '922222222'
);

INSERT INTO socios 
(rut, nombre, apellido, direccion, telefono)
VALUES
('3333333-3', 'Sandra', 'Aguilar', 'avenida 2, santiago', '933333333'
);

INSERT INTO socios 
(rut, nombre, apellido, direccion, telefono)
VALUES
('4444444-4', 'Esteban', 'Jerez', 'avenida 3, santiago', '944444444'
);

INSERT INTO socios 
(rut, nombre, apellido, direccion, telefono)
VALUES
('5555555-5', 'Silvana', 'Muñoz', 'pasaje 3, santiago', '955555555'
);

INSERT INTO libros
(isbn, titulo, paginas, dias_prestamo)
VALUES
('111-1111111-111', 'Cuentos de Terror', 344, 7
);

INSERT INTO libros
(isbn, titulo, paginas, dias_prestamo)
VALUES
('222-2222222-222', 'Poesias Contemporaneas', 167, 7
);

INSERT INTO libros
(isbn, titulo, paginas, dias_prestamo)
VALUES
('333-3333333-333', 'Historia de Asia', 511, 14
);

INSERT INTO libros
(isbn, titulo, paginas, dias_prestamo)
VALUES
('444-4444444-444', 'Manual de Mecanica', 298, 14
);

INSERT INTO autor
(codigo_autor, nombre_autor, apellido_autor, nacimiento, muerte, tipo_autor)
VALUES
(3, 'Jose', 'Salgado', '1968', '2020', 'Principal'
);

INSERT INTO autor
(codigo_autor, nombre_autor, apellido_autor, nacimiento, muerte, tipo_autor)
VALUES
(4, 'Ana', 'Salgado', '1972', null, 'Coautor'
);

INSERT INTO autor
(codigo_autor, nombre_autor, apellido_autor, nacimiento, muerte, tipo_autor)
VALUES
(1, 'Andres', 'Ulloa', '1982', null, 'Principal'
);

INSERT INTO autor
(codigo_autor, nombre_autor, apellido_autor, nacimiento, muerte, tipo_autor)
VALUES
(2, 'Sergio', 'Mardones', '1950', '2012', 'Principal'
);

INSERT INTO autor
(codigo_autor, nombre_autor, apellido_autor, nacimiento, muerte, tipo_autor)
VALUES
(5, 'Martin', 'Porta', '1976', null, 'Principal'
);

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('1111111-1', '111-1111111-111', '2020-01-20', '2020-01-27');

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('5555555-5', '222-2222222-222', '2020-01-20', '2020-01-30');

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('3333333-3', '333-3333333-333', '2020-01-22', '2020-01-30');

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('4444444-4', '444-4444444-444', '2020-01-23', '2020-01-30');

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('2222222-2', '111-1111111-111', '2020-01-27', '2020-02-04');

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('1111111-1', '444-4444444-444', '2020-01-31', '2020-02-12');

INSERT INTO historial_prestamos
(socios_rut, libros_isbn, fecha_prestamo, fecha_devolucion)
VALUES
('3333333-3', '222-2222222-222', '2020-01-31', '2020-02-12');

INSERT INTO libro_autor
(libros_isbn, aut_codigo_autor)
VALUES
('111-1111111-111', 3);

INSERT INTO libro_autor
(libros_isbn, aut_codigo_autor)
VALUES
('111-1111111-111', 4);

INSERT INTO libro_autor
(libros_isbn, aut_codigo_autor)
VALUES
('222-2222222-222', 1);

INSERT INTO libro_autor
(libros_isbn, aut_codigo_autor)
VALUES
('333-3333333-333', 2);

INSERT INTO libro_autor
(libros_isbn, aut_codigo_autor)
VALUES
('444-4444444-444', 5);

-- Realizando consultas para chequear los valores ingresados

SELECT * FROM socios;
SELECT * FROM libros;
SELECT * FROM historial_prestamos;
SELECT * FROM autor; 
SELECT * FROM libro_autor;

-- Mostrar todos los libros que posean menos de 300 páginas.

SELECT isbn, titulo, paginas, aut_codigo_autor FROM libros 
INNER JOIN libro_autor
ON libros.isbn = libro_autor.libros_isbn
WHERE paginas < 300;

-- Mostrar todos los autores que hayan nacido después del 01-01-1970

SELECT * FROM autor WHERE nacimiento > '1970' ORDER BY nacimiento ASC;

-- ¿Cuál es el libro más solicitado?

SELECT titulo, libros_isbn, COUNT(libros_isbn) solicitudes 
FROM libros
INNER JOIN historial_prestamos
ON historial_prestamos.libros_isbn = libros.isbn
GROUP BY libros_isbn, titulo
ORDER BY solicitudes DESC LIMIT 1;

-- Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que registre días de atraso. 

SELECT rut, nombre, apellido, (SELECT((fecha_devolucion - fecha_prestamo) - dias_prestamo) * 100 AS deuda) FROM historial_prestamos
INNER JOIN libros
ON historial_prestamos.libros_isbn = libros.isbn
INNER JOIN socios
ON historial_prestamos.socios_rut = socios.rut
WHERE ((fecha_devolucion - fecha_prestamo) - dias_prestamo) > 0
ORDER BY rut ASC; 