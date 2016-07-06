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
/// Descripción breve de SoftwareOfertado
/// </summary>
public class SoftwareOfertado : Software 
{
    private String _nickProgramador;
    private bool _personalizable;
    private String _nickCliente;

    public String NickProgramador
    {
        get { return _nickProgramador; }
        set { _nickProgramador = value; }
    }

    public bool Personalizable
    {
        get { return _personalizable; }
        set { _personalizable = value; }
    }

    public String NickCliente
    {
        get { return _nickCliente; }
        set { _nickCliente = value; }
    }

    private static SqlConnection conexion;

    public override void Insertar()
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("INSERTAR_SOFTWARE_OFERTADO", conexion);
        SqlParameter spNickPro = new SqlParameter("@nickpro", this.NickProgramador);
        SqlParameter spTipo = new SqlParameter("@tipo", this.Tipo);
        SqlParameter spDescripcion = new SqlParameter("@descripcion", this.Descripcion);
        SqlParameter spPersonalizable = new SqlParameter("@personalizable", this.Personalizable);
        SqlParameter spConexionBD = new SqlParameter("@connbd", this.ConexionBD);
        SqlParameter spTipoBD = new SqlParameter("@tipobd", this.TipoBD);
        SqlParameter spNickCli = new SqlParameter("@nickcli", this.NickCliente);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNickPro);
            comando.Parameters.Add(spTipo);
            comando.Parameters.Add(spDescripcion);
            comando.Parameters.Add(spPersonalizable);
            comando.Parameters.Add(spConexionBD);
            comando.Parameters.Add(spTipoBD);
            comando.Parameters.Add(spNickCli);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }
    }

    public override SqlDataReader Consultar(String usuario, int pagina, String vista)
    {
        AbrirConexion();
        SqlDataReader dr;
        SqlCommand comando = new SqlCommand();

        try
        {
            comando.CommandText = "EXECUTE VER_MIS_OFERTAS '" + usuario + "', " + Convert.ToString(pagina) + ", '" + vista + "'";
            comando.Connection = conexion;

            dr = comando.ExecuteReader(CommandBehavior.SingleResult);
        }
        finally
        {
            comando.Dispose();
        }

        return dr;
    }

    public SqlDataReader ConsultaDeCliente(String cliente, int pagina, String vista)
    {
        AbrirConexion();
        SqlDataReader dr;
        SqlCommand comando = new SqlCommand();

        try
        {
            comando.CommandText = "EXECUTE VER_CLI_OFERTAS '" + cliente + "', " + Convert.ToString(pagina) + ", '" + vista + "'";
            comando.Connection = conexion;

            dr = comando.ExecuteReader(CommandBehavior.SingleResult);
        }
        finally
        {
            comando.Dispose();
        }

        return dr;
    }

    public override int Contar(String usuario, String vista)
    {
        int num;

        AbrirConexion();

        SqlCommand comando = new SqlCommand("CONTAR_MIS_OFERTAS", conexion);
        SqlParameter spNick = new SqlParameter("@nickpro", usuario);
        SqlParameter spVista = new SqlParameter("@vista", vista);
        SqlParameter spNum = new SqlParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            spNum.ParameterName = "@num";
            spNum.Direction = ParameterDirection.Output;
            spNum.SqlDbType = SqlDbType.Int;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spVista);
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

    public int ContarLasDeCliente(String cliente, String vista)
    {
        int num;

        AbrirConexion();

        SqlCommand comando = new SqlCommand("CONTAR_CLI_OFERTAS", conexion);
        SqlParameter spNick = new SqlParameter("@nickcli", cliente);
        SqlParameter spVista = new SqlParameter("@vista", vista);
        SqlParameter spNum = new SqlParameter();

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            spNum.ParameterName = "@num";
            spNum.Direction = ParameterDirection.Output;
            spNum.SqlDbType = SqlDbType.Int;

            comando.Parameters.Add(spNick);
            comando.Parameters.Add(spVista);
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

    public override void Modificar(long idsoftware)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("MODIFICAR_SOFTWARE_OFERTADO", conexion);
        SqlParameter spID = new SqlParameter("@idsoft", idsoftware);
        SqlParameter spConBD = new SqlParameter("@conbd", this.ConexionBD);
        SqlParameter spTipoBD = new SqlParameter("@tipobd", this.TipoBD);
        SqlParameter spAMedida = new SqlParameter("@amedida", this.Personalizable);
        SqlParameter spDescrip = new SqlParameter("@descripcion", this.Descripcion);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spID);
            comando.Parameters.Add(spConBD);
            comando.Parameters.Add(spTipoBD);
            comando.Parameters.Add(spAMedida);
            comando.Parameters.Add(spDescrip);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }        
    }

    public override void Borrar(long idsoftware)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("BORRAR_SOFTWARE_OFERTADO", conexion);
        SqlParameter spID = new SqlParameter("@idsoft", idsoftware);

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

    public override void Aceptar(long idsoftware)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("ACEPTAR_OFERTA", conexion);
        SqlParameter spID = new SqlParameter("@idsoft", idsoftware);

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

    public override void Rechazar(long idsoftware)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("RECHAZAR_OFERTA", conexion);
        SqlParameter spID = new SqlParameter("@idsoft", idsoftware);

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

	public SoftwareOfertado() : base()
	{

	}
}
