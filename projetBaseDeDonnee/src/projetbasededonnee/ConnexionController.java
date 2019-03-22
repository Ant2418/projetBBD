/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package projetbasededonnee;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

/**
 * FXML Controller class
 *
 * @author Ludivine
 */
public class ConnexionController implements Initializable {

    @FXML
    private TextField emailTF;
    @FXML
    private PasswordField mdpPF;
    @FXML
    private Button connexionButton;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }   
    
    public void connexionButton(ActionEvent event) throws IOException
    {
        Parent ajoutParent = FXMLLoader.load(getClass().getResource("Chercheur.fxml"));
        Scene ajoutScene = new Scene(ajoutParent);
        
        //This line gets the Stage information
        Stage window = (Stage)((Node)event.getSource()).getScene().getWindow();
        
        window.setScene(ajoutScene);
        window.show();
    }
    
}
