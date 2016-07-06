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
/// Descripción breve de SoftwareDemandado
/// </summary>
public class SoftwareDemandado : Software 
{
    private String _nickCliente;
    private String _nickProgramador;

    public String NickCliente
    {
        get { return _nickCliente; }
        set { _nickCliente = value; }
    }

    public String NickProgramador
    {
        get { return _nickProgramador; }
        set { _nickProgramador = value; }
    }

    private static SqlConnection conexion;

    public override void Insertar()
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("INSERTAR_SOFTWARE_DEMANDADO", conexion);
        SqlParameter spNickCli = new SqlParameter("@nickcli", this.NickCliente);
        SqlParameter spTipo = new SqlParameter("@tipo", this.Tipo);
        SqlParameter spDescripcion = new SqlParameter("@descripcion", this.Descripcion);
        SqlParameter spConexionBD = new SqlParameter("@connbd", this.ConexionBD);
        SqlParameter spTipoBD = new SqlParameter("@tipobd", this.TipoBD);
        SqlParameter spNickPro = new SqlParameter("@nickpro", this.NickProgramador);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spNickCli);
            comando.Parameters.Add(spTipo);
            comando.Parameters.Add(spDescripcion);
            comando.Parameters.Add(spConexionBD);
            comando.Parameters.Add(spTipoBD);
            comando.Parameters.Add(spNickPro);

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
            comando.CommandText = "EXECUTE VER_MIS_DEMANDAS '" + usuario + "', " + Convert.ToString(pagina) + ", '" + vista + "'";
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

        SqlCommand comando = new SqlCommand("CONTAR_MIS_DEMANDAS", conexion);
        SqlParameter spNick = new SqlParameter("@nickcli", usuario);
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

        SqlCommand comando = new SqlCommand("MODIFICAR_SOFTWARE_DEMANDADO", conexion);
        SqlParameter spID = new SqlParameter("@idsoft", idsoftware);
        SqlParameter spConBD = new SqlParameter("@conbd", this.ConexionBD);
        SqlParameter spTipoBD = new SqlParameter("@tipobd", this.TipoBD);
        SqlParameter spDescrip = new SqlParameter("@descripcion", this.Descripcion);

        try
        {
            comando.CommandType = CommandType.StoredProcedure;

            comando.Parameters.Add(spID);
            comando.Parameters.Add(spConBD);
            comando.Parameters.Add(spTipoBD);
            comando.Parameters.Add(spDescrip);

            comando.ExecuteNonQuery();

        }
        finally
        {
            comando.Dispose();
            CerrarConexion();
        }        
    }

    public override void Borrar(Int64 idsoftware)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("BORRAR_SOFTWARE_DEMANDADO", conexion);
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

    public SqlDataReader ConsultaDeProgramador(String programador, int pagina, String vista)
    {
        AbrirConexion();
        SqlDataReader dr;
        SqlCommand comando = new SqlCommand();

        try
        {
            comando.CommandText = "EXECUTE VER_PRO_DEMANDAS '" + programador + "', " + Convert.ToString(pagina) + ", '" + vista + "'";
            comando.Connection = conexion;

            dr = comando.ExecuteReader(CommandBehavior.SingleResult);
        }
        finally
        {
            comando.Dispose();
        }

        return dr;
    }

    public int ContarLasDeProgramador(String programador, String vista)
    {
        int num;

        AbrirConexion();

        SqlCommand comando = new SqlCommand("CONTAR_PRO_DEMANDAS", conexion);
        SqlParameter spNick = new SqlParameter("@nickpro", programador);
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

    public override void Aceptar(long idsoftware)
    {
        AbrirConexion();

        SqlCommand comando = new SqlCommand("ACEPTAR_SOLICITUD", conexion);
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

        SqlCommand comando = new SqlCommand("RECHAZAR_SOLICITUD", conexion);
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

	public SoftwareDemandado()
	{

	}
}
