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

public partial class ZonaCli : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((String)Session["Customer"] != null)
        {
            if (!Page.IsPostBack)
            {
                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + (String)Session["Customer"] + "'); iniciarNotificaciones()");

                Master.lblCli.InnerHtml = "Aloha " + (String)Session["Customer"];
                Master.menuKailua.Visible = false;
                Master.mSoftwareCli.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaCli.Visible = true;
                Master.irAinicio.Visible = true;
            }
            Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Mi Carpeta");
        }
        else
        {
            Response.Redirect("Inicio.aspx?sessionout=1");
        }
    }
}
