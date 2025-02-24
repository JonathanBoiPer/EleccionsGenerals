package projecte_base_dades.apartat1;

import projecte_base_dades.ConnexioDBGrup2;
import projecte_base_dades.apartat4.DescomprimirZip;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.sql.*;
import java.util.Calendar;

public class ImportVotsAutonomic {

    static String codiCandidatura;
    static String vots;
    static String codiIneCA;
    static String codiProvincia;
    static String codiDistricteElectoral;
    static String zipId;
    public static void importarDades(){
        BufferedReader bfLector = null;

        try {
            zipId = DescomprimirZip.zipId;

            //Obtenim el directori actual
            Path pathActual = Paths.get(System.getProperty("user.dir"));

            //Concatenem el directori actual amb un subdirectori "temp" i afegim el fitxer "08021904.DAT"
            Path pathFitxer = Paths.get(pathActual.toString(), "temp", "08"+ zipId + ".DAT");

            //objReader = new BufferedReader(new FileReader(pathFitxer.toString()));

            bfLector = Files.newBufferedReader(pathFitxer, StandardCharsets.ISO_8859_1);
            String strLinia;

            while ((strLinia = bfLector.readLine()) != null) {
                //comprobar que el codigo de provincia ine sea 99, que el codigo del distrito electoral sea 9 y que el codigo ine de la CCAA no sea 99(que significaria a nivel nacional)
                // para que los votos que coja sean a nivel total de la comunidad por esa candidatura,
                codiProvincia = strLinia.substring(11,13);
                codiDistricteElectoral = strLinia.substring(13,14);
                codiIneCA = strLinia.substring(9,11);
                if (codiProvincia.equals("99") && codiDistricteElectoral.equals("9") && !codiIneCA.equals("99")){
                    // una vez comprobado que son a nivel total de la comunidad i que el codigo de la comunidad no sea 99, significando los votos a nivel nacional, que coja el codigo de la CCAA, el codigo de la candidatura i los votos totales de la CCAA
                    codiIneCA = strLinia.substring(9,11);
                    codiCandidatura = strLinia.substring(14,20);
                    vots = strLinia.substring(20,28);
                    insert();
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (bfLector != null)
                    bfLector.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }
    static void insert(){
        try {
            Connection con= ConnexioDBGrup2.getConnection();
            
            // the mysql insert statement
            String query = " INSERT INTO vots_candidatures_ca (comunitat_autonoma_id,candidatura_id,vots)"
                    + " values ( ?, ?, ?)";

            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = con.prepareStatement(query);
            preparedStmt.setInt (1, selectComunitatAutonomaId(codiIneCA));
            preparedStmt.setInt (2, selectCandidaturaId(codiCandidatura));
            preparedStmt.setInt (3, Integer.parseInt(vots));
            // execute the preparedstatement
            preparedStmt.execute();

        }catch(Exception e){
            System.out.println(e);
        }
    }
    public static int selectComunitatAutonomaId(String codiIneCA) {
        int a = 0;
        int ine = Integer.parseInt(codiIneCA);
        try{

            Connection con= ConnexioDBGrup2.getConnection();
            //SENTÈNCIA SELECT
            //Preparem una sentència amb paràmetres.
            String query = "SELECT comunitat_aut_id " +
                    " FROM comunitats_autonomes " +
                    "WHERE codi_ine = ?";
            PreparedStatement preparedStmt = con.prepareStatement(query);
            preparedStmt.setInt(1,ine);


            ResultSet rs = preparedStmt.executeQuery();

            while(rs.next()) {
                a = rs.getInt("comunitat_aut_id");

            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return a;

    }
    public static int selectCandidaturaId(String codiCandidatura) {
        int a = 0;
        int codCandidatura = Integer.parseInt(codiCandidatura);
        try{

            Connection con= ConnexioDBGrup2.getConnection();
            //SENTÈNCIA SELECT
            //Preparem una sentència amb paràmetres.
            String query = "SELECT candidatura_id " +
                    " FROM candidatures " +
                    "WHERE codi_candidatura = ?";
            PreparedStatement preparedStmt = con.prepareStatement(query);
            preparedStmt.setInt(1,codCandidatura);


            ResultSet rs = preparedStmt.executeQuery();

            while(rs.next()) {
                a = rs.getInt("candidatura_id");

            }

        } catch ( SQLException throwables) {
            throwables.printStackTrace();
        }

        return a;

    }
}
