DROP DATABASE IF EXISTS neumaticossgo;
CREATE DATABASE neumaticossgo;

USE neumaticossgo;

CREATE TABLE Proveedor (
    IdProveedor INT NOT NULL AUTO_INCREMENT,
    CUITProveedor VARCHAR(20),
    Nombre VARCHAR(120),
    RazonSocial VARCHAR(120),
    Direccion VARCHAR(250),
    Localidad VARCHAR(30),
    Provincia VARCHAR(30),
    Contacto VARCHAR(30),
    Estado ENUM('A', 'B') NOT NULL DEFAULT 'A',
    PRIMARY KEY (IdProveedor)
);

CREATE TABLE Rubro (
    IdRubro INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30) UNIQUE,
    Caracteristicas VARCHAR(200) NOT NULL,
    PRIMARY KEY (IdRubro)
);
CREATE INDEX idx_rubro_nombre ON rubro (nombre);

CREATE TABLE Producto (
    IdProducto INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(200) NOT NULL,
    Descripcion VARCHAR(250),
    PrecioCompra DECIMAL(10 , 2 ),
    PrecioVenta DECIMAL(10 , 2 ),
    Marca VARCHAR(40),
    StockDisponible INT,
    Rubro VARCHAR(30),
    Caracteristicas VARCHAR(300),
    PRIMARY KEY (IdProducto , Nombre),
    FOREIGN KEY (Rubro)
        REFERENCES Rubro (Nombre)
);
  
CREATE TABLE entrada (
    idEntrada INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idProveedor INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    montoTotal DECIMAL(10 , 2 ),
    FOREIGN KEY (idProveedor)
        REFERENCES proveedor (idProveedor)
);

CREATE TABLE entradaDetalle (
    idEntrada INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10 , 2 ),
    PRIMARY KEY (idEntrada , idProducto),
    FOREIGN KEY (idEntrada)
        REFERENCES entrada (idEntrada),
    FOREIGN KEY (IdProducto)
        REFERENCES producto (IdProducto)
);
                                

CREATE TABLE salida (
    idSalida INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    idProveedor INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    montoTotal DECIMAL(10 , 2 ),
    FOREIGN KEY (idProveedor)
        REFERENCES proveedor (idProveedor)
);

CREATE TABLE salidaDetalle (
    idSalida INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10 , 2 ),
    PRIMARY KEY (idSalida , idProducto),
    FOREIGN KEY (idSalida)
        REFERENCES salida (idSalida),
    FOREIGN KEY (IdProducto)
        REFERENCES producto (IdProducto)
);


DROP PROCEDURE IF EXISTS spProductoAlta;
DELIMITER //
CREATE PROCEDURE spProductoAlta (IN nombre VARCHAR(100),IN descrip VARCHAR(200),IN precioC DECIMAL(10,2),IN precioV DECIMAL(10,2),IN marcaP VARCHAR(100),IN stock INT,IN rubro VARCHAR(30), IN carac VARCHAR(300))
BEGIN
  INSERT INTO Producto (Nombre, Descripcion, PrecioCompra, PrecioVenta, Marca, StockDisponible, Rubro, Caracteristicas) VALUES (nombre,descrip,precioC,precioV,marcaP,stock,rubro, carac);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS spProveedorAlta;
DELIMITER //
CREATE PROCEDURE spProveedorAlta (IN cuitIn VARCHAR(15),IN nombreIn VARCHAR(120),IN razonIn VARCHAR(120),IN direc VARCHAR(120), IN localIn VARCHAR(120), IN provIn VARCHAR(120))
BEGIN
  INSERT INTO Proveedor (CUITProveedor, nombre, razonSocial, direccion, localidad, provincia, Contacto) VALUES (cuitIn, nombreIn, razonIn, direc, localIn, provIn, 'a cargar');
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS spRubroAlta;
DELIMITER //
CREATE PROCEDURE spRubroAlta (IN nombreIn VARCHAR(30),IN caracteristicasIn varchar(200))
BEGIN
  INSERT INTO Rubro (nombre, caracteristicas) VALUES (nombreIn, caracteristicasIn);
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER trEntrada
AFTER INSERT ON entradaDetalle
FOR EACH ROW
BEGIN
    UPDATE producto SET StockDisponible = StockDisponible + NEW.cantidad WHERE IdProducto = NEW.IdProducto;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER trSalidaDetalle
AFTER INSERT ON salidaDetalle
FOR EACH ROW
BEGIN
	UPDATE producto SET StockDisponible = StockDisponible - NEW.cantidad WHERE IdProducto = NEW.IdProducto;
END //
DELIMITER ;


CALL spRubroAlta ('neumatico','{"rodado": "", "ancho": "", "perfil": "", "indice": ""}');
CALL spRubroAlta ('llanta','{"rodado": "", "ancho": "", "material": "", "estado": ""}');
CALL spRubroAlta ('lubricentro','{"descripcion": "", "medida": "", "tipo": ""}');
CALL spRubroAlta ('bateria','{"amperaje": "", "voltaje": "", "tipo": ""}');
CALL spRubroAlta ('filtro','{"tipo": "", "vehiculo": ""}');
CALL spRubroAlta ('lampara','{"voltaje": "", "watts": "", "tipo": ""}');


