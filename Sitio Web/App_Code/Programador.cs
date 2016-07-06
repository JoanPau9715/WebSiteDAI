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
/// Esta clase representa al objeto Programador en la aplicación
/// Para la comunicación con la base de datos
/// </summary>
public class Programador
{

    private String _nombre;
    private String _apellidos;
    private String _email;
    private String _telContacto;
    private String _empresa;
    private String _nUsuario;
    private String _kAcceso;

    private String _ip;

    public String Nombre
    {
        get { return _nombre; }
        set { _nombre = value; }
    }

    public String Apellidos
    {
        get { return _apellidos; }
        set { _apellidos = value; }
    }


    public String EMail
    {
        get { return _email; }
        set { _email = value; }
    }

    public String Telefono
    {
        get { return _telContacto; }
        set { _telContacto = value; }
    }

    public String Empresa
    {
        get { return _empresa; }
        set { _empresa = value; }
    }

    public String Nick
    {
        get { return _nUsuario; }
        set { _nUsuario = value; }
    }

    public String ClaveAcceso
    {
        get { return _kAcceso; }
        set { _kAcceso = value; }
    }

    public String IP
    {
        get { return _ip; }
        set { _ip = value; }
    }

    private static SqlConnection conexion;

	public Programador()
	{

    }

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

    public void Insertar()
    {

        AbrirConexion();

        SqlCommand comando = new SqlCommand("INSERTAR_PROGRAMADOR", conexion);
        SqlParameter spNombre = new SqlParameter("@nombre", this.Nombre);
        SqlParameter spApellidos = new SqlParameter("@apellidos", this.Apellidos);
        SqlParameter spEMail = new SqlParameter("@email", this.EMail);
        SqlParameter spTel = new SqlParameter("@tel", this.Telefono);
        SqlParameter spEmpresa = new SqlParameter("@empresa", this.Empresa);
        SqlParameter spNick = new SqlParameter("@nick", this.Nick);
        SqlParameter spClave = new SqlParameter("@clave", this.ClaveAcceso);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNombre);
            comando.Parameters.Add(spApellidos);
            comando.Parameters.Add(spEMail);
            comando.Parameters.Add(spTel);
            comando.Parameters.Add(spEmpresa);
            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spClave);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public void InsertarExperiencias(String nick, String exp)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("INSERTAR_PROG_EXP", conexion);
        SqlParameter spNick = new SqlParameter("@nickpro", nick);
        SqlParameter spExp = new SqlParameter("@exp", exp);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spExp);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public bool ComprobarDisponibilidadNick(String Nick)
    {
        bool disponible = true;

        AbrirConexion();

        SqlCommand comando = new SqlCommand("COMPROBAR_DISPONIBILIDAD_NICK", conexion);
        SqlParameter spNick = new SqlParameter("@nick", Nick);
        SqlParameter spRes = new SqlParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            spRes.ParameterName = "@res";
            spRes.Direction = ParameterDirection.Output;
            spRes.SqlDbType = SqlDbType.Int;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spRes);

            comando.ExecuteNonQuery();

            disponible = ((int)spRes.Value == 1);

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }

        return disponible;
    }

    public void Logear()
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("LOGEAR_PROGRAMADOR", conexion);
        SqlParameter spNick = new SqlParameter("@nick", this.Nick);
        SqlParameter spIP = new SqlParameter("@ip", this.IP);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spIP);

            comando.ExecuteNonQuery();
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public void Desconectar()
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("DESCONECTAR_PROGRAMADOR", conexion);
        SqlParameter spNick = new SqlParameter("@nick", this.Nick);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNick);

            comando.ExecuteNonQuery();
        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public bool Comprobar()
    {
        bool existe;

        AbrirConexion();

        SqlCommand comando = new SqlCommand("COMPROBAR_PROGRAMADOR", conexion);
        SqlParameter spUsuario = new SqlParameter("@nick", this.Nick);
        SqlParameter spClave = new SqlParameter("@clave", this.ClaveAcceso);
        SqlParameter spRes = new SqlParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            spRes.ParameterName = "@res";
            spRes.Direction = ParameterDirection.Output;
            spRes.SqlDbType = SqlDbType.Int;

            comando.Parameters.Add(spUsuario);
            comando.Parameters.Add(spClave);
            comando.Parameters.Add(spRes);

            comando.ExecuteNonQuery();

            existe = ((int)spRes.Value == 1);

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }

        return existe;
    }

    public SqlDataReader ListarTodos()
    {
        AbrirConexion();

        SqlDataReader dr;
        SqlCommand comando = new SqlCommand();

        try
        {
            comando.Connection = conexion;
            comando.CommandText = "SELECT Nick FROM K_PROGRAMADORES ORDER BY Nick";

            dr = comando.ExecuteReader(CommandBehavior.SingleResult);
        }
        finally
        {
            comando.Dispose();
        }

        return dr;
    }

}
