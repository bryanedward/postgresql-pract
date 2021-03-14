
--variables en postgresql 
--para la implementacion variables debemos usarlo en una estructura de bloque
do $$
DECLARE 
nombre varchar;
edad int := 200;
BEGIN
	nombre := 'bryan';
	RAISE NOTICE 'el valor es de %',nombre;
END $$;

--condicional if --
do $$
declare
	nombre text;
begin 
	nombre := 'brian';
	if exists(select * from users where nameuser = nombre) then
		RAISE NOTICE 'exito en la consulta';
	else
	RAISE NOTICE 'fallo en la consulta';
	end if;
	
end $$

--condincional while--
--contandor con la tabla user
do $$
declare
 	limite int := (select count(iduser) from users);	
	contador int:= 0;
begin
	while(contador < limite)
	loop
	contador = contador + 1;
	raise notice 'el contador va por %', contador;
	end loop;
end$$

--case
select nameuser, emailuser,
	case when nameuser = 'brian'
	 		then 'es el nombre del desarrollador'
		when nameuser = 'katty'
			then 'es la hermana del desarrollador'
	else 'no encontramos relacion relacion'
	end as tipo_de_usuario
from users


/*cursores*/
--uso de un while
do $$
declare
	registro record;
	cur_nombre Cursor for select * from users;
begin
	OPEN cur_nombre;
	FETCH cur_nombre into registro;
	while(FOUND)
	loop
		RAISE NOTICE 'nombre %', registro.nameuser;
		FETCH cur_nombre into registro;
	end loop;
end $$
LANGUAGE PLPGSQL

--uso de un for
do $$
declare
	registro record;
	cur_nombre Cursor for select * from users;
begin
	FOR registro in cur_nombre
	loop
		RAISE NOTICE 'nombre %', registro.nameuser;
	end loop;
end $$
LANGUAGE PLPGSQL
