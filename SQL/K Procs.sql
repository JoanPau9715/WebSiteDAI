USE KAILUA
GO

CREATE PROCEDURE INSERTAR_SOFTWARE_OFERTADO
	(@nickpro VARCHAR(20), @tipo VARCHAR(20), @descripcion VARCHAR(400), 
	 @personalizable BIT, @connbd BIT, @tipobd VARCHAR(30), @nickcli VARCHAR(20))
AS BEGIN

	INSERT INTO K_SOFTWARE_OFERTADO
		VALUES	(@nickpro, @tipo, @descripcion, @personalizable,
				 @connbd, CASE WHEN @tipobd = '' THEN null ELSE @tipobd END, @nickcli, default, default)

	INSERT INTO K_NOTIFICACIONES
		VALUES (@nickcli, 'Software', 'Nueva oferta de ' + @tipo + ' de ' + @nickpro, 
				default, dbo.PREPARAR_FECHA(current_timestamp), default)

END
GO



CREATE PROCEDURE INSERTAR_SOFTWARE_DEMANDADO
  (@nickcli VARCHAR(20), @tipo VARCHAR(20), @descripcion VARCHAR(400),
   @connbd BIT, @tipobd VARCHAR(30), @nickpro VARCHAR(20))
AS BEGIN

	INSERT INTO K_SOFTWARE_DEMANDADO
		VALUES (@nickcli, @tipo, @descripcion, @connbd, 
			CASE WHEN @tipobd = '' THEN null ELSE @tipobd END, @nickpro, default, default)

	INSERT INTO K_NOTIFICACIONES
		VALUES (@nickpro, 'Software', 'Nueva solicitud de ' + @tipo + ' de ' +  @nickcli, 
				default, dbo.PREPARAR_FECHA(current_timestamp), default)

END
GO

create PROCEDURE MODIFICAR_SOFTWARE_DEMANDADO
	(@idsoft INTEGER, @conbd BIT, @tipobd VARCHAR(30), @descripcion VARCHAR(400))
AS BEGIN

	UPDATE K_SOFTWARE_DEMANDADO
		SET ConexionBD = @conbd, TipoBD = CASE WHEN @tipobd = '' THEN null ELSE @tipobd END,
			Descrip = @descripcion
		WHERE IdSoft = @idsoft
	
END
GO

CREATE PROCEDURE BORRAR_SOFTWARE_DEMANDADO
	(@idsoft INTEGER)
AS BEGIN

	DELETE FROM K_SOFTWARE_DEMANDADO
		WHERE IdSoft = @idsoft

END
GO


create PROCEDURE MODIFICAR_SOFTWARE_OFERTADO
	(@idsoft INTEGER, @conbd BIT, @tipobd VARCHAR(30), @amedida BIT, @descripcion VARCHAR(400))
AS BEGIN

	UPDATE K_SOFTWARE_OFERTADO
		SET ConexionBD = @conbd, TipoBD = CASE WHEN @tipobd = '' THEN null ELSE @tipobd END,
			Descrip = @descripcion, Personalizable = @amedida
		WHERE IdSoft = @idsoft
	
END
GO


CREATE PROCEDURE BORRAR_SOFTWARE_OFERTADO
	(@idsoft INTEGER)
AS BEGIN

	DELETE FROM K_SOFTWARE_OFERTADO
		WHERE IdSoft = @idsoft

END
GO

CREATE PROCEDURE ACEPTAR_OFERTA
	(@idsoft INTEGER)
AS BEGIN

	UPDATE K_SOFTWARE_OFERTADO
	   SET Aceptado = 1
	 WHERE IdSoft = @idsoft
	 
	
	DECLARE @ofertante VARCHAR(20)
	DECLARE @ofertado  VARCHAR(20)
	DECLARE @oferta VARCHAR(20)
	
	SET @ofertante =
		(SELECT NickPro
		   FROM K_SOFTWARE_OFERTADO
		  WHERE IdSoft = @idsoft)
		  
	SET @ofertado =
		(SELECT NickCli
		   FROM K_SOFTWARE_OFERTADO
		  WHERE IdSoft = @idsoft)
		  
	SET @oferta =
		(SELECT Tipo
		   FROM K_SOFTWARE_OFERTADO
		  WHERE IdSoft = @idsoft)		  
		  
	INSERT INTO K_NOTIFICACIONES
		VALUES (@ofertante, 'Software', @ofertado + ' ha aceptado su oferta de ' + @oferta, 
				default, dbo.PREPARAR_FECHA(Current_TimeStamp), default)
	
