package basesita;

/*
 this.usrBD = "root";
        this.passBD = "cazoa";
        this.urlBD = "jdbc:mysql://127.0.0.1:3306/ezhome?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC";///?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author EZ-Home
 */
public class Base {

    private String usrBD;
    private String passBD;
    private String urlBD;
    private String driverClassName;
    private Connection conn = null;
    private Statement estancia;

    /**
     * Base remota
     *
     * public Base() { this.usrBD = "ezbuilder"; this.passBD = "elgordoesgei";
     * this.urlBD =
     * "jdbc:mysql://db4free.net:3306/ezbuilder?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC";///?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC
     * this.driverClassName = "com.mysql.jdbc.Driver"; }
     */
    /**
     * public Base() { this.usrBD = "usuario"; this.passBD = "contraseña";
     * this.urlBD =
     * "jdbc:mysql://127.0.0.1:3306/ezbuilder?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC";///?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC
     * this.driverClassName = "com.mysql.jdbc.Driver"; } }
     * mypicsareaction.mysql.database.azure.com
     * this.urlBD = "jdbc:mysql://127.0.0.1:3306/ezbuilder?useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC";
     */
    public Base() {
        this.usrBD = "adminAzure"; // en Azure suele ser user@servername
        this.passBD = "contra123Si";
        // Para Azure se recomienda sslMode=REQUIRED
        this.urlBD = "jdbc:mysql://basedepruebas.mysql.database.azure.com:3306/mesaregalos?useSSL=false";
        this.driverClassName = "com.mysql.cj.jdbc.Driver";    }

    public void setUsuarioBD(String usuario) throws SQLException {
        this.usrBD = usuario;
    }

    public void setPassBD(String pass) {
        this.passBD = pass;
    }

    public void setUrlBD(String url) {
        this.urlBD = url;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }

    public void conectar() throws SQLException {
        try {
            Class.forName(this.driverClassName).newInstance();
            this.conn = (Connection) DriverManager.getConnection(this.urlBD, this.usrBD, this.passBD);
        } catch (Exception err) {
            System.out.println("Error " + err.getMessage());
        }
    }

    public void cierraConexion() throws SQLException {
        this.conn.close();
    }

    public int insertar(String inserta) throws SQLException {
        Statement st = (Statement) this.conn.createStatement();
        return st.executeUpdate(inserta);
    }

    public int borrar(String borra) throws SQLException {
        Statement st = (Statement) this.conn.createStatement();
        return st.executeUpdate(borra);
    }

    public ResultSet consulta(String consulta) throws SQLException {
        this.estancia = (Statement) conn.createStatement();
        return this.estancia.executeQuery(consulta);
    }

    public int edita(String edita) throws SQLException {
        Statement st = (Statement) this.conn.createStatement();
        return st.executeUpdate(edita);
    }

}
