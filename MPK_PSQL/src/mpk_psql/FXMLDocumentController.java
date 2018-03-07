/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mpk_psql;

import java.io.IOException;
import static java.lang.Thread.sleep;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.control.PasswordField;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.util.Callback;


/**
 *
 * @author Wojte_000
 */
public class FXMLDocumentController implements Initializable {
    private ObservableList<ObservableList> data;


    Connection conn;
    private boolean builtFlag=false;
    
    
    @FXML
    private TextField pracownicy_dane1;
    
    @FXML
    private Button Login;
    
    @FXML
    private Button button;

    @FXML
    private Label label;

    @FXML
    private Label info;

    @FXML
    private Label Error;
    @FXML
    private AnchorPane wykonajPane;
    
    @FXML
    private Button wyslij;
    
    @FXML
    private TableView tableview;
    
    @FXML
    private MenuBar Menu_cale;
    
    @FXML
    private MenuItem Pracownicy_menu;

    @FXML
    private MenuItem Pracownicy_menu1;

    @FXML
    private MenuItem Pracownicy_menu11;

    @FXML
    private ScrollPane Insertowanie;
    
    @FXML
    private Button wyslij1;

    @FXML
    private TextField pracownicy_dane11;

    @FXML
    private TextField pracownicy_dane1111;

    @FXML
    private TextField pojazdy_dane1;

    @FXML
    private TextField pojazdy_dane2;

    @FXML
    private Button wyslij2;

    @FXML
    private TextField zajezdnie_dane1;

    @FXML
    private TextField zajezdnie_dane2;

    @FXML
    private Button wyslij3;
    
    @FXML
    private Label Label40;

    @FXML
    private TextField modele_dane1;

            
    @FXML
    private ChoiceBox<String> stanowiskoBox;
    
    @FXML 
    private ChoiceBox<String> polaczenia_przystankow_dane4;
    @FXML 
    private ChoiceBox<String> TabelaBox;
    
    @FXML
    private TextField modele_dane2;

    @FXML
    private TextField modele_dane3;

    @FXML
    private Button wyslij4;

    @FXML
    private TextField grafik_dane;

    @FXML
    private Button wyslij5;

    @FXML
    private TextField linie_dane1;

    @FXML
    private TextField linie_dane2;

    @FXML
    private TextField linie_dane3;

    @FXML
    private TextField linie_dane4;

    @FXML
    private TextField linie_dane5;

    @FXML
    private TextField linie_dane6;

    @FXML
    private TextField linie_dane7;

    @FXML
    private TextField linie_dane8;

    @FXML
    private Button wyslij6;

    @FXML
    private TextField linie_przystanki_dane1;

    @FXML
    private TextField linie_przystanki_dane2;

    @FXML
    private TextField linie_przystanki_dane3;

    @FXML
    private TextField przystanki_dane1;

    @FXML
    private CheckBox przystanki_dane2;

    @FXML
    private Button wyslij7;

    @FXML
    private Button wyslij8;


    @FXML
    private TextField polaczenia_przystankow_dane1;

    @FXML
    private TextField polaczenia_przystankow_dane2;

    @FXML
    private TextField polaczenia_przystankow_dane3;

    @FXML
    private Button wyslij9;

    @FXML
    private TextField typy_polaczen_dane1;

    @FXML
    private Button wyslij10;

    @FXML
    private Label Label1;

    @FXML
    private Label Label2;

    @FXML
    private Label Label3;

    @FXML
    private Label Label4;

    @FXML
    private Label Label5;


    @FXML
    private Label Label6;

    @FXML
    private Label Label7;

  
    @FXML
    private Label Label8;

    @FXML
    private Label Label9;

    @FXML
    private Label Label10;

    @FXML
    private Label Label11;

    @FXML
    private Label Label12;

    @FXML
    private Label Label13;

    @FXML
    private Label Label14;

 
    @FXML
    private Label Label15;

 
    @FXML
    private Label Label16;

    @FXML
    private Label Label17;


