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

public partial class Inicio : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int desconexion = Convert.ToInt16(Request.QueryString["desconexion"]);
            int sessionout = Convert.ToInt16(Request.QueryString["sessionout"]);

            if (sessionout == 1)
            {
                Master.MyBodyTag.Attributes.Add("onload", "sessionOut()");
            }
            else if (desconexion == 1)
            {
                if (Session["Customer"] != null)
                {
                    Master.MyBodyTag.Attributes.Add("onload", "despedida('" + Convert.ToString(Session["Customer"]) + "')");

                    Cliente cliente = new Cliente();
                    cliente.Nick = Convert.ToString(Session["Customer"]);
                    cliente.Desconectar();

                    Session.Remove("Customer");
                }

                if (Session["Programmer"] != null)
                {
                    Master.MyBodyTag.Attributes.Add("onload", "despedida('" + Convert.ToString(Session["Programmer"]) + "')");

                    Programador programador = new Programador();
                    programador.Nick = Convert.ToString(Session["Programmer"]);
                    programador.Desconectar();

                    Session.Remove("Programmer");
                }
            }
            else
                Master.MyBodyTag.Attributes.Add("onload", "Inicio()");


            ComprueboCookie();

        }
    }

    protected void btnAcceder_Click(object sender, EventArgs e)
    {
        RecuerdoCookie();
        bool Validado = ValidarLogin();

        if (Validado)
        {
            switch (ddTipoAcceso.SelectedIndex)
            {
                case 0:
                    Cliente miCliente = new Cliente();
                    miCliente.Nick = txtUsuario.Text;
                    miCliente.ClaveAcceso = txtPwd.Text;
                    bool existecli = miCliente.Comprobar();

                    if (existecli)
                    {
                        miCliente.IP = Request.UserHostAddress;
                        miCliente.Logear();
                        Session["Customer"] = miCliente.Nick;
                        Response.Redirect("zonacli.aspx");
                    }
                    else
                        errAcceso.Text = "hala";
                    break;

                case 1:
                    Programador miProgramador = new Programador();
                    miProgramador.Nick = txtUsuario.Text;
                    miProgramador.ClaveAcceso = txtPwd.Text;
                    bool existepro = miProgramador.Comprobar();

                    if (existepro)
                    {
                        miProgramador.IP = Request.UserHostAddress;
                        miProgramador.Logear();
                        Session["Programmer"] = miProgramador.Nick;
                        Response.Redirect("zonapro.aspx");
                    }
                    else
                        errAcceso.Text = "hala";
                    break;
            }
        }
        else
        {
            errAcceso.Text = "hala";

            // la validación en jscript evita que se llegue a este punto
        }
    }

    protected bool ValidarLogin()
    {
        bool Bien = ((txtUsuario.Text != "") && (txtPwd.Text != ""));
        return Bien;
    }

    private void RecuerdoCookie()
    {
        if (chkRecordar.Checked)
        {
            HttpCookie cookieTipo = new HttpCookie("tipoAcceso", Convert.ToString(ddTipoAcceso.SelectedIndex));
            cookieTipo.Expires = DateTime.Now.AddDays(10);
            this.Response.Cookies.Add(cookieTipo);
        }
        else
        {
            if ((this.Request.Cookies["tipoAcceso"] != null))
            {
                HttpCookie cookieTipo = new HttpCookie("tipoAcceso", Convert.ToString(ddTipoAcceso.SelectedIndex));
                cookieTipo.Expires = DateTime.Now.AddDays(-1);
                this.Response.Cookies.Add(cookieTipo);
            }
        }
    }

    private void ComprueboCookie()
    {
        HttpCookie cookieTipo;
        if ((cookieTipo = this.Request.Cookies["tipoAcceso"]) != null)
        {
            this.ddTipoAcceso.SelectedIndex = Convert.ToInt16(cookieTipo.Value);
            this.chkRecordar.Checked = true;
        }
    }
}
