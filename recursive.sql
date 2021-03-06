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

--creamos un nodo raiz y actualizados la primera generacion haciendo relacion con el nodo
--raiz creado
insert into persona(nombre, genero,idpadre, idmadre) values('generacion',null,null,null);
--creamos la relacion con el nodo raiz con su idpersona   
update persona set idpadre = 16 where idpersona = 1;
update persona set idpadre = 16 where idpersona = 2;
update persona set idpadre = 16 where idpersona = 3;
update persona set idpadre = 16 where idpersona = 4;

--creamos la consulta sobre generaciones 
--iniciamos nuestro contador en -1 debido al nodo raiz que hemos creado
;WITH RECURSIVE rec AS (
        SELECT idpersona, nombre, apellido, genero, idpadre, idmadre, -1 AS contador
        FROM persona
        WHERE idpersona = 16     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.apellido, e.genero, e.idpadre, e.idmadre,
		rec.contador + 1 AS contador
        FROM persona e
        JOIN rec ON e.idpadre = rec.idpersona or e.idmadre = rec.idpersona
)
select distinct nombre, (contador) as generacion from rec where contador = 3

--creamos una nueva generacion
insert into persona(nombre, genero,idpadre, idmadre) values('luis robert','masculino',null,13);
insert into persona(nombre, genero,idpadre, idmadre) values('jose robert','masculino',null,13);
insert into persona(nombre, genero,idpadre, idmadre) values('luis gabriel','masculino',14,null);
insert into persona(nombre, genero,idpadre, idmadre) values('jose gabriel','masculino',14,null);

--volvemos a consultar con nuestra consulta
