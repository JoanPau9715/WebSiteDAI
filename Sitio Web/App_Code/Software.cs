using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Esta es la clase que sirve de ancestro a las subclases
/// Software demandado y Software ofertado
/// </summary>

abstract public class Software
{
    private String _tipo;
    private String _descripcion;
    private bool _conexionBD;
    private String _tipoBD;

    public String Tipo
    {
        get { return _tipo; }
        set { _tipo = value; }
    }

    public String Descripcion
    {
        get { return _descripcion; }
        set { _descripcion = value; }
    }

    public bool ConexionBD
    {
        get { return _conexionBD; }
        set { _conexionBD = value; }
    }

    public String TipoBD
    {
        get { return _tipoBD; }
        set { _tipoBD = value; }
    }

    
    abstract public void Insertar();
    abstract public void Modificar(long idsoftware);
    abstract public void Borrar(long idsoftware);
    abstract public SqlDataReader Consultar(String usuario, int pagina, String vista);
    abstract public int Contar(String usuario, String vista);
    abstract public void Aceptar(long idsoftware);
    abstract public void Rechazar(long idsoftware);
    
	public Software()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
}