CALL spProductoAlta ('Bateria MOURA M22RD', 'Bateria MOURA M22RD 12X85 HILUX 550 Toyota Hilux; Tucson, Santa Fe', 54686.00, 86022.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "85", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M22RI', 'Bateria MOURA M22RI 12X85 HILUX (IZ) 550 Toyota Hilux', 54686.00, 86022.00, 'BATERIAS MOURA', 2, 'bateria', '{"amperaje": "85", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M23UI', 'Bateria MOURA M23UI TRACT. CESPED 150 12-24 Tractores Pequeños', 19991.00, 31446.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "24", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M24KD', 'Bateria MOURA M24KD 12X75 530 12x75 (Estándar)', 39931.00, 62812.00, 'BATERIAS MOURA', 5, 'bateria', '{"amperaje": "75", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M26AD', 'Bateria MOURA M26AD 12X65 ALTA 470 Diésel Livianos 307/8, Fox, Punto', 39922.00, 62798.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "65", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M26AI', 'Bateria MOURA M26AI 12X65 ALTA (IZ) 470 Chery Tiggo (Original)', 45294.00, 71248.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "65", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M28KD', 'Bateria MOURA M28KD 12X75 REF 580 Ranger 2013 >(original)', 43117.00, 67824.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "75", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M28KI', 'Bateria MOURA M28KI 12X75 REF (IZ) 580 Gran Cherokee', 50455.00, 79366.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "75", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M28TD/ME90TD', 'Bateria MOURA M28TD/ME90TD 12X90 HILUX 720', 41644.00, 65507.00, 'BATERIAS MOURA', 1, 'bateria', '{"amperaje": "90", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M28TE/ME90TI', 'Bateria MOURA M28TE/ME90TI 12X90 HILUX (IZ) 720', 66554.00, 104690.00, 'BATERIAS MOURA', 1, 'bateria', '{"amperaje": "90", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M30HA/ME100HA', 'Bateria MOURA M30HA/ME100HA 12X110 750 Camiones Mercedes Benz; Iveco; P 504 d', 62999.00, 99098.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "110", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M30LD', 'Bateria MOURA M30LD 12X75 ALTA 600 Ranger <2013, Amarok (Original)', 46277.00, 72794.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "75", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M30LI', 'Bateria MOURA M30LI 12X75 ALTA (IZ) 600 Silverado Caja Alta', 49372.00, 77663.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "75", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M30QD/ME95QD', 'Bateria MOURA M30QD/ME95QD 12X90 SPRINTER 750 Amarok, Sprinter; MB Automóviles; BMW', 54543.00, 85797.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "90", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M40FD', 'Bateria MOURA M40FD 12X45 343 Clío; Fiesta, Palio; Fiorino, Punto 1,4', 27203.00, 42791.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "45", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M42BD/ME150BD', 'Bateria MOURA M42BD/ME150BD 12X180 930 12-180 (Camiones)', 62907.00, 98953.00, 'BATERIAS MOURA', 2, 'bateria', '{"amperaje": "180", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M46BD/ME180BD', 'Bateria MOURA M46BD/ME180BD 12X180 REF 12-180 Reforzada (Camiones)', 100323.00, 157809.00, 'BATERIAS MOURA', 1, 'bateria', '{"amperaje": "180", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M46BE/ME180BI', 'Bateria MOURA M46BE/ME180BI 12X180 REF (IZ) 12-180 Volvo Scania (Camiones)', 117976.00, 185577.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "180", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M58PD/ME220PD', 'Bateria MOURA M58PD/ME220PD 12X220 1150 12-2220 (Ómnibus) (Tractores)', 155581.00, 244729.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "220", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA ME135BD', 'Bateria MOURA ME135BD 12X135 850 12-150 (Camiones)', 85646.00, 134722.00, 'BATERIAS MOURA', 1, 'bateria', '{"amperaje": "135", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M18FD', 'Bateria MOURA M18FD 12X45 380 Clío; Fiesta, Palio; Fiorino, Punto 1,4', 29968.00, 47140.00, 'BATERIAS MOURA', 1, 'bateria', '{"amperaje": "45", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA ME80CD', 'Bateria MOURA ME80CD 12X80 650', 92169.00, 144982.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "80", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA MF60AD', 'Bateria MOURA MF60AD L2 530', 64061.00, 100768.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "60", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA MF72LD', 'Bateria MOURA MF72LD L3 730', 83847.00, 131892.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "72", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('BATERIA  BOSCH 12X90 AMP', 'BATERIA  BOSCH 12X90 AMP  VEHICULO LIVIANO', 42439.00, 66757.00, 'BOSCH', 0, 'bateria', '{"amperaje": "90", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M18SD', 'Bateria MOURA M18SD 12X40 (H FIT) 260 Honda Fit (Borne Grueso)', 36288.00, 57082.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "40", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M20GD', 'Bateria MOURA M20GD 12X65 350 12x65 (Estándar)', 29423.00, 46283.00, 'BATERIAS MOURA', 3, 'bateria', '{"amperaje": "65", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M22ED', 'Bateria MOURA M22ED 12X50 390 Palio; Punto, Cobalt, Prisma.', 20807.00, 32730.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "50", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M22GD', 'Bateria MOURA M22GD 12X65 REF 450 Focus, Gol,207, 208, Corsa (N)', 28365.00, 44619.00, 'BATERIAS MOURA', 2, 'bateria', '{"amperaje": "65", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M22GI', 'Bateria MOURA M22GI 12X65 REF (IZ) 450 Neón/99; C4; Agile; Aveo; Daewoo', 25379.00, 39922.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "65", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Bateria MOURA M22JD', 'Bateria MOURA M22JD 12X50 (H CIVIC) 375 Honda Civic (Borne Grueso)', 38710.00, 60891.00, 'BATERIAS MOURA', 0, 'bateria', '{"amperaje": "50", "voltaje": "12", "tipo": "Litio"}');
CALL spProductoAlta ('Filtro de aire BOSCH AB', 'Filtro de aire BOSCH AB Renault Sandero-Scenic-Laguna II-Clio II-Megane II', 1080.00, 1699.00, 'BOSCH', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Sandero, Scenic, Laguna II, Clio II, Megane II"}');
CALL spProductoAlta ('Filtro de aire ERCIF', 'Filtro de aire ERCIF Nissan 3.2 diesel 98', 2344.00, 3688.00, 'ERCIF', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Nissan 3.2 diesel 98"}');
CALL spProductoAlta ('Filtro de aire FORD Transit 2.2', 'Filtro de aire FORD Transit 2.2', 1600.00, 2517.00, 'FORD', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Transit 2.2"}');
CALL spProductoAlta ('Filtro de aire HASTING', 'Filtro de aire HASTING Renault Kangoo-Logan 1.6', 2018.00, 3175.00, 'HASTING', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Kangoo-Logan 1.6"}');
CALL spProductoAlta ('Filtro de aire HASTING', 'Filtro de aire HASTING Citroen C4-Peugeot 307 308 2.0', 2653.00, 4174.00, 'HASTING', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Citroen C4-Peugeot 307 308 2.0"}');
CALL spProductoAlta ('Filtro de aire HASTING', 'Filtro de aire HASTING Renault Logan 1.6 08', 2027.00, 3189.00, 'HASTING', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Logan 1.6 08"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Chevrolet S-10 2.8', 3504.00, 5512.00, 'MASTERFILT', 17, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet S-10 2.8"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Ranger 3.0 TDI POWER STROKE 05->', 3815.00, 6001.00, 'MASTERFILT', 15, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Ranger 3.0 TDI POWER STROKE 05->"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford f100 92 -> MWM-F14000', 6252.00, 9835.00, 'MASTERFILT', 10, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford f100 92 -> MWM-F14000"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot  Boxer 1.9 TURBO DIESEL', 4709.00, 7408.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot Boxer 1.9 TURBO DIESEL"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Clio Diesel 97´-> Express-Clio RL 1.9 diesel Dto Ace.', 2281.00, 3589.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Clio Diesel 97-> Express-Clio RL 1.9 diesel Dto Ace"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Kangoo-Clio 1.6', 2261.00, 3557.00, 'MASTERFILT', 21, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Kangoo-Clio 1.6"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Chevrolet S10 MWM 2.8-Blazer-Grand Blazer-Nissan Frontier', 3182.00, 5006.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet S10 MWM 2.8-Blazer-Grand Blazer-Nissan Frontier"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Toyota Hilux 05´ ->', 2885.00, 4539.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Toyota Hilux 05 "}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot 205-306 Dto Ace', 1270.00, 1998.00, 'MASTERFILT', 7, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 205-306 Dto Ace"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Clio II-Laguna I Y II-Megane', 1568.00, 2467.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Clio II-Laguna I Y II-Megane"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT VW Amarok 2.0 tdi (TODOS)', 2664.00, 4191.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Amarok 2.0 tdi (TODOS)"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Master 2.5 dci', 3075.00, 4837.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Master 2.5 dci"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Transit 2.2 tdci 2012', 3283.00, 5165.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Transit 2.2 tdci 2012"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Master 2.3 tdci -> -Nissan NV 400', 3015.00, 4743.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Master 2.3 tdci -> -Nissan NV 400"}');
CALL spProductoAlta ('Filtro de aire MANN', 'Filtro de aire MANN Toyota Hilux 2.5 td 3.0 tdi', 4515.00, 7103.00, 'MANN', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Toyota Hilux 2.5 td 3.0 tdi"}');
CALL spProductoAlta ('Filtro de aire MANN', 'Filtro de aire MANN Renault Kwid 1.0', 2457.00, 3865.00, 'MANN', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Kwid 1.0"}');
CALL spProductoAlta ('Filtro de aire MANN', 'Filtro de aire MANN MB Sprinter 308 310 313 413 cdi', 4615.00, 7260.00, 'MANN', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "MB Sprinter 308 310 313 413 cdi"}');
CALL spProductoAlta ('Filtro de aire MANN', 'Filtro de aire MANN Toyota Hilux 2.8 tdi', 3234.00, 5088.00, 'MANN', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Toyota Hilux 2.8 tdi"}');
CALL spProductoAlta ('Filtro de aire NISSAN', 'Filtro de aire NISSAN Frontier D40', 4068.00, 6399.00, 'NISSAN', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "NISSAN Frontier D40"}');
CALL spProductoAlta ('Filtro de habitáculo HASTING', 'Filtro de habitaculo HASTING Renault Duster', 1507.00, 2371.00, 'HASTING', 5, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Renault Duster"}');
CALL spProductoAlta ('Filtro de habitáculo HASTING', 'Filtro de habitáculo HASTING VW Voyage-Suran-Fox-Gol Trend', 1593.00, 2506.00, 'HASTING', 5, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "VW Voyage-Suran-Fox-Gol Trend"}');
CALL spProductoAlta ('Filtro de habitáculo HASTING', 'Filtro de habitáculo HASTING Ford Ecosport Kinetic design-Ford KA III', 1546.00, 2432.00, 'HASTING', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Ford Ecosport Kinetic design-Ford KA III"}');
CALL spProductoAlta ('Filtro de habitáculo HASTING', 'Filtro de habitáculo HASTING Renault Sandero-Capture', 1507.00, 2371.00, 'HASTING', 1, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Renault Sandero-Capture"}');
CALL spProductoAlta ('Filtro de habitáculo HASTING', 'Filtro de habitáculo HASTING P307-308-408-Partner Ranch', 2187.00, 3441.00, 'HASTING', 1, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "P307-308-408-Partner Ranch"}');
CALL spProductoAlta ('Filtro de habitáculo MANN', 'Filtro de habitáculo MANN Fiat Qubo-Fiorino-Doblo 1.4', 2332.00, 3669.00, 'MANN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Fiat Qubo-Fiorino-Doblo 1.4"}');
CALL spProductoAlta ('Filtro de habitáculo MANN', 'Filtro de habitáculo MANN Toyota Hilux 2.4 2.8 TD 15´', 1800.00, 2832.00, 'MANN', 3, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Toyota Hilux 2.4 2.8 TD 15"}');
CALL spProductoAlta ('Filtro de habitáculo RENAULT', 'Filtro de habitáculo RENAULT Master III', 950.00, 1495.00, 'RENAULT', 6, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "RENAULT Master III"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Hilux 05', 1875.00, 2950.00, 'MANN', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Hilux 05"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Toyota Hilux 05', 3147.00, 4951.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Toyota Hilux 05"}');
CALL spProductoAlta ('Filtro de aceite NEOTECH', 'Filtro de aceite NEOTECH Chevrolet S10', 2600.00, 4090.00, 'NEOTECH', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet S10"}');
CALL spProductoAlta ('Filtro de habitáculo WEGA', 'Filtro de habitaculo WEGA VW Amarok', 1400.00, 2203.00, 'WEGA', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "VW Amarok"}');
CALL spProductoAlta ('Filtro de aceite AC DELCO', 'Filtro de aceite AC DELCO Chevrolet S10-Blazer MWM 2.8-Sprinter-Nissan Frontier', 5721.00, 9000.00, 'AC DELCO', 14, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet S10-Blazer MWM 2.8-Sprinter-Nissan Frontier"}');
CALL spProductoAlta ('Filtro de habitáculo MASTERFILT', 'Filtro de habitaculo MASTERFILT Ford Ranger 2.5 2.2 3.2', 1436.00, 2259.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Ford Ranger 2.5 2.2 3.2"}');
CALL spProductoAlta ('Filtro de aceite BOSCH', 'Filtro de aceite BOSCH Chevrolet S10 2.8', 2000.00, 3146.00, 'BOSCH', 17, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet S10 2.8"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Renault Kwid', 1495.00, 2352.00, 'MANN', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault Kwid"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Chevrolet S10-Blazer EFI-Monza-Kadet-Ipanema-Omega 2.0', 1112.00, 1750.00, 'MANN', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet S10-Blazer EFI-Monza-Kadet-Ipanema-Omega 2.0"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Toyota Hilux 3.0 tdi', 1477.00, 2324.00, 'MANN', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "Toyota Hilux 3.0 tdi"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Renault Clio-Duster-Kangoo-Logan-Megane-Sandero-Scenic-Symbal', 1139.00, 1792.00, 'MANN', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault Clio-Duster-Kangoo-Logan-Megane-Sandero-Scenic-Symbal"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Mercedes Benz C220', 2100.00, 3304.00, 'MANN', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz C220"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Mercedes Benz motor OM449', 5041.00, 7930.00, 'MANN', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz motor OM449"}');
CALL spProductoAlta ('Filtro de aceite WEGA', 'Filtro de aceite WEGA Ford Falcon', 1400.00, 2203.00, 'WEGA', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Falcon"}');
CALL spProductoAlta ('Filtro de aceite WEGA', 'Filtro de aceite WEGA Fiat Uno-Alfa Romeo 145', 2200.00, 3461.00, 'WEGA', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat Uno-Alfa Romeo 145"}');
CALL spProductoAlta ('Filtro de aceite MAHLE', 'Filtro de aceite MAHLE MB 1521L 1526LS', 1465.00, 2305.00, 'MAHLE', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "MB 1521L 1526LS"}');
CALL spProductoAlta ('Filtro de aceite HASTING', 'Filtro de aceite HASTING Renault Kangoo-Clio', 1335.00, 2100.00, 'HASTING', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault Kangoo-Clio"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Chevrolet Astra 2.0', 1207.00, 1899.00, 'FRAM', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet Astra 2.0"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Fiat Palio-Siena', 1280.00, 2014.00, 'FRAM', 15, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat Palio-Siena"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM  Fiat Palio-Siena-Idea-Strada 1.3 1.4', 1590.00, 2502.00, 'FRAM', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat Palio-Siena-Idea-Strada 1.3 1.4"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Citroen G gsa', 1280.00, 2014.00, 'FRAM', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Citroen G gsa"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Citroen Visa Dyane', 1950.00, 3068.00, 'FRAM', 5, 'filtro', '{"tipo": "Aceite", "vehiculo": "Citroen Visa Dyane"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Renault 4 6 11 12 18', 1600.00, 2517.00, 'FRAM', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault 4 6 11 12 18"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Peugeot 504 2.0 83´-00´', 1600.00, 2517.00, 'FRAM', 4, 'filtro', '{"tipo": "Aceite", "vehiculo": "Peugeot 504 2.0 83-00"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Toyota Hilux SW4-Prado supra', 1600.00, 2517.00, 'FRAM', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Toyota Hilux SW4-Prado supra"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Ford F100-F4000 MWM', 1900.00, 2989.00, 'FRAM', 5, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford F100-F4000 MWM"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Mitsubishi L200Y', 2860.00, 4499.00, 'FRAM', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mitsubishi L200Y"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Ford Ranger 3.0', 1600.00, 2517.00, 'FRAM', 5, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Ranger 3.0"}');
CALL spProductoAlta ('Filtro de aceite MOTORCRAFT', 'Filtro de aceite MOTORCRAFT Ford F100 HSD', 1600.00, 2517.00, 'MOTORCRAFT', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford F100 HSD"}');
CALL spProductoAlta ('Filtro de aceite MOTORCRAFT', 'Filtro de aceite MOTORCRAFT Ford Ranger', 2000.00, 3146.00, 'MOTORCRAFT', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Ranger"}');
CALL spProductoAlta ('Filtro de aceite FLEETGUARD', 'Filtro de aceite FLEETGUARD Ford F100/F4000-F14000/Cargo CUMMINS- VW 15160/14170/17160  Dto Ace', 2000.00, 3146.00, 'FLEETGUARD', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford F100/F4000-F14000/Cargo CUMMINS-VW 15160/14170/17160 Dto Ace"}');
CALL spProductoAlta ('Filtro de aceite WEGA', 'Filtro de aceite WEGA Mitsubishi L200 3.0 06´-Chev Astra 2.0 98´-99´-Ford Ranger 3.0 06´', 1300.00, 2045.00, 'WEGA', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mitsubishi L200 3.0 06-Chev Astra 2.0 98-99-Ford Ranger 3.0 06"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT VW Caddy 1.6-Gol 1.4-Polo classic 1.6-Ford Ranger power stroke 3.0 08´', 2623.00, 4126.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "VW Caddy 1.6-Gol 1.4-Polo classic 1.6-Ford Ranger power stroke 3.0 08"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT F100-F150-F4000 MWM 92´->', 2347.00, 3692.00, 'MASTERFILT', 9, 'filtro', '{"tipo": "Aceite", "vehiculo": "F100-F150-F4000 MWM 92->"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Renault 12', 1608.00, 2530.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault 12"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Citroen C3-Saxo-Xsara-Berlingo-P.106-206-206SW-306-307', 1987.00, 3126.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Citroen C3-Saxo-Xsara-Berlingo-P.106-206-206SW-306-307"}');
CALL spProductoAlta ('Filtro de aceite FORD', 'Filtro de aceite FORD Ford Ranger 3.0', 2250.00, 3540.00, 'FORD', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Ranger 3.0"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Renault Clio II-Twingo II 1.2', 1616.00, 2542.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault Clio II-Twingo II 1.2"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT VW Amarok 2.0-Tiguan 2.0-Audi Q5 2.0-A4 II 2.0-Vento 2.0', 2219.00, 3491.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "VW Amarok 2.0-Tiguan 2.0-Audi Q5 2.0-A4 II 2.0-Vento 2.0"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Fiat Palio-Siena', 1779.00, 2799.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat Palio-Siena"}');
CALL spProductoAlta ('Filtro de comb. ERCIF', 'Filtro de comb. ERCIF Chevrolet S10-Blazer-Nissan Frontier MWM', 4103.00, 6455.00, 'ERCIF', 6, 'filtro', '{"tipo": "Combustible", "vehiculo": "Chevrolet S10-Blazer-Nissan Frontier MWM"}');
CALL spProductoAlta ('Filtro de aire ERCIF', 'Filtro de aire ERCIF Chevrolet Blazer-Grand Blazer-S10-Silverado- MWM', 3182.00, 5006.00, 'ERCIF', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet Blazer-Grand Blazer-S10-Silverado- MWM"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Agrale-Deutz Mediano A 70/85/100/110-Ford tractor 400/500/700-Chev-Zanel', 3933.00, 6187.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "Agrale-Deutz Mediano A 70/85/100/110-Ford tractor 400/500/700-Chev-Zanel"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Fiat camion 619-697 largo linea E', 3920.00, 6167.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat camion 619-697 largo linea E"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT MB 1215-1315-1619-OH1319', 4005.00, 6300.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "MB 1215-1315-1619-OH1319"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT VW Gol 1000-Ibiza II-Seat cordoba', 1780.00, 2800.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "VW Gol 1000-Ibiza II-Seat cordoba"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Peugeot 206-306-307-106-205', 1474.00, 2319.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aceite", "vehiculo": "Peugeot 206-306-307-106-205"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford Mondeo IV 2.0-Fiesta Kinetic 1.6-Focus II 1.6-Courier 1.6-Cmax 1.6', 1100.00, 1731.00, 'MASTERFILT', 13, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Mondeo IV 2.0-Fiesta Kinetic 1.6-Focus II 1.6-Courier 1.6-Cmax 1.6"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Cimarron 3300/3800 D/88HP/99HP SEG. SERIE-John Deere', 2572.00, 4046.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Cimarron 3300/3800 D/88HP/99HP SEG. SERIE-John Deere"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Caterpillar 1R0734-3145-65P1-Caja allison', 3897.00, 6130.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aceite", "vehiculo": "Caterpillar 1R0734-3145-65P1-Caja allison"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Fiat Ducato Multijet Economy 10´-> 2.3', 2858.00, 4496.00, 'MASTERFILT', 21, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat Ducato Multijet Economy 10-> 2.3"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Toyota Hilux 2.5 3.0 05´-Camry 3.0-SW4 3.4', 1760.00, 2769.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Toyota Hilux 2.5 3.0 05-Camry 3.0-SW4 3.4"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Iveco Daily 2.8-Ducato 2.8-Peugeot Boxer', 6174.00, 9712.00, 'MASTERFILT', 12, 'filtro', '{"tipo": "Aceite", "vehiculo": "Iveco Daily 2.8-Ducato 2.8-Peugeot Boxer"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford Ka', 1706.00, 2684.00, 'MASTERFILT', 11, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Ka"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford F100-Cargo 914- CUMMINS', 2851.00, 4485.00, 'MASTERFILT', 12, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford F100-Cargo 914- CUMMINS"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Renault Master 2.2-Trafic 2.5-Laguna 2.2-Nissan Almera 2.2', 2591.00, 4076.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault Master 2.2-Trafic 2.5-Laguna 2.2-Nissan Almera 2.2"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford F10007´-Cargo131 DE-VW 17250-Iveco 2992-242', 4382.00, 6893.00, 'MASTERFILT', 8, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford F10007-Cargo131 DE-VW 17250-Iveco 2992-242"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Daihatsu-applause-Suzuki Vitara-Toyota Camri-celica-corolla-corona-Rav4', 2225.00, 3500.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Daihatsu-applause-Suzuki Vitara-Toyota Camri-celica-corolla-corona-Rav4"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford F100-F14000-Cargo 814-F1416', 3769.00, 5929.00, 'MASTERFILT', 11, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford F100-F14000-Cargo 814-F1416"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Chevrolet D20-D20C-Silverado-camion d600-d600t', 2466.00, 3880.00, 'MASTERFILT', 12, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet D20-D20C-Silverado-camion d600-d600t"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford Ranger TDI POWER STROKE', 2448.00, 3851.00, 'MASTERFILT', 12, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Ranger TDI POWER STROKE"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford Falcon/Chevrolet Corsa', 7616.00, 11980.00, 'MASTERFILT', 10, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Falcon/Chevrolet Corsa"}');
CALL spProductoAlta ('Filtro de aire WIX', 'Filtro de aire WIX Chevrolet Celta 1.4-Prisma 1.4-Suzuki Fun 1.0 1.4-', 863.00, 1358.00, 'WIX', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet Celta 1.4-Prisma 1.4-Suzuki Fun 1.0 1.4"}');
CALL spProductoAlta ('Filtros Pack MASTERFILT', 'Filtros Pack MASTERFILT Renault Clio-Logan-Symbal-Kangoo 1.6', 0.00, 0.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Pack", "vehiculo": "Renault Clio-Logan-Symbal-Kangoo 1.6"}');
CALL spProductoAlta ('Filtros pack MASTERFILT', 'Filtros pack MASTERFILT VW Amarok 2.0 tdi', 0.00, 0.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Pack", "vehiculo": "VW Amarok 2.0 tdi"}');
CALL spProductoAlta ('Filtros pack MASTERFILT', 'Filtros pack MASTERFILT Ford Ranger 3.0 turbo diesel', 0.00, 0.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Pack", "vehiculo": "Ford Ranger 3.0 turbo diesel"}');
CALL spProductoAlta ('Filtros pack MASTERFILT', 'Filtros pack MASTERFILT Chevrolet S10 2.8 TDI', 0.00, 0.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Pack", "vehiculo": "Chevrolet S10 2.8 TDI"}');
CALL spProductoAlta ('Filtros pack MASTERFIL', 'Filtros pack MASTERFIL Ford Ranger 2.2 3.2 diesel', 0.00, 0.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Pack", "vehiculo": "Ford Ranger 2.2 3.2 diesel"}');
CALL spProductoAlta ('Filtros pack MANN', 'Filtros pack MANN VW Gol Trend', 0.00, 0.00, 'MANN', 1, 'filtro', '{"tipo": "Pack", "vehiculo": "VW Gol Trend"}');
CALL spProductoAlta ('Filtros pack HASTING', 'Filtros pack HASTING Ford Ka-Ecosport', 0.00, 0.00, 'HASTING', 1, 'filtro', '{"tipo": "Pack", "vehiculo": "Ford Ka-Ecosport"}');
CALL spProductoAlta ('Filtros pack HASTING', 'Filtros pack HASTING Chevrolet Onix-Prisma II 1.4 13´', 0.00, 0.00, 'HASTING', 2, 'filtro', '{"tipo": "Pack", "vehiculo": "Chevrolet Onix-Prisma II 1.4 13"}');
CALL spProductoAlta ('Filtros pack CITROEN', 'Filtros pack CITROEN C4 Lounge', 0.00, 0.00, 'CITROEN', 1, 'filtro', '{"tipo": "Pack", "vehiculo": "CITROEN C4 Lounge"}');
CALL spProductoAlta ('Filtros pack MANN', 'Filtros pack MANN Toyota Hilux 2.5 td 3.0 tdi 05´-15´', 0.00, 0.00, 'MANN', 0, 'filtro', '{"tipo": "Pack", "vehiculo": "Toyota Hilux 2.5 td 3.0 tdi 05-15"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Chevrolet TrailBlazer 2.8-S10 2.8', 5223.00, 8216.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Chevrolet TrailBlazer 2.8-S10 2.8"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Ford Ranger 2.2 11´ ->', 3466.00, 5453.00, 'MASTERFILT', 20, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Ranger 2.2 11 ->"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Toyota Hilux 3.0 TD 07´ ->', 2740.00, 4311.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Toyota Hilux 3.0 TD 07 ->"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Ford Ranger 3.0 Tdi-VW 5.140 E', 5049.00, 7943.00, 'MASTERFILT', 10, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Ranger 3.0 Tdi-VW 5.140 E"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Peugeot 408- hdi-308 1.6 hdi-207-Citroen c4 lounge', 7686.00, 12091.00, 'MASTERFILT', 7, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot 408- hdi-308 1.6 hdi-207-Citroen c4 lounge"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Ford XLT 00´ Cummins 4 cilindros', 2015.00, 3170.00, 'MASTERFILT', 9, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford XLT 00 Cummins 4 cilindros"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT MB Sprinter 310CD-Ford Ranger tdic 2.5-F100 2.4 MWM', 3948.00, 6211.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "MB Sprinter 310CD-Ford Ranger tdic 2.5-F100 2.4 MWM"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT VW 13150 -13180-15180-17210-7100-8100-8120-8150', 5805.00, 9132.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW 13150 -13180-15180-17210-7100-8100-8120-8150"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Renault Master 2.8-Agrale bus serie MA-VW 8140-9140', 4650.00, 7315.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Master 2.8-Agrale bus serie MA-VW 8140-9140"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Fiat Duna diesel Borgward', 2288.00, 3600.00, 'MASTERFILT', 10, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat Duna diesel Borgward"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Peugeot 106-205-206-406-Reanult Clio II 00´-03´-Laguna II 00´-Megane 97', 1200.00, 1888.00, 'MASTERFILT', 13, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot 106-205-206-406-Reanult Clio II 00-03-Laguna II 00-Megane 97"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT MB Sprinter 308-311-313-413', 4109.00, 6464.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Combustible", "vehiculo": "MB Sprinter 308-311-313-413"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT VW 9,150-13,180-15,180-26,260-31,260-18,320 MWM-Agrale bus-Volvo', 6543.00, 10293.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW 9,150-13,180-15,180-26,260-31,260-18,320 MWM-Agrale bus-Volvo"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Citroen Berlingo 1.8-Fiat Tipo 1.6-Uno 1.1 1.3 1.4-P106-306-Wv Polo-Savei', 1527.00, 2402.00, 'MASTERFILT', 18, 'filtro', '{"tipo": "Combustible", "vehiculo": "Citroen Berlingo 1.8-Fiat Tipo 1.6-Uno 1.1 1.3 1.4-P106-306-Wv Polo-Savei"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT tacita tipo perkins larga vida', 945.00, 1487.00, 'MASTERFILT', 10, 'filtro', '{"tipo": "Combustible", "vehiculo": "Tacita tipo perkins larga vida"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT VW Amarok 2.0 (todos los modelos)', 3520.00, 5537.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW Amarok 2.0 (todos los modelos)"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT VW Fox-Crossfox-Gol-Quantum-Caddy-Gol country', 860.00, 1353.00, 'MASTERFILT', 7, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW Fox-Crossfox-Gol-Quantum-Caddy-Gol country"}');
CALL spProductoAlta ('Filtro de comb. BOSCH', 'Filtro de comb. BOSCH Ford Ranger 2.2 3.2 tdci 12´', 1550.00, 2439.00, 'BOSCH', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Ranger 2.2 3.2 tdci 12"}');
CALL spProductoAlta ('Filtro de comb. BOSCH', 'Filtro de comb. BOSCH Agrale MA-Volare-VW 13.180-15.180-17.210-17.220-17.240-17.300-26.260-9.150', 4400.00, 6922.00, 'BOSCH', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Agrale MA-Volare-VW 13.180-15.180-17.210-17.220-17.240-17.300-26.260-9.150"}');
CALL spProductoAlta ('Filtro de comb. WIX', 'Filtro de comb. WIX Chevrolet Agile-Astra-Celta-Corsa-Meriva-Montana-Prisma-Zafira-Fiat idea Uno Str', 955.00, 1503.00, 'WIX', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Chevrolet Agile-Astra-Celta-Corsa-Meriva-Montana-Prisma-Zafira-Fiat idea Uno Str"}');
CALL spProductoAlta ('Filtro de comb. TECNECO', 'Filtro de comb. TECNECO Toyota Hilux 2.4 2.8 3.0-Daihatsu-Delta', 0.00, 0.00, 'TECNECO', 8, 'filtro', '{"tipo": "Combustible", "vehiculo": "Toyota Hilux 2.4 2.8 3.0-Daihatsu-Delta"}');
CALL spProductoAlta ('Filtro de comb. MANN', 'Filtro de comb. MANN MB Sprinter 413', 6790.00, 10681.00, 'MANN', 4, 'filtro', '{"tipo": "Combustible", "vehiculo": "MB Sprinter 413"}');
CALL spProductoAlta ('Filtro de comb. WIX', 'Filtro de comb. WIX F1000-F14000-F150-F4000-MB 1114-1214-1314-1318-1418-1514-1517-1518-1618-608-710', 637.00, 1003.00, 'WIX', 6, 'filtro', '{"tipo": "Combustible", "vehiculo": "F1000-F14000-F150-F4000-MB 1114-1214-1314-1318-1418-1514-1517-1518-1618-608-710"}');
CALL spProductoAlta ('Filtro de comb. PURFLUX', 'Filtro de comb. PURFLUX Renault Master III 2.3', 1335.00, 2100.00, 'PURFLUX', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Master III 2.3"}');
CALL spProductoAlta ('Filtro de comb. TECNECO', 'Filtro de comb. TECNECO Ford Courier-Escort-Fiesta III IV-Mondeo II-Orion-S10 STD 2.5', 1000.00, 1573.00, 'TECNECO', 6, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Courier-Escort-Fiesta III IV-Mondeo II-Orion-S10 STD 2.5"}');
CALL spProductoAlta ('Filtro de comb. WEGA', 'Filtro de comb. WEGA Chevrolet S10 2.8 MWM', 3950.00, 6214.00, 'WEGA', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Chevrolet S10 2.8 MWM"}');
CALL spProductoAlta ('Filtro de comb. WEGA', 'Filtro de comb. WEGA Renault Master 2.5 03´-06´', 960.00, 1511.00, 'WEGA', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Master 2.5 03-06"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT Ford cargo c1416 c1716 c1722 c2625 c1730', 1910.00, 3005.00, 'MOTORCRAFT', 6, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford cargo c1416 c1716 c1722 c2625 c1730"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT VW Senda-Saveiro', 960.00, 1511.00, 'MOTORCRAFT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW Senda-Saveiro"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT Ford F4000-F14000', 1100.00, 1731.00, 'MOTORCRAFT', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford F4000-F14000"}');
CALL spProductoAlta ('Filtro de comb. HASTING', 'Filtro de comb. HASTING Scania deutz-Fiat-Volvo WK731', 2175.00, 3422.00, 'HASTING', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Scania deutz-Fiat-Volvo WK731"}');
CALL spProductoAlta ('Filtro de comb. HASTING', 'Filtro de comb. HASTING Fiat-VW', 3180.00, 5003.00, 'HASTING', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat-VW"}');
CALL spProductoAlta ('Filtro de comb. ORIGINAL', 'Filtro de comb. ORIGINAL Seat-Cordoba-Ibiza-VW Polo 1.9 tdi', 3750.00, 5899.00, 'ORIGINAL', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Seat-Cordoba-Ibiza-VW Polo 1.9 tdi"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Renault Megane Dto Ace.', 1631.00, 2566.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Megane Dto Ace"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM MB 1114', 830.00, 1306.00, 'FRAM', 5, 'filtro', '{"tipo": "Combustible", "vehiculo": "MB 1114"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM MB 1114 1114L 114LO 1214OF 1214turbo 1218 1314 1315 1318 1418 1514 1517 1518', 480.00, 756.00, 'FRAM', 4, 'filtro', '{"tipo": "Combustible", "vehiculo": "MB 1114 1114L 114LO 1214OF 1214turbo 1218 1314 1315 1318 1418 1514 1517 1518"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT F100-F4000-F14000 (separador de agua) Dto Ace', 3842.00, 6044.00, 'MOTORCRAFT', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "F100-F4000-F14000 (separador de agua) Dto Ace"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT Ford Transit 2.5', 1650.00, 2596.00, 'MOTORCRAFT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Transit 2.5"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Nissan Patrol 2.8', 1900.00, 2989.00, 'FRAM', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Nissan Patrol 2.8"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Nissan Path 2.7 2.5-Pat 2.8 4.2-Pick up 2.5td-Ser 2.3-Terr II-Xtrail-Vane-TOYOT', 2160.00, 3398.00, 'FRAM', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Nissan Path 2.7 2.5-Pat 2.8 4.2-Pick up 2.5td-Ser 2.3-Terr II-Xtrail-Vane-TOYOT"}');
CALL spProductoAlta ('Filtro de comb. HASTING', 'Filtro de comb. HASTING Peugeot Boxer II 2.3 2.8-Fiat Strada 1.3 Ducato 2.8 500 1.3-Citroen Jumper', 1780.00, 2800.00, 'HASTING', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot Boxer II 2.3 2.8-Fiat Strada 1.3 Ducato 2.8 500 1.3-Citroen Jumper"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford Ranger 2.2 3.2 12´ ->', 1574.00, 2476.00, 'MASTERFILT', 8, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Ranger 2.2 3.2 12 ->"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT MB Vito III 119 2.0-Nissan Frontier 2.3-Reanult Master-Latitude 2.0', 1810.00, 2848.00, 'MASTERFILT', 11, 'filtro', '{"tipo": "Aceite", "vehiculo": "MB Vito III 119 2.0-Nissan Frontier 2.3-Reanult Master-Latitude 2.0"}');
CALL spProductoAlta ('Filtro pack HASTING', 'Filtro pack HASTING VW Gol Trend/Suran/voyage 1.6', 7236.00, 11383.00, 'HASTING', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW Gol Trend/Suran/voyage 1.6"}');
CALL spProductoAlta ('Filtro pack HASTING', 'Filtro pack HASTING Chevrolet Aveo 1.6 08´', 9840.00, 15479.00, 'HASTING', 1, 'filtro', '{"tipo": "Pack", "vehiculo": "Chevrolet Aveo 1.6 08"}');
CALL spProductoAlta ('Filtro de Habitaculo WEGA', 'Filtro de Habitaculo WEGA Toyota Hilux 3.0 2.5 Mitsubishi L200', 826.00, 1300.00, 'WEGA', 1, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Toyota Hilux 3.0 2.5 Mitsubishi L200"}');
CALL spProductoAlta ('Filtro de Aire MASTERFILT', 'Filtro de Aire MASTERFILT Ford Explorer 4x4/ Ranger Dto Ace', 4226.00, 6648.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Explorer 4x4/ Ranger Dto Ace"}');
CALL spProductoAlta ('Filtro de Aire MASTERFILT', 'Filtro de Aire MASTERFILT Torino Tsx /gr /zx', 2060.00, 3241.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Torino Tsx /gr /zx"}');
CALL spProductoAlta ('Filtro de Aire MASTERFILT', 'Filtro de Aire MASTERFILT Fiat 1500 ovalado Dto Ace', 1051.00, 1654.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat 1500 ovalado Dto Ace"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Fiesta naftero Dto Ace.', 1497.00, 2355.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Fiesta naftero Dto Ace"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Lada Laika/niva', 1086.00, 1709.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Lada Laika/niva"}');
CALL spProductoAlta ('Filtro de Aire MASTERFILT', 'Filtro de Aire MASTERFILT VW Kombi Furgon Dto Ace', 2220.00, 3493.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Kombi Furgon Dto Ace"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Chevrolet Silverado Nacional-C10', 1621.00, 2550.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet Silverado Nacional-C10"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault 19 TURBO DIESEL-MEGANE TD-SCENIC', 1740.00, 2738.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 19 TURBO DIESEL-MEGANE TD-SCENIC"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Duna 1.3 Fiorino 1.3 Uno', 992.00, 1561.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "Duna 1.3 Fiorino 1.3 Uno"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault 18 Trafic', 988.00, 1554.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 18 Trafic"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Mondeo', 1097.00, 1725.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Mondeo"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Duna 1.7 Weekend 1.7', 714.00, 1123.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Duna 1.7 Weekend 1.7"}');
CALL spProductoAlta ('Filtro de aire FRAM', 'Filtro de aire FRAM Renault Clio 1.6 99´', 1654.00, 2602.00, 'FRAM', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Clio 1.6 99"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire WEGA VW Senda D-Saveiro 1.6-gol diesel', 890.00, 1400.00, 'WEGA', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Senda D-Saveiro 1.6-gol diesel"}');
CALL spProductoAlta ('Filtro de aire MOTORCRAFT', 'Filtro de aire MOTORCRAFT Ford Mondeo Zetec 1.8 2.0 Dto Ace.', 2102.00, 3307.00, 'MOTORCRAFT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Mondeo Zetec 1.8 2.0 Dto Ace"}');
CALL spProductoAlta ('Filtro de aire FRAM', 'Filtro de aire FRAM Ford Mandeo turbo diesel', 2288.00, 3600.00, 'FRAM', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Mandeo turbo diesel"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat Duna 1.6', 635.00, 999.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Duna 1.6"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot 405 Dto Ace.', 635.00, 999.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 405 Dto Ace"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault 19´1.6 2.2 Dto Ace.', 1487.00, 2340.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 19 1.6 2.2"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT tacita Perkins/Deutz boca grande Dto Ace.', 1363.00, 2144.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Tacita Perkins/Deutz boca grande Dto Ace"}');
CALL spProductoAlta ('Filtro de aire FILTREX', 'Filtro de aire  FILTREX Toyota Hilux 3,od 01´', 1017.00, 1600.00, 'FILTREX', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Toyota Hilux 3.0 01"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Chevrolet 1400/1600', 579.00, 911.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Chevrolet 1400/1600"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Fiat Palio/Siena', 715.00, 1125.00, 'FRAM', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat Palio/Siena"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Peugeot/indenor', 470.00, 740.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Peugeot/Indenor"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Corsa gl/Monza/vectra/kadett', 936.00, 1473.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Corsa GL/Monza/Vectra/Kadett"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'filtro de aceite MASTERFILT Renault 18', 635.00, 999.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault 18"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Ford Fiesta naftero Dto Ace', 1140.00, 1794.00, 'MASTERFILT', 9, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Fiesta naftero Dto Ace"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Regatta 100', 508.00, 800.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Regatta 100"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Fiat 919 N1 697 NY', 1557.00, 2450.00, 'FRAM', 3, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat 919 N1 697 NY"}');
CALL spProductoAlta ('Filtro de combustible WEGA', 'Filtro de combustible WEGA Toyota Hilux 2.4/2.8 15´', 0.00, 0.00, 'WEGA', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Toyota Hilux 2.4/2.8 15"}');
CALL spProductoAlta ('Filtro de aceite OILFILTER', 'Filtro de aceite OILFILTER Hyundai-Santamo', 953.00, 1500.00, 'OILFILTER', 4, 'filtro', '{"tipo": "Aceite", "vehiculo": "Hyundai-Santamo"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM  Vw Polo-Passat-Golf G4-Sharan-Ibiza-Caddy', 4218.00, 6635.00, 'FRAM', 4, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW Polo-Passat-Golf G4-Sharan-Ibiza-Caddy"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Toyota Hilux 05´', 1271.00, 2000.00, 'FRAM', 4, 'filtro', '{"tipo": "Combustible", "vehiculo": "Toyota Hilux 05"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Chevrolet S10 2.8/Nissan Frontier', 1907.00, 3000.00, 'FRAM', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Chevrolet S10 2.8/Nissan Frontier"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Nisan frontier 2.5', 1888.00, 2970.00, 'FRAM', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Nissan Frontier 2.5"}');
CALL spProductoAlta ('Filtro de comb. FILTREX', 'Filtro de comb. FILTREX', 1589.00, 2500.00, 'FILTREX', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "N/A"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Fiat 400/500/700', 953.00, 1500.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Fiat 400/500/700"}');
CALL spProductoAlta ('Filtro de comb. AGCO PARTS', 'Filtro de comb. AGCO PARTS', 953.00, 1500.00, 'AGCO PARTS', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "N/A"}');
CALL spProductoAlta ('Filtro de comb. ARGO PARTS', 'Filtro de comb. ARGO PARTS', 0.00, 0.00, 'AGCO PARTS', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "N/A"}');
CALL spProductoAlta ('Filtro de aceite BARDFIL', 'Filtro de aceite BARDFIL Tractor Zanello/Valtra Valmet', 0.00, 0.00, 'BARDFIL', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Tractor Zanello/Valtra Valmet"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz 1215/1315/1619/ Dto Ace', 1595.00, 2509.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 1215/1315/1619"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire WEGA Peugeot 208/308 08´ Partner', 1044.00, 1643.00, 'WEGA', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 208/308 08 Partner"}');
CALL spProductoAlta ('Filtro de aceite WEGA', 'Filtro de aceite WEGA Peugeot Partner/Citroen', 1248.00, 1964.00, 'WEGA', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Peugeot Partner/Citroen"}');
CALL spProductoAlta ('Filtro de aire MONZA', 'Filtro de aire MONZA Vw Polo 00´', 953.00, 1500.00, 'MONZA', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Polo 00"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT      Dto Ace', 699.00, 1100.00, 'MOTORCRAFT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "N/A"}');
CALL spProductoAlta ('Filtro de comb. nafta universal', 'Filtro de comb. nafta universal FILTREX', 635.00, 999.00, 'UNIVERSAL', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "N/A"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Fiesta naftero/courrier Dto Ace.', 1497.00, 2355.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Fiesta naftero/courrier"}');
CALL spProductoAlta ('Filtro de habitaculo WEGA', 'Filtro de habitaculo WEGA Toyota Hilux 2.4 15´ Inova 2.7 18´ Camry 2.5', 1469.00, 2311.00, 'WEGA', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Toyota Hilux 2.4 15 Inova 2.7 18 Camry 2.5"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat Ducato diesel/Boxer diesel Dto Ace.', 1673.00, 2632.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Ducato diesel/Boxer diesel"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot 505 turbo diesel Dto Ace', 1614.00, 2539.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 505 turbo diesel"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Scania 110/111/  Nro 219.517', 340.00, 535.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Scania 110/111"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT', 636.00, 1001.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "N/A"}');
CALL spProductoAlta ('Filtro de comb. WEGA', 'Filtro de comb. WEGA Fiat Palio 1.6 /500/Argo 17´', 953.00, 1500.00, 'WEGA', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat Palio 1.6/500/Argo 17"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Duna diesel', 488.00, 768.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Duna diesel"}');
CALL spProductoAlta ('Filtro de comb. WEGA', 'Filtro de comb. WEGA  Ford Fiesta/Escosport', 907.00, 1427.00, 'WEGA', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Fiesta/Ecosport"}');
CALL spProductoAlta ('Filtro de aire WIX', 'Filtro de aire WIX Ford Ecosport/Fiesta/ka 1.0 1.6', 1808.00, 2844.00, 'WIX', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Ecosport/Fiesta/ka 1.0 1.6"}');
CALL spProductoAlta ('Filtro de aceite MAHLE', 'Filtro de aceite MAHLE  Vw Bora 2.0', 919.00, 1446.00, 'MAHLE', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Vw Bora 2.0"}');
CALL spProductoAlta ('Filtro de combustible FRAM', 'Filtro de combustible FRAM Peugeot/Mercedes Benz/Perkins/Jonh Deere Dto Ace', 2288.00, 3600.00, 'FRAM', 31, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot/Mercedes Benz/Perkins/Jonh Deere"}');
CALL spProductoAlta ('Filtro de combustible separador MOTORCRAFT', 'Filtro de combustible separador MOTORCRAFT Ford F4000', 2945.00, 4633.00, 'MOTORCRAFT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford F4000"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault 18 diesel-Trafic-Rodeo Dto Ace', 1619.00, 2547.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 18 diesel-Trafic-Rodeo"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot  405-306 turbo diesel/Citroen Xantia-Xsara Dto Ace.', 1568.00, 2467.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 405-306 turbo diesel/Citroen Xantia-Xsara"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Laguna Renault Laguna Dto Ace.', 1568.00, 2467.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Laguna Renault Laguna"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Escort 1600 hasta 90´', 1303.00, 2050.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Escort 1600 hasta 90"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault 18', 635.00, 999.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 18"}');
CALL spProductoAlta ('Filtro de aire MASATERFILT', 'Filtro de aire MASATERFILT Fiat Uno Turbo diesel 1.7', 1681.00, 2645.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Uno Turbo diesel 1.7"}');
CALL spProductoAlta ('Filtro de comb. WEGA', 'Filtro de comb. WEGA Peugeot 208/Renault  Clio II/Vw Gol Trend /Gol', 720.00, 1133.00, 'WEGA', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot 208/Renault Clio II/Vw Gol Trend/Gol"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Vw Amarok 2.0 TDI (todos)', 4860.00, 7645.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Vw Amarok 2.0 TDI (todos)"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat duna diesel-147-SPAZIO-FIORINO Dto Ace', 1274.00, 2005.00, 'MASTERFILT', 12, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat duna diesel-147-SPAZIO-FIORINO"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Escort Motor 1600 (BRASILERO)', 1321.00, 2078.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Escort Motor 1600 (BRASILERO)"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Falcon/Chevrolet 400 -CASE-IH CS 48 48A 903.27/52 52A 903.27', 2800.00, 4405.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Falcon/Chevrolet 400-CASE-IH CS 48 48A 903.27/52 52A 903.27"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Escort motor 1.6 90 Dto Ace.', 1321.00, 2078.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Escort motor 1.6 90"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Falcon/Chevrolet 400 Dto Ace.', 1046.00, 1646.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Falcon/Chevrolet 400"}');
CALL spProductoAlta ('Filtro de habitaculo ERCIF', 'Filtro de habitaculo  ERCIF Peugeot 405 Dto Ace.', 2276.00, 3581.00, 'ERCIF', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Peugeot 405"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat 128 Dto Ace', 888.00, 1397.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat 128"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault 4/8/12 Dto Ace.', 565.00, 889.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 4/8/12"}');
CALL spProductoAlta ('Filtro de aceite BARDFILT', 'Filtro de aceite BARDFILT', 635.00, 999.00, 'BARDFIL', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "No especificado"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot-205/306/Partner/Citroen/Berlingo', 508.00, 800.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot-205/306/Partner/Citroen/Berlingo"}');
CALL spProductoAlta ('Filtro de aire MOTORCRAFT', 'Filtro de aire MOTORCRAFT Ford Escort 89 93 Dto Ace', 614.00, 966.00, 'MOTORCRAFT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Escort 89 93"}');
CALL spProductoAlta ('Filtro de habitaculo MANN', 'Filtro de habitaculo MANN Toyota Hilux 2.5 3.0-Daihatsu-Lexus-Subaru', 1271.00, 2000.00, 'MANN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Toyota Hilux 2.5 3.0-Daihatsu-Lexus-Subaru"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aceite MANN Renault Sandero-Stepway-Symbol-Express 1.6-Kangoo 1.6 1.9 Diesel-Duster 1.6', 1020.00, 1605.00, 'MANN', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault Sandero-Stepway-Symbol-Express 1.6-Kangoo 1.6 1.9 Diesel-Duster 1.6"}');
CALL spProductoAlta ('Filtro de habitaculo MANN', 'Filtro de habitaculo MANN Renault Clio-Kangoo-Megane-Scenic', 1375.00, 2163.00, 'MANN', 2, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Renault Clio-Kangoo-Megane-Scenic"}');
CALL spProductoAlta ('Filtro de comb. MANN', 'Filtro de comb. MANN Renault Oroch-Megane-Clio-Citroen C3 C4 Picaso-Peugeot 206 207 3008 306 307', 1163.00, 1830.00, 'MANN', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Oroch-Megane-Clio-Citroen C3 C4 Picaso-Peugeot 206 207 3008 306 307"}');
CALL spProductoAlta ('Filtro de aire WIX', 'Filtro de aire WIX Renault Clio-Kangoo-Logan-Megane-Sandero-Scenic-Symbol', 1144.00, 1800.00, 'WIX', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Clio-Kangoo-Logan-Megane-Sandero-Scenic-Symbol"}');
CALL spProductoAlta ('Filtro de comb. MANN', 'Filtro de comb. MANN VW Amarok', 11280.00, 17744.00, 'MANN', 3, 'filtro', '{"tipo": "Combustible", "vehiculo": "VW Amarok"}');
CALL spProductoAlta ('Filtro pack MANN', 'Filtro pack MANN Toyota Hilux 2.5 3.0', 7140.00, 11232.00, 'MANN', 3, 'filtro', '{"tipo": "Pack", "vehiculo": "Toyota Hilux 2.5 3.0"}');
CALL spProductoAlta ('Filtro pack MANN', 'Filtro pack MANN Toyota Hilux-2 (sin Habitaculo)', 6946.00, 10927.00, 'MANN', 2, 'filtro', '{"tipo": "Pack", "vehiculo": "Toyota Hilux-2 (sin Habitaculo)"}');
CALL spProductoAlta ('Filtro pack WIX', 'Filtro pack WIX Peugeot-Citroen-Ford', 8544.00, 13440.00, 'WIX', 3, 'filtro', '{"tipo": "Pack", "vehiculo": "Peugeot-Citroen-Ford"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire WEGA Nissan Frontier/Renault Alaskan', 2488.00, 3914.00, 'WEGA', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Nissan Frontier/Renault Alaskan"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite FRAM Mercedes Benz Vito-Nissan Frontier', 2560.00, 4027.00, 'FRAM', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz Vito-Nissan Frontier"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Nissan Frontier', 5492.00, 8639.00, 'FRAM', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Nissan Frontier"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire WEGA Vw Gol/Caddy/Saveiro/', 1201.00, 1890.00, 'WEGA', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Gol/Caddy/Saveiro/"}');
CALL spProductoAlta ('Filtro de habitaculo', 'Filtro de habitaculo Nissan kicks-Renault Captur/logan/Sandero', 1473.00, 2318.00, 'NISSAN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Nissan kicks-Renault Captur/logan/Sandero"}');
CALL spProductoAlta ('Filtro de habitaculo', 'Filtro de habitaculo Nissan Frontier-Renault Duster 10/Logan7/Oroch 16/Sandero', 1287.00, 2025.00, 'NISSAN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Nissan Frontier-Renault Duster 10/Logan7/Oroch 16/Sandero"}');
CALL spProductoAlta ('Filtro de aire Masterfilt', 'Filtro de aire Masterfilt Fiat Duna/Uno Dto. Ace.', 992.00, 1561.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Duna/Uno"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Vw Passat Dto. Ace.', 1773.00, 2789.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Passat"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat Uno Turbo Diesel Dto Ace', 1681.00, 2645.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Uno Turbo Diesel"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Ford Fiesta Dto. Ace.', 1222.00, 1923.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Fiesta"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat Duna/Fiorino Dto Ace.', 1198.00, 1885.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Duna/Fiorino"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Trafic Diesel Dto Ace.', 1866.00, 2936.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Trafic Diesel"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat Uno 70/Tempra 1.6 Dto Ace.', 1212.00, 1907.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Uno 70/Tempra 1.6"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Vw Passat Dto Ace.', 1773.00, 2789.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Passat"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT  Vw Polo Dto Ace.', 1254.00, 1973.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "VW Polo"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Taunus Ghia/Ford Falcon/Perkins Potenciado Dto Ace.', 1353.00, 2129.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Taunus Ghia/Ford Falcon/Perkins Potenciado"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat 128 Dto Ace.', 0.00, 0.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat 128"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot 504 Dto Ace.', 2442.00, 3842.00, 'MASTERFILT', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 504"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Twinco Dto Ace.', 1222.00, 1923.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Twinco"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Deutz  AX80/Perkins 6 cil Dto Ace.', 3598.00, 5660.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Deutz AX80/Perkins 6 cil"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Mercedes Benz  180 Dto Ace', 3630.00, 5710.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Mercedes Benz 180"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtrode aire MASTERFILT Torino/tsx/gr/zx Dto Ace.', 2058.00, 3238.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Torino/tsx/gr/zx"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Renault Clio Megane Dto Ace.', 1320.00, 2077.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Clio Megane"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Chevrolet motor 1400 Dto Ace.', 1320.00, 2077.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet motor 1400"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT  Fiat Uno 70/ Tempra 1.6 Dto Ace.', 1213.00, 1909.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Uno 70/ Tempra 1.6"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT secundario AMP86/Scania 111 Dto Ace', 4471.00, 7033.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Secundario AMP86/Scania 111"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Deutz chico A 30/40/65/55 Dto Ace', 1536.00, 2417.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aceite", "vehiculo": "Deutz chico A 30/40/65/55"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Citroen Dto Ace', 1296.00, 2039.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Citroen"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Renault Megane Dto Ace.', 1631.00, 2566.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Megane"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT  Fiat Duna diesel Dto Ace.', 1477.00, 2324.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat Duna diesel"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Indenor 6 cilindros Dto Ace.', 1537.00, 2418.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Indenor 6 cilindros"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Renault 9/11/Gol/Scort/Saveiro Dto Ace.', 1346.00, 2118.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Renault 9/11/Gol/Scort/Saveiro"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Fiat Camion 619/673/697 Dto Ace.', 2585.00, 4067.00, 'MASTERFILT', 8, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat Camion 619/673/697"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtrto de comb. MASTERFILT Renault Express/Clio Diesel Dto Ace.', 1163.00, 1830.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Renault Express/Clio Diesel"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Univelsal trampa de agua Dto Ace.', 603.00, 949.00, 'MASTERFILT', 9, 'filtro', '{"tipo": "Combustible", "vehiculo": "Universal trampa de agua"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz  1215/1620 Dto Ace.', 2668.00, 4197.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 1215/1620"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Trafic Diesel(Cav. Larg.) Dto Ace.', 1537.00, 2418.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Trafic Diesel (Cav. Larg.)"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Mercedes Benz 180 Dto Ace.', 1417.00, 2229.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Mercedes Benz 180"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Peugeot 505/Renault Express Dto Ace.', 618.00, 973.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot 505/Renault Express"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Peugeot 206 diesel/Parrtner Dto Ace.', 1206.00, 1898.00, 'MASTERFILT', 40, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot 206 diesel/Partner"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro de comb. MASTERFILT Fiat Tractor 400/500/700 Dto Ace.', 2585.00, 4067.00, 'MASTERFILT', 8, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat Tractor 400/500/700"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Express Diesel/Clio Diesel Dto Ace.', 1537.00, 2418.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aceite", "vehiculo": "Express Diesel/Clio Diesel"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz 608 Dto Ace.', 1801.00, 2833.00, 'MASTERFILT', 9, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 608"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz 608 Dto Ace.', 1801.00, 2833.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 1633"}');
CALL spProductoAlta ('Filtro de aire FRAM', 'Filtro de aceite MASTERFILT Mercedes Benz  1633 Dto Ace.', 3573.00, 5621.00, 'FRAM', 6, 'filtro', '{"tipo": "Aire", "vehiculo": "Hyundai Rover"}');
CALL spProductoAlta ('Filtro de aire FRAM', 'Filtro de aire FRAM Hyundai Rover Dto Ace', 0.00, 0.00, 'FRAM', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Nissan Terrano"}');
CALL spProductoAlta ('Filtro de aire FRAM', 'Filtro de aire FRAM Nissan Terrano Dto Ace.', 0.00, 0.00, 'FRAM', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Chevrolet Vectra 2.0"}');
CALL spProductoAlta ('Filtro de aire FRAM', 'Filtro de aire FRAM Chevrolet Vectra 2.0 Dto Ace', 0.00, 0.00, 'FRAM', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Sandero Stepway"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de aire FRAM Renault Sandero Stepway Dto Ace.', 0.00, 0.00, 'FRAM', 2, 'filtro', '{"tipo": "Combustible", "vehiculo": "Isuzu 3.1"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Isuzu 3.1 Dto Ace.', 0.00, 0.00, 'FRAM', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Chevrolet S10 2.8 Nissan Frontier"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Chevrolet S10 2.8 Nissan Frontier Dto Ace.', 0.00, 0.00, 'FRAM', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Mercedes Benz Sprinter 308 cdi"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Mercedes Benz Sprinter 308 cdi Dto Ace.', 0.00, 0.00, 'FRAM', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Toyota Hilux 05 15"}');
CALL spProductoAlta ('Filtro de comb. FRAM', 'Filtro de comb. FRAM Toyota Hilux 05 15  Dto Ace.', 0.00, 0.00, 'FRAM', 4, 'filtro', '{"tipo": "Combustible", "vehiculo": "Vw Polo/Passat Gol G4"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de comb. FRAM Vw Polo/Passat Gol G4 Dto Ace.', 0.00, 0.00, 'WEGA', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Ranger 3.0 08"}');
CALL spProductoAlta ('Filtro de habitaculo WEGA', 'Filtro de aire WEGA  Ford Ranger 3.0 08 Dto Ace', 4989.00, 7848.00, 'WEGA', 1, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Chevrolet Corsa/Fun/Vectra"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de habitaculo WEGA Chevrolet Corsa/Fun/Vectra', 1537.00, 2418.00, 'WEGA', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Master 2.5/2.8 05"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire WEGA Renault Master  2.5/2.8 05 Dto Ace', 2136.00, 3360.00, 'WEGA', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 11/19"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de aire WEGA Renault 11/19 Dto Ace', 2883.00, 4535.00, 'MOTORCRAFT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Transit 2.5"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT Ford Transit 2.5 Dto Ace', 1441.00, 2267.00, 'MOTORCRAFT', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford Ranger 4.0-2.5 Explorer 94/97"}');
CALL spProductoAlta ('Filtro de comb. MOTORCRAFT', 'Filtro de comb. MOTORCRAFT Ford Ranger 4.0-2.5 Eplorer 94/97 Dto Ace.', 1393.00, 2192.00, 'MOTORCRAFT', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Ford F4000 motor cummins"}');
CALL spProductoAlta ('Filtro de comb. FLEETGUARD', 'Filtro de comb. MOTORCRAFT Ford F4000 motor cummins Dto Ace', 3796.00, 5972.00, 'FLEETGUARD', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "Motores Cummins"}');
CALL spProductoAlta ('Filtro de agua refrigerante FLEETGUARD', 'Filtro de comb. FLEETGUARD Motores Cummins Dto Ace', 3018.00, 4748.00, 'FLEETGUARD', 8, 'filtro', '{"tipo": "Agua", "vehiculo": "Maquinarias Agricolas"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de agua refrigerante FLEETGUARD Maquinarias Agricolas Dto Ace', 3460.00, 5443.00, 'WEGA', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Kuga/Focus"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aire WEGA Ford Kuga/Focus', 2735.00, 4303.00, 'FRAM', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Ford Focus"}');
CALL spProductoAlta ('Filtro de habitaculo', 'Filtro de aceite FRAM Ford Focus', 1965.00, 3091.00, 'UNIVERSAL', 1, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Ford Focus/Kuga II 13"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de habitaculo Ford Focus/Kuga II 13', 1826.00, 2873.00, 'WEGA', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 207"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aire WEGA Peugeot 207', 2019.00, 3176.00, 'FRAM', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Peugeot 207"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aceite FRAM Peugeot 207', 2235.00, 3516.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault 12 92"}');
CALL spProductoAlta ('Filtro de habitaculo WIX', 'Filtro de aire MASTERFILT Renault 12 92 Dto Ace', 874.00, 1375.00, 'WIX', 1, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Toyota Corolla/Hilux"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de habitaculo WIX Toyota Corolla/Hilux', 2651.00, 4171.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Uno"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Fiat Uno', 1212.00, 1907.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 505/504"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot 505/504', 1007.00, 1585.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 504/Dodge 1500"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de aire MASTERFILT Peugeot 504/Dodge 1500', 670.00, 1054.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Ansi Tubular"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire MASTERFILT Ansi Tubular', 1026.00, 1614.00, 'WEGA', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Master 2.5/2.8 05"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire WEGA Renault Master 2.5/2.8 05', 2256.00, 3549.00, 'WEGA', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Escort/Fiesta/Orion/Suzuki Samurai"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aire WEGA Ford Escort/Fiesta /Orion/Suzuki Samurai Dto Ace', 1392.00, 2190.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 1633"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz 1633', 3823.00, 6014.00, 'MASTERFILT', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 1938/1935"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz 1938/1935', 4274.00, 6724.00, 'MASTERFILT', 5, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz 600"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro de aceite MASTERFILT Mercedes Benz 600', 1636.00, 2574.00, 'MASTERFILT', 9, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz L 710/LQ813"}');
CALL spProductoAlta ('Filtro de aire JAPANPARTS', 'Filtro de aceite MASTERFILT Mercedes Benz L 710/LQ813', 1402.00, 2206.00, 'JAPANARTS', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Daihatsu Ferosa"}');
CALL spProductoAlta ('Filtro de aire JAPANPARTS', 'Filtro de aire JAPAMPARTS Daihatsu Ferosa', 3069.00, 4828.00, 'JAPANARTS', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Toyota Supra 3.0 93"}');
CALL spProductoAlta ('Filtro de aire JAPANPARTS', 'Filtro de aire JAPANPARTS Toyota Supra 3.0 93>', 2383.00, 3749.00, 'JAPANARTS', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Suzuki"}');
CALL spProductoAlta ('Filtro de aire JAPANPARTS', 'Filtro de aire JAPANPARTS Suzuki', 1447.00, 2277.00, 'JAPANARTS', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Kia Sportage 01"}');
CALL spProductoAlta ('Filtro de aire JAPANPARTS', 'Filtro de aire JAPANPARTS Kia Sportage 01', 1905.00, 2997.00, 'JAPANARTS', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Suzuki Van 1.6 Vitara SP"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aire JAPANPARTS Suzuki Van 1.6 Vitara SP', 904.00, 1422.00, 'WEGA', 3, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Ecosport/Kinetic 12"}');
CALL spProductoAlta ('Filtro de aire HASTING', 'Filtro de aire WEGA Ford Ecosport/Kinetic 12', 1922.00, 3024.00, 'HASTING', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Ford Ka/Ecosport"}');
CALL spProductoAlta ('Filtro de comb. MANN', 'Fitro de aire HASTING Ford Ka/Ecosportd', 1723.00, 2711.00, 'MANN', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Fiat Palio/Strada/Siena 1.0/1.5/1.6/16v"}');
CALL spProductoAlta ('Filtro de aire WIX', 'Filtro de comb. MANN Fiat Palio/Strada/Siena 1.0/1.5/1.6/16v', 1613.00, 2538.00, 'WIX', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Fiat Palio/1.0/1.3/Siena/Strada"}');
CALL spProductoAlta ('Filtro de habitaculo MANN', 'Filtro de aire WIX Fiat Palio/1.0/1.3/Siena/Strada', 1590.00, 2502.00, 'MANN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Fiat Idea/Palio/Strada/Siena"}');
CALL spProductoAlta ('Filtro de aire MORENO', 'Filtro de habitaculo MANN Fiat Idea/Palio/Strada/Siena', 2223.00, 3497.00, 'MORENO', 1, 'filtro', '{"tipo": "Aire", "vehiculo": "Nissan NP300 Frontier 2.3 16"}');
CALL spProductoAlta ('Filtro de aire AEQUIPE', 'Filtro de aire MORENO Nissan NP300 Frontier 2.3 16', 3239.00, 5095.00, 'AEQUIPE', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Dustercap/Kannii"}');
CALL spProductoAlta ('Filtro de habitaculo MANN', 'Filtro aire AEQUIPE Renault Dustercap/Kannii', 2128.00, 3348.00, 'MANN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Nissan Frontier 2.3/Renault Alaskan 2.3"}');
CALL spProductoAlta ('Filtro de comb. MANN', 'Filtro de habitaculo MANN Nissan Frontier 2.3/Renault Alaskan 2.3', 4371.00, 6876.00, 'MANN', 6, 'filtro', '{"tipo": "Combustible", "vehiculo": "M.Benz Vito/Nissan Frontier 2.3 15/Renaul Master 2./Trafic 16"}');
CALL spProductoAlta ('Filtro ede aire MANN', 'Filtro de comb. MANN M.Benz Vito/Nissan Frontier 2.3 15 /Renaul Master 2./Trafic 16', 7509.00, 11812.00, 'MANN', 4, 'filtro', '{"tipo": "Aire", "vehiculo": "Nissan Frontier 2.3 16"}');
CALL spProductoAlta ('Filtro de aceite WEGA', 'Filtro ede aire MANN Nissan Frontier 2.3 16', 4820.00, 7582.00, 'WEGA', 4, 'filtro', '{"tipo": "Aceite", "vehiculo": "Peugeot 408"}');
CALL spProductoAlta ('Filtro de aire WEGA', 'Filtro de aceite WEGA Peugeot 408', 1828.00, 2876.00, 'WEGA', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "Peugeot 408"}');
CALL spProductoAlta ('Filtro pack MASTERFILT', 'Filtro de aire WEGA Peugeot 408', 2242.00, 3527.00, 'MASTERFILT', 0, 'filtro', '{"tipo": "Pack", "vehiculo": "Chevrolet S10 MWM/Grand Blazer/Nissan Frontier"}');
CALL spProductoAlta ('Filtro pack MASTERFILT', 'Filtro pack MASTERFILT Chevrolet S10 MWM/Grand Blazer/Nissan Frontier', 4380.00, 6890.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Pack", "vehiculo": "Renault Duter Oroch 2.0"}');
CALL spProductoAlta ('Filtro pack MASTERFILT', 'Filtro pack MASTERFILT Renault Duter Oroch 2.0', 4847.00, 7625.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Pack", "vehiculo": "Toyota Hilux/SW4 2.4 2.8 TDI"}');
CALL spProductoAlta ('Filtro pack MASTERFILT', 'Filtro pack MASTERFILT Toyota Hilux/SW4 2.4 2.8 TDI', 6669.00, 10491.00, 'MASTERFILT', 4, 'filtro', '{"tipo": "Pack", "vehiculo": "Vw Amarock 2.0 tdi"}');
CALL spProductoAlta ('Filtro de comb. MASTERFILT', 'Filtro pack MASTERFILT Vw Amarock 2.0 tdi', 8826.00, 13884.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Combustible", "vehiculo": "Peugeot 106 1.4/205 1.4/Partner/Renault Clio"}');
CALL spProductoAlta ('Filtro de aire MANN', 'Filtro de comb. MASTERFILT Peugeot 106 1.4/205 1.4/Partner/Renault Clio', 974.00, 1533.00, 'MANN', 10, 'filtro', '{"tipo": "Aire", "vehiculo": "Renault Kangoo II/Logan"}');
CALL spProductoAlta ('Filtro de aceite MANN', 'Filtro de aire MANN Renault Kangoo II/Logan', 1780.00, 2800.00, 'MANN', 6, 'filtro', '{"tipo": "Aceite", "vehiculo": "M.BENZ Clc/klasse C/E/M"}');
CALL spProductoAlta ('Filtro de habitaculo WEGA', 'Filtro de aceite MANN M.BENZ Clc/klasse C/E/M', 8761.00, 13782.00, 'WEGA', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Clase C 180/C220/230 CDI /22,2 CDI 04"}');
CALL spProductoAlta ('Filtro de aire MAHLE', 'Filtro de habitaculo WEGA Clase C 180/C220/230  CDI /22,2 CDI 04', 3057.00, 4809.00, 'MAHLE', 0, 'filtro', '{"tipo": "Aire", "vehiculo": "M.Benz"}');
CALL spProductoAlta ('Filtro de comb. NISSAN GROUP', 'Filtro de aire MAHLE M.Benz', 5490.00, 8636.00, 'NISSAN', 0, 'filtro', '{"tipo": "Combustible", "vehiculo": "-"}');
CALL spProductoAlta ('Filtro de habitaculo liviano MANN', 'Filtro de comb. NISSAN GROUP', 15702.00, 24700.00, 'MANN', 0, 'filtro', '{"tipo": "Habitu00e1culo", "vehiculo": "Toyota Hilux 2.5 3.0"}');
CALL spProductoAlta ('Filtro de aire MASTERFILT', 'Filtro de habitaculo liviano MANN Toyota Hilux 2.5 3.0', 3987.00, 6272.00, 'MASTERFILT', 2, 'filtro', '{"tipo": "Aire", "vehiculo": "Vw Amarok"}');
CALL spProductoAlta ('FILTRO PACK MANN', 'Filtro de aire MASTERFILT equivalente con mann Vw Amarok', 4132.00, 6500.00, 'MANN', 1, 'filtro', '{"tipo": "Pack", "vehiculo": "TOYOTA HILUX 2.5-3.0 C/N HABITACULO"}');
CALL spProductoAlta ('Filtro MANN', 'FILTRO PACK MANN TOYOTA HILUX 2.5-3.0 C/N HABITACULO', 0.00, 0.00, 'MANN', 5, 'filtro', '{"tipo": "-", "vehiculo": "Peugeot 306 12 -Citroen C41.6 08"}');
CALL spProductoAlta ('Filtro de aceite MASTERFILT', 'Filtro MANN Peugeot 306 12 -Citroen C41.6 08', 0.00, 0.00, 'MASTERFILT', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Megane/twingo"}');
CALL spProductoAlta ('Filtro de aceite FRAM', 'Filtro de aceite MASTERFILT Megane/twingo', 1365.00, 2148.00, 'FRAM', 1, 'filtro', '{"tipo": "Aceite", "vehiculo": "Mercedes Benz Vito-Nissan Frontier"}');
CALL spProductoAlta ('Llanta 17x7 Toyota', 'Llanta 17x7 Toyota chapa original gris 6 agujeros (usada)', 12714.00, 20000.00, 'TOYOTA', 0, 'llanta', '{"rodado": "17", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Ranger', 'Llanta 16x7 Ranger chapa original gris 6 agujeros (usada)', 13000.00, 20449.00, 'FORD RANGER', 6, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 S10', 'Llanta 16x7 S10 original chapa gris 6 agujeros (usada)', 12700.00, 19978.00, 'CHEVROLET S10', 4, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x6.5 Toyota', 'Llanta 16x6.5 Toyota chapa original negra 5 agujeros (usada)', 12000.00, 18876.00, 'TOYOTA', 8, 'llanta', '{"rodado": "16", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x6.5 Sprinter', 'Llanta 16x6.5 Sprinter chapa original gris 5 agujeros nueva', 23000.00, 36179.00, 'SPRINTER', 2, 'llanta', '{"rodado": "16", "ancho": "6.5", "material": "Chapa", "estado": "Nueva"}');
CALL spProductoAlta ('Llanta 14x5.5 Ford Ka', 'Llanta 14x5.5 Ford Ka chapa original 4 agujeros (usada)', 10000.00, 15730.00, 'FORD KA', 9, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta Renault 13x5.5', 'Llanta Renault 13x5.5 negra 4 agujeros nueva', 15000.00, 23595.00, 'RENAULT', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "No especifica", "estado": "Nueva"}');
CALL spProductoAlta ('Llanta 15x6 Peugeot', 'Llanta 15x6 Peugeot Citroen chapa original negra 4 agujeros nueva', 15000.00, 23595.00, 'PEUGEOT CITROEN', 5, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Nueva"}');
CALL spProductoAlta ('Llanta 15x6 Renault', 'Llanta 15x6 Renault Sandero chapa original 5 agujeros negra nueva', 16000.00, 25168.00, 'RENAULT SANDERO', 2, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Nueva"}');
CALL spProductoAlta ('Llanta 15x6 Ford', 'Llanta 15x6 Ford chapa original 4 agujeros negra nueva', 23000.00, 36179.00, 'FORD KA', 5, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Nueva"}');
CALL spProductoAlta ('Llanta 15x7 Chevrolet', 'Llanta 15x7 Chevrolet S10 5 agujeros gris (usada)', 12000.00, 18876.00, 'CHEVROLET S10', 15, 'llanta', '{"rodado": "15", "ancho": "7", "material": "No especifica", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Chevrolet', 'Llanta 15x7 Chevrolet D20 gris 6 agujeros usada', 12700.00, 19978.00, 'CHEVROLET D20', 2, 'llanta', '{"rodado": "15", "ancho": "7", "material": "No especifica", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Renault', 'Llanta 15x6 Renault Traffic 4 agujeros gris usada', 12100.00, 19034.00, 'RENAULT TRAFFIC', 6, 'llanta', '{"rodado": "15", "ancho": "6", "material": "No especifica", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Ford', 'Llanta 15x6 Ford Ecosport chapa original 4 agujeros usada', 12000.00, 18876.00, 'FORD ECOSPORT', 6, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x6.5 Toyota', 'Llanta 16x6.5 Toyota chapa original mod 08 usada', 12500.00, 19663.00, 'TOYOTA', 6, 'llanta', '{"rodado": "16", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x6 chapa', 'Llanta 16x6 chapa original Toyota mod viejo usada', 12000.00, 18876.00, 'TOYOTA', 1, 'llanta', '{"rodado": "16", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x6.5 Renault', 'Llanta 16x6.5 Renault Master chapa original usada', 38143.00, 59999.00, 'RENAULT MASTER', 8, 'llanta', '{"rodado": "16", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6.5 Nissan', 'Llanta 15x6.5 Nissan chapa original usada', 12000.00, 18876.00, 'NISSAN', 4, 'llanta', '{"rodado": "15", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 chapa', 'Llanta 15x7 chapa original Fiat Iveco 5 agujeros usada', 10000.00, 15730.00, 'FIAT IVECO', 4, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Chevrolet', 'Llanta 15x6 Chevrolet Meriva chapa original usada', 12000.00, 18876.00, 'CHEVROLET MERIVA', 2, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Ford', 'Llanta 15x6 Ford Focus chapa original 4 agujeros usada', 11500.00, 18090.00, 'FORD FOCUS', 2, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Chevrolet', 'Llanta 15x6 Chevrolet Prisma chapa original usada', 11500.00, 18090.00, 'CHEVROLET PRISMA', 3, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Renault', 'Llanta 15x6 Renault Sandero chapa original usada', 10500.00, 16517.00, 'RENAULT SANDERO', 1, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 VW Bora', 'Llanta 15x6 VW Bora chapa original usada', 13000.00, 20449.00, 'VW BORA', 6, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 Fiat Siena', 'Llanta 14x6 Fiat Siena original chapa usada', 5340.00, 8400.00, 'FIAT SIENNA', 1, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 Chevrolet LUV', 'Llanta 14x6 Chevrolet LUV chapa original usada', 12500.00, 19663.00, 'CHEVROLET LUV', 13, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 VW Senda Gol', 'Llanta 13x5.5 VW Senda Gol chapa original usada', 11000.00, 17303.00, 'VW SENDA GOL', 23, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Renault Clio', 'Llanta 13x5.5 Renault Clio chapa original usada', 3496.00, 5500.00, 'RENAULT CLIO', 13, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Fiesta', 'Llanta 13x5.5 Ford Fiesta chapa original usada', 8000.00, 12584.00, 'FORD FIESTA', 12, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Chevrolet Corsa', 'Llanta 13x5.5 Chevrolet Corsa chapa original usada', 10000.00, 15730.00, 'CHEVROLET CORSA', 2, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Dodge 1500', 'Llanta 13x5.5 Dodge 1500 chapa original usada', 10000.00, 15730.00, 'DODGE 1500', 3, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Honda', 'Llanta 13x5.5 Honda chapa original usada', 10000.00, 15730.00, 'HONDA', 1, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Renault 9', 'Llanta 13x5.5 Renault 9 chapa original usada', 8000.00, 12584.00, 'RENAULT 9', 2, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Sierra', 'Llanta 13x5.5 Ford Sierra chapa original usada', 10000.00, 15730.00, 'FORD SIERRA', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x5.5 Peugeot 504', 'Llanta 14x5.5 Peugeot 504 chapa original usada', 10000.00, 15730.00, 'PEUGEOT 504', 1, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x5.5 Ford Ecosport-Fiesta', 'Llanta 14x5.5 Ford Ecosport-Fiesta chapa original usada', 11000.00, 17303.00, 'FORD ECOSPORT - FIESTA', 34, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x5.5 Peugeot Partner', 'Llanta 14x5.5 Peugeot Partner chapa original usada', 11000.00, 17303.00, 'PEUGEOT PARTNER', 6, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Nissan', 'Llanta 15x6 Nissan chapa original usada', 12000.00, 18876.00, 'NISSAN', 3, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Toyota mod viejo', 'Llanta 15x6 Toyota mod viejo chapa original usada', 12000.00, 18876.00, 'TOYOTA', 15, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 VW Polo', 'Llanta 15x6 VW Polo chapa original usada', 11500.00, 18090.00, 'VW POLO', 3, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Peugeot Partner', 'Llanta 15x6 Peugeot Partner chapa original usada', 14000.00, 22022.00, 'PEUGEOT PARTNER', 7, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 Ford Transit', 'Llanta 14x6 Ford Transit chapa original usada', 15000.00, 23595.00, 'FORD TRANSIT', 2, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 VW Suran', 'Llanta 14x6 VW Suran chapa original usada', 13000.00, 20449.00, 'VW SURAN', 2, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 VW Passat', 'Llanta 14x6 VW Passat chapa original usada', 14000.00, 22022.00, 'VW PASSAT', 1, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Fiat Iveco', 'Llanta 15x6 Fiat Iveco chapa original usada', 15000.00, 23595.00, 'FIAT IVECO', 2, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Ford Focus', 'Llanta 15x6 Ford Focus chapa original usada', 14000.00, 22022.00, 'FORD FOCUS', 1, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Falcon', 'Llanta 13x5.5 Ford Falcon chapa original usada', 13000.00, 20449.00, 'FORD FALCON', 2, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x5.5 Ford Taunus', 'Llanta 14x5.5 Ford Taunus chapa original usada', 13000.00, 20449.00, 'FORD TAUNUS', 2, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Fiat 147', 'Llanta 13x5.5 Fiat 147 chapa original usada', 13000.00, 20449.00, 'FIAT 147', 1, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6.5 Ford Ranger', 'Llanta 15x6.5 Ford Ranger chapa original usada', 16000.00, 25168.00, 'FORD RANGER', 3, 'llanta', '{"rodado": "15", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6.5 Ford Escort', 'Llanta 15x6.5 Ford Escort chapa original usada', 15000.00, 23595.00, 'FORD ESCORT', 4, 'llanta', '{"rodado": "15", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 VW Amarok', 'Llanta 16x7 VW Amarok chapa original usada', 17000.00, 26741.00, 'VW AMAROK', 4, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Chevrolet D20', 'Llanta 16x7 Chevrolet D20 chapa original usada', 16000.00, 25168.00, 'CHEVROLET D20', 2, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Toyota', 'Llanta 16x7 Toyota chapa original usada', 15000.00, 23595.00, 'TOYOTA', 2, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Chevrolet Custom', 'Llanta 16x7 Chevrolet Custom chapa original usada', 15000.00, 23595.00, 'CHEVROLET CUSTOM', 3, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Chevrolet D20', 'Llanta 15x7 Chevrolet D20 chapa original usada', 15000.00, 23595.00, 'CHEVROLET D20', 2, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 chapa original', 'Llanta 15x6 chapa original usada', 14000.00, 22022.00, 'None', 3, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Taunus', 'Llanta 13x5.5 Ford Taunus chapa original usada', 13000.00, 20449.00, 'FORD TAUNUS', 2, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 10.00x16 agricola', 'Llanta 10.00x16 agricola chapa original usada', 23000.00, 36179.00, 'None', 2, 'llanta', '{"rodado": "10", "ancho": "16", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x5.5 Peugeot 504', 'Llanta 15x5.5 Peugeot 504 chapa original usada', 9000.00, 14157.00, 'PEUGEOT 504', 1, 'llanta', '{"rodado": "15", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 17x8 Ford Focus', 'Llanta 17x8 Ford Focus aleacion usada', 21000.00, 33033.00, 'FORD FOCUS', 4, 'llanta', '{"rodado": "17", "ancho": "8", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Amarok', 'Llanta 15x7 Amarok aleacion usada', 23000.00, 36179.00, 'AMAROK', 4, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Ford Ecosport', 'Llanta 15x7 Ford Ecosport aleacion usada', 19000.00, 29887.00, 'FORD ECOSPORT', 2, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Chevrolet Corsa', 'Llanta 13x5.5 Chevrolet Corsa aleacion usada', 14000.00, 22022.00, 'CHEVROLET CORSA', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Fiesta', 'Llanta 13x5.5 Ford Fiesta aleacion usada', 15000.00, 23595.00, 'FORD FIESTA', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Fiat', 'Llanta 13x5.5 Fiat aleacion usada', 14000.00, 22022.00, 'FIAT', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 VW Senda', 'Llanta 13x5.5 VW Senda aleacion usada', 14000.00, 22022.00, 'VW SENDA GOL', 1, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Fiesta dorada', 'Llanta 13x5.5 Ford Fiesta dorada aleacion usada', 16000.00, 25168.00, 'FORD FIESTA', 2, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 VW Bora', 'Llanta 15x7 VW Bora aleacion usada original', 25000.00, 39325.00, 'VW BORA', 4, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Renault', 'Llanta 15x7 Renault aleacion usada', 22000.00, 34606.00, 'RENAULT', 4, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6.5 VW Renault', 'Llanta 14x6.5 VW Renault aleacion usada', 13986.00, 22000.00, 'VW RENAULT', 4, 'llanta', '{"rodado": "14", "ancho": "6.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 VW Amarok', 'Llanta 16x7 VW Amarok aleacion negra usada', 22000.00, 34606.00, 'AMAROK', 0, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Chevrolet S10', 'Llanta 15x7 Chevrolet S10 aleacion usada', 18000.00, 28314.00, 'CHEVROLET S10', 5, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Chevrolet D20', 'Llanta 15x7 Chevrolet D20 aleacion usada', 17000.00, 26741.00, 'CHEVROLET D20', 4, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x7 Binno Renault', 'Llanta 14x7 Binno Renault aleacion usada', 17000.00, 26741.00, 'RENAULT BINNO', 4, 'llanta', '{"rodado": "14", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x7 VW', 'Llanta 14x7 VW aleacion usada', 15000.00, 23595.00, 'VW', 4, 'llanta', '{"rodado": "14", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 Ford', 'Llanta 14x6 Ford aleacion usada', 16000.00, 25168.00, 'FORD', 4, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x6 Renault (fallada!)', 'Llanta 13x6 Renault (fallada!)', 0.00, 0.00, 'RENAULT', 4, 'llanta', '{"rodado": "13", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x7 Fiat', 'Llanta 14x7 Fiat aleacion usada', 14000.00, 22022.00, 'FIAT', 4, 'llanta', '{"rodado": "14", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x7 VW', 'Llanta 14x7 VW aleacion usada (2)', 14000.00, 22022.00, 'VW', 2, 'llanta', '{"rodado": "14", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x5.5 Ford', 'Llanta 14x5.5 Ford aleacion usada', 14000.00, 22022.00, 'FORD', 2, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x6 Fiat', 'Llanta 13x6 Fiat aleacion usada', 13500.00, 21236.00, 'FIAT', 2, 'llanta', '{"rodado": "13", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 Ford', 'Llanta 14x6 Ford aleacion usada 3 rayos', 13000.00, 20449.00, 'FORD', 3, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Chevrolet Corsa', 'Llanta 13x5.5 Chevrolet Corsa aleacion usada 8 rayos', 13000.00, 20449.00, 'CHEVROLET CORSA', 5, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Renault 18', 'Llanta 13x5.5 Renault 18 aleacion usada', 10000.00, 15730.00, 'RENAULT 18', 2, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Peugeot 504', 'Llanta 15x6 Peugeot 504 aleacion usada', 3900.00, 6135.00, 'PEUGEOT 504', 3, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Fiesta', 'Llanta 13x5.5 Ford Fiesta aleacion usada 16 rayos', 12500.00, 19663.00, 'FORD FIESTA', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Fiat Palio', 'Llanta 13x5.5 Fiat Palio aleacion original usada', 15000.00, 23595.00, 'FIAT PALIO', 4, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x6 Peugeot 505', 'Llanta 14x6 Peugeot 505 aleacion usada', 6000.00, 9438.00, 'PEUGEOT 505', 1, 'llanta', '{"rodado": "14", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 VW Amarok', 'Llanta 16x7 VW Amarok aleacion usada', 16000.00, 25168.00, 'VW AMAROK', 4, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Ford Focus/D20', 'Llanta 16x7 Ford Focus/D20 aleacion original usada', 15000.00, 23595.00, 'FORD FOCUS/D20', 1, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Ford Focus Ghia', 'Llanta 16x7 Ford Focus Ghia aleacion original usada', 16000.00, 25168.00, 'FORD FOCUS', 1, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Ford F100', 'Llanta 16x7 Ford F100 aleacion usada', 15000.00, 23595.00, 'FORD F100', 1, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 17x8 VW Amarok', 'Llanta 17x8 VW Amarok aleacion original usada', 20000.00, 31460.00, 'VW AMAROK', 1, 'llanta', '{"rodado": "17", "ancho": "8", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Nissan', 'Llanta 15x7 Nissan aleacion original usada', 13000.00, 20449.00, 'NISSAN', 2, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Mitsubishi', 'Llanta 16x7 Mitsubishi aleacion usada', 17000.00, 26741.00, 'MITSUBISHI', 1, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x6 Ecosport', 'Llanta 15x6 Ecosport aleacion usada', 15000.00, 23595.00, 'FORD ECOSPORT', 1, 'llanta', '{"rodado": "15", "ancho": "6", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Escort orig', 'Llanta 13x5.5 Ford Escort orig aleacion usada', 14000.00, 22022.00, 'FORD ESCORT', 1, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x5.5 Ford Vega', 'Llanta 13x5.5 Ford Vega aleacion usada', 14000.00, 22022.00, 'FORD VEGA', 1, 'llanta', '{"rodado": "13", "ancho": "5.5", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Ford F150 con aro', 'Llanta 16x7 Ford F150 con aro nueva', 19000.00, 29887.00, 'FORD F150', 0, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Nueva"}');
CALL spProductoAlta ('Llanta 16x6.5 VW Amarok chapa', 'Llanta 16x6,5 Vw Amarock chapa usada', 17800.00, 28000.00, 'VW AMAROK', 2, 'llanta', '{"rodado": "16", "ancho": "6.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Ford F100', 'Llanta 15x7 Ford F100', 10000.00, 15730.00, 'FORD F100', 1, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 13x3 Fiat', 'Llanta 13x3 Fiat', 5500.00, 8652.00, 'FIAT', 1, 'llanta', '{"rodado": "13", "ancho": "3", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x6 Peugeot 504', 'Llanta 16x6 Peugeot 504', 17000.00, 26741.00, 'PEUGEOT 504', 1, 'llanta', '{"rodado": "16", "ancho": "6", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 14x5.5 Chevrolet /Vw', 'Llanta 14x5,5 Chevrolet /Vw chapa usada', 4600.00, 7236.00, 'CHEVROLET', 0, 'llanta', '{"rodado": "14", "ancho": "5.5", "material": "Chapa", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 16x7 Vw Amarok original', 'Llanta 16x7 Vw Amarock original', 25429.00, 40000.00, 'VW AMAROK', 2, 'llanta', '{"rodado": "16", "ancho": "7", "material": "Aleaciu00f3n", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 19x7 Vw Amarok aluminio', 'Llanta 19x7 Vw Amarock aluminio', 0.00, 0.00, 'VW AMAROK', 0, 'llanta', '{"rodado": "19", "ancho": "7", "material": "Aluminio", "estado": "Usada"}');
CALL spProductoAlta ('Llanta 15x7 Toyota aluminio', 'LLANTA 15X7 TOYOTA ALUMINIO USADO', 10000.00, 15730.00, 'TOYOTA', 0, 'llanta', '{"rodado": "15", "ancho": "7", "material": "Aluminio", "estado": "Usada"}');
CALL spProductoAlta ('GOODYEAR Kelly', '255/75 R15 GOODYEAR Kelly', 58000.00, 91234.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "15", "ancho": "255", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('WINDFORCE', '175/70 R14 WINDFORCE', 19911.00, 31320.00, 'WINDFORCE', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('KUMHO', '145/80 R10 KUMHO', 19224.00, 30240.00, 'KUMHO', 1, 'neumatico', '{"rodado": "10", "ancho": "145", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('DAYTON D300', '215/75 R17.5 DAYTON D300', 104541.00, 164443.00, 'DAYTON', 0, 'neumatico', '{"rodado": "17.5", "ancho": "215", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI', '1100X22 PIRELLI', 50000.00, 78650.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "22", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE B250', '175/65 R14 BRIDGESTONE B250', 22626.00, 35591.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE POTENZA', '225/55 R16 BRIDGESTONE POTENZA', 66582.00, 104734.00, 'BRIDGESTONE', 1, 'neumatico', '{"rodado": "16", "ancho": "225", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT', '245/65 R17 BRIDGESTONE DUELER HT', 69777.00, 109760.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "HT"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT', '245/70 R16 BRIDGESTONE DUELER HT', 84869.00, 133499.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "245", "perfil": "70", "indice": "HT"}');
CALL spProductoAlta ('FIREMAX', '235/60 R16 FIREMAX', 29808.00, 46888.00, 'FIREMAX', 0, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('TRIANGLE', '235/60 R16 TRIANGLE', 27486.00, 43236.00, 'TRIANGLE', 0, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE FIREHAWK 900', '195/65 R15 FIRESTONE FIREHAWK 900 91H', 50909.00, 80080.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "65", "indice": "91H"}');
CALL spProductoAlta ('FIRESTONE F700', '185/65 R14 FIRESTONE F700 86T', 34675.00, 54544.00, 'FIRESTONE', 6, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "65", "indice": "86T"}');
CALL spProductoAlta ('FIRESTONE F700', '185/70 R14 FIRESTONE F700 88T', 21492.00, 27940.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "70", "indice": "88T"}');
CALL spProductoAlta ('WESTLAKE RP18', '195/65 R15 WESTLAKE RP18 91H', 28247.00, 36721.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "65", "indice": "91H"}');
CALL spProductoAlta ('WESTLAKE RP18', '195/55 R15 WESTLAKE RP18 85V', 29916.00, 38891.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "55", "indice": "85V"}');
CALL spProductoAlta ('CENTELLA C/KIT', '7.50X16 CENTELLA C/KIT', 52000.00, 81796.00, 'CENTELLA', 0, 'neumatico', '{"rodado": "16", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER AT 693', '265/65 R17 BRIDGESTONE DUELER AT 693 R112S', 50342.00, 79188.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "R112S"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT 684', '265/65 R17 BRIDGESTONE DUELER HT 684 112T', 83020.00, 130591.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "112T"}');
CALL spProductoAlta ('BRIDGESTONE ECOPIA EP150', '175/70 R14 BRIDGESTONE ECOPIA EP150 84T', 25276.00, 39760.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "84T"}');
CALL spProductoAlta ('TRIANGLE TR668', '7.50 R16 TRIANGLE TR668 14 122L', 60785.00, 95615.00, 'TRIANGLE', 1, 'neumatico', '{"rodado": "16", "ancho": "None", "perfil": "None", "indice": "122L"}');
CALL spProductoAlta ('BRIDGESTONE TURANZA', '235/60 R16 BRIDGESTONE TURANZA', 40511.00, 63724.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('ECWAY XBR1', '295/80 R22.5 ECWAY XBR1', 121000.00, 190333.00, 'ECWAY', 0, 'neumatico', '{"rodado": "22.5", "ancho": "295", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('NEXEN CP321', '205/75 R16C NEXEN CP321', 41548.00, 65355.00, 'NEXEN', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT', '255/70 R16 BRIDGESTONE DUELER HT 111H', 95232.00, 149800.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "255", "perfil": "70", "indice": "111H"}');
CALL spProductoAlta ('FIRESTONE F700', '175/65 R14 FIRESTONE F700', 30972.00, 48719.00, 'FIRESTONE', 5, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE FIREHAWK 900', '185/65 R15 FIRESTONE FIREHAWK 900 85H', 45390.00, 71399.00, 'FIRESTONE', 2, 'neumatico', '{"rodado": "15", "ancho": "185", "perfil": "65", "indice": "85H"}');
CALL spProductoAlta ('FIRESTONE DESTINATION', '235/70 R16 FIRESTONE DESTINATION', 48747.00, 76679.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE DESTINATION A/T', '245/70 R16 FIRESTONE DESTINATION A/T', 75015.00, 117999.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "245", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('WESTLAKE', '185/70 R14 WESTLAKE', 20628.00, 32448.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('WESTLAKE', '195/65 R15 WESTLAKE', 28150.00, 44279.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('FATE EXIMIA PININFARINA SUV', '235/60 R16 FATE EXIMIA PININFARINA SUV', 37763.00, 59400.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('FATE RR HT S2', '235/70 R16 FATE RR HT S2 110/107T', 67641.00, 106400.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "70", "indice": "110/107T"}');
CALL spProductoAlta ('FATE RANGERUNNER H/T SERIE 2', '255/70 R15 FATE RANGERUNNER H/T SERIE 2 112/110T', 60756.00, 95570.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "255", "perfil": "70", "indice": "112/110T"}');
CALL spProductoAlta ('GOODYEAR ARMORTRACK', '205 R16 GOODYEAR ARMORTRACK', 43254.00, 68039.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "15", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('Bridgestone USADA', '225/60 R18 Bridgestone USADA', 41958.00, 66000.00, 'BRIDGESTONE', 5, 'neumatico', '{"rodado": "18", "ancho": "225", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI SCORPION ATR R (usada)', '245/65 R17 PIRELLI SCORPION ATR R (usada)', 23760.00, 37375.00, 'PIRELLI', 1, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE TURANZA ER770 R (usada)', '215/55 R17 BRIDGESTONE TURANZA ER770 R (usada)', 21600.00, 33977.00, 'BRIDGESTONE', 2, 'neumatico', '{"rodado": "17", "ancho": "215", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE R244 MB (usada)', '255/70 R22.5 BRIDGESTONE R244 MB (usada)', 86400.00, 135908.00, 'BRIDGESTONE', 2, 'neumatico', '{"rodado": "22.5", "ancho": "255", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE R (usada)', '7.50-R18 FIRESTONE R (usada)', 21600.00, 33977.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "18", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE MB (usada)', '185 R15C FIRESTONE MB (usada)', 22140.00, 34827.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "15", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR MB (usada)', '6.50-16 GOODYEAR MB (usada)', 24840.00, 39074.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "16", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR B (usada)', '265/65 R17 GOODYEAR B (usada)', 30240.00, 47568.00, 'GOODYEAR', 1, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR MB (usada)', '215/75 R17.5 GOODYEAR MB (usada)', 59400.00, 93437.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "17.5", "ancho": "215", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR MB (usada)', '18.5 R14C GOODYEAR MB (usada)', 21708.00, 34147.00, 'GOODYEAR', 1, 'neumatico', '{"rodado": "14", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FATE M (usada)', '205 R15C FATE M (usada)', 16200.00, 25483.00, 'FATE', 1, 'neumatico', '{"rodado": "15", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FATE SUPER AGARRE MB (usada)', '7.00-15 FATE SUPER AGARRE MB (usada)', 29160.00, 45869.00, 'FATE', 1, 'neumatico', '{"rodado": "15", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FATE MB (usada)', '185 R15C AR30 FATE MB (usada)', 21924.00, 34487.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FATE M (usada)', '195/55 R15 FATE M (usada)', 8640.00, 13591.00, 'FATE', 1, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI (precurada)', '7.50-R16 PIRELLI (precurada)', 35640.00, 56062.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "16", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI (usada recapada)', '7.00-16 PIRELLI (usada recapada)', 33480.00, 52665.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "16", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI (usada ROTA NO VENDER! Para precapar)', '8.25-20 PIRELLI (usada ROTA NO VENDER! Para precapar)', 0.00, 0.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "20", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('KUMHO MB (usada)', '235/60 R18 KUMHO MB (usada)', 64800.00, 101931.00, 'KUMHO', 1, 'neumatico', '{"rodado": "18", "ancho": "235", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('KUMHO M (usada)', '245/70 R19.5 KUMHO M (usada)', 43200.00, 67954.00, 'KUMHO', 1, 'neumatico', '{"rodado": "19.5", "ancho": "245", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('MICHELIN (usada)', '195/55 R16 MICHELIN (usada)', 24840.00, 39074.00, 'MICHELIN', 0, 'neumatico', '{"rodado": "16", "ancho": "195", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('YOKOHAMA precurada', '285/70 R16 YOKOHAMA precurada', 86400.00, 135908.00, 'YOKOHAMA', 2, 'neumatico', '{"rodado": "16", "ancho": "285", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('CONTINENTAL POWER CONTACT 2 MB (usada)', '195/55 R16 CONTINENTAL POWER CONTACT 2 MB (usada)', 29160.00, 45869.00, 'CONTINENTAL', 0, 'neumatico', '{"rodado": "16", "ancho": "195", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('HANKOOK DYNAPRO HP MB (usada)', '235/60 R18 HANKOOK DYNAPRO HP MB (usada)', 64800.00, 101931.00, 'HANKOOK', 1, 'neumatico', '{"rodado": "18", "ancho": "235", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('HANKOOK MB (usada)', '255/70 R22.5 HANKOOK MB (usada)', 86400.00, 135908.00, 'HANKOOK', -1, 'neumatico', '{"rodado": "22.5", "ancho": "255", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('ECOWAY (usada)', '295/80 R22.5 ECOWAY (usada)', 129600.00, 203861.00, 'ECOWAY', 0, 'neumatico', '{"rodado": "22.5", "ancho": "295", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI (usada)', '1100-22 PIRELLI (usada)', 86400.00, 135908.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "22", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI MB (usada)', '1400-24 PIRELLI MB (usada)', 129600.00, 203861.00, 'PIRELLI', 2, 'neumatico', '{"rodado": "24", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('LGN-HS ARMOUR B (usada)', '6.00-9 LGN-HS ARMOUR B (usada)', 15120.00, 23784.00, 'ARMOUR', 2, 'neumatico', '{"rodado": "9", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('WESTLAKE B con auxilio (usada)', '225/75 R15 WESTLAKE B con auxilio (usada)', 24840.00, 39074.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "15", "ancho": "225", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('SPARETIRE RUEDIN C/ LLANTA B (usada)', '145/80 D16 SPARETIRE RUEDIN C/ LLANTA B (usada)', 16200.00, 25483.00, 'SPARETIRE', 2, 'neumatico', '{"rodado": "16", "ancho": "145", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('KENDA RUEDIN C/ LLANTA B (usada)', '135/90 D16 KENDA RUEDIN C/ LLANTA B (usada)', 15660.00, 24634.00, 'KENDA', 1, 'neumatico', '{"rodado": "16", "ancho": "135", "perfil": "90", "indice": "No especifica"}');
CALL spProductoAlta ('KINGSTIRE B (usada)', '15/6.00-6 KINGSTIRE B (usada)', 20520.00, 32278.00, 'KINGSTIRE', 1, 'neumatico', '{"rodado": "15", "ancho": "15", "perfil": "6", "indice": "No especifica"}');
CALL spProductoAlta ('TURF-SAVER MB (usada)', '18x9.50-8 TURF-SAVER MB (usada)', 15120.00, 23784.00, 'SAVER', 2, 'neumatico', '{"rodado": "18", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FATE PLENTIA CROSS TL 98T', '215/65 R16 FATE PLENTIA CROSS TL 98T', 70418.00, 110768.00, 'FATE', 2, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "65", "indice": "98T"}');
CALL spProductoAlta ('1000x20 (precurada)', '1000x20 (precurada)', 41202.00, 64811.00, 'UNIVERSAL', 1, 'neumatico', '{"rodado": "20", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR B (usada)', '275/80 R22.5 GOODYEAR B (usada)', 65880.00, 103630.00, 'GOODYEAR', 1, 'neumatico', '{"rodado": "22.5", "ancho": "275", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE (vulcanizada)', '265/65 R17 BRIDGESTONE (vulcanizada)', 0.00, 0.00, 'BRIDGESTONE', 1, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR WRANGLER (precurada)', '265/65 R17 GOODYEAR WRANGLER (precurada)', 50000.00, 78650.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE (precurada)', '245/65 R17 BRIDGESTONE (precurada)', 33480.00, 52665.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI (precurada)', '245/65 R17 PIRELLI (precurada)', 32400.00, 50966.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('LGN-HS ARMOUR M (usada)', '6.00-9 LGN-HS ARMOUR M (usada)', 7020.00, 11043.00, 'ARMOUR', 1, 'neumatico', '{"rodado": "9", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR M (usada)', '265/65 R17 GOODYEAR M (usada)', 19440.00, 30580.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('HANKOOK B (usada)', '255/70 R22.5 HANKOOK B (usada)', 75600.00, 118919.00, 'HANKOOK', 2, 'neumatico', '{"rodado": "22.5", "ancho": "255", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('HANKOOK R (usada)', '255/70 R22.5 HANKOOK R (usada)', 50760.00, 79846.00, 'HANKOOK', 1, 'neumatico', '{"rodado": "22.5", "ancho": "255", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT B (usada)', '255/60 R18 BRIDGESTONE DUELER HT B (usada)', 34560.00, 54363.00, 'BRIDGESTONE', 1, 'neumatico', '{"rodado": "18", "ancho": "255", "perfil": "60", "indice": "HT"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT M (usada)', '255/60 R18 BRIDGESTONE DUELER HT M (usada)', 16200.00, 25483.00, 'BRIDGESTONE', 2, 'neumatico', '{"rodado": "18", "ancho": "255", "perfil": "60", "indice": "HT"}');
CALL spProductoAlta ('PIRELLI R (usada)', '1400-24 PIRELLI R (usada)', 86400.00, 135908.00, 'PIRELLI', 2, 'neumatico', '{"rodado": "24", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('CONTINENTAL EXTREME CONTACT B (usada)', '205/55 R16 CONTINENTAL EXTREME CONTACT B (usada)', 22680.00, 35676.00, 'CONTINENTAL', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE F600 82T', '175/65 R14 FIRESTONE F600 82T', 33108.00, 52079.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "65", "indice": "82T"}');
CALL spProductoAlta ('FIRESTONE F600 84T', '175/70 R14 FIRESTONE F600 84T', 26744.00, 42069.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "84T"}');
CALL spProductoAlta ('BRIDGESTONE TURANZA ER300 91V', '205/55 R16 BRIDGESTONE TURANZA ER300 91V', 40600.00, 63864.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "55", "indice": "91V"}');
CALL spProductoAlta ('BRIDGESTONE TURANZA ER370', '215/55 R17 BRIDGESTONE TURANZA ER370', 46413.00, 73008.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "215", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER AT REVO 2 108T', '225/70 R17 BRIDGESTONE DUELER AT REVO 2 108T', 76345.00, 120091.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "225", "perfil": "70", "indice": "108T"}');
CALL spProductoAlta ('FIRESTONE DESTINATION ATX 112T', '265/65 R17 FIRESTONE DESTINATION ATX 112T', 58860.00, 92587.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "65", "indice": "112T"}');
CALL spProductoAlta ('CONTINENTAL', '175/65 R14 CONTINENTAL', 23310.00, 36667.00, 'CONTINENTAL', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('WESTLAKE RP18 79T', '165/70 R13 WESTLAKE RP18 79T', 20400.00, 32090.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "13", "ancho": "165", "perfil": "70", "indice": "79T"}');
CALL spProductoAlta ('WESTLAKE RP18 82T', '175/70 R13 WESTLAKE RP18 82T', 21500.00, 33820.00, 'WESTLAKE', 0, 'neumatico', '{"rodado": "13", "ancho": "175", "perfil": "70", "indice": "82T"}');
CALL spProductoAlta ('GOODYEAR WRANGLER R (usada)', '245/70 R16 GOODYEAR WRANGLER R (usada)', 11000.00, 17303.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "16", "ancho": "245", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE F200 82T', '185/60 R14 FIRESTONE F200 82T', 33464.00, 52639.00, 'FIRESTONE', 4, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "60", "indice": "82T"}');
CALL spProductoAlta ('PIRELLI Scorpion Verde 102H', '215/65 R16 PIRELLI Scorpion Verde 102H', 43600.00, 68583.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "65", "indice": "102H"}');
CALL spProductoAlta ('FATE Sentiva AR360', '165/70 R13 FATE Sentiva AR360', 21805.00, 34300.00, 'FATE', 0, 'neumatico', '{"rodado": "13", "ancho": "165", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FATE Range Runner AT/R SERIE 4', '215/80 R16 FATE Range Runner AT/R SERIE 4', 63013.00, 99120.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('FATE RANGE RUNNER AT SERIE 4', '255/70 R16 FATE RANGE RUNNER AT SERIE 4', 7814.00, 12292.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "255", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FATE RANGE RUNNER AT SERIE 4', '265/70 R16 FATE RANGE RUNNER AT SERIE 4', 57908.00, 91090.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "265", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FATE EXIMIA PININFARINA SUV TL', '245/65 R17 FATE EXIMIA PININFARINA SUV TL', 67641.00, 106400.00, 'FATE', 0, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "TL"}');
CALL spProductoAlta ('FIRESTONE CV5000', '225/65 R16C FIRESTONE CV5000', 78258.00, 123100.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "225", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('PIRELLI (precurada)', '1000x20 PIRELLI (precurada)', 52447.00, 82500.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "20", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('GNHS TURF-SAVER MB (usada)', '15x6000 GNHS TURF-SAVER MB (usada)', 27972.00, 44000.00, 'SAVER', 2, 'neumatico', '{"rodado": "15", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('YOKOHAMA MB (usada)', '215/55 R17 94V YOKOHAMA MB (usada)', 15000.00, 23595.00, 'YOKOHAMA', 1, 'neumatico', '{"rodado": "17", "ancho": "215", "perfil": "55", "indice": "94V"}');
CALL spProductoAlta ('FATE Avantia A3410', '205/75 R16 FATE Avantia A3410', 48951.00, 77000.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('FATE RANGE RUNNER AT/R SERIE 4 113/110T', '245/70 R16 FATE RANGE RUNNER AT/R SERIE 4 113/110T', 83804.00, 131824.00, 'FATE', 1, 'neumatico', '{"rodado": "16", "ancho": "245", "perfil": "70", "indice": "113/110T"}');
CALL spProductoAlta ('FORMULA ENERGY', '175/70 R13 FORMULA ENERGY', 26415.00, 41551.00, 'ENERGY', 2, 'neumatico', '{"rodado": "13", "ancho": "175", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE F600 88T', '185/70 R14 FIRESTONE F600 88T', 27056.00, 42560.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "70", "indice": "88T"}');
CALL spProductoAlta ('PIRELLI P400 EVO', '175/65 R14 PIRELLI  P400 EVO', 23776.00, 37400.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('FORMULA ENERGY 82T', '175/70 R13 FORMULA ENERGY 82T', 20979.00, 33000.00, 'ENERGY', 0, 'neumatico', '{"rodado": "13", "ancho": "175", "perfil": "70", "indice": "82T"}');
CALL spProductoAlta ('FIRESTONE 126/124L', '215/75 R17.5 FIRESTONE 126/124L', 94940.00, 149341.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "17.5", "ancho": "215", "perfil": "75", "indice": "126/124L"}');
CALL spProductoAlta ('FIRESTONE CV5000', '205/75 R16C FIRESTONE CV5000', 62603.00, 98475.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE TURANZA', '225/45 R17 BRIDGESTONE TURANZA', 65705.00, 103354.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "17", "ancho": "225", "perfil": "45", "indice": "No especifica"}');
CALL spProductoAlta ('NEXEN BLUE ECO 86H', '185/65 R15 NEXEN BLUE ECO 86H', 34177.00, 53761.00, 'NEXEN', 0, 'neumatico', '{"rodado": "15", "ancho": "185", "perfil": "65", "indice": "86H"}');
CALL spProductoAlta ('FATE Sentiva H AR-360', '185/65 R15 FATE Sentiva H AR-360', 38020.00, 59806.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "185", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER H/T 684', '265/60 R18 BRIDGESTONE DUELER H/T 684', 98258.00, 154560.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "18", "ancho": "265", "perfil": "60", "indice": "HT"}');
CALL spProductoAlta ('CHAMPIRO VP1', '165/80 R13 CHAMPIRO VP1', 23774.00, 37397.00, 'CHAMPIRO', 1, 'neumatico', '{"rodado": "13", "ancho": "165", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE FIREHAWK 900', '195/60 R15 FIRESTONE FIREHAWK 900', 38347.00, 60320.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('FATE SENTIVA 84H', '185/60 R15 FATE SENTIVA 84H', 31778.00, 49987.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "185", "perfil": "60", "indice": "84H"}');
CALL spProductoAlta ('FATE SENTIVA 88H', '195/60 R15 FATE SENTIVA 88H', 36429.00, 57303.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "60", "indice": "88H"}');
CALL spProductoAlta ('GOODYEAR ASSURANCE 88T', '185/65 R15 GOODYEAR ASSURANCE 88T', 0.00, 0.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "15", "ancho": "185", "perfil": "65", "indice": "88T"}');
CALL spProductoAlta ('GOODYEAR EFFICIENTGRIP', '175/70 R14 GOODYEAR EFFICIENTGRIP', 35244.00, 55439.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('PACE PC20 82H', '175/70 R13 PACE PC20 82H', 15575.00, 24500.00, 'PACE', 0, 'neumatico', '{"rodado": "13", "ancho": "175", "perfil": "70", "indice": "82H"}');
CALL spProductoAlta ('BRIDGESTONE 87V ECOPIA EP150', '195/55 R16 BRIDGESTONE 87V ECOPIA EP150', 52447.00, 82500.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "195", "perfil": "55", "indice": "87V"}');
CALL spProductoAlta ('FATE PRESTIVA 79T', '165/70/ R13 FATE PRESTIVA  79T', 23839.00, 37499.00, 'FATE', 0, 'neumatico', '{"rodado": "13", "ancho": "165", "perfil": "70", "indice": "79T"}');
CALL spProductoAlta ('TRIANGLE S/T', '265/70 R17 TRIANGLE S/T', 0.00, 0.00, 'TRIANGLE', 2, 'neumatico', '{"rodado": "17", "ancho": "265", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FATE RR H/T SERIE2', '235/75 R15 FATE RR H/T SERIE2', 58869.00, 92601.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "235", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('BRIDGESTONE DUELER HT USADO', '265/60 R18 BRIDGESTONE DUELER HT USADO', 3178.00, 4999.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "18", "ancho": "265", "perfil": "60", "indice": "HT"}');
CALL spProductoAlta ('PIRELLI SPORPION usada', '265/65 R18 PIRELLI SPORPION usada', 3178.00, 4999.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "18", "ancho": "265", "perfil": "65", "indice": "No especifica"}');
CALL spProductoAlta ('LUHE 14T SUPER FARM S/G ( con protector y camara)', '900-20 LUHE 14T SUPER FARM S/G ( con protector y camara)', 123966.00, 194999.00, 'LUHE', 4, 'neumatico', '{"rodado": "20", "ancho": "None", "perfil": "None", "indice": "14T"}');
CALL spProductoAlta ('FATE PRESTIVA 82T TL', '175/70 R13 FATE PRESTIVA 82T TL', 23496.00, 36960.00, 'FATE', 0, 'neumatico', '{"rodado": "13", "ancho": "175", "perfil": "70", "indice": "82T TL"}');
CALL spProductoAlta ('FIRESTONE DESTINATION A/T 107S', '215/80 R16 FIRESTONE DESTINATION A/T 107S', 63013.00, 99120.00, 'FIRESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "80", "indice": "107S"}');
CALL spProductoAlta ('FATE PRECURADA', '900-20 FATE PRECURADA', 63572.00, 99999.00, 'FATE', 1, 'neumatico', '{"rodado": "20", "ancho": "None", "perfil": "None", "indice": "No especifica"}');
CALL spProductoAlta ('FATE PRECURADA', '275/80 22.5 FATE PRECURADA', 92180.00, 145000.00, 'FATE', 1, 'neumatico', '{"rodado": "22.5", "ancho": "275", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('FIREMAX FM316 98H', '215/65 R16 FIREMAX FM316 98H', 50882.00, 80038.00, 'FIREMAX', 0, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "65", "indice": "98H"}');
CALL spProductoAlta ('CONTINENTAL usado', '195/55 R16 CONTINENTAL usado', 10680.00, 16800.00, 'CONTINENTAL', 0, 'neumatico', '{"rodado": "16", "ancho": "195", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('FORMULA ENERGY 82T', '175/65 R14 FORMULA ENERGY 82T', 28289.00, 44499.00, 'ENERGY', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "65", "indice": "82T"}');
CALL spProductoAlta ('PIRRELLI 84T P400 EVO', '175/70 R14 PIRRELLI 84T P400 EVO', 31196.00, 49072.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "84T"}');
CALL spProductoAlta ('PIRELLI 86T P400 EVO', '185/65 R14 PIRELLI 86T P400 EVO', 33057.00, 51999.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "65", "indice": "86T"}');
CALL spProductoAlta ('PIRELLI P1 CINTURATO', '195/55 R15 PIRELLI 85V P1 CINTURATO', 45849.00, 72121.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "55", "indice": "85V"}');
CALL spProductoAlta ('PIRELLI P1 CINTURATO', '195/60 R15 PIRELLI P1 CINTURATO', 50302.00, 79126.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "60", "indice": "No especifica"}');
CALL spProductoAlta ('GOOD YEAR DURA PLUS', '175/70 R14 GOOD YEAR DURA PLUS', 32040.00, 50399.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('GOOD YEAR DURA PLUS', '275/70 R14 GOOD YEAR DURA PLUS', 32040.00, 50399.00, 'GOODYEAR', 1, 'neumatico', '{"rodado": "14", "ancho": "275", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('MICHELIN PRIMACY 4', '205/55 R17 MICHELIN PRIMACY 95V 4', 106802.00, 168000.00, 'MICHELIN', 0, 'neumatico', '{"rodado": "17", "ancho": "205", "perfil": "55", "indice": "95V"}');
CALL spProductoAlta ('PIRELLI P400 EVO', '185/70 R14 PIRELLI 88H P400 EVO', 30075.00, 47308.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "70", "indice": "88H"}');
CALL spProductoAlta ('PIRELLI P400 EVO', '185/60 R14 PIRELLI 82H P400 EVO', 32227.00, 50694.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "14", "ancho": "185", "perfil": "60", "indice": "82H"}');
CALL spProductoAlta ('PIRELLI CINTURATO', '195/50 R16 PIRELLI CINTURATO 84V P7', 68175.00, 107240.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "16", "ancho": "195", "perfil": "50", "indice": "84V"}');
CALL spProductoAlta ('BRIDGESTONE TURANZA USADA', '205/55 R17 BRIDGESTONE TURANZA USADA', 0.00, 0.00, 'BRIDGESTONE', 4, 'neumatico', '{"rodado": "17", "ancho": "205", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('FATE EXIMIA PININFARINA TL', '195/55 R16 FATE EXIMIA PININFARINA TL 91H', 57139.00, 89880.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "195", "perfil": "55", "indice": "91H"}');
CALL spProductoAlta ('FATE RR AT/R SERIE2', '235/75 R15 FATE RR AT/R 110/107R SERIE2', 56605.00, 89040.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "235", "perfil": "75", "indice": "110/107R"}');
CALL spProductoAlta ('PIRELLI SCORPION VERDE XL-S', '255/55 R19 PIRELLI SCORPION VERDE 111H XL-S', 145963.00, 229600.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "19", "ancho": "255", "perfil": "55", "indice": "111H"}');
CALL spProductoAlta ('GOOD YEAR EFFICIENTGRIP', '225/45 R17 GOOD YEAR EFFICIENTGRIP 94W', 94761.00, 149060.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "17", "ancho": "225", "perfil": "45", "indice": "94W"}');
CALL spProductoAlta ('PIRELLI SCORPION ATR', '245/70 R16 PIRELLI SCORPION ATR', 74761.00, 117600.00, 'PIRELLI', 0, 'neumatico', '{"rodado": "16", "ancho": "245", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('GOOD YEAR WRANGLER SUV', '215/65 R16 GOOD YEAR WRANGLER SUV  98H SL TL', 69777.00, 109760.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "65", "indice": "98H"}');
CALL spProductoAlta ('FATE RR A/T SERIE4', '245/65 R17 FATE RR A/T SERIE4 105/102T', 76605.00, 120500.00, 'FATE', 0, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "105/102T"}');
CALL spProductoAlta ('BRIDGESTONE DUELER H/T 684 II', '215/65 R16 BRIDGESTONE DUELER H/T 684 II 98T', 52778.00, 83020.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "65", "indice": "98T"}');
CALL spProductoAlta ('FORMULA ENERGY', '175/70 R14 FORMULA ENERGY', 31150.00, 48999.00, 'ENERGY', 0, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('ECOWAY XBRI', '295/80 R22,5 ECOWAY XBRI', 163763.00, 257600.00, 'ECOWAY', 0, 'neumatico', '{"rodado": "22.5", "ancho": "295", "perfil": "80", "indice": "No especifica"}');
CALL spProductoAlta ('GOOD YEAR G32 CARGO D SL', '225/65 R15 GOOD YEAR G32 CARGO 112/110R D SL', 98970.00, 155680.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "15", "ancho": "225", "perfil": "65", "indice": "112/110R"}');
CALL spProductoAlta ('MAXISPORT 2', '205/55 R16 MAXISPORT 2 91H', 46993.00, 73920.00, 'MAXISPORT', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "55", "indice": "91H"}');
CALL spProductoAlta ('FATE SENTIVA SPORT', '185/65 R15 FATE SENTIVA SPORT 92H', 43027.00, 67682.00, 'FATE', 0, 'neumatico', '{"rodado": "15", "ancho": "185", "perfil": "65", "indice": "92H"}');
CALL spProductoAlta ('FATE AVANTIA C118/116R AR-410', '225/75 R16 FATE AVANTIA C118/116R AR-410', 73693.00, 115920.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "225", "perfil": "75", "indice": "C118/116R"}');
CALL spProductoAlta ('FATE AVANTIA AR-410 USADA EXCELENTE', '205/75 R16 FATE AVANTIA AR-410 USADA EXCELENTE', 39160.00, 61599.00, 'FATE', 2, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "75", "indice": "No especifica"}');
CALL spProductoAlta ('FIREMAX FM316', '215/65 R16 FIREMAX FM316 98H', 50882.00, 80038.00, 'FIREMAX', 2, 'neumatico', '{"rodado": "16", "ancho": "215", "perfil": "65", "indice": "98H"}');
CALL spProductoAlta ('BRIDGESTONE DUELER A/T REVO 2', '245/70 R16 BRIDGESTONE DUELER A/T REVO 2 111T', 80457.00, 126559.00, 'BRIDGESTONE', 0, 'neumatico', '{"rodado": "16", "ancho": "245", "perfil": "70", "indice": "111T"}');
CALL spProductoAlta ('FIRESTONE F700', '175/70 R14 FIRESTONE F700 84T', 34888.00, 54879.00, 'FIRESTONE', 6, 'neumatico', '{"rodado": "14", "ancho": "175", "perfil": "70", "indice": "84T"}');
CALL spProductoAlta ('HANKOOK DYNAPRO HP2 XL', '245/65 R17 HANKOOK DYNAPRO HP2 111H XL', 0.00, 0.00, 'HANKOOK', 2, 'neumatico', '{"rodado": "17", "ancho": "245", "perfil": "65", "indice": "111H"}');
CALL spProductoAlta ('FATE TRIPLE GUIA 10T', '7.50-R16 FATE TRIPLE GUIA 10T', 10342.00, 16268.00, 'FATE', 0, 'neumatico', '{"rodado": "16", "ancho": "7.5", "perfil": "None", "indice": "10T"}');
CALL spProductoAlta ('ZEXTOUR Highlander', '235/70 R16 ZEXTOUR Highlander 106T', 0.00, 0.00, 'ZEXTOUR', 2, 'neumatico', '{"rodado": "16", "ancho": "235", "perfil": "70", "indice": "106T"}');
CALL spProductoAlta ('HYFLY VIGOROUS AT 601', '265/70 R16 HYFLY VIGOROUS AT 601', 70566.00, 111001.00, 'HYFLY', 0, 'neumatico', '{"rodado": "16", "ancho": "265", "perfil": "70", "indice": "No especifica"}');
CALL spProductoAlta ('FIRESTONE FIREHAWK 900 T CR', '205/55 R16 FIRESTONE FIREHAWK 900 T CR', 61945.00, 97440.00, 'FIRESTONE', 4, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "55", "indice": "No especifica"}');
CALL spProductoAlta ('GOODYEAR ASSURANCE', '205/65R15 GOODYEAR ASSURANCE 94T', 48061.00, 62480.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "15", "ancho": "205", "perfil": "65", "indice": "94T"}');
CALL spProductoAlta ('GOODYEAR WRANGLER ARMORTRAC XL', '235/75R15 GOODYEAR WRANGLER ARMORTRAC 109S XL', 45431.00, 59060.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "15", "ancho": "235", "perfil": "75", "indice": "109S"}');
CALL spProductoAlta ('GOODYEAR CARGO MARATHON 2', '195/70R15C GOODYEAR CARGO MARATHON 2 104/102R', 45675.00, 59378.00, 'GOODYEAR', 2, 'neumatico', '{"rodado": "15", "ancho": "195", "perfil": "70", "indice": "104/102R"}');
CALL spProductoAlta ('GOODYEAR EFFICIENTGRIP PERFORMANCE', '205/55R16 GOODYEAR EFFICIENTGRIP PERFORMANCE 91V', 63209.00, 99428.00, 'GOODYEAR', 0, 'neumatico', '{"rodado": "16", "ancho": "205", "perfil": "55", "indice": "91V"}');
CALL spProductoAlta ('Lampara halogena OSRAM H4 24V. 70/75W vehiculos gran porte', 'Lampara halogena OSRAM H4 24V. 70/75W vehiculos gran porte', 1674.00, 2634.00, 'OSRAM', 44, 'lampara', '{"voltaje": "24", "watts": "70/75", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara incandescente NEOLUX 12V 5W', 'Lampara incandescente NEOLUX 12V 5W', 69.00, 109.00, 'NEOLUX', 34, 'lampara', '{"voltaje": "12", "watts": "5", "tipo": "incandescente"}');
CALL spProductoAlta ('Lampara incandescente NEOLUX 12V 21W', 'Lampara incandescente NEOLUX 12V 21W', 93.00, 147.00, 'NEOLUX', 14, 'lampara', '{"voltaje": "12", "watts": "21", "tipo": "incandescente"}');
CALL spProductoAlta ('Lampara auxiliar OSRAM 12V 21/5W (freno giro retroceso)', 'Lampara auxiliar OSRAM 12V 21/5W (freno giro retroceso)', 671.00, 1056.00, 'OSRAM', 5, 'lampara', '{"voltaje": "12", "watts": "21/5", "tipo": "auxiliar"}');
CALL spProductoAlta ('Lampara auxiliar OSRAM 12V 16W (freno stop giro)', 'Lampara auxiliar OSRAM 12V 16W (freno stop giro)', 496.00, 781.00, 'OSRAM', 10, 'lampara', '{"voltaje": "12", "watts": "16", "tipo": "auxiliar"}');
CALL spProductoAlta ('Lampara halogena VOSLA H7 12V 21W', 'Lampara halogena VOSLA H7 12V 21W', 572.00, 900.00, 'VOSLA', 10, 'lampara', '{"voltaje": "12", "watts": "21", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena VOSLA 12V 21/5W', 'Lampara halogena VOSLA 12V 21/5W', 160.00, 252.00, 'VOSLA', 0, 'lampara', '{"voltaje": "12", "watts": "21/5", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena VOSLA 12V 21/5W', 'Lampara halogena VOSLA 12V 21/5W', 160.00, 252.00, 'VOSLA', 6, 'lampara', '{"voltaje": "12", "watts": "21/5", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena OSRAM 12V 55W', 'Lampara halogena OSRAM 12V 55W', 1538.00, 2420.00, 'OSRAM', 1, 'lampara', '{"voltaje": "12", "watts": "55", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena DURER H7 12V 55W', 'Lampara halogena DURER H7 12V 55W', 572.00, 900.00, 'DURER', 9, 'lampara', '{"voltaje": "12", "watts": "55", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena KERZE 12V 55W', 'Lampara halogena KERZE 12V 55W', 480.00, 756.00, 'KERZE', 6, 'lampara', '{"voltaje": "12", "watts": "55", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena PHILIPS H4 24V 75/70W', 'Lampara halogena PHILIPS H4 24V 75/70W', 700.00, 1102.00, 'PHILIPS', 9, 'lampara', '{"voltaje": "24", "watts": "75/70", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara 12V 21W (muela grande)', 'Lampara 12V 21W (muela grande)', 315.00, 496.00, 'UNIVERSAL', 10, 'lampara', '{"voltaje": "12", "watts": "21", "tipo": " "}');
CALL spProductoAlta ('Lampara halogena KOBO 12V 55W', 'Lampara halogena KOBO 12V 55W', 267.00, 420.00, 'KOBO', 1, 'lampara', '{"voltaje": "12", "watts": "55", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena OSRAM HA 12V 60/55W', 'Lampara halogena OSRAM HA 12V 60/55W', 0.00, 0.00, 'OSRAM', 1, 'lampara', '{"voltaje": "12", "watts": "60/55", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena OSRAM 60W55 12V H4', 'Lampara halogena OSRAM 60W55 12V H4', 0.00, 0.00, 'OSRAM', 0, 'lampara', '{"voltaje": "12", "watts": "60", "tipo": "halogena"}');
CALL spProductoAlta ('Lampara halogena PHILIPS 12V 60/55W', 'Lampara halogena PHILIPS 12V 60/55W', 0.00, 0.00, 'PHILIPS', 1, 'lampara', '{"voltaje": "12", "watts": "60/55", "tipo": "halogena"}');
CALL spProductoAlta ('Aceite TOTAL Quartz Ineo', 'Aceite TOTAL Quartz Ineo 0w30 4lts.', 7500.00, 11798.00, 'TOTAL', 2, 'lubricentro', '{"Descripcion": "Aceite TOTAL 0w30 4lts", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aerosol Rost Off', 'Rost off aerosol 300ml', 636.00, 1001.00, 'ROST OFF', 12, 'lubricentro', '{"Descripcion": "Rost off aerosol 300ml", "medida": "300ml", "tipo": "otro"}');
CALL spProductoAlta ('Aditivo de Inyección WURTH', 'Aditivo de inyección diesel WURTH 300ml.', 0.00, 0.00, 'WURTH', 2, 'lubricentro', '{"Descripcion": "Aditivo de inyecciu00f3n diesel 300ml", "medida": "300ml", "tipo": "aditivo"}');
CALL spProductoAlta ('Aditivo Limpia Inyectores WURTH', 'Aditivo limpia inyectores WURTH 300ml.', 0.00, 0.00, 'WURTH', 2, 'lubricentro', '{"Descripcion": "Aditivo limpia inyectores 300ml", "medida": "300ml", "tipo": "aditivo"}');
CALL spProductoAlta ('Liquido de frenos WAGNER', 'Liquido de frenos 1L. WAGNER', 858.00, 1350.00, 'WAGNER', 8, 'lubricentro', '{"Descripcion": "Liquido de frenos", "medida": "1L", "tipo": "liquido de frenos"}');
CALL spProductoAlta ('WANDER REFRIGERANTE 66', 'Liquido refrigerante verde 66 5lts. WANDER', 600.00, 944.00, 'WANDER', 9, 'lubricentro', '{"Descripcion": "Liquido refrigerante verde 66", "medida": "5lts", "tipo": "liquido refrigerante"}');
CALL spProductoAlta ('WANDER REFRIGERANTE 75', 'Liquido refrigerante rosa 76 5lts. WANDER', 600.00, 944.00, 'WANDER', 0, 'lubricentro', '{"Descripcion": "Liquido refrigerante rosa 76", "medida": "5lts", "tipo": "otro"}');
CALL spProductoAlta ('Agua Desmineralizada', 'Agua desmineralizada 1OOO cm3', 95.00, 150.00, 'OTRO', 3, 'lubricentro', '{"Descripcion": "Agua desmineralizada", "medida": "1L", "tipo": "aceite"}');
CALL spProductoAlta ('PUMA EXTRA GD', 'Aceite PUMA 10W40 4L. EXTRA GD', 4296.00, 6758.00, 'PUMA', 0, 'lubricentro', '{"Descripcion": "Aceite 10W40  EXTRA GD", "medida": "4L", "tipo": "aceite"}');
CALL spProductoAlta ('PUMA EXTRA GD', 'Aceite PUMA 10W40 1L. EXTRA GD', 1050.00, 1652.00, 'PUMA', 7, 'lubricentro', '{"Descripcion": "Aceite 10W40 EXTRA GD", "medida": "1L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite MOTORCRAFT', 'Aceite MOTORCRAFT 15W40 1L.', 1352.00, 2127.00, 'MOTORCRAFT', 0, 'lubricentro', '{"Descripcion": "Aceite 15W40", "medida": "1L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite MOTORCRAFT mineral', 'Aceite mineral MOTORCRAFT 15W40 4lts.', 3286.00, 5169.00, 'MOTORCRAFT', 0, 'lubricentro', '{"Descripcion": "Aceite mineral 15W40", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite MOTORCRAFT Semisintetico', 'Aceite semisintetico MOTORCRAFT 10W40 4lts.', 5340.00, 8400.00, 'MOTORCRAFT', 0, 'lubricentro', '{"Descripcion": "Aceite semisintetico 10W40", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite MOTORCRAFT', 'Aceite MOTORCRAFT 15W40 20lts.', 610.00, 960.00, 'MOTORCRAFT', 0, 'lubricentro', '{"Descripcion": "Aceite 15W40", "medida": "20lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite TOTAL Quartz 7000', 'Aceite TOTAL Quartz 7000 4lts. 10W40', 4500.00, 7079.00, 'TOTAL', 0, 'lubricentro', '{"Descripcion": "Aceite 7000 10W40", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Grasa lubricante RHINNOL', 'Grasa lubricante RHINNOL 900grs.', 629.00, 990.00, 'RHINNOL', 7, 'lubricentro', '{"Descripcion": "Grasa lubricante", "medida": "900grs", "tipo": "grasa"}');
CALL spProductoAlta ('Aceite LIQUI MOLY', 'Aceite LIQUI MOLY 5W30 DPF filtro diesel particulas 4lts.', 13100.00, 20607.00, 'LIQUI MOLY', 8, 'lubricentro', '{"Descripcion": "Aceite 5W30 DPF filtro diesel particulas", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite LIQUI MOLY', 'Aceite LIQUI MOLY 10W40 semisintetico 4lts.', 7500.00, 11798.00, 'LIQUI MOLY', 0, 'lubricentro', '{"Descripcion": "Aceite 10W40 semisintetico", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite LIQUI MOLY', 'Aceite LIQUI MOLY 5W30 4lts.', 10500.00, 16517.00, 'LIQUI MOLY', 2, 'lubricentro', '{"Descripcion": "Aceite 5W30", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Protector filtros particulas Diesel LIQUI MOLY', 'Protector filtros particulas Diesel LIQUI MOLY 250ml.', 2809.00, 4419.00, 'LIQUI MOLY', 8, 'lubricentro', '{"Descripcion": "Protector filtros particulas Diesel", "medida": "250ml", "tipo": "otro"}');
CALL spProductoAlta ('Aceite LIQUI MOLY', 'Aceite LIQUI MOLY 10W40 4lts. sintetico', 9000.00, 14157.00, 'LIQUI MOLY', 0, 'lubricentro', '{"Descripcion": "Aceite 10W40 sintetico", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite LIQUI MOLY', 'Aceite LIQUI MOLY 5W40 4lts.', 10300.00, 16202.00, 'LIQUI MOLY', 0, 'lubricentro', '{"Descripcion": "Aceite 5W40", "medida": "4lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aditivo LIQUI MOLY', 'Aditivo  super diesel  LIQUI MOLY 250ml', 1573.00, 2475.00, 'LIQUI MOLY', 5, 'lubricentro', '{"Descripcion": "Aditivo super diesel", "medida": "250ml", "tipo": "aditivo"}');
CALL spProductoAlta ('Limpia Motor LIQUI MOLY', 'Limpia motor LIQUI MOLY 250ml.', 2105.00, 3312.00, 'LIQUI MOLY', 4, 'lubricentro', '{"Descripcion": "Limpia motor", "medida": "250ml", "tipo": "otro"}');
CALL spProductoAlta ('Limpia Inyección Diesel', 'Limpia inyeccion Diesel 1L.', 5407.00, 8506.00, 'OTRO', 2, 'lubricentro', '{"Descripcion": "Limpia inyeccion Diesel", "medida": "1L", "tipo": "otro"}');
CALL spProductoAlta ('Aditivo Diesel LIQUI MOLY', 'Aditivo Diesel antibacteria LIQUI MOLY 1L.', 7350.00, 11562.00, 'LIQUI MOLY', 2, 'lubricentro', '{"Descripcion": "Aditivo Diesel antibacteria", "medida": "1L", "tipo": "aditivo"}');
CALL spProductoAlta ('Aceite TOTAL QUARTZ Ineo', 'Aceite TOTAL Quartz Ineo 0W30 1L.', 2500.00, 4000.00, 'TOTAL', 4, 'lubricentro', '{"Descripcion": "Aceite 0W30", "medida": "1L", "tipo": "aceite"}');
CALL spProductoAlta ('Anticongelante refrigerante y anticorrosivo ARGAL', 'Anticongelante refrigerante y anticorrosivo ARGAL', 413.00, 650.00, 'ARGAL', 53, 'lubricentro', '{"Descripcion": "Anticongelante refrigerante y anticorrosivo", "medida": "NA", "tipo": "anticongelante"}');
CALL spProductoAlta ('Limpiador para tapizados y alfombras VERMOL', 'Limpiador para tapizados y alfombras VERMOL', 636.00, 1001.00, 'VERMOL', 0, 'lubricentro', '{"Descripcion": "Limpiador para tapizados y alfombras", "medida": "NA", "tipo": "otro"}');
CALL spProductoAlta ('Lubricante adhesivo WURTH HHS', 'Lubricante adhesivo WURTH HHS 2000', 0.00, 0.00, 'WURTH', 1, 'lubricentro', '{"Descripcion": "Lubricante adhesivo HHS 2000", "medida": "NA", "tipo": "lubricante"}');
CALL spProductoAlta ('Aceite CASTROL', 'Aceite de motor CASTROL 2T 500ml.', 953.00, 1500.00, 'CASTROL', 0, 'lubricentro', '{"Descripcion": "Aceite de motor 2T", "medida": "500ml", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite CASTROL', 'Aceite de motor CASTROL 2T 1L', 1271.00, 2000.00, 'CASTROL', 0, 'lubricentro', '{"Descripcion": "Aceite de motor 2T", "medida": "1L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite PETRONAS AKCELA', 'Aceite PETRONAS AKCELA 15W40 20lts', 635.00, 999.00, 'PETRONAS', 0, 'lubricentro', '{"Descripcion": "Aceite 15W40", "medida": "20lts", "tipo": "aceite"}');
CALL spProductoAlta ('Aciete MOTORCRAFT', 'Aceite motor  MOTORCRAFT 15W40 200L', 1059.00, 1666.00, 'MOTORCRAFT', 108, 'lubricentro', '{"Descripcion": "Aceite motor 15W40", "medida": "200L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite de motor PUMA', 'Aceite de motor PUMA SAE 5W30 4L', 9902.00, 15576.00, 'PUMA', 15, 'lubricentro', '{"Descripcion": "Aceite de motor 5W30", "medida": "4L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite de transmision RHINNOL', 'Aceite de transmision RHINNOL 140 20L', 536.00, 844.00, 'RHINNOL', 10, 'lubricentro', '{"Descripcion": "Aceite de transmision 140", "medida": "20L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite RHINNOL HIP', 'Aceite hidramatic RHINNOL ATF II ROJO 20L', 526.00, 828.00, 'RHINNOL', 24, 'lubricentro', '{"Descripcion": "Aceite hidramatic ROJO", "medida": "20L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite RHINNOL HIP', 'Aceite RHINNOL HIP 75W80 mineral 20L', 588.00, 925.00, 'RHINNOL', 4, 'lubricentro', '{"Descripcion": "Aceite 75W80 mineral", "medida": "20L", "tipo": "aceite"}');
CALL spProductoAlta ('Aceite RHINNOL HIP', 'Aceite RHINNOL HIP 80W90 GL5 20L', 641.00, 1009.00, 'RHINNOL', 4, 'lubricentro', '{"Descripcion": "Aceite 80W90 GL5", "medida": "20L", "tipo": "aceite"}');
CALL spProductoAlta ('Grasa RHINNOL', 'Grasa RHINNOL Multiuso Roja 20L', 0.00, 0.00, 'RHINNOL', 60, 'lubricentro', '{"Descripcion": "Grasa Multiuso Roja", "medida": "20L", "tipo": "grasa"}');
CALL spProductoAlta ('Limpia Inyectores LIQUI MOLY', 'Limpia inyectores diesel LIQUI MOLY 300ml.', 2008.00, 3159.00, 'LIQUI MOLY', 4, 'lubricentro', '{"Descripcion": "Limpia inyectores diesel", "medida": "300ml", "tipo": "otro"}');
CALL spProductoAlta ('Líquido Refrigerante TOTAL SUPRA RED', 'Liquido refrigerante TOTAL SUPRA RED rosa', 1068.00, 1680.00, 'TOTAL', 34, 'lubricentro', '{"Descripcion": "Liquido refrigerante rosa", "medida": "NA", "tipo": "liquido refrigerante"}');


CALL spProveedorAlta('30-54285183-6','ABC','ABC SA','Córdoba 1177','San Miguel de Tucumán','Tucumán');
CALL spProveedorAlta('20-30565541-5','AMORTIGUADORES SACHS','SCARAFIA MARCELO DANIEL','Av. 25 de Mayo 286','San Guillero','Santa Fe');
CALL spProveedorAlta('N/A','Amortiguadores varios','N/A','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-69132395-8','BATERIAS MOURA','Baterías Moura de Argentina SA','Ruta 8 Km 1626','Pilar','Buenos Aires');
CALL spProveedorAlta('30-70928922-1','BRACCO','Equipamientos Bracco SRL','RN8','Colón','Buenos Aires');
CALL spProveedorAlta('33-69978850-9','DAVID NEUMATICOS','DAVID NEUMATICOS SRL','Libertad 2114','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-71586576-5','Dir. Gral. de Agencias de Des.','Agencia de Desarrollo','Garibaldi 45','Santiago del Estero','Santiago');
CALL spProveedorAlta('20-14054224-6','EXTRAS','SSS SRL','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-71584584-5','FABRILTRANS SA NEUMATICOS','Fabriltrans SA','Uruguay 841','Avellaneda','Buenos Aires');
CALL spProveedorAlta('30-71730625-9','FRAM','N/A','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('20-28641862-8','Federico Pablo Bongiovanni','Federico Pablo Bongiovanni','Llavallol 4315','CABA','C.A.B.A.');
CALL spProveedorAlta('30-71188541-9','GB NEUMATICOS','GB Neumaticos SRL','Pedro Leon Gallo 908','Santiago del Estero','Santiago');
CALL spProveedorAlta('33-70717415-9','GLOBAL GROUP LLANTAS','Global Group SA','Vera Mujica 22','Rosario','Santa Fe');
CALL spProveedorAlta('30-69640142-6','HASTING','HASTING SRL','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-62555216-4','LA SUSPENSION','La Suspension SA','Tillard 1185 esq Bv Los Andes','Córdoba','Córdoba');
CALL spProveedorAlta('30-70817989-9','LIQUI MOLY','Deutsche Autoteile SA','Ombu 2971','CABA','Buenos Aires');
CALL spProveedorAlta('30-68667474-2','LO BRUNO AUTOMOTORES','Lo Bruno Automotores SA','Av Saenz Peña 1380','Santiago del Estero','Santiago');
CALL spProveedorAlta('33-71510764-9','LUCOIL LUBRICANTES','LUCOIL SA','Av. Zapiola 4831','Bernal Oeste','Buenos Aires');
CALL spProveedorAlta('30-59677808-5','MASTERFILT','N/A','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('20-35222517-8','MF REPUESTOS','Ferradas Matias Hector','Belgrano 1382','Rafaela','Santa Fe');
CALL spProveedorAlta('30-59012324-9','NEUMASUR NEUMATICOS','Neumasur SA','B. Quinquela Martin 1160','CABA','C.A.B.A.');
CALL spProveedorAlta('N/A','NEUMAT SANT USADOS','N/A','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('20-30441705-7','NEUMATICOS DEL VALLE','Jorge Luis Canepa','Av. Belgrano 2834','Santiago del Estero','Santiago');
CALL spProveedorAlta('N/A','NEUMATICOS SANTIAGO','NEUMASANTIAGO SRL','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-64007937-8','NEUMEN NEUMATICOS','Gomerias Neumen SA','Av. Lafuente 2946','CABA','Buenos Aires');
CALL spProveedorAlta('27-38732894-2','OPTICAS Y FAROS','ROCIO LEGUIZAMON','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-64142810-4','PERERZ CURBELO NEUMATICOS','Perez Curbelo Hnos SRL','Av Belgrano Sur 3410','Santiago del Estero','Santiago');
CALL spProveedorAlta('N/A','TUERCAS Y TORNILLOS','N/A','N/A','Santiago del Estero','Santiago');
CALL spProveedorAlta('30-59513490-7','VCM NEUMATICOS','Vulcamoia SA','Av. Alcorta Amancio 2347','CABA','Buenos Aires');
CALL spProveedorAlta('30-51852919-2','VEGLIA NEUMATICOS','Veglia Neumáticos SA','Diagonal Ica 1344','Córdoba','Córdoba');
CALL spProveedorAlta('30-63181058-2','WURTH','Wurth Argentina SA','Autovia RP 6 km. 101,5','Cañuelas','Buenos Aires');



    