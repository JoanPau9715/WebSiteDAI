using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.Data.SqlClient;

public partial class Registro : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            Master.MyBodyTag.Attributes.Add("onload", "InicioReg()");
            LlenarDDSectores();
        }
        Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Registro de clientes");
    }

    private void LlenarDDSectores()
    {
        MSectores sectores = new MSectores();
        SqlDataReader dr = sectores.ListarSectores();
        try
        {
            ddSector.Items.Add("");
            while (dr.Read())
            {
                ListItem li = new ListItem(Convert.ToString(dr["DENOM"]), Convert.ToString(dr["IDSECTOR"]));
                ddSector.Items.Add(li);
            }
        }
        finally
        {
            dr.Close();
            sectores.CerrarConexion();
        }
    }

    protected void AccesoDirecto_Command(object sender, CommandEventArgs e)
    {
        Cliente nuevoCliente = new Cliente();
        nuevoCliente.Nick = txtNick.Text;
        nuevoCliente.IP = Request.UserHostAddress;
        nuevoCliente.Logear();

        Session["Customer"] = nuevoCliente.Nick;
        Response.Redirect("zonacli.aspx");
    }

}
