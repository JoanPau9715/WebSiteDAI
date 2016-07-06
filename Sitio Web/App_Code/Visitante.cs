using System;
using System.Data;
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
/// Objeto visitante con las propiedades de su modo de navegación
/// </summary>
public class Visitante
{
    private String _ip;
    private String _pagina;
    private String _metodo;
    private String _navegador;
    private DateTime _fhvisita;

    public String IP { get { return _ip; } }

    public String Pagina { get { return _pagina; } }

    public String Metodo { get { return _metodo; } }

    public String Navegador { get { return _navegador; } }

    public DateTime FechaHoraVisita { get { return _fhvisita; } }

    public Visitante(String ip, String pagina, String metodo, String navegador, DateTime fhvisita)
    {
        _ip = ip;
        _pagina = pagina;
        _metodo = metodo;
        _navegador = navegador;
        _fhvisita = fhvisita;
    }
}
