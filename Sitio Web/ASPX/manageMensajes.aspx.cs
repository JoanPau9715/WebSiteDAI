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

public partial class ASPX_manageMensajes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String modo = (String)Request.Form["modo"];

        switch (modo)
        {
            case "sendmensaje":
                Mensaje mensajesend = new Mensaje();

                string direccion = "";

                if ((String)Session["Customer"] != null)
                {
                    direccion = "CliPro";
                    mensajesend.NickCliente = (String)Request.Form["emisor"];
                    mensajesend.NickProgramador = (String)Request.Form["receptor"];
                }
                else if ((String)Session["Programmer"] != null)
                {
                    direccion = "ProCli";
                    mensajesend.NickCliente = (String)Request.Form["receptor"];
                    mensajesend.NickProgramador = (String)Request.Form["emisor"];
                }

                mensajesend.Direccion = direccion;

                mensajesend.Asunto = (String)Request.Form["asunto"];
                mensajesend.Texto = (String)Request.Form["texto"];

                mensajesend.Enviar();

                break;

            case "deletemensaje":
                Mensaje mensajedelete = new Mensaje();
                int idmensajedelete = Convert.ToInt16(Request.Form["idmensaje"]);
                mensajedelete.Borrar(idmensajedelete);

                break;

            case "markread":
                Mensaje mensajemark = new Mensaje();
                int idmensajemark = Convert.ToInt16(Request.Form["idmensaje"]);
                mensajemark.MarcarLeido(idmensajemark);

                break;
        }
    }
}
