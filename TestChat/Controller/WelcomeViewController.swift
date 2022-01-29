//
//  WelcomeViewController.swift
//  TestChat
//
//  Created by Dmytro on 05.01.2022.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: CLTypingLabel!
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
//        welcomeLabel.text = Constants.titleLabel
        
        navigationController?.navigationBar.barTintColor = UIColor(named: Constants.BrandColors.lighBlue)
        
        print("add newFeature")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        welcomeLabel.text = Constants.titleLabel
    }
    
    

    
    
    



}
