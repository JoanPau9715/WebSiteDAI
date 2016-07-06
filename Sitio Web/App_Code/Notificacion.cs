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
/// Descripción breve de Notificacion
/// </summary>
public class Notificacion
{
    private static SqlConnection conexion;

    private void AbrirConexion()
    {
        ConnectionStringSettings setKailua = ConfigurationManager.ConnectionStrings["CadenaKailua"];
        String cadenaConexion = setKailua.ConnectionString;

        conexion = new SqlConnection();

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

    public SqlDataReader BuscarNuevas(string nick)
    {
        AbrirConexion();

        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand("EXECUTE BUSCAR_NOTIFICACIONES_NUEVAS '" + nick + "'", conexion);

        dr = cmd.ExecuteReader(CommandBehavior.SingleResult);

        return dr;
    }

    public SqlDataReader BuscarTodas(string nick)
    {
        AbrirConexion();

        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand("EXECUTE BUSCAR_TODAS_NOTIFICACIONES '" + nick + "'", conexion);

        dr = cmd.ExecuteReader(CommandBehavior.SingleResult);

        return dr;
    }

    public void MarcarVistas(string nick, string tipo)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("MARCAR_VISTAS", conexion);
        SqlParameter spNick = new SqlParameter("@nick", nick);
        SqlParameter spTipo = new SqlParameter("@tipo", tipo);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spTipo);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

	public Notificacion()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
}
