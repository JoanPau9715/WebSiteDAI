USE KAILUA	
GO


CREATE VIEW KV_SOFTWARE_DEMANDADO
	(IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
AS
	SELECT KS.IdSoft, KS.NickCli, 
		   KS.Tipo + CASE WHEN KS.ConexionBD = 1 THEN ' BD ' + KS.TipoBD ELSE ' sin BD' END, 
		   KS.Descrip, KS.FHSolicitud,
		   dbo.PREPARAR_FECHA(KS.FHSolicitud),
		   CASE WHEN Aceptado = 0 THEN 'Solicitado - ' + NickPro 		     		     
		        WHEN Aceptado = 1 THEN 'Aceptado - ' + NickPro 
		        WHEN Aceptado IS NULL THEN 'Rechazado - ' + NickPro END
		   
	FROM K_SOFTWARE_DEMANDADO KS
	
GO


CREATE VIEW KV_SOFTWARE_OFERTADO
	(IdSoft, Programador, Tipo, Descripcion, Personalizable, FHOferta, FHCadena, Atendida)
AS
	SELECT KS.IdSoft, KS.NickPro, 
		   KS.Tipo + CASE WHEN KS.ConexionBD = 1 THEN ' BD ' + KS.TipoBD ELSE ' sin BD' END, 
		   KS.Descrip, CASE WHEN KS.Personalizable = 1 THEN 'A medida' ELSE 'Comercial' END, 
		   KS.FHOferta, dbo.PREPARAR_FECHA(KS.FHOferta),
		   CASE WHEN Aceptado = 0 THEN 'Ofertado - ' + KS.NickCli 		     		     
		        WHEN Aceptado = 1 THEN 'Aceptado - ' + KS.NickCli 
		        WHEN Aceptado IS NULL THEN 'Rechazado - ' + KS.NickCli END		        
		   
	FROM K_SOFTWARE_OFERTADO KS
	
GO

CREATE VIEW KV_SOFTWARE_OFERTADO_A_CLIENTE
	(Cliente, IdSoft, Programador, Tipo, Descripcion, FHOferta, FHCadena, Atendida)
AS
	SELECT KS.NickCli, KS.IdSoft, KS.NickPro, 
		   KS.Tipo + 
		   CASE WHEN KS.Personalizable = 1 THEN ' A medida ' ELSE ' Comercial ' END +  
		   CASE WHEN KS.ConexionBD = 1 THEN 'BD ' + KS.TipoBD ELSE 'sin BD' END, 
		   KS.Descrip, KS.FHOferta, dbo.PREPARAR_FECHA(KS.FHOferta),
		   CASE WHEN Aceptado = 0 THEN 'Ofertado - ' + KS.NickPro 		     		     
		        WHEN Aceptado = 1 THEN 'Aceptado - ' + KS.NickPro 
		        WHEN Aceptado IS NULL THEN 'Rechazado - ' + KS.NickPro END		        		        
		   
	FROM K_SOFTWARE_OFERTADO KS
	
GO


CREATE VIEW KV_SOFTWARE_DEMANDADO_A_PROGRAMADOR
	(Programador, IdSoft, Cliente, Tipo, Descripcion, FHSolicitud, FHCadena, Atendida)
AS
	SELECT KS.NickPro, KS.IdSoft, KS.NickCli, 
		   KS.Tipo + CASE WHEN KS.ConexionBD = 1 THEN ' BD ' + KS.TipoBD ELSE ' sin BD' END, 
		   KS.Descrip, KS.FHSolicitud,
		   dbo.PREPARAR_FECHA(KS.FHSolicitud),
		   CASE WHEN Aceptado = 0 THEN 'Solicitado - ' + NickCli 		     		     
		        WHEN Aceptado = 1 THEN 'Aceptado - ' + NickCli
		        WHEN Aceptado IS NULL THEN 'Rechazado - ' + NickCli END
		   
	FROM K_SOFTWARE_DEMANDADO KS
	
GO



CREATE VIEW KV_MENSAJES
	(IdMensaje, Direccion, NickCli, NickPro, Asunto, Texto, FHEnvio, FHCadena, Leido)
AS

	SELECT KM.IdMensaje, KM.Direccion, KM.NickCli, KM.NickPro, KM.Asunto, KM.Texto,
		   KM.DateEnvio, dbo.PREPARAR_FECHA(KM.DateEnvio), KM.Leido
	  FROM K_MENSAJES KM
	  
GO


			