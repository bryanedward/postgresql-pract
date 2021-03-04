--creamos nuestra tabla 
CREATE TABLE IF NOT EXISTS persona(
    idpersona INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    nombre varchar(255) NOT NULL,
    apellido varchar(255)NULL,
    genero varchar(255)NULL,
    idpadre INTEGER REFERENCES persona(idpersona),
    idmadre INTEGER REFERENCES persona(idpersona)
)
--creacion de los usuarios 
--generacion 0
insert into persona(nombre, genero,idpadre, idmadre) values('luiss','masculino',null,null);
insert into persona(nombre, genero,idpadre, idmadre) values('carmen','femenino',null,null);
insert into persona(nombre, genero,idpadre, idmadre) values('angel','masculino',null,null);
insert into persona(nombre, genero,idpadre, idmadre) values('maria','femenino',null,null);
--generacion 1
insert into persona(nombre, genero,idpadre, idmadre) values('wilfrido','masculino',1,null);
insert into persona(nombre, genero,idpadre, idmadre) values('auxiliadora','femeneno',null,2);
insert into persona(nombre, genero,idpadre, idmadre) values('oralia','femenino',3,null);
insert into persona(nombre, genero,idpadre, idmadre) values('wilson','masculino',null,4);
--generacion 2
insert into persona(nombre, genero,idpadre, idmadre) values('robert','masculino',5,6);
insert into persona(nombre, genero,idpadre, idmadre) values('nicole','femenino',5,6);
insert into persona(nombre, genero,idpadre, idmadre) values('mayra','femeneno',7,8);
insert into persona(nombre, genero,idpadre, idmadre) values('luis','femenino',7,8);
--generacion 3
insert into persona(nombre, genero,idpadre, idmadre) values('amaia','femeneno',9,11);
insert into persona(nombre, genero,idpadre, idmadre) values('luis','femenino',10,12);


--consulta para buscar en un generacion en el where al final where degree = 1 defines que generacion necesitas buscar
;WITH RECURSIVE rec AS (
        SELECT idpersona, nombre,idpadre, idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 1     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.idpadre, e.idmadre ,rec.degree + 1 AS degree
        FROM persona e
        JOIN rec ON e.idpadre = rec.idpersona or e.idmadre = rec.idpersona
)
, recs  As(
		SELECT idpersona, nombre, idpadre, idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 2     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.idpadre, e.idmadre ,recs.degree + 1 AS degree
        FROM persona e
        JOIN recs ON e.idmadre = recs.idpersona or e.idpadre = recs.idpersona
)
, datas  As(
		SELECT idpersona, nombre, idpadre, 
	idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 3     
		UNION ALL
        SELECT e.idpersona, e.nombre, 
	e.idpadre, e.idmadre ,
	datas.degree + 1 AS degree
        FROM persona e
        JOIN datas ON e.idpadre = datas.idpersona or e.idmadre = datas.idpersona
)
, datass  As(
		SELECT idpersona, nombre, idpadre, 
	idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 4     
		UNION ALL
        SELECT e.idpersona, e.nombre, 
	e.idpadre, e.idmadre ,
	datass.degree + 1 AS degree
        FROM persona e
        JOIN datass ON e.idmadre = datass.idpersona or e.idpadre = datass.idpersona
)
,unions as(
	select distinct rec.nombre, rec.degree from rec 
	union all select s.nombre, s.degree from recs s join rec on rec.degree = s.degree 
	order by degree asc 
)
,unionss as(
	select distinct datas.degree, datas.nombre from datas 
	union all select s.degree, s.nombre 
	from datass s join datas on datas.degree = s.degree 
)
, superunion as(
	select distinct unions.nombre, unions.degree from unions 
	union all select ons.nombre, ons.degree from unionss ons join 
	unions on unions.degree = ons.degree
)
select distinct nombre, degree as "Generacion" from superunion where degree = 1 order by degree asc



