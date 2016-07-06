using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class ASPX_leerProgramadores : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Programador programador = new Programador();
        SqlDataReader dr = programador.ListarTodos();
        
        string respuesta = "";
        while (dr.Read())
        {
            if (respuesta != "")
                respuesta += "-";

            respuesta += ((String)dr["Nick"]);
        }
        
        programador.CerrarConexion();
        Response.Write(respuesta);
    }
}
