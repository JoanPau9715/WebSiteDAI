USE KAILUAHOUSE
GO


CREATE PROCEDURE UPDATE_KH_OFERTAS_SOFTWARE
AS BEGIN

	DECLARE @programadores TABLE(Programador VARCHAR(20))

	DECLARE @programmer VARCHAR(20)
	DECLARE @ofertasWindows INTEGER
	DECLARE @ofertasWindowsConBDLocal INTEGER
	DECLARE @ofertasWindowsConBDCS INTEGER
	DECLARE @ofertasWeb INTEGER
	DECLARE @ofertasWebConBD INTEGER
	
	INSERT INTO @programadores
		SELECT DISTINCT NickPro
		FROM KAILUA.dbo.K_SOFTWARE_OFERTADO

	DECLARE PROGRAMADORES CURSOR
		FOR SELECT Programador FROM @programadores
		
	OPEN PROGRAMADORES
	
	FETCH NEXT FROM PROGRAMADORES
		INTO @programmer

	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		SET @ofertasWindows =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_OFERTADO
			  WHERE NickPro = @programmer AND Tipo = 'Aplicación Windows'
			    AND ConexionBD = 0)
			    
		SET @ofertasWindowsConBDLocal =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_OFERTADO
			  WHERE NickPro = @programmer AND Tipo = 'Aplicación Windows'
			    AND ConexionBD = 1 AND TipoBD = 'De escritorio')
			    
		SET @ofertasWindowsConBDCS =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_OFERTADO
			  WHERE NickPro = @programmer AND Tipo = 'Aplicación Windows'
			    AND ConexionBD = 1 AND TipoBD = 'Cliente / Servidor')			    
			    
		SET @ofertasWeb =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_OFERTADO
			  WHERE NickPro = @programmer AND Tipo = 'Sitio Web'
			    AND ConexionBD = 0)
		
		SET @ofertasWebConBD =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_OFERTADO
			  WHERE NickPro = @programmer AND Tipo = 'Sitio Web'
			    AND ConexionBD = 1)
			    
		IF EXISTS (SELECT 1 FROM KAILUAHOUSE.dbo.KH_OFERTAS_SOFTWARE
					WHERE Programador = @programmer)
		BEGIN
		
			UPDATE KH_OFERTAS_SOFTWARE
			   SET ofertasWindows = @ofertasWindows, ofertasWinConBDLocal = @ofertasWindowsConBDLocal,
			       ofertasWinConBDCS = @ofertasWindowsConBDCS, ofertasWeb = @ofertasWeb, ofertasWebConBD = @ofertasWebConBD,
			       FHLastUpdate = CURRENT_TIMESTAMP
			 WHERE Programador = @programmer
		
		END ELSE
		BEGIN

			INSERT INTO KH_OFERTAS_SOFTWARE
				VALUES (@programmer, @ofertasWindows, @ofertasWindowsConBDLocal, 
						@ofertasWindowsConBDCS, @ofertasWeb, @ofertasWebConBD, default)
		
		END


		FETCH NEXT FROM PROGRAMADORES
			INTO @programmer
	
	END	
	
	CLOSE PROGRAMADORES	
	DEALLOCATE PROGRAMADORES
	
	-- si no libero el cursor se produce el warning 16915
	-- en la segunda ejecucion del procedimiento
		
END
GO



