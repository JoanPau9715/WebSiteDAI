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

public partial class ASPX_insertProgramador : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Programador miProgramador = new Programador();

        String Nombre = Request.Form["nombre"];
        String Apellidos = Request.Form["apellidos"];
        String EMail = Request.Form["email"];
        String Tel = Request.Form["tel"];
        String Empresa = Request.Form["empresa"];
        String Experiencias = Request.Form["experiencias"];
        String Nick = Request.Form["nick"];
        String Clave = Request.Form["clave"];

        String[] TodasLasExperiencias = Experiencias.Split('-');
        
        bool nickdisponible = miProgramador.ComprobarDisponibilidadNick(Nick);

        if (nickdisponible)
        {
            miProgramador.Nombre = Nombre;
            miProgramador.Apellidos = Apellidos;
            miProgramador.EMail = EMail;
            miProgramador.Telefono = Tel;
            miProgramador.Empresa = Empresa;
            miProgramador.Nick = Nick;
            miProgramador.ClaveAcceso = Clave;

            miProgramador.Insertar();

            foreach (String CadaExperiencia in TodasLasExperiencias)
            {
                miProgramador.InsertarExperiencias(miProgramador.Nick, CadaExperiencia);
            }

            respuesta.InnerHtml = "insertado correctamente";
        }
        else
            respuesta.InnerHtml = "nick no disponible";
    }

}
