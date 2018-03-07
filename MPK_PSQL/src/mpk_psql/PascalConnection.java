/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mpk_psql;
import com.jcraft.jsch.*;
import java.util.Properties;
import java.sql.*;


/**
 *
 * @author Wojte_000
 */
public class PascalConnection {
       public Connection c;
    /**
     * zmienna opisujaca stan otwarcia tunelu
     */
    private boolean tunnelIsOpen;

    private static volatile PascalConnection db = null;
    /**
     *  funkcja otwiera oraz zwraca odpowiednia klasa zawierajaca polaczenie
     * @return
     */
    public static PascalConnection getInstance(String login, String haslo) {
        PascalConnection result = db;
        if (db == null) {
            synchronized (PascalConnection.class) {
                if (result == null) {
                    db = result = new PascalConnection(login, haslo);
                }
            }
        }
        return result;
    }

    /**
     *  prywatny konstruktor tworzy polaczenie ssh z serwerem Pascal
     */
    private PascalConnection(String login, String haslo) {
        System.out.println("Probóje nawiązać połączenie z Pascalem...");
        int i;
        tunnelIsOpen = false;
        for(i = 1102; i <= 1200; ++i) {
            tunnelIsOpen = openSSH(i, 5432, login, haslo);
            if(tunnelIsOpen) {
                url = "jdbc:postgresql://localhost:" + localPort +"/u5franczuk?allowMultiQueries=true&currentSchema=mpk";
                System.out.println("url = " + url);
                break;
            }
        }
        openPostgres();
    }

    private String dbuser;
    private String dbpass;

    private int localPort;
    private String url;

    private JSch jsch;
    private Session session;
    /**
     * funkcja otwierajaca polaczenie ssh 
     * @param localPort port lokalny na ktorym odbywa sie polaczenie
     * @param remotePort port zewnatrzny na serwerze na ktory ma sie odbywac polaczenie
     * @param user nazwa uzytkownika
     * @param password haslo
     * @return 
     */
    private boolean openSSH(int localPort, int remotePort, String user, String password) {
       
        try {
            System.out.println("Proboje otworzyć tunel SSH...");
            jsch = new JSch();
            session = jsch.getSession(user, "pascal.fis.agh.edu.pl", 22);
            session.setPassword(password);

            Properties config = new Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);

            session.connect();
            // make port forwarding from local port to pascal
            this.localPort = session.setPortForwardingL(localPort,
                    "pascal.fis.agh.edu.pl",
                    remotePort);

        } catch (JSchException e) {
            return false;
        }


        return true;
    }


    /**
     * Metoda laczaca sie z baza danych postgres
     */
    public void openPostgres(){
        System.out.println("Łączenie z bazą danych...");
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException cnfe) {
            System.out.println("Nie znaleziono sterownika!");
            System.out.println("Wydruk sledzenia bledu i zakonczenie.");
            cnfe.printStackTrace();
            System.exit(1);
        }

        c = null;
        try {
            c = DriverManager.getConnection(url, "u5franczuk", "5franczuk");
        } catch (SQLException se) {
            System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
            se.printStackTrace();
            System.exit(1);
        }
        System.out.println("Successfull connection");
    }
    
    public static void openPostgresStatic(String localPort){
        
        Connection c;
        System.out.println("Łączenie z bazą danych na porcie: " + localPort);
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException cnfe) {
            System.out.println("Nie znaleziono sterownika!");
            System.out.println("Wydruk sledzenia bledu i zakonczenie.");
            cnfe.printStackTrace();
            System.exit(1);
        }
        String url = "jdbc:postgresql://localhost:pascal/u5franczuk?allowMultiQueries=true&currentSchema=mpk";
        c = null;
        try {
            c = DriverManager.getConnection(url, "u5franczuk", "5franczuk");
        } catch (SQLException se) {
            System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
            se.printStackTrace();
            System.exit(1);
        }
        System.out.println("Successfull connection");
    }
    
    /**
     * funkcja zwaraca aktualne polaczenie
     * @return 
     */
    public Connection getConnection() {
        return c;
    }
    
    /**
     * funkcja zamykajaca wszystkie polaczenia
     */
    public void close()
    {
        try {
            c.close();
            session.disconnect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
