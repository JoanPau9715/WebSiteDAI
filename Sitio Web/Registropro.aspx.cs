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

public partial class Registropro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!(Page.IsPostBack))
        {
            Master.MyBodyTag.Attributes.Add("onload", "InicioReg()");
            LlenarEspecialidades();
        }
        Server.Execute("ASPX/cuentaVisitantes.aspx?lugar=Registro de programadores");
    }

    private void LlenarEspecialidades()
    {
        Especialidades experiencia = new Especialidades();
        SqlDataReader dr = experiencia.ListarEspecialidades();
        try
        {
            while (dr.Read())
            {
                ListItem li = new ListItem(Convert.ToString(dr["DENOM"]), Convert.ToString(dr["IDEXP"]));
                chExperiencia.Items.Add(li);
            }
        }
        finally
        {
            dr.Close();
            experiencia.CerrarConexion();
        }
    }

    protected void AccesoDirecto_Command(object sender, CommandEventArgs e)
    {
        Programador nuevoProgramador = new Programador();
        nuevoProgramador.Nick = txtNick.Text;
        nuevoProgramador.IP = Request.UserHostAddress;
        nuevoProgramador.Logear();

        Session["Programmer"] = nuevoProgramador.Nick;
        Response.Redirect("zonapro.aspx");
    }

}