END
GO

CREATE PROCEDURE RECHAZAR_OFERTA
	(@idsoft INTEGER)
AS BEGIN

	UPDATE K_SOFTWARE_OFERTADO
	   SET Aceptado = NULL
	 WHERE IdSoft = @idsoft
	 
	DECLARE @ofertante VARCHAR(20)
	DECLARE @ofertado  VARCHAR(20)
	DECLARE @oferta VARCHAR(20)
	
	SET @ofertante =
		(SELECT NickPro
		   FROM K_SOFTWARE_OFERTADO
		  WHERE IdSoft = @idsoft)
		  
	SET @ofertado =
		(SELECT NickCli
		   FROM K_SOFTWARE_OFERTADO
		  WHERE IdSoft = @idsoft)
		  
	SET @oferta =
		(SELECT Tipo
		   FROM K_SOFTWARE_OFERTADO
		  WHERE IdSoft = @idsoft)		  		  
		  
	INSERT INTO K_NOTIFICACIONES
		VALUES (@ofertante, 'Software', @ofertado + ' ha rechazado su oferta de ' + @oferta, 
				default, dbo.PREPARAR_FECHA(Current_TimeStamp), default)	 
	
END
GO

CREATE PROCEDURE ACEPTAR_SOLICITUD
	(@idsoft INTEGER)
AS BEGIN

	UPDATE K_SOFTWARE_DEMANDADO
	   SET Aceptado = 1
	 WHERE IdSoft = @idsoft

	DECLARE @solicitante VARCHAR(20)
	DECLARE @solicitado  VARCHAR(20)
	DECLARE @solicitud VARCHAR(20)
	
	SET @solicitante =
		(SELECT NickCli
		   FROM K_SOFTWARE_DEMANDADO
		  WHERE IdSoft = @idsoft)
		  
	SET @solicitado =
		(SELECT NickPro
		   FROM K_SOFTWARE_DEMANDADO
		  WHERE IdSoft = @idsoft)

	SET @solicitud =
		(SELECT Tipo
		   FROM K_SOFTWARE_DEMANDADO
		  WHERE IdSoft = @idsoft)
		  
	INSERT INTO K_NOTIFICACIONES
		VALUES (@solicitante,'Software', @solicitado + ' ha aceptado su solicitud de ' + @solicitud, 
				default, dbo.PREPARAR_FECHA(Current_TimeStamp), default)


END
GO

CREATE PROCEDURE RECHAZAR_SOLICITUD
	(@idsoft INTEGER)
AS BEGIN

	UPDATE K_SOFTWARE_DEMANDADO
	   SET Aceptado = NULL
	 WHERE IdSoft = @idsoft

	DECLARE @solicitante VARCHAR(20)
	DECLARE @solicitado  VARCHAR(20)
	DECLARE @solicitud VARCHAR(20)	
	
	SET @solicitante =
		(SELECT NickCli
		   FROM K_SOFTWARE_DEMANDADO
		  WHERE IdSoft = @idsoft)
		  
	SET @solicitado =
		(SELECT NickPro
		   FROM K_SOFTWARE_DEMANDADO
		  WHERE IdSoft = @idsoft)
		  
	SET @solicitud =
		(SELECT Tipo
		   FROM K_SOFTWARE_DEMANDADO
		  WHERE IdSoft = @idsoft)		  
		  
	INSERT INTO K_NOTIFICACIONES
		VALUES (@solicitante, 'Software', @solicitado + ' ha rechazado su solicitud de ' + @solicitud, 
				default, dbo.PREPARAR_FECHA(Current_TimeStamp), default)

END
GO

CREATE PROCEDURE DESCONECTAR_CLIENTE
	(@nick VARCHAR(20))
AS BEGIN

	DELETE FROM K_NAVEGACION 
	 WHERE Miembro = @nick	 	

	UPDATE K_CLIENTES_LOGEADOS
		SET IP = null, Estado = 'Desconectado', ZonaActual = null,
			FHLogin = null, FHDescon = CURRENT_TIMESTAMP
			
		WHERE Nick = @nick

