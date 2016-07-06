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

public partial class ASPX_cuentaVisitantes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String lugar = Request.QueryString["lugar"];
        NuevaVisita(lugar);
    }

    private void NuevaVisita(String donde)
    {
        Visitante elVisitante;

        String ip = Request.UserHostAddress;
        String metodo = Request.HttpMethod;
        String navegador = (String)Request.Browser.Browser;
        navegador += " " + Request.Browser.Version;
        DateTime fhvisita = DateTime.Now;

        elVisitante = new Visitante(ip, donde, metodo, navegador, fhvisita);

        TodosLosVisitantes todos = (TodosLosVisitantes)Application["visitors"];
        todos.Add(elVisitante);
        Application.Lock();
        try
        {
            if (todos.Count >= 3)
            {
                todos.Volcar();
                todos.Clear();
            }
            Application["visitors"] = todos;
        }
        finally
        {
            Application.UnLock();
        }
    }
}
