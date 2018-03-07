/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mpk_psql;

import java.io.IOException;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

/**
 *
 * @author Wojte_000
 */
public class MPK_PSQL extends Application {
    
    @Override
    public void start(Stage stage) throws Exception {
        Parent root;
        try{
            root = FXMLLoader.load(getClass().getResource("main_screen.fxml"));
        } catch(IOException e)
        {
            System.err.println(e.getMessage());
            return;
        }
        Scene scene = new Scene(root);
        stage.setScene(scene);
        stage.show();
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
}
