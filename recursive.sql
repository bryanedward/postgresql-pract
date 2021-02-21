;WITH RECURSIVE rec AS (
        SELECT idpersona, nombre,idpadre, idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 1     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.idpadre, e.idmadre ,rec.degree + 1 AS degree
        FROM persona e
        JOIN rec ON e.idpadre = rec.idpersona
)
, datas  As(
		SELECT idpersona, nombre, idpadre, idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 2     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.idpadre, e.idmadre ,datas.degree + 1 AS degree
        FROM persona e
        JOIN datas ON e.idmadre = datas.idpersona
), unions as(
	select distinct rec.nombre, rec.degree from rec 
	union all select s.nombre, s.degree from datas s join rec on rec.degree = s.degree 
	order by degree asc 
)
select distinct nombre, degree as "Generacion" from unions where degree = 1 order by degree asc
