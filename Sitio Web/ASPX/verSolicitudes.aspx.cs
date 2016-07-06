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
using System.Xml.Serialization;
using System.Text;
using System.IO;
using System.Threading;

public partial class ASPX_verSolicitudes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String cliente = (String)Request.Form["cliente"];
        int pagina = Convert.ToInt16(Request.Form["pagina"]);
        String vista = (String)Request.Form["vista"];

        SoftwareDemandado softdem = new SoftwareDemandado();
        int numSols = softdem.Contar(cliente, vista);
        
        SqlDataReader dr = softdem.Consultar(cliente, pagina, vista);

        string respuesta = "";
        string descripciones = "";
        string idactual = "";
        bool cabecera = false;

        int contador = 0;

        respuesta += "<table id='tablaSolicitudes' class='tablaSolicitudes'>";


        while (dr.Read())
        {

            if (!cabecera)
            {
                respuesta += "<td class='cellcab'>Tipo</td>";
                respuesta += "<td class='cellcab'>Fecha</td>";
                respuesta += "<th colspan='2' class='cellcab'>Programador</td>";

                cabecera = true;
            }

            if (descripciones != "")
                descripciones += "*";

            descripciones += (String)dr["Descripcion"];

            if (idactual == "")
                idactual = Convert.ToString(dr["IdSoft"]);

            respuesta += "<tr>";

            respuesta += "<td id='fila" + Convert.ToString(contador) + "' name='" + Convert.ToString(dr["IdSoft"]) + "' class='celltipo' onclick='setIdActual(" + Convert.ToString(dr["IdSoft"]) + "); setIndice(" + Convert.ToString(contador) + "); informarPosicion()'>" + (String)dr["Tipo"] + "</td>";
            respuesta += "<td class='cells'>" + (String)dr["FHCadena"] + "</td>";
            respuesta += "<td id='atendida" + Convert.ToString(contador) + "' class='cells'>" + (String)dr["Atendida"] + "</td>";
            respuesta += "<td class='cells'><input type='image' id='" + Convert.ToString(contador) + "' title='ver la descripción' alt=' ' src='images/about.png' onclick='return mostrarInfo(this.id)' onmousemove='setXY(event)' /></td>";

            respuesta += "</tr>";

            respuesta += "<tr id='edit" + Convert.ToString(contador) + "' class='filaedit'>";
            respuesta += "<th colspan='1' class='celledit'>";
            respuesta += "<span class='editlabel1'>Conexión a BD</span><br/><br/>";
            respuesta += "<select id='select" + Convert.ToString(contador) + "'>";
            respuesta += "<option selected='selected' value='sinbd'>Sin BD</option>";
            respuesta += "<option value='bdcs'>BD Cliente / Servidor</option>";
            respuesta += "<option value='bde'>BD de escritorio</option>";
            respuesta += "</select>";
            respuesta += "</th>";
            respuesta += "<th colspan='1' class='celledit'>";
            respuesta += "<span class='editlabel2'>Descripción</span><br/>";
            respuesta += "<textarea class='editarea' id='txtarea" + Convert.ToString(contador) + "'>";
            respuesta += "</textarea>";
            respuesta += "</th>";
            respuesta += "<th colspan='2' class='celledit'>";
            respuesta += "<input id='ok" + Convert.ToString(contador) + "' type='button' value='Confirmar' class='editbotonok' onclick='okEditarFila(indice)' /><br/><br/>";
            respuesta += "<input id='cancel" + Convert.ToString(contador) + "' type='button' value='Cancelar' class='editbotonok' onclick='cancelEditarFila(indice)' />";
            respuesta += "</th>";

            respuesta += "</tr>";

            contador++;
        }

        respuesta += "</table>";

        Response.Write(Convert.ToString(numSols) + "#" + descripciones + "#" + idactual + "#" + respuesta);
    }

}