CREATE PROCEDURE UPDATE_KH_SOLICITUDES_SOFTWARE
AS BEGIN

	DECLARE @clientes TABLE(Cliente VARCHAR(20))

	DECLARE @customer VARCHAR(20)
	DECLARE @solsWindows INTEGER
	DECLARE @solsWindowsConBDLocal INTEGER
	DECLARE @solsWindowsConBDCS INTEGER
	DECLARE @solsWeb INTEGER
	DECLARE @solsWebConBD INTEGER
	
	INSERT INTO @clientes
		SELECT DISTINCT NickCli
		FROM KAILUA.dbo.K_SOFTWARE_DEMANDADO
		
	DECLARE CLIENTES CURSOR
		FOR SELECT Cliente FROM @clientes
		
	OPEN CLIENTES
	
	FETCH NEXT FROM CLIENTES
		INTO @customer
		
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		SET @solsWindows =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_DEMANDADO
			  WHERE NickCli = @customer AND Tipo = 'Aplicación Windows'
			    AND ConexionBD = 0)
			    
		SET @solsWindowsConBDLocal =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_DEMANDADO
			  WHERE NickCli = @customer AND Tipo = 'Aplicación Windows'
			    AND ConexionBD = 1 AND TipoBD = 'De escritorio')
			    
		SET @solsWindowsConBDCS =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_DEMANDADO
			  WHERE NickCli = @customer AND Tipo = 'Aplicación Windows'
			    AND ConexionBD = 1 AND TipoBD = 'Cliente / Servidor')			    
			    
		SET @solsWeb =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_DEMANDADO
			  WHERE NickCli = @customer AND Tipo = 'Sitio Web'
			    AND ConexionBD = 0)
		
		SET @solsWebConBD =
			(SELECT COUNT(*) FROM KAILUA.dbo.K_SOFTWARE_DEMANDADO
			  WHERE NickCli = @customer AND Tipo = 'Sitio Web'
			    AND ConexionBD = 1)
			    
		IF EXISTS (SELECT 1 FROM KH_SOLICITUDES_SOFTWARE
					WHERE Cliente = @customer)
		BEGIN
		
			UPDATE KH_SOLICITUDES_SOFTWARE
			   SET SolsWindows = @solsWindows, SolsWinConBDLocal = @solsWindowsConBDLocal,
			       SolsWinConBDCS = @solsWindowsConBDCS, SolsWeb = @solsWeb, SolsWebConBD = @solsWebConBD,
			       FHLastUpdate = CURRENT_TIMESTAMP
			 WHERE Cliente = @customer
		
		END ELSE
		BEGIN

			INSERT INTO KH_SOLICITUDES_SOFTWARE
				VALUES (@customer, @solsWindows, @solsWindowsConBDLocal, 
						@solsWindowsConBDCS, @solsWeb, @solsWebConBD, default)
		
		END


		FETCH NEXT FROM CLIENTES
			INTO @customer
	
	END
	
	CLOSE CLIENTES
	DEALLOCATE CLIENTES
		

END
GO


CREATE PROCEDURE UPDATE_KH_ZONAS
AS BEGIN

	DECLARE @zona VARCHAR(50)
	DECLARE @numvisitas INTEGER
	
	DECLARE curNAVZONAS CURSOR FOR 
		SELECT Pagina, COUNT(IP)
		  FROM K_NAVEGACION_DUPLICADO
		  WHERE Metodo = 'GET'
		  GROUP BY Pagina
		  
	OPEN curNAVZONAS
	
	FETCH NEXT FROM curNAVZONAS
		INTO @zona, @numvisitas
		
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		IF EXISTS (SELECT 1 FROM KH_ZONAS WHERE Zona = @zona)
		BEGIN
		
			UPDATE KH_ZONAS
			   SET NumVisitas = NumVisitas + @numvisitas, 
				   FHLastUpdate = CURRENT_TIMESTAMP
			 WHERE Zona = @zona
		
		END ELSE
		BEGIN
			
			INSERT INTO KH_ZONAS 
			VALUES(@zona, @numvisitas, default)
		
		END

		FETCH NEXT FROM curNAVZONAS
			INTO @zona, @numvisitas
	
	END		
	
	CLOSE curNAVZONAS
	DEALLOCATE curNAVZONAS

END
GO


CREATE PROCEDURE UPDATE_KH_USUARIOS
AS BEGIN
			  
	DECLARE @user VARCHAR(20)
	DECLARE @tipo VARCHAR(11)			
	DECLARE @zona VARCHAR(50)
	DECLARE @numvisitas INTEGER
	
	DECLARE curNAVUSERS CURSOR FOR
		SELECT Miembro, Pagina, COUNT(Pagina) 
			FROM K_NAVEGACION_DUPLICADO
			WHERE Metodo = 'GET'
			GROUP BY Miembro, Pagina
			
	OPEN curNAVUSERS
	
	FETCH NEXT FROM curNAVUSERS
		INTO @user, @zona, @numvisitas
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		IF @user != '?'
		BEGIN
	
			SET @tipo =
				(CASE WHEN EXISTS (SELECT 1 FROM KAILUA.dbo.K_CLIENTES
						WHERE Nick = @user) THEN 'Cliente'
					  WHEN EXISTS (SELECT 1 FROM KAILUA.dbo.K_PROGRAMADORES
						WHERE Nick = @user) THEN 'Programador' 
					  ELSE 'Visitante'	END)		
		
			IF EXISTS 
				(SELECT 1 FROM KH_USUARIOS 
				  WHERE Usuario = @user
					AND Zona = @zona)
			BEGIN
					
				UPDATE KH_USUARIOS 
				   SET NumVisitas = NumVisitas + @numvisitas, 
					   FHLastUpdate = CURRENT_TIMESTAMP
				   WHERE Usuario = @user 
					 AND Zona = @zona
			
			END ELSE
			BEGIN

				INSERT INTO KH_USUARIOS 
				  VALUES (@user, @tipo, @zona, @numvisitas, default)		
			
			END
		END
		
		FETCH NEXT FROM curNAVUSERS
			INTO @user, @zona, @numvisitas		
	
	END	
	
	CLOSE curNAVUSERS
	DEALLOCATE curNAVUSERS
	
