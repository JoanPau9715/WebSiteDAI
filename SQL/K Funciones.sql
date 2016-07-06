USE KAILUA
GO


CREATE FUNCTION PREPARAR_FECHA(@fecha DATETIME)
RETURNS VARCHAR(70)
AS BEGIN

	DECLARE @diasemana VARCHAR
	SET @diasemana = CAST(DatePart(dw, @fecha) AS VARCHAR)

	DECLARE @numeromes VARCHAR
	SET @numeromes = CAST(DatePart(mm, @fecha) AS VARCHAR)

	DECLARE @cadenafh VARCHAR(70)
	
	
	DECLARE @segundos VARCHAR(2)
	DECLARE @minutos VARCHAR(2)
	DECLARE @horas VARCHAR(2)
	
	SET @segundos = CAST(DatePart(SECOND, @fecha) AS VARCHAR)
	SET @minutos = CAST(DatePart(MINUTE, @fecha) AS VARCHAR)
	SET @horas = CAST(DatePart(HOUR, @fecha) AS VARCHAR)

	IF CAST(DatePart(HOUR, @fecha) AS INTEGER) < 10
	BEGIN
		
		SET @horas = '0' + @horas
	
	END
	
	IF CAST(DatePart(MINUTE, @fecha) AS INTEGER) < 10
	BEGIN
		
		SET @minutos = '0' + @minutos
	
	END

	SET @cadenafh = case when @diasemana = '1' then 'Lunes'
				when @diasemana = '2' then 'Martes'
				when @diasemana = '3' then 'Miércoles'
				when @diasemana = '4' then 'Jueves'
				when @diasemana = '5' then 'Viernes'
				when @diasemana = '6' then 'Sábado'
				when @diasemana = '7' then 'Domingo' end
			+ ' ' + CAST(DatePart(dd, @fecha) AS VARCHAR)
			+ ' de ' + 
		   case when @numeromes = '1' then 'Enero'
				when @numeromes = '2' then 'Febrero'
				when @numeromes = '3' then 'Marzo'
				when @numeromes = '4' then 'Abril'
				when @numeromes = '5' then 'Mayo'
				when @numeromes = '6' then 'Junio'
				when @numeromes = '7' then 'Julio' 
				when @numeromes = '8' then 'Agosto'
				when @numeromes = '9' then 'Septiembre'
				when @numeromes = '10' then 'Octubre'
				when @numeromes = '11' then 'Noviembre'
				when @numeromes = '12' then 'Diciembre' end 
			+ ' a las ' + @horas
			+ ':' + @minutos


	RETURN @cadenafh
	
END
GO

