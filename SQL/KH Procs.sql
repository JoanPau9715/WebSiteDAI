use KAILUAHOUSE
GO


CREATE PROCEDURE COMPROBAR_ADMIN 
	(@userid VARCHAR(20), @claveacceso VARCHAR(20), @res INTEGER OUTPUT)
AS BEGIN

	IF EXISTS 
		(SELECT 1 FROM K_ADMINS
  		 WHERE Usuario = @userid
		 AND CAST(ClaveAcceso AS VARBINARY(20)) = CAST(@claveacceso AS VARBINARY(20)))

		
		SET @res = 1
				
	ELSE
	
		SET @res = 0

	RETURN @res
END
GO


-- Programación para Server Side


USE KAILUA
GO


CREATE PROCEDURE VER_NAVEGACION
AS BEGIN

	SELECT * FROM KV_NAVEGACION
	ORDER BY Miembro ASC, [Fecha hora] DESC

END
GO

CREATE PROCEDURE VER_CLIENTES_LOGEADOS
AS BEGIN

	SELECT * FROM KV_CLIENTES_LOGEADOS
	ORDER BY Estado ASC, [Fecha hora login] DESC, [Fecha hora desconexión] DESC
	
END
GO


CREATE PROCEDURE VER_PROGRAMADORES_LOGEADOS
AS BEGIN

	SELECT * FROM KV_PROGRAMADORES_LOGEADOS
	ORDER BY Estado ASC, [Fecha hora login] DESC, [Fecha hora desconexión] DESC

END
GO

CREATE PROCEDURE CONTAR_VISITANTES(@navs INTEGER OUTPUT)
AS BEGIN

	SET @navs =
		(SELECT COUNT(DISTINCT IP)
		 FROM K_NAVEGACION)
		 
	RETURN @navs

END
GO

CREATE PROCEDURE CONTAR_MOVIMIENTOS(@movs INTEGER OUTPUT)
AS BEGIN

	SET @movs =
		(SELECT COUNT(*)
		 FROM K_NAVEGACION)
	
	RETURN @movs

END
GO



CREATE PROCEDURE GUARDAR_CONFIGURACION
	(@lecturanav SMALLINT, @lecturalogs SMALLINT, @reconstruccion SMALLINT)
AS BEGIN

	UPDATE K_CONFIG
	   SET LecturaNav = @lecturanav,
		   LecturaLogs = @lecturalogs,
		   Reconstruccion = @reconstruccion

END
GO



