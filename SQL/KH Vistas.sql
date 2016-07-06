USE KAILUA
GO

CREATE VIEW KV_NAVEGACION
AS
	SELECT Miembro, IP, Pagina AS Zona, Navegador, 
		   Metodo AS [Método], FHVisita AS [Fecha hora]
	FROM K_NAVEGACION
	
GO	


CREATE VIEW KV_CLIENTES_LOGEADOS
AS
	SELECT Nick AS Cliente, IP, Estado, 
	       ZonaActual AS [Zona actual],
		   FHLogin AS [Fecha hora login],
		   FHDescon AS [Fecha hora desconexión]
	FROM   K_CLIENTES_LOGEADOS 
	
GO	


CREATE VIEW KV_PROGRAMADORES_LOGEADOS
AS
	SELECT Nick AS Programador, IP, Estado, 
		   ZonaActual AS [Zona actual], 
		   FHLogin AS [Fecha hora login],
		   FHDescon AS [Fecha hora desconexión]
	FROM   K_PROGRAMADORES_LOGEADOS		   
	
GO