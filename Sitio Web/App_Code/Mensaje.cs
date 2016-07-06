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
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de Mensaje
/// </summary>
public class Mensaje
{
    private String _nickcliente;
    private String _nickprogramador;
    private String _direccion;
    private String _asunto;
    private String _texto;

    public String NickCliente
    {
        get { return _nickcliente; }
        set { _nickcliente = value; }
    }

    public String NickProgramador
    {
        get { return _nickprogramador; }
        set { _nickprogramador = value; }
    }

    public String Direccion
    {
        get { return _direccion; }
        set { _direccion = value; }
    }

    public String Asunto
    {
        get { return _asunto; }
        set { _asunto = value; }
    }

    public String Texto
    {
        get { return _texto; }
        set { _texto = value; }
    }

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

    public void CerrarConexion()
    {
        if (conexion.State == ConnectionState.Open)
            conexion.Close();
    }

    public void Enviar()
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("ENVIAR_MENSAJE", conexion);
        SqlParameter spCliente = new SqlParameter("@nickcli", this.NickCliente);
        SqlParameter spProgramador = new SqlParameter("@nickpro", this.NickProgramador);
        SqlParameter spDireccion = new SqlParameter("@direccion", this.Direccion);
        SqlParameter spAsunto = new SqlParameter("@asunto", this.Asunto);
        SqlParameter spTexto = new SqlParameter("@texto", this.Texto);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spCliente);
            comando.Parameters.Add(spProgramador);
            comando.Parameters.Add(spDireccion);
            comando.Parameters.Add(spAsunto);
            comando.Parameters.Add(spTexto);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public void MarcarLeido(int idmensaje)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("MARCAR_LEIDO", conexion);
        SqlParameter spID = new SqlParameter("@idmensaje", idmensaje);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spID);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public void Borrar(int idmensaje)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("BORRAR_MENSAJE", conexion);
        SqlParameter spID = new SqlParameter("@idmensaje", idmensaje);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spID);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public SqlDataReader VerMensajesPara(string usuario, string tipousuario, int pagina)
    {
        AbrirConexion();

        SqlDataReader dr;
        SqlCommand comando = new SqlCommand();

        string direccion = "";
        string cliente = "";
        string programador = "";

        switch (tipousuario)
        {
            case "cliente":
                direccion = "ProCli";
                cliente = usuario;
                break;
            case "programador":
                direccion = "CliPro";
                programador = usuario;
                break;
        }

        try
        {
            comando.Connection = conexion;
            comando.CommandText =
                String.Format("EXECUTE VER_MENSAJES_PARA {0}, {1}, {2}, {3}",
                              "'" + direccion + "'", "'" + cliente + "'", "'" + programador + "'", 
                              Convert.ToString(pagina));

            dr = comando.ExecuteReader(CommandBehavior.SingleResult);
        }
        finally
        {
            comando.Dispose();
        }

        return dr;
    }

    public int ContarMensajesPara(string nick)
    {
        int num;

        AbrirConexion();

        SqlCommand comando = new SqlCommand("CONTAR_MENSAJES_PARA", conexion);
        SqlParameter spNick = new SqlParameter("@nick", nick);
        SqlParameter spNum = new SqlParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            spNum.ParameterName = "@num";
            spNum.Direction = ParameterDirection.Output;
            spNum.SqlDbType = SqlDbType.Int;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spNum);

            comando.ExecuteNonQuery();

            num = (int)spNum.Value;
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }

        return num;
    }

	public Mensaje()
	{

	}
}
