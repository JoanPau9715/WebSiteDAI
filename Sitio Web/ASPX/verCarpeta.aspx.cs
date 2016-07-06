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

public partial class ASPX_verCarpeta : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String usuario = (String)Request.Form["usuario"];

        Notificacion notificacion = new Notificacion();
        SqlDataReader dr = notificacion.BuscarTodas(usuario);

        string respuesta = "";

        respuesta += "<table id='tablaFolder' cellpadding='10' class='tablaCarpeta'>";


        while (dr.Read())
        {
            respuesta += "<tr>";
            respuesta += "<td class='cellcarpeta'>" + (String)dr["FHCadena"] + "   :   " + (String)dr["Texto"] + "</td>";
            respuesta += "</tr>";
        }

        respuesta += "</table>";

        Response.Write(respuesta);
    }
}
