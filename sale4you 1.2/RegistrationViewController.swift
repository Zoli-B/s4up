//
//  RegistrationViewController.swift
//  sale4you 1.2
//
//  Created by Balaska Zoltán on 2022. 12. 20..
//

import UIKit





class RegistrationViewController: UIViewController {
    
    
    
    

    
    
    @IBOutlet weak var RegFirstNField: UITextField!
    
    @IBOutlet weak var RegLastNField: UITextField!
    
    @IBOutlet weak var RegEmailField: UITextField!
    
    @IBOutlet weak var RegPassField: UITextField!
    
    @IBOutlet weak var RegPassAgainField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Regisztráció"
        
        
    }
    
    
    @IBAction func RegButton(_ sender: Any) {
        
        if RegPassField.text != RegPassAgainField.text{
            RegPassAgainField.text = ""
            RegPassAgainField.placeholder = "Nem megeggyező jelszavak"
            return
        }
        
                
        mainAPi.apiCallCustomerReg(firstname: RegFirstNField.text!, lastname: RegLastNField.text!, password: RegPassField.text!, email: RegEmailField.text!)
        

        
    }
    
}