    @FXML
    private Label Label18;

    @FXML
    private Label Ostatnie; 
            
    @FXML
    private Label Label19;
    @FXML
    private Label Label20;

    @FXML
    private Label Label21;

    @FXML
    private Label Label22;

    @FXML
    private Label Label23;

    @FXML
    private Label Label24;

    @FXML
    private Label Label25;

    @FXML
    private Label Label26;

    @FXML
    private Label Label27;

    @FXML
    private Label Label28;

    @FXML
    private Label Label29;

    @FXML
    private Label Label30;

    @FXML
    private AnchorPane LoginPane;
    
    @FXML
    private Label Label31;

    @FXML
    private Label Label32;

    @FXML
    private Label Label33;

    @FXML
    private Label Label34;

    @FXML
    private Label Label35;

    @FXML
    private ChoiceBox AkcjaBox;
 
    @FXML
    private Label Label36;


    @FXML
    private Label Label37;

    @FXML
    private Label Label38;

    @FXML
    private TextField PolecenieField;

    @FXML
    private Label Label39;

    @FXML
    private TextField kwerendaField;
    
    @FXML 
    private Label kwerendaLabel;
    
    
    private void showOdczyt()
    {
        kwerendaLabel.setVisible(true);
        kwerendaField.setVisible(true);
        tableview.setVisible(true);
        Insertowanie.setVisible(false);
        wykonajPane.setVisible(false);
           
    }
    @FXML
    private TextField Username;
    
    @FXML
    private PasswordField Password;
    
    @FXML
    void TunelowanieButton(ActionEvent event)
    {
        Polaczenie.Connect(Username.getText(), Password.getText());
        conn = Polaczenie.conn;
        if(conn != null)
            info.setText("Witamy w bazie danych MPK!");
        else info.setText("Blad polaczenia z pascalem :(");

        Menu_cale.setVisible(true);
        LoginPane.setVisible(false);
        
    }
    
    
    
     @FXML
    void Przekaz_polecenie_click(ActionEvent event)
    {
      showWykonaj();
    }
    
    @FXML
    private void wykonajPolecenie(ActionEvent event)
    {       
        PreparedStatement ps;
        String akcja = AkcjaBox.getValue().toString();

        if(akcja.equals("DELETE"))
        {
            akcja+= " FROM";
        }
        System.out.println(akcja + " "+ TabelaBox.getValue() + " " + PolecenieField.getText());
        try{
           ps = Polaczenie.conn.prepareStatement(akcja + " "+ TabelaBox.getValue() + " " + PolecenieField.getText());
           ps.execute();

        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        } finally
        {
            Ostatnie.setText(akcja + " "+ TabelaBox.getValue() + " " + PolecenieField.getText());
        }
        Error.setText("Polecenie wykonane pomyślnie: " + ps.toString());
    }
        
    
    
    @FXML
    void view_menu(ActionEvent event) {
        showOdczyt();
    }
    
    private void showInsert()
    {
        kwerendaLabel.setVisible(false);
        kwerendaField.setVisible(false);
        
        tableview.setVisible(false);
        Insertowanie.setVisible(true);
        wykonajPane.setVisible(false);
    }
    
    private void showWykonaj()
    {
        kwerendaLabel.setVisible(false);
        kwerendaField.setVisible(false);
        
        tableview.setVisible(false);
        Insertowanie.setVisible(false);
        wykonajPane.setVisible(true);
    }
    
    @FXML
    void dodawanieMenu(ActionEvent event) {
        showInsert();
    }
      
    
    
