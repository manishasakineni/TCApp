//
//  ForgotPassWordViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/13/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ForgotPassWordViewController: UIViewController {

    var appVersion : String = ""


//MARK: -   view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//MARK: -   view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Utilities.forgotPassWordViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "forgot Password".localize(), backTitle: " forgot Password".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
    }
    
//MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
    }
}
