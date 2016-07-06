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

public partial class ZonaCliMisSolicitudes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string cliente = (String)Session["Customer"];

        if (cliente != null)
        {
            if (!Page.IsPostBack)
            {
                Server.Execute("aspx/manageNotificaciones.aspx?modo=marcar&nick=" + cliente + "&tipo=Software");

                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + cliente + "'); verSolicitudes(0); iniciarNotificaciones()");

                Master.lblCli.InnerHtml = "Aloha " + cliente;
                Master.menuKailua.Visible = false;
                Master.mSoftwareCli.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaCli.Visible = true;
                Master.irAinicio.Visible = true;
            }
            Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Ver mis solicitudes");
        }
        else
        {
            Response.Redirect("Inicio.aspx?sessionout=1");
        }
    }

}
