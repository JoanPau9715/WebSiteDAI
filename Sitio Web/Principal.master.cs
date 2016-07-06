using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

public partial class Principal : System.Web.UI.MasterPage
{
    public HtmlGenericControl MyBodyTag
    {
        get { return BodyTag; }
        set { BodyTag = value; }
    }

    public HtmlGenericControl lblCli
    {
        get { return lblCustomer; }
        set { lblCustomer = value; }
    }

    public HtmlGenericControl menuKailua
    {
        get { return menuK; }
        set { menuK = value; }
    }

    public HtmlGenericControl mSoftwareCli
    {
        get { return menuSoftwareCli; }
        set { menuSoftwareCli = value; }
    }

    public HtmlGenericControl mSoftwarePro
    {
        get { return menuSoftwarePro; }
        set { menuSoftwarePro = value; }
    }

    public HtmlGenericControl menuMensajes
    {
        get { return mensajes; }
        set { mensajes = value; }
    }

    public HtmlImage irAcarpetaCli
    {
        get { return irCarpetaCli; }
        set { irCarpetaCli = value; }
    }

    public HtmlImage irAcarpetaPro
    {
        get { return irCarpetaPro; }
        set { irCarpetaPro = value; }
    }

    public HtmlImage irAinicio
    {
        get { return irInicio; }
        set { irInicio = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

}
