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
/// Clase para comunicar con la bd y obtener un DataReader 
/// con las especialidades actualizadas
/// </summary>
public class Especialidades
{
    private static SqlConnection conexion;

    private void AbrirConexion()
    {
        ConnectionStringSettings setKailua = ConfigurationManager.ConnectionStrings["CadenaKailua"];
        String cadenaConexion = setKailua.ConnectionString;
        try
        {
            conexion.ConnectionString = cadenaConexion;
            conexion.Open();
        }
        catch (SqlException)
        {

        }
    }

    public void CerrarConexion()
    {
        if (conexion.State == ConnectionState.Open)
            conexion.Close();
    }

    public SqlDataReader ListarEspecialidades()
    {
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand("SELECT IDEXP, DENOM FROM K_ESPECIALIDADES ORDER BY DENOM", conexion);

        AbrirConexion();
        dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

        return dr;
    }

	public Especialidades()
	{
        conexion = new SqlConnection();
    }
}
