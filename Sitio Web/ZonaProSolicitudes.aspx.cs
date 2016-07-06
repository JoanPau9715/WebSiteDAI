﻿using System;
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

public partial class ZonaProSolicitudes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((String)Session["Programmer"] != null)
        {
            if (!Page.IsPostBack)
            {
                Server.Execute("aspx/manageNotificaciones.aspx?modo=marcar&nick=" + (String)Session["Programmer"] + "&tipo=Software");

                Master.MyBodyTag.Attributes.Add("onload", "setUsuario('" + (String)Session["Programmer"] + "'); verSolicitudesAProgramador(0); iniciarNotificaciones()");

                Master.lblCli.InnerHtml = "Aloha " + (String)Session["Programmer"];
                Master.menuKailua.Visible = false;
                Master.mSoftwarePro.Visible = true;
                Master.menuMensajes.Visible = true;
                Master.irAcarpetaPro.Visible = true;
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
