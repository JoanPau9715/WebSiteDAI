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
using System.Collections;

/// <summary>
/// Objeto contenedor de todos los visitantes y sus movimientos
/// </summary>
public class TodosLosVisitantes : ArrayList
{

    private static SqlConnection conexion;

    private void AbrirConexion()
    {
        conexion = new SqlConnection();

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

    private void CerrarConexion()
    {
        if (conexion.State == ConnectionState.Open)
            conexion.Close();
    }

    public void Volcar()
    {
        AbrirConexion();

        try
        {
            foreach (Visitante vis in this)
            {
                OnebyOne(vis);
            }
        }
        finally
        {
            CerrarConexion();
        }
    }

    private void OnebyOne(Visitante vis)
    {
        SqlCommand comando = new SqlCommand("VOLCAR_DATOS_VISITAS", conexion);
        SqlParameter spMiembro = new SqlParameter("@miembro", "?");
        SqlParameter spIP = new SqlParameter("@ip", vis.IP);
        SqlParameter spPagina = new SqlParameter("@pagina", vis.Pagina);
        SqlParameter spNavegador = new SqlParameter("@navegador", vis.Navegador);
        SqlParameter spMetodo = new SqlParameter("@metodo", vis.Metodo);
        SqlParameter spFHVisita = new SqlParameter("@fhvisita", vis.FechaHoraVisita);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spMiembro);
            comando.Parameters.Add(spIP);
            comando.Parameters.Add(spPagina);
            comando.Parameters.Add(spNavegador);
            comando.Parameters.Add(spMetodo);
            comando.Parameters.Add(spFHVisita);
            
            comando.ExecuteNonQuery();
        }
        finally
        {
            comando.Dispose();
        }
    }

	public TodosLosVisitantes()
	{

	}
}
