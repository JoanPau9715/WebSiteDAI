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

public partial class ASPX_insertCliente : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Cliente miCliente = new Cliente();

        String Nombre = Request.Form["nombre"];
        String Apellidos = Request.Form["apellidos"];
        String Empresa = Request.Form["empresa"];
        int Sector = Convert.ToInt32(Request.Form["sector"]);
        String Cargo = Request.Form["cargo"];
        String EMail = Request.Form["email"];
        String Tel = Request.Form["tel"];
        String Nick = Request.Form["nick"];
        String Clave = Request.Form["clave"];

        bool nickdisponible = miCliente.ComprobarDisponibilidadNick(Nick);

        if (nickdisponible)
        {
            miCliente.Nombre = Nombre;
            miCliente.Apellidos = Apellidos;
            miCliente.Empresa = Empresa;
            miCliente.IdSector = Sector;
            miCliente.Cargo = Cargo;
            miCliente.EMail = EMail;
            miCliente.Telefono = Tel;
            miCliente.Nick = Nick;
            miCliente.ClaveAcceso = Clave;

            miCliente.Insertar();

            respuesta.InnerHtml = "insertado correctamente";
        }
        else
            respuesta.InnerHtml = "nick no disponible";
    }

}
