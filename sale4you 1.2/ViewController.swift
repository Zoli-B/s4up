//
//  ViewController.swift
//  sale4you 1.2
//
//  Created by Balaska Zoltán on 2022. 12. 18..
//

import UIKit

class ViewController: UIViewController {
    
    

    
    
    @IBOutlet weak var LogInEmailTextF: UITextField!
    
    @IBOutlet weak var LogInPassTextF: UITextField!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.title = "Bejelentkezés"
        let appDelegate = UIApplication.shared.windows.first
        appDelegate?.overrideUserInterfaceStyle = .dark
    }

    
    @IBAction func LogInButton(_ sender: Any) {
        
        mainAPi.login(email: LogInEmailTextF.text!, password: LogInPassTextF.text!)
        
    }
}