    @FXML
    void Insert_data_Pracownicy(ActionEvent event) {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO pracownicy VALUES(DEFAULT, ?, ?, ?, ?, 0 )");
           ps.setString(1, pracownicy_dane1.getText());
           ps.setString(2, pracownicy_dane11.getText());
           ps.setString(3, stanowiskoBox.getValue() );
           ps.setInt(4, Integer.parseInt(pracownicy_dane1111.getText()) );
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            pracownicy_dane1.setText("");
            pracownicy_dane11.setText("");
            pracownicy_dane1111.setText("");
        }
        Error.setText("Dane dodane pomyślnie: " + ps.toString());

    }
    
    
    @FXML
    void Pracownicy_menu_click(ActionEvent event) {
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        try
        {
            buildData("Select * from Pracownicy");
        } catch(Exception e)
        {
            System.err.println(e.getMessage());
        }
    }
    
    @FXML
    void Grafik_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_linii, czas_rozpoczecia, data";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Grafik " + c);
    }

    @FXML
    void Kierowcy_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_pracownika";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Kierowcy_czytelne " + c);
    }

    @FXML
    void Kierowcyy_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_pracownika";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Kierowcy " + c);
    }

    @FXML
    void Linie_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_linii";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Linie " + c);
    }
   
    @FXML
    void Polaczenia_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_linii, kolejnosc";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        } 
        buildData("Select * from polaczenia_przystankow_czytelne " + c);
    }
    @FXML
    void Modele_menu_click(ActionEvent event) {
        buildData("Select * from modele order by id_model");
    }

    @FXML
    void Pojazdy_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_pojazdu";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Pojazdy " + c);
    }


    @FXML
    void Przystanki_linie_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_linii, kolejnosc";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Przystanki_linie " + c);
    }

    @FXML
    void Przystanki_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_przystanku";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Przystanki " + c);
    }

    @FXML
    void Przystanki_polaczenia_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by od";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Polaczenia_przystankow " + c);
    }

    @FXML
    void Przystanki_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_linii, kolejnosc";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from przystanki_linie_czytelne " + c);
    }

    @FXML
    void Typy_polaczen_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_typu";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Typy_Polaczen " + c);
    }

    @FXML
    void Zajezdnie_menu_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_zajezdni";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from Zajezdnie " + c);
    }

    @FXML
    void pojazdy_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by id_pojazdu";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from pojazdy_czytelne " + c);
    }
    
    @FXML
    void Do_liczenia_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from do_liczenia_podrozy "+ c);
    }
    
   @FXML
    void Dodatkowe_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from polaczenia_pomocnicze " + c);
    }
    
    @FXML
    void Polaczenia_pomocnicze_widoki_click(ActionEvent event) {
        String c;
        if(kwerendaField.getText().equals(""))
            c= "order by od";
        else c = kwerendaField.getText();
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
        buildData("Select * from polaczenia_przystankow_czytelne " + c);
    }
    
    
    @FXML
    void Dodawanie_click(ActionEvent event) {
        if(builtFlag)
        {
            data.clear();
            tableview.getColumns().clear();
        }
 
        
    }
    
    
    public void buildData(String statement){

        data = FXCollections.observableArrayList();
          try{

            String SQL = statement;

            ResultSet rs = conn.createStatement().executeQuery(SQL);


            for(int i=0 ; i<rs.getMetaData().getColumnCount(); i++){

                final int j = i;                
                TableColumn col = new TableColumn<>(rs.getMetaData().getColumnName(i+1));
                col.setCellValueFactory(new Callback<TableColumn.CellDataFeatures<ObservableList,String>,ObservableValue<String>>(){   
                    @Override
                    public ObservableValue<String> call(TableColumn.CellDataFeatures<ObservableList, String> param) {                                                                                              
                       return new SimpleStringProperty(param.getValue().get(j).toString());                        
                    }                    
                });

                tableview.getColumns().addAll(col); 

            }

            while(rs.next()){
           
                try{
                ObservableList<String> row = FXCollections.observableArrayList();
                for(int i=1 ; i<=rs.getMetaData().getColumnCount(); i++){
               
                    row.add(rs.getString(i));
                }
            
                data.add(row);
                }catch(Exception e)
                {
                    System.err.println(e.getMessage());
                    Error.setText(e.getMessage());
                }
            }

            //FINALLY ADDED TO TableView
            tableview.setItems(data);
            builtFlag=true;
          }catch(SQLException e){
              Error.setText("Problem z budowaniem");             
              System.err.println(e.getMessage());
          }
      }
    


    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        ObservableList<String> Stanowiska_lista;
        ObservableList<String> Typy_lista;
        ObservableList<String> akcjeLista;
        ObservableList<String> TabelaLista;
        Stanowiska_lista = FXCollections.observableArrayList("Kierownik", "Kierowca");
        Typy_lista = FXCollections.observableArrayList("Autobusowe", "Tramwajowe", "Autobusowo-Tramwajowe");
        akcjeLista = FXCollections.observableArrayList("UPDATE", "DELETE");
        TabelaLista = FXCollections.observableArrayList("Pracownicy", "Kierowcy", "Zajezdnie", "Pojazdy", "Modele", "Grafik",
                      "Linie", "Przystanki_linie", "Przystanki", "Polaczenia_przystankow", "Typy_polaczen" );
        stanowiskoBox.setItems(Stanowiska_lista);
        polaczenia_przystankow_dane4.setItems(Typy_lista);
        AkcjaBox.setItems(akcjeLista);
        TabelaBox.setItems(TabelaLista);
        
        

    }

   

    @FXML
    void Insert_data_Modele(ActionEvent event) {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO modele VALUES(DEFAULT, ?, ?, ? )");
           ps.setString(1, modele_dane1.getText());
           ps.setString(2, modele_dane2.getText());
           ps.setString(3, modele_dane3.getText());
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            modele_dane1.setText("");
            modele_dane2.setText("");
            modele_dane3.setText("");
        }
        Error.setText("Dane dodane pomyślnie: " + ps.toString());

    }

    @FXML
    void Insert_data_Pojazdy(ActionEvent event) {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO pojazdy VALUES(DEFAULT, ?, ? )");
           ps.setInt(1, Integer.parseInt(pojazdy_dane1.getText()));
           ps.setInt(2, Integer.parseInt(pojazdy_dane2.getText()) );
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            pojazdy_dane1.setText("");
            pojazdy_dane2.setText("");
        }
        Error.setText("Dane dodane pomyślnie: " + ps.toString());
 
    }
    
    @FXML
    void Insert_data_Grafik(ActionEvent event)
    {
        PreparedStatement ps;
        String dzien = grafik_dane.getText();
        if(dzien.matches("^[0-3][0-9][.][0-1][0-9][.][0-9][0-9][0-9][0-9]"))
        {
            try{
                
                ps = Polaczenie.conn.prepareStatement("Select Generuj_grafik( CAST (N'"+ dzien +"' AS DATE) )");
                System.out.println(ps.toString());
                ps.execute();
            }		
            catch(SQLException ex){
                System.err.println(ex.getMessage());
                Error.setText(ex.getMessage());
                return;
            }finally
            {
                grafik_dane.setText("");

            }
                 Error.setText("Dane dodane pomyślnie: " + ps.toString());   
        }
        else
        {
            Error.setText("Niepoprawny format daty");
        }

        
    }
    
    
      @FXML
    void Insert_data_Linie(ActionEvent event)
    {
        PreparedStatement ps;
        String s1 = linie_dane6.getText();
        String s2 = linie_dane7.getText();
        if(s1.matches("^[0-5][0-9][:][0-5][0-9]") && s2.matches("^[0-5][0-9][:][0-5][0-9]"))
        { 
            try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO Linie VALUES(DEFAULT, ?, ?,?,?,?, ?, ?, ? )");
           ps.setInt(1, Integer.parseInt(linie_dane1.getText()));
           ps.setInt(2, Integer.parseInt(linie_dane2.getText()) );
           ps.setInt(3, Integer.parseInt(linie_dane3.getText()) );
           ps.setInt(4, Integer.parseInt(linie_dane4.getText()) );
           ps.setInt(5, Integer.parseInt(linie_dane5.getText()) );
           ps.setString(6, "(CAST N'"+ s1 +":00' AS TIME)" );
           ps.setString(7, "(CAST N'"+ s2 +":00' AS TIME)" );
           ps.setInt(8, Integer.parseInt(linie_dane8.getText()) );
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            linie_dane1.setText("");
            linie_dane2.setText("");
            linie_dane3.setText("");
            linie_dane4.setText("");
            linie_dane5.setText("");
            linie_dane6.setText("");
            linie_dane7.setText("");
            linie_dane8.setText("");
        }
                Error.setText("Dane dodane pomyślnie: " + ps.toString());
        }
        else
        {
            Error.setText("Zły format danych, popraw godzinę");
        }
        
    }
    @FXML
    void Insert_data_przystanki_linie(ActionEvent event)
    {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO modele VALUES( ?, ?, ? )");
           ps.setInt(1, Integer.parseInt(linie_przystanki_dane1.getText()));
           ps.setInt(2, Integer.parseInt(linie_przystanki_dane2.getText()));
           ps.setInt(3, Integer.parseInt(linie_przystanki_dane3.getText()));
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            linie_przystanki_dane1.setText("");
            linie_przystanki_dane2.setText("");
            linie_przystanki_dane3.setText("");
        }
                Error.setText("Dane dodane pomyślnie: " + ps.toString());
    }
    
    @FXML
    void Insert_data_Przystanki(ActionEvent event)
    {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO przystanki VALUES(DEFAULT,  ?, ? )");
           ps.setString(1, przystanki_dane1.getText());
           ps.setBoolean(2, Boolean.parseBoolean(przystanki_dane2.selectedProperty().toString() ) );
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            przystanki_dane1.setText("");
            przystanki_dane2.setText("");
        }
               Error.setText("Dane dodane pomyślnie: " + ps.toString());
    }
    
    @FXML
    void Insert_data_polaczenia_przystankow(ActionEvent event)
    {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO polaczenia_przystankow VALUES( ?, ?, ? ,? )");
           ps.setInt(1, Integer.parseInt(polaczenia_przystankow_dane1.getText()));
           ps.setInt(2, Integer.parseInt(polaczenia_przystankow_dane2.getText()));
           ps.setInt(3, Integer.parseInt(polaczenia_przystankow_dane3.getText()));
           ps.setInt(4, Integer.parseInt(polaczenia_przystankow_dane4.getValue() ));
           
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            polaczenia_przystankow_dane1.setText("");
            polaczenia_przystankow_dane2.setText("");
            polaczenia_przystankow_dane3.setText("");
        }
                Error.setText("Dane dodane pomyślnie: " + ps.toString());
        
    }
    
    @FXML
    void Insert_data_typy_polaczen(ActionEvent event)
    {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO typy_polaczen VALUES(Default,  ?  )");
           ps.setInt(1, Integer.parseInt(typy_polaczen_dane1.getText()));

           
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            typy_polaczen_dane1.setText("");
        }
                Error.setText("Dane dodane pomyślnie: " + ps.toString());
    }
    

    @FXML
    void Insert_data_Zajezdnie(ActionEvent event) {
        PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("INSERT INTO zajezdnie VALUES( DEFAULT, ? ,? )");
           ps.setString(1, zajezdnie_dane1.getText());
           ps.setInt(2, Integer.parseInt(zajezdnie_dane2.getText()));
;
           
           ps.executeUpdate();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {
            zajezdnie_dane1.setText("");
            zajezdnie_dane2.setText("");
        }
                Error.setText("Dane dodane pomyślnie: " + ps.toString());
    }


  @FXML
  private void Przydziel_pojazdy_click(ActionEvent event)
  {
      PreparedStatement ps;
        try{
           ps = Polaczenie.conn.prepareStatement("Select Przydziel_pojazdy()");

           
           ps.execute();
        }		
	catch(SQLException ex){
            System.err.println(ex.getMessage());
            Error.setText(ex.getMessage());
            return;
        }finally
        {

        }
        Error.setText("Przydzieliłem pojazdy!");
  }
 
}

  

 

  

  

 
  