END
GO


CREATE PROCEDURE DESCONECTAR_PROGRAMADOR
	(@nick VARCHAR(20))
AS BEGIN

	DELETE FROM K_NAVEGACION 
	 WHERE Miembro = @nick

	UPDATE K_PROGRAMADORES_LOGEADOS
		SET IP = null, Estado = 'Desconectado', ZonaActual = null,
			FHLogin = null, FHDescon = CURRENT_TIMESTAMP
			
		WHERE Nick = @nick			

END
GO

CREATE PROCEDURE LOGEAR_CLIENTE
  (@nick VARCHAR(20), @ip VARCHAR(20))
AS BEGIN

	DECLARE @fhlogin DATETIME
	DECLARE @estado VARCHAR(12)
	
	SET @fhlogin = CURRENT_TIMESTAMP
	SET @estado = 'Conectado'

	INSERT INTO K_CLIENTES_LOGEADOS 
		VALUES (@nick, @ip, @estado, null, @fhlogin, null)

END
GO


CREATE PROCEDURE LOGEAR_PROGRAMADOR
  (@nick VARCHAR(20), @ip VARCHAR(20))
AS BEGIN

	DECLARE @fhlogin DATETIME
	DECLARE @estado VARCHAR(12)
	
	SET @fhlogin = CURRENT_TIMESTAMP
	SET @estado = 'Conectado'

	INSERT INTO K_PROGRAMADORES_LOGEADOS 
		VALUES (@nick, @ip, @estado, null, @fhlogin, null)

END
GO


CREATE PROCEDURE VOLCAR_DATOS_VISITAS	
  (@miembro VARCHAR(20),@ip VARCHAR(20), @pagina VARCHAR(50), 
   @navegador VARCHAR(100), @metodo VARCHAR(50), @fhvisita DATETIME)   	
AS BEGIN

	INSERT INTO K_NAVEGACION
		VALUES (@miembro, @ip, @pagina, @navegador, @metodo, @fhvisita)		

END
GO


CREATE PROCEDURE INSERTAR_PROGRAMADOR
  (@nombre VARCHAR(20), @apellidos VARCHAR(40), @email VARCHAR(40), 
   @tel CHAR(9), @empresa VARCHAR(40), @nick VARCHAR(20), @clave VARCHAR(20))
AS BEGIN
	
	INSERT INTO K_PROGRAMADORES
		VALUES(@nombre, @apellidos, @email, @tel, @empresa, default, @nick, @clave)
		
	INSERT INTO K_NOTIFICACIONES
		VALUES (@nick, 'Ekomomai', 'E komo mai, mahalo ''ohana kailua', 
				default, dbo.PREPARAR_FECHA(CURRENT_TIMESTAMP), default)
	
END
GO


CREATE PROCEDURE INSERTAR_PROG_EXP (@nickpro VARCHAR(20), @exp VARCHAR(20))
AS BEGIN

	DECLARE @idexp INTEGER
	
	SET @idexp =
		(SELECT IdExp FROM K_ESPECIALIDADES WHERE Denom = @exp)

	INSERT INTO K_PROGRAMADORES_ESPECIALIDADES 
		VALUES(@nickpro, @idexp)		

END
GO

CREATE PROCEDURE INSERTAR_CLIENTE
  (@nombre VARCHAR(20), @apellidos VARCHAR(40), @empresa VARCHAR(40), 
   @idsector INTEGER, @cargo VARCHAR(40), @email VARCHAR(40), @tel CHAR(9), 
   @nick VARCHAR(20), @clave VARCHAR(20))
AS BEGIN
	
	INSERT INTO K_CLIENTES 
		VALUES(@nombre, @apellidos, @empresa, @idsector, @cargo, @email, @tel, default, @nick, @clave)
	
	INSERT INTO K_NOTIFICACIONES
		VALUES (@nick, 'Ekomomai', 'E komo mai, mahalo ''ohana kailua', 
				default, dbo.PREPARAR_FECHA(CURRENT_TIMESTAMP), default)
	
END
GO


CREATE PROCEDURE COMPROBAR_CLIENTE
	(@nick VARCHAR(20), @clave VARCHAR(20), @res INTEGER OUTPUT)
