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

public partial class ASPX_demandaSoftware : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string modo = Request.Form["modo"];

        switch (modo)
        {
            case "insertcli":
                SoftwareDemandado softdemins = new SoftwareDemandado();

                softdemins.NickCliente = (String)Session["Customer"];
                softdemins.Tipo = Request.Form["tipo"];
                softdemins.Descripcion = Request.Form["descripcion"];
                softdemins.ConexionBD = (Request.Form["conbd"] == "1");
                softdemins.TipoBD = Request.Form["tipobd"];
                softdemins.NickProgramador = Request.Form["programador"];

                softdemins.Insertar();
                break;

            case "deletecli":
                SoftwareDemandado softdemdel = new SoftwareDemandado();

                Int64 idsoftware = Convert.ToInt64(Request.Form["idsoft"]);
                softdemdel.Borrar(idsoftware);
                break;

            case "modifycli":
                SoftwareDemandado softdemmod = new SoftwareDemandado();

                softdemmod.Descripcion = Request.Form["descripcion"];
                softdemmod.ConexionBD = (Request.Form["conbd"] == "1");
                softdemmod.TipoBD = Request.Form["tipobd"];

                Int64 idsoftwaremod = Convert.ToInt64(Request.Form["idsoft"]);
                softdemmod.Modificar(idsoftwaremod);
                break;

            case "insertpro":
                SoftwareOfertado softoferins = new SoftwareOfertado();

                softoferins.NickProgramador = (String)Session["Programmer"];
                softoferins.Tipo = Request.Form["tipo"];
                softoferins.Descripcion = Request.Form["descripcion"];
                softoferins.Personalizable = (Request.Form["personalizable"] == "1");
                softoferins.ConexionBD = (Request.Form["conbd"] == "1");
                softoferins.TipoBD = Request.Form["tipobd"];
                softoferins.NickCliente = Request.Form["cliente"];

                softoferins.Insertar();
                break;

            case "deletepro":
                SoftwareOfertado softoferdel = new SoftwareOfertado();

                long idsoftwareofer = Convert.ToInt64(Request.Form["idsoft"]);
                softoferdel.Borrar(idsoftwareofer);
                break;

            case "modifypro":
                SoftwareOfertado softpromod = new SoftwareOfertado();

                softpromod.Descripcion = Request.Form["descripcion"];
                softpromod.ConexionBD = (Request.Form["conbd"] == "1");
                softpromod.TipoBD = Request.Form["tipobd"];
                softpromod.Personalizable = (Request.Form["amedida"] == "1");

                Int64 idsoftwarepromod = Convert.ToInt64(Request.Form["idsoft"]);
                softpromod.Modificar(idsoftwarepromod);
                break;

            case "acceptofer":
                SoftwareOfertado softoferaccept = new SoftwareOfertado();

                long idsoftwareaccept = Convert.ToInt64(Request.Form["idsoft"]);
                softoferaccept.Aceptar(idsoftwareaccept);
                break;

            case "rejectofer":
                SoftwareOfertado softofereject = new SoftwareOfertado();

                long idsoftwareject = Convert.ToInt64(Request.Form["idsoft"]);
                softofereject.Rechazar(idsoftwareject);
                break;

            case "acceptsol":
                SoftwareDemandado softsolaccept = new SoftwareDemandado();

                long idsoftwaresolaccept = Convert.ToInt64(Request.Form["idsoft"]);
                softsolaccept.Aceptar(idsoftwaresolaccept);
                break;

            case "rejectsol":
                SoftwareDemandado softsolreject = new SoftwareDemandado();

                long idsoftwasolreject = Convert.ToInt64(Request.Form["idsoft"]);
                softsolreject.Rechazar(idsoftwasolreject);
                break;

        }

    }
}
