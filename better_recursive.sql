
;WITH RECURSIVE rec AS (
        SELECT idpersona, nombre,idpadre, idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 1     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.idpadre, e.idmadre ,rec.degree + 1 AS degree
        FROM persona e
        JOIN rec ON e.idpadre = rec.idpersona
)
, recs  As(
		SELECT idpersona, nombre, idpadre, idmadre, 0 AS degree
        FROM persona
        WHERE idpersona = 2     
		UNION ALL
        SELECT e.idpersona, e.nombre, e.idpadre, e.idmadre ,recs.degree + 1 AS degree
        FROM persona e
        JOIN recs ON e.idmadre = recs.idpersona
), unions as(
	select distinct rec.nombre, rec.degree from rec 
	union all select s.nombre, s.degree from recs s join rec on rec.degree = s.degree 
	order by degree asc 
)
select distinct nombre, degree as "Generacion" from unions where degree = 3 order by degree asc