AS BEGIN

	IF EXISTS 
		(SELECT 1 FROM K_CLIENTES 
		 WHERE 	Nick = @nick
		 AND    CAST(Clave  AS VARBINARY(20)) = CAST(@clave   AS VARBINARY(20)))

		
		SET @res = 1
				
	ELSE
	
		SET @res = 0

	RETURN @res
END
GO


CREATE PROCEDURE COMPROBAR_PROGRAMADOR
	(@nick VARCHAR(20), @clave VARCHAR(20), @res INTEGER OUTPUT)
AS BEGIN

	IF EXISTS 
		(SELECT 1 FROM K_PROGRAMADORES 
		 WHERE 	Nick = @nick
		 AND    CAST(Clave  AS VARBINARY(20)) = CAST(@clave   AS VARBINARY(20)))
		
		SET @res = 1
				
	ELSE
	
		SET @res = 0

	RETURN @res
END
GO


CREATE PROCEDURE COMPROBAR_DISPONIBILIDAD_NICK
	(@Nick VARCHAR(20), @res INTEGER OUTPUT)
AS BEGIN

	IF EXISTS 
		(SELECT 1 FROM K_CLIENTES 
		 WHERE 	Nick = @Nick)		 
    OR EXISTS 
		(SELECT 1 FROM K_PROGRAMADORES
		 WHERE 	Nick = @Nick)		 		 
		
		SET @res = 0
				
	ELSE
	
		SET @res = 1

	RETURN @res
END
GO


CREATE PROCEDURE ENVIAR_MENSAJE
(@nickcli VARCHAR(20), @nickpro VARCHAR(20), @direccion CHAR(6), @asunto VARCHAR(40), @texto VARCHAR(600))
AS BEGIN

	INSERT INTO K_MENSAJES
		VALUES (@nickcli, @nickpro, @direccion, CASE WHEN @asunto = '' THEN 'sin asunto' else @asunto end, 
		@texto, Default, Default)
		
	
	INSERT INTO K_NOTIFICACIONES
		VALUES (CASE WHEN @direccion = 'CliPro' THEN @nickpro
					 WHEN @direccion = 'ProCli' THEN @nickcli END,
				'Mensaje',
				'Nuevo mensaje de ' + 
				CASE WHEN @direccion = 'CliPro' THEN @nickcli
					 WHEN @direccion = 'ProCli' THEN @nickpro END, 				
				default, dbo.PREPARAR_FECHA(current_timestamp), default)

END
GO

CREATE PROCEDURE BORRAR_MENSAJE
	(@idmensaje INTEGER)
AS BEGIN

	DELETE FROM K_MENSAJES
		WHERE IdMensaje = @idmensaje

END 
GO
	

CREATE PROCEDURE MARCAR_LEIDO
	(@idmensaje INTEGER)
AS BEGIN

	UPDATE K_MENSAJES
		SET Leido = 1
		WHERE IdMensaje = @idmensaje

END
GO


CREATE PROCEDURE VER_MIS_DEMANDAS
	(@nickcli VARCHAR(20), @pag INTEGER, @vista VARCHAR(20))
