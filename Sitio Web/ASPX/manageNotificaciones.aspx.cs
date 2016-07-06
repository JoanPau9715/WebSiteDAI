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

public partial class ASPX_manageNotificaciones : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string modo = (String)Request.Form["modo"];

        if (modo == null)
        {
            modo = (String)Request.QueryString["modo"];
        }

        switch (modo)
        {
            case "buscar":

                string nick = (String)Request.Form["nick"];

                Notificacion notificacion = new Notificacion();
                SqlDataReader dr = notificacion.BuscarNuevas(nick);

                string ids = "";
                string textos = "";
                string tipos = "";

                while (dr.Read())
                {
                    if (ids != "")
                        ids += "*";

                    ids += Convert.ToInt64(dr["IdNotificacion"]);

                    if (textos != "")
                        textos += "*";

                    textos += (String)dr["Texto"];

                    if (tipos != "")
                        tipos += "*";

                    tipos += (String)dr["Tipo"];
                }

                notificacion.CerrarConexion();
                Response.Write(ids + "#" + textos + "#" + tipos);

                break;

            case "marcar":

                string nickmark = (String)Request.QueryString["nick"];
                string tipomark = (String)Request.QueryString["tipo"];
                Notificacion notificacionmark = new Notificacion();
                notificacionmark.MarcarVistas(nickmark, tipomark);

                break;

        }
    }
}
