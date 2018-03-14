//
//  ForgotPassWordViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/13/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ForgotPassWordViewController: UIViewController {

    var appVersion          : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.forgotPassWordViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "forgot Password".localize(), backTitle: " forgot Password".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")

        
     //   self.navigationController?.navigationBar.isHidden = true
        
        //   print(showNav)
        
        
        
        //  self.navigationController?.navigationBar.isHidden = !showNav
        //    Utilities.setLoginViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " ", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
    }
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        //   navigationItem.leftBarButtonItems = []
        //   let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        
        print("Back Button Clicked......")
        
    }

}
