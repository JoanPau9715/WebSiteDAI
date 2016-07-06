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

public partial class ASPX_leerClientes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Cliente cliente = new Cliente();
        SqlDataReader dr = cliente.ListarTodos();

        string respuesta = "";
        while (dr.Read())
        {
            if (respuesta != "")
                respuesta += "-";

            respuesta += ((String)dr["Nick"]);
        }

        cliente.CerrarConexion();
        Response.Write(respuesta);
    }
}
