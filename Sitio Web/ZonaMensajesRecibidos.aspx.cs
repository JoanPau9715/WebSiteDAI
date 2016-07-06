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

public partial class ZonaMensajesRecibidos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((String)Session["Customer"] != null)
        {
            string cliente = (String)Session["Customer"];

            Server.Execute("aspx/manageNotificaciones.aspx?modo=marcar&nick=" + cliente + "&tipo=Mensaje");

            if (!Page.IsPostBack)
            {
                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + cliente + "'); iniciarNotificaciones(); verMensajes(0);");

                Master.lblCli.InnerHtml = "Aloha " + (String)Session["Customer"];
                Master.menuKailua.Visible = false;
                Master.mSoftwareCli.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaCli.Visible = true;
                Master.irAinicio.Visible = true;
            }
            Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Mensajes recibidos");
        }
        else if ((String)Session["Programmer"] != null)
        {
            if (!Page.IsPostBack)
            {
                string programador = (String)Session["Programmer"];

                Server.Execute("aspx/manageNotificaciones.aspx?modo=marcar&nick=" + programador + "&tipo=Mensaje");

                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + programador + "'); iniciarNotificaciones(); verMensajes(0);");

                Master.lblCli.InnerHtml = "Aloha " + (String)Session["Programmer"];
                Master.menuKailua.Visible = false;
                Master.mSoftwarePro.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaPro.Visible = true;
                Master.irAinicio.Visible = true;
            }
            Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Mensajes recibidos");
        }
        else
        {
            Response.Redirect("Inicio.aspx?sessionout=1");
        }
    }
}
