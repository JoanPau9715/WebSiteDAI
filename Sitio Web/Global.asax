<%@ Application Language="C#" %>

<script runat="server">
    
    void Application_Start(object sender, EventArgs e) 
    {
        // Código que se ejecuta al iniciarse la aplicación
        // (la primera petición de la primera sesión)
        TodosLosVisitantes todosvis = new TodosLosVisitantes();

        this.Application.Lock();
        try
        {
            this.Application["visitors"] = todosvis;
        }
        finally
        {
            this.Application.UnLock();
        }        
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Código que se ejecuta cuando se cierra la aplicación
        //  (cierre de la ultima sesión)
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Código que se ejecuta al producirse un error no controlado
    }

    void Session_Start(object sender, EventArgs e) 
    {        
        Server.Execute("ASPX/InicioVisita.aspx");                
    }

    void Session_End(object sender, EventArgs e) 
    {
        try
        {
            Response.Redirect("Inicio.aspx");
        }
        catch (Exception)
        {
            
        }
        // Código que se ejecuta cuando finaliza una sesión. 
        // Nota: El evento Session_End se desencadena sólo cuando el modo sessionstate
        // se establece como InProc en el archivo Web.config. Si el modo de sesión se establece como StateServer 
        // o SQLServer, el evento no se genera.

    }
       
</script>