AS BEGIN

	DECLARE @sols 
		TABLE
			(NumRow INTEGER NULL, 
			 IdSoft INTEGER, 
			 Cliente VARCHAR(20), 
			 Tipo VARCHAR(60), 
			 Descripcion VARCHAR(400), 
			 FHSolicitud SMALLDATETIME, 
			 FHCadena VARCHAR(70),
			 Atendida VARCHAR(40))


	IF @vista = 'Todas'
			INSERT INTO 
				@sols(IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_DEMANDADO
						 WHERE Cliente = @nickcli
	
	IF @vista = 'AppWindows'
			INSERT INTO 
				@sols(IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_DEMANDADO
						 WHERE Cliente = @nickcli
						   AND Tipo LIKE 'Apl%'
	  
	IF @vista = 'SitiosWeb'
			INSERT INTO 
				@sols(IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_DEMANDADO
						 WHERE Cliente = @nickcli
						   AND Tipo LIKE 'Sit%'

					
				 
	DECLARE curNumRow CURSOR FOR
		SELECT NumRow FROM @sols
		FOR UPDATE OF NumRow
		
	DECLARE @numRow INTEGER
	DECLARE @filaactual INTEGER
	
	SET @numRow = ((SELECT COUNT(*) FROM @sols) - 1)
	
	OPEN curNumRow
	
	FETCH NEXT FROM curNumRow 
		INTO @filaactual
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		UPDATE @sols SET NumRow = @numRow
			WHERE CURRENT OF curNumRow
			

		SET @numRow = @numRow - 1
					
		FETCH NEXT FROM curNumRow			
			INTO @filaactual
		
	END
	
	CLOSE curNumRow
	DEALLOCATE curNumRow
		
	SELECT * FROM @sols	
		WHERE NumRow BETWEEN (6 * (@pag - 1)) AND ((6 * @pag) - 1)
		ORDER BY FHSolicitud DESC	 


END
GO



CREATE PROCEDURE CONTAR_MIS_DEMANDAS
	(@nickcli VARCHAR(20), @vista VARCHAR(20), @num INTEGER OUTPUT)
AS BEGIN

	SET @num =
	  CASE 
	    WHEN @vista = 'Todas' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_DEMANDADO
	  		 WHERE Cliente = @nickcli)	  
	  
	    WHEN @vista = 'AppWindows' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_DEMANDADO
	  		 WHERE Cliente = @nickcli 
	  		   AND Tipo LIKE 'Apl%')	  	  		   
	  		 
	    WHEN @vista = 'SitiosWeb' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_DEMANDADO
	  		 WHERE Cliente = @nickcli 
	  		   AND Tipo LIKE 'Sit%')	  
	  		   

	   END
	 	  		 
	RETURN @num

END
GO



CREATE PROCEDURE VER_MIS_OFERTAS
	(@nickpro VARCHAR(20), @pag INTEGER, @vista VARCHAR(20))
AS BEGIN

	DECLARE @ofers 
		TABLE
			(NumRow INTEGER NULL, 
			 IdSoft INTEGER, 
			 Programador VARCHAR(20), 
			 Tipo VARCHAR(60), 
			 Descripcion VARCHAR(400),
			 Personalizable VARCHAR(9), 
			 FHOferta SMALLDATETIME, 
			 FHCadena VARCHAR(70),
			 Atendida VARCHAR(40))


	IF @vista = 'Todas'
			INSERT INTO 
				@ofers(IdSoft, Programador, Tipo, Descripcion, Personalizable, FHOferta, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_OFERTADO
						 WHERE Programador = @nickpro
	
	IF @vista = 'AppWindows'
			INSERT INTO 
				@ofers(IdSoft, Programador, Tipo, Descripcion, Personalizable, FHOferta, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_OFERTADO
						 WHERE Programador = @nickpro
						   AND Tipo LIKE 'Apl%'
	  
	IF @vista = 'SitiosWeb'
			INSERT INTO 
				@ofers(IdSoft, Programador, Tipo, Descripcion, Personalizable, FHOferta, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_OFERTADO
						 WHERE Programador = @nickpro
						   AND Tipo LIKE 'Sit%'

					
				 
	DECLARE curNumRow CURSOR FOR
		SELECT NumRow FROM @ofers
		FOR UPDATE OF NumRow
		
	DECLARE @numRow INTEGER
	DECLARE @filaactual INTEGER
	
	SET @numRow = ((SELECT COUNT(*) FROM @ofers) - 1)
	
	OPEN curNumRow
	
	FETCH NEXT FROM curNumRow 
		INTO @filaactual
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		UPDATE @ofers SET NumRow = @numRow
			WHERE CURRENT OF curNumRow
			

		SET @numRow = @numRow - 1
					
		FETCH NEXT FROM curNumRow			
			INTO @filaactual
		
	END
	
	CLOSE curNumRow
	DEALLOCATE curNumRow
		
	SELECT * FROM @ofers	
		WHERE NumRow BETWEEN (6 * (@pag - 1)) AND ((6 * @pag) - 1)
		ORDER BY FHOferta DESC	 


END
GO



CREATE PROCEDURE CONTAR_MIS_OFERTAS
	(@nickpro VARCHAR(20), @vista VARCHAR(20), @num INTEGER OUTPUT)
AS BEGIN

	SET @num =
	  CASE 
	    WHEN @vista = 'Todas' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_OFERTADO
	  		 WHERE Programador = @nickpro)	  
	  		 
	  
	    WHEN @vista = 'AppWindows' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_OFERTADO
	  		 WHERE Programador = @nickpro 
	  		   AND Tipo LIKE 'Apl%')	  	  		   
	  		 
	    WHEN @vista = 'SitiosWeb' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_OFERTADO
	  		 WHERE Programador = @nickpro 
	  		   AND Tipo LIKE 'Sit%')	  
	  		   

	   END
	 	  		 
	RETURN @num

