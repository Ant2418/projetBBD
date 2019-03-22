/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package projetbasededonnee;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

/**
 * FXML Controller class
 *
 * @author Antoine
 */
public class AcceuilChercheurController implements Initializable {

    @FXML
    private VBox menuVBox;
    @FXML
    private ImageView deconnexionIV;
    @FXML
    private ImageView home;
    @FXML
    private ImageView newExp;
    @FXML
    private AnchorPane homePageChercheur;
    @FXML
    private VBox titleAcceuil;
    @FXML
    private TableColumn<?, ?> numExpCol;
    @FXML
    private TableColumn<?, ?> nomExpCol;
    @FXML
    private TableColumn<?, ?> etatCol;
    @FXML
    private TableColumn<?, ?> labCol;
    @FXML
    private TableColumn<?, ?> typeExpCol;
    @FXML
    private TableColumn<?, ?> TypeAnaCol;
    @FXML
    private TableColumn<?, ?> nupletCol;
    @FXML
    private TableColumn<?, ?> puitCol;
    @FXML
    private TableColumn<?, ?> dateCol;
    @FXML
    private TableColumn<?, ?> debCol;
    @FXML
    private TableColumn<?, ?> finCol;
    @FXML
    private AnchorPane ajoutExpPage;
    @FXML
    private Label AddExpLabel;
    @FXML
    private ComboBox<?> PlaqueCombo;
    @FXML
    private TextField dureeTextfield;
    @FXML
    private RadioButton NonSuiviButton;
    @FXML
    private RadioButton OuiSuiviButton;
    @FXML
    private Label FreqLabel;
    @FXML
    private TextField frequTextField;
    @FXML
    private TextField puitReplicatTextField;
    @FXML
    private ComboBox<?> TypeExpCombo;
    @FXML
    private ComboBox<?> TypeAnalyseCombo;
    @FXML
    private TextField Alpha1TextField;
    @FXML
    private TextField Alpha2TextField;
    @FXML
    private TextField Alpha3TextField;
    @FXML
    private AnchorPane AddUpletPage;
    @FXML
    private VBox titleAcceuil1;
    @FXML
    private ImageView validerIV;
    @FXML
    private Label typePlaqueLabel;
    @FXML
    private Label dureeLabel;
    @FXML
    private Label suiviLabel;
    @FXML
    private Label frequenceLabel;
    @FXML
    private Label nbPuitReplicatLabel;
    @FXML
    private Label typeExpLabel;
    @FXML
    private Label typeAnaLabel;
    @FXML
    private Label alpha1Label;
    @FXML
    private Label alpha2Label;
    @FXML
    private Label alpha3Label;
    @FXML
    private Label debutExpLabel;
    @FXML
    private TableView<?> tableNUplet;
    @FXML
    private TableColumn<?, ?> replicatCol;
    @FXML
    private TableColumn<?, ?> agentBioCol;
    @FXML
    private TableColumn<?, ?> qteAgentBioCol;
    @FXML
    private TableColumn<?, ?> typeCellCol;
    @FXML
    private TableColumn<?, ?> qteCellCol;
    @FXML
    private TableColumn<?, ?> plaqueCol;
    @FXML
    private TableColumn<?, ?> photometreCol;
    @FXML
    private ImageView resuserIV;
    @FXML
    private ImageView validerIV11;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        homePageChercheur.setVisible(true);
        ajoutExpPage.setVisible(false); 
        AddUpletPage.setVisible(false);
    }    
    
    //Quand on clique sur l'image deconnection, on affiche la scène connexion
        //Ajout mouseClicked sur l'image deconnexion
       //deconnexionIV.setOnMouseClicked(new EventHandler<MouseEvent>() {

    @FXML
        public void deconnexionEvent(MouseEvent event) throws IOException
        {
        Parent ajoutParent = FXMLLoader.load(getClass().getResource("connexion.fxml"));
        Scene ajoutSceneConn = new Scene(ajoutParent);
        
        //This line gets the Stage information
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
        
        
        window.setScene(ajoutSceneConn);
        window.show();
        }
        
        //Quand on clique sur l'image d'accueil
    @FXML
        public void homeEvent(MouseEvent event) throws IOException
        {
            homePageChercheur.setVisible(true);
            ajoutExpPage.setVisible(false); 
            AddUpletPage.setVisible(false);
        } 
        
         //Quand on clique sur l'image 
    @FXML
        public void AddExpEvent(MouseEvent event) throws IOException
        {
            homePageChercheur.setVisible(false);
            ajoutExpPage.setVisible(true); 
            AddUpletPage.setVisible(false);
        } 
}
