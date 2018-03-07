/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mpk_psql;

import java.sql.Connection;

/**
 *
 * @author Wojte_000
 */
public class Polaczenie {
    public static Connection conn = null;
    
    public static void Connect(String login, String haslo)
    {
        PascalConnection pc = PascalConnection.getInstance(login, haslo);
        conn = pc.getConnection();
    }
}