END
GO



CREATE PROCEDURE VER_CLI_OFERTAS
	(@nickcli VARCHAR(20), @pag INTEGER, @vista VARCHAR(20))
AS BEGIN

	DECLARE @ofers 
		TABLE
			(NumRow INTEGER NULL, 
			 Cliente VARCHAR(20),
			 IdSoft INTEGER, 
			 Programador VARCHAR(20), 
			 Tipo VARCHAR(60), 
			 Descripcion VARCHAR(400),
			 FHOferta SMALLDATETIME, 
			 FHCadena VARCHAR(70),
			 Atendida VARCHAR(40))


	IF @vista = 'Todas'
			INSERT INTO 
				@ofers(Cliente, IdSoft, Programador, Tipo, Descripcion, FHOferta, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_OFERTADO_A_CLIENTE
						 WHERE Cliente = @nickcli
						   AND Atendida NOT LIKE 'Rechaz%'
	
	IF @vista = 'AppWindows'
			INSERT INTO 
				@ofers(Cliente, IdSoft, Programador, Tipo, Descripcion, FHOferta, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_OFERTADO_A_CLIENTE
						 WHERE Cliente = @nickcli
						   AND Tipo LIKE 'Apl%'
						   AND Atendida NOT LIKE 'Rechaz%'						   
	  
	IF @vista = 'SitiosWeb'
			INSERT INTO 
				@ofers(Cliente, IdSoft, Programador, Tipo, Descripcion, FHOferta, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_OFERTADO_A_CLIENTE
						 WHERE Cliente = @nickcli
						   AND Tipo LIKE 'Sit%'
						   AND Atendida NOT LIKE 'Rechaz%'						   

					
				 
	DECLARE curNumRow CURSOR FOR
		SELECT NumRow FROM @ofers
		FOR UPDATE OF NumRow
		
	DECLARE @numRow INTEGER
	DECLARE @filaactual INTEGER
	
	SET @numRow = ((SELECT COUNT(*) FROM @ofers WHERE Cliente = @nickcli) - 1)
	
	OPEN curNumRow
	
	FETCH NEXT FROM curNumRow 
		INTO @filaactual
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		UPDATE @ofers SET NumRow = @numRow
			WHERE CURRENT OF curNumRow
			

		SET @numRow = @numRow - 1
					
		FETCH NEXT FROM curNumRow			
			INTO @filaactual
		
	END
	
	CLOSE curNumRow
	DEALLOCATE curNumRow
		
	SELECT * FROM @ofers	
		WHERE NumRow BETWEEN (6 * (@pag - 1)) AND ((6 * @pag) - 1)
		ORDER BY FHOferta DESC	 


END
GO

CREATE PROCEDURE CONTAR_CLI_OFERTAS
	(@nickcli VARCHAR(20), @vista VARCHAR(20), @num INTEGER OUTPUT)
AS BEGIN

	SET @num =
	  CASE 
	    WHEN @vista = 'Todas' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_OFERTADO_A_CLIENTE
	  		 WHERE Cliente = @nickcli
			   AND Atendida NOT LIKE 'Rechaz%')	  		 	  
	  
	    WHEN @vista = 'AppWindows' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_OFERTADO_A_CLIENTE
	  		 WHERE Cliente = @nickcli AND Tipo LIKE 'Apl%'
			   AND Atendida NOT LIKE 'Rechaz%')
	  		 
	  		 
	    WHEN @vista = 'SitiosWeb' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_OFERTADO_A_CLIENTE
	  		 WHERE Cliente = @nickcli AND Tipo LIKE 'Sit%'
			   AND Atendida NOT LIKE 'Rechaz%')	  		 

	   END
	 	  		 
	RETURN @num