END
GO



CREATE PROCEDURE UPDATE_KH_NAVEGADORES
AS BEGIN

	DECLARE @navegador VARCHAR(100)
	DECLARE @numusers INTEGER
	
	DECLARE curNAVS CURSOR FOR
		SELECT Navegador, COUNT(DISTINCT(IP))
			FROM K_NAVEGACION_DUPLICADO
			GROUP BY Navegador
			
	OPEN curNAVS
	
	FETCH NEXT FROM curNAVS
		INTO @navegador, @numusers
		
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		IF EXISTS (SELECT 1 FROM KH_NAVEGADORES 
					WHERE Navegador = @navegador)
		BEGIN
		
			UPDATE KH_NAVEGADORES
			   SET NumUsers = @numusers, FHLastUpdate = CURRENT_TIMESTAMP 
			   WHERE Navegador = @navegador
		
		END ELSE
		BEGIN
		
			INSERT INTO KH_NAVEGADORES
			  VALUES (@navegador, @numusers, default)
		
		END

		FETCH NEXT FROM curNAVS
			INTO @navegador, @numusers
	
	END
	
	CLOSE curNAVS
	
	DEALLOCATE curNAVS

END
GO


CREATE PROCEDURE UPDATE_KH_ESPECIALIDADES
AS BEGIN

	DECLARE @especialidad VARCHAR(20)
	DECLARE @idesp INTEGER
	DECLARE @numpros INTEGER
	
	DECLARE curESPECIALIDADES CURSOR FOR
		SELECT E.Denom, E.IdExp, COUNT(PE.NickPro)
		  FROM KAILUA.dbo.K_ESPECIALIDADES E
			JOIN KAILUA.dbo.K_PROGRAMADORES_ESPECIALIDADES PE
				ON E.IdExp = PE.IdEsp
		  GROUP BY E.Denom, E.IdExp
		  
	OPEN curESPECIALIDADES
	
	FETCH NEXT FROM curESPECIALIDADES
		INTO @especialidad, @idesp, @numpros
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		IF EXISTS (SELECT 1 FROM KH_ESPECIALIDADES WHERE Especialidad = @especialidad)
		BEGIN
		
			UPDATE KH_ESPECIALIDADES 
			   SET NumProgrammers = @numpros, FHLastUpdate = CURRENT_TIMESTAMP
			   WHERE Especialidad = @especialidad
		
		END ELSE
		BEGIN
		
			INSERT INTO KH_ESPECIALIDADES
			  VALUES (@especialidad, @numpros, default)
		
		END

		FETCH NEXT FROM curESPECIALIDADES
			INTO @especialidad, @idesp, @numpros
	
	END
	
	CLOSE curESPECIALIDADES
	DEALLOCATE curESPECIALIDADES

END
GO

CREATE PROCEDURE UPDATE_KH_SECTORES
AS BEGIN

	DECLARE @sector VARCHAR(40)
	DECLARE @idsector INTEGER
	DECLARE @numclis INTEGER
	
	DECLARE curSECTORES CURSOR FOR
	  SELECT S.Denom, S.IdSector, COUNT(C.Nick)
	    FROM KAILUA.dbo.K_SECTORES S
			JOIN KAILUA.dbo.K_CLIENTES C
			  ON S.IdSector = C.IdSector
		GROUP BY S.Denom, S.IdSector
		
	OPEN curSECTORES
	
	FETCH NEXT FROM curSECTORES
	  INTO @sector, @idsector, @numclis
	  
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	
		IF EXISTS (SELECT 1 FROM KH_SECTORES WHERE Sector = @sector)
		BEGIN
		
			UPDATE KH_SECTORES 
			   SET NumClientes = @numclis, FHLastUpdate = CURRENT_TIMESTAMP
			   WHERE Sector = @sector
			   	
		END ELSE		
		BEGIN
		
			INSERT INTO KH_SECTORES 
			  VALUES (@sector, @numclis, default)
		
		END

		FETCH NEXT FROM curSECTORES
		  INTO @sector, @idsector, @numclis
		
	
	END
	
	CLOSE curSECTORES
	DEALLOCATE curSECTORES

END
GO


CREATE PROCEDURE BUILD_HOUSE
AS BEGIN

	EXECUTE UPDATE_KH_NAVEGADORES
	EXECUTE UPDATE_KH_SECTORES
	EXECUTE UPDATE_KH_USUARIOS
	EXECUTE UPDATE_KH_ZONAS
	EXECUTE UPDATE_KH_ESPECIALIDADES
	EXECUTE UPDATE_KH_SOLICITUDES_SOFTWARE
	EXECUTE UPDATE_KH_OFERTAS_SOFTWARE
	
	DELETE FROM K_NAVEGACION_DUPLICADO	

END
GO