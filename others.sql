--view

CREATE VIEW mostraruser
as SELECT nameuser, emailuser FROM backup_users;

SELECT * FROM mostraruser;


--functions maths
    ABS(x) = --valor absoluto | 
    --cbrt(x) = raiz cubica | 
    CEILING(x) = --redondear hacia arriba
    floor(x)= --redondear hacia abajo | 
    power(x,y)  --eleva a la "y" potencia
    ROUND(n,d) --redondear con "d" asignamos los decimales | 
    --sign(x) + = 1, - = -1,  0 = 0 | sqrt(x) raiz cuadrada |
    trunc(x) --devuelve la parte entera de un numero


--functions characters majo cadena de caracteres
    char_length('hola mundo') --devuelve el largo del texto
    UPPER(string) --vuelve todo mayuscula
    LOWER(string) --vuelve todo minuscula

--function para fechas y horas
    SELECT CURRENT_DATE --fecha actual
    SELECT CURRENT_TIME --hora actual y zona horario
    SELECT CURRENT_TIMESTAMP -- fecha y hora actual

    SELECT extract (year FROM CURRENT_TIMESTAMP) -- extraerr 