END
GO


CREATE PROCEDURE VER_PRO_DEMANDAS
	(@nickpro VARCHAR(20), @pag INTEGER, @vista VARCHAR(20))
AS BEGIN

	DECLARE @sols 
		TABLE
			(NumRow INTEGER NULL, 
			 Programador VARCHAR(20),
			 IdSoft INTEGER, 
			 Cliente VARCHAR(20), 
			 Tipo VARCHAR(60), 
			 Descripcion VARCHAR(400), 
			 FHSolicitud SMALLDATETIME, 
			 FHCadena VARCHAR(70),
			 Atendida VARCHAR(40))


	IF @vista = 'Todas'
			INSERT INTO 
				@sols(Programador, IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
						 WHERE Programador = @nickpro
						   AND Atendida NOT LIKE 'Rechaz%'						   
						 
	
	IF @vista = 'AppWindows'
			INSERT INTO 
				@sols(Programador, IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
						 WHERE Programador = @nickpro
						   AND Tipo LIKE 'Apl%'
						   AND Atendida NOT LIKE 'Rechaz%'						   
	  
	IF @vista = 'SitiosWeb'
			INSERT INTO 
				@sols(Programador, IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
				SELECT * FROM KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
						 WHERE Programador = @nickpro
						   AND Tipo LIKE 'Sit%'
						   AND Atendida NOT LIKE 'Rechaz%'						   

					
				 
	DECLARE curNumRow CURSOR FOR
		SELECT NumRow FROM @sols
		FOR UPDATE OF NumRow
		
	DECLARE @numRow INTEGER
	DECLARE @filaactual INTEGER
	
	SET @numRow = ((SELECT COUNT(*) FROM @sols) - 1)
	
	OPEN curNumRow
	
	FETCH NEXT FROM curNumRow 
		INTO @filaactual
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		UPDATE @sols SET NumRow = @numRow
			WHERE CURRENT OF curNumRow
			

		SET @numRow = @numRow - 1
					
		FETCH NEXT FROM curNumRow			
			INTO @filaactual
		
	END
	
	CLOSE curNumRow
	DEALLOCATE curNumRow
		
	SELECT * FROM @sols	
		WHERE NumRow BETWEEN (6 * (@pag - 1)) AND ((6 * @pag) - 1)
		ORDER BY FHSolicitud DESC	 


END
GO



CREATE PROCEDURE CONTAR_PRO_DEMANDAS
	(@nickpro VARCHAR(20), @vista VARCHAR(20), @num INTEGER OUTPUT)
AS BEGIN

	SET @num =
	  CASE 
	    WHEN @vista = 'Todas' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
	  		 WHERE Programador = @nickpro
	  		   AND Atendida NOT LIKE 'Rechaz%')	  
	  		 	  	  
	    WHEN @vista = 'AppWindows' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
	  		 WHERE Programador = @nickpro 
	  		   AND Tipo LIKE 'Apl%'
	  		   AND Atendida NOT LIKE 'Rechaz%')	  	  		   
	  		 
	    WHEN @vista = 'SitiosWeb' THEN
			(SELECT COUNT(*) FROM KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
	  		 WHERE Programador = @nickpro 
	  		   AND Tipo LIKE 'Sit%'
	  		   AND Atendida NOT LIKE 'Rechaz%')	  
	  		   

	   END
	 	  		 
	RETURN @num

END
GO



CREATE PROCEDURE VER_MENSAJES_PARA
	(@direccion CHAR(6), @nickcli VARCHAR(20), @nickpro VARCHAR(20), @pag INTEGER)
AS BEGIN


	DECLARE @mensajes 
		TABLE (NumRow INTEGER NULL,
			   IdMensaje INTEGER,
			   NickCli VARCHAR(20),
			   NickPro VARCHAR(20),
			   Asunto VARCHAR(40),
			   Texto VARCHAR(500),
			   FHEnvio SMALLDATETIME,
			   FHCadena VARCHAR(70),
			   Leido BIT)
			   
	IF (@direccion = 'CliPro')
		INSERT INTO @mensajes(IdMensaje, NickCli, NickPro, Asunto, Texto, FHEnvio, FHCadena, Leido)
			SELECT IdMensaje, NickCli, NickPro, Asunto, Texto, FHEnvio, FHCadena, Leido
			  FROM KV_MENSAJES
			 WHERE Direccion = 'CliPro' 
			   AND NickPro = @nickpro
		
	IF (@direccion = 'ProCli')
		INSERT INTO @mensajes(IdMensaje, NickCli, NickPro, Asunto, Texto, FHEnvio, FHCadena, Leido)
			SELECT IdMensaje, NickCli, NickPro, Asunto, Texto, FHEnvio, FHCadena, Leido
			  FROM KV_MENSAJES
			 WHERE Direccion = 'ProCli' 
			   AND NickCli = @nickcli

	DECLARE curNumRow CURSOR FOR
		SELECT NumRow FROM @mensajes
		FOR UPDATE OF NumRow

	DECLARE @numRow INTEGER
	DECLARE @filaactual INTEGER
	
	SET @numRow = ((SELECT COUNT(*) FROM @mensajes) - 1)
	
	OPEN curNumRow
	
	FETCH NEXT FROM curNumRow 
		INTO @filaactual
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		UPDATE @mensajes SET NumRow = @numRow
			WHERE CURRENT OF curNumRow
			

		SET @numRow = @numRow - 1
					
		FETCH NEXT FROM curNumRow			
			INTO @filaactual
		
	END
	
	CLOSE curNumRow
	DEALLOCATE curNumRow
		
	SELECT * FROM @mensajes	
		WHERE NumRow BETWEEN (6 * (@pag - 1)) AND ((6 * @pag) - 1)
		ORDER BY FHEnvio DESC	 

		
END
GO


CREATE PROCEDURE CONTAR_MENSAJES_PARA 
	(@nick VARCHAR(20), @num INTEGER OUTPUT)
AS BEGIN

	DECLARE @direccion CHAR(6)

	IF EXISTS (SELECT 1 FROM K_CLIENTES WHERE Nick = @nick)		  		  
		  SET @direccion = 'ProCli'

	IF EXISTS (SELECT 1 FROM K_PROGRAMADORES WHERE Nick = @nick)		  		  
		  SET @direccion = 'CliPro'

	SET @num =
		CASE WHEN @direccion = 'ProCli' THEN
				(SELECT COUNT(*) FROM K_MENSAJES
					WHERE NickCli = @nick
					AND Direccion = @direccion)
			 WHEN @direccion = 'CliPro' THEN	 
				(SELECT COUNT(*) FROM K_MENSAJES
					WHERE NickPro = @nick
					AND Direccion = @direccion)
		END
					
	RETURN @num

END 
GO

CREATE PROCEDURE CONTAR_CLIENTES_LOGEADOS(@clis INTEGER OUTPUT)
AS BEGIN
	
	SET @clis =
		(SELECT COUNT(*) FROM K_CLIENTES_LOGEADOS
		 WHERE Estado = 'Conectado')
		
	RETURN @clis
	
END
GO

CREATE PROCEDURE CONTAR_PROGRAMADORES_LOGEADOS(@pros INTEGER OUTPUT)
AS BEGIN
	
	SET @pros =
		(SELECT COUNT(*) FROM K_PROGRAMADORES_LOGEADOS
		 WHERE Estado = 'Conectado')		
		
	RETURN @pros
	
END
GO

CREATE PROCEDURE BUSCAR_NOTIFICACIONES_NUEVAS
	(@nick VARCHAR(20))
AS BEGIN

	SELECT * FROM K_NOTIFICACIONES
	 WHERE Nick = @nick
	   AND Vista = 0
	
	ORDER BY FHNotificacion DESC

END
GO

CREATE PROCEDURE BUSCAR_TODAS_NOTIFICACIONES
	(@nick VARCHAR(20))
AS BEGIN

	SELECT TOP 10 * FROM K_NOTIFICACIONES
	 WHERE Nick = @nick
	ORDER BY FHNotificacion DESC

END
GO


CREATE PROCEDURE MARCAR_VISTAS
	(@nick VARCHAR(20), @tipo VARCHAR(8))
AS BEGIN

	UPDATE K_NOTIFICACIONES
	   SET Vista = 1
	   
	 WHERE Nick = @nick AND Tipo = @tipo

END
GO
	 
