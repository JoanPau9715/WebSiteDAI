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

public partial class ASPX_verMensajesPara : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Mensaje mensaje = new Mensaje();

        string usuario = "";
        string tipousuario = "";
        int pagina = Convert.ToInt16(Request.Form["pagina"]);
        string direccion = "";

        if ((String)Session["Customer"] != null)
        {
            usuario = (String)Session["Customer"];
            tipousuario = "cliente";
            direccion = "ProCli";
        }
        else if ((String)Session["Programmer"] != null)
        {
            usuario = (String)Session["Programmer"];
            tipousuario = "programador";
            direccion = "CliPro";
        }

        int numMensajes = mensaje.ContarMensajesPara(usuario);

        SqlDataReader dr = mensaje.VerMensajesPara(usuario, tipousuario, pagina);

        string respuesta = "";
        string fechas = "";
        string textos = "";
        string idactual = "";
        string sobre = "";
        bool cabecera = false;

        int contador = 0;

        respuesta += "<table id='tablaMensajes' class='tablaSolicitudes'>";


        while (dr.Read())
        {

            if (!cabecera)
            {
                respuesta += "<td class='cellcab'>Remite</td>";
                respuesta += "<th colspan='2' class='cellcab'>Asunto</td>";

                respuesta += "<th rowspan='7' class='viewmensaje' id='viewmensaje' >";
                respuesta += "<span class='editlabel2' id='descripview'>Descripción</span><br/>";
                respuesta += "<textarea class='viewarea' id='txtviewarea' onkeypress='return false'>";
                respuesta += "</textarea>";
                respuesta += "</th>";

                respuesta += "<th rowspan='7' class='viewmensaje' id='viewmensajeB' >";
                respuesta += "<input id='responder' type='button' value='Responder' class='editbotonok' /><br/><br/>";
                respuesta += "<input id='borrar' type='button' value='Borrar' class='editbotonok' onclick='borrarMensaje(idactual)'/><br/><br/>";
                respuesta += "<input id='ok' type='button' value='Ok' class='editbotonok' onclick='unreadMensaje()'/>";
                respuesta += "</th>";

                cabecera = true;
            }

            if (fechas != "")
                fechas += "*";

            fechas += (String)dr["FHCadena"];

            if (textos != "")
                textos += "*";

            textos += (String)dr["Texto"];

            if (idactual == "")
                idactual = Convert.ToString(dr["IdMensaje"]);

            respuesta += "<tr>";

            string remite = "";

            switch (direccion)
            {
                case "ProCli":
                    remite = (String)dr["NickPro"];
                    break;

                case "CliPro":
                    remite = (String)dr["NickCli"];
                    break;

            }

            respuesta += "<td id='filaremite" + Convert.ToString(contador) + "' name='" + Convert.ToString(dr["IdMensaje"]) + "' class='celltipo' onclick='setIdActual(" + Convert.ToString(dr["IdMensaje"]) + "); setIndiceMensajes(" + Convert.ToString(contador) + "); informarPosicion()'>" + remite + "</td>";
            respuesta += "<td id='filasunto" + Convert.ToString(contador) + "' name='" + Convert.ToString(dr["IdMensaje"]) + "' class='cells' onclick='setIdActual(" + Convert.ToString(dr["IdMensaje"]) + "); setIndiceMensajes(" + Convert.ToString(contador) + "); informarPosicion()'>" + (String)dr["Asunto"] + "</td>";

            switch (Convert.ToBoolean(dr["Leido"]))
            {
                case true:
                    sobre = "openmailb.png";
                    break;
                case false:
                    sobre = "mail.png";
                    break;
            }

            respuesta += "<td id='filasobre" + Convert.ToString(contador) + "' class='cells'><input type='image' id='" + Convert.ToString(contador) + "' title='leer el mensaje' alt=' ' src='images/" + sobre + "' onclick='return readMensaje(this.id)' /></td>";

            respuesta += "</tr>";

            contador++;
        }

        respuesta += "</table>";

        Response.Write(Convert.ToString(numMensajes) + "#" + fechas + "#" + textos + "#" + idactual + "#" + respuesta);
    }
}
