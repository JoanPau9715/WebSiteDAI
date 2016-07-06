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

public partial class LaEmpresa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((String)Session["Customer"] != null)
        {
            if (!Page.IsPostBack)
            {
                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + (String)Session["Customer"] + "'); focusDest(); leerDestinatarios('Programadores'); iniciarNotificaciones();");

                Master.lblCli.InnerHtml = "Aloha " + (String)Session["Customer"];
                Master.menuKailua.Visible = false;
                Master.mSoftwareCli.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaCli.Visible = true;
                Master.irAinicio.Visible = true;
            }
            Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Información sobre la empresa");
        }
        else if ((String)Session["Programmer"] != null)
        {
            if (!Page.IsPostBack)
            {
                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + (String)Session["Programmer"] + "'); focusDest(); leerDestinatarios('Clientes'); iniciarNotificaciones();");

                Master.lblCli.InnerHtml = "Aloha " + (String)Session["Programmer"];
                Master.menuKailua.Visible = false;
                Master.mSoftwarePro.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaPro.Visible = true;
                Master.irAinicio.Visible = true;
            }
            Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Información sobre la empresa");
        }
    }
}
