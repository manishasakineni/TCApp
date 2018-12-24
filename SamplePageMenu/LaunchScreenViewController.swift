//
//  ViewController.swift
//  LunchingScreen
//
//  Created by Mac OS on 24/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var quotationLabel: UILabel!
   
     var messge  : String = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
  //MARK: -   View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    quotationLabel.animate(newText:"The first paragraph of the body should contain the strongest argument, most significant example, cleverest illustration, or an obvious beginning point.", characterDelay: 0.1)

        
    // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -    skip Clicked

    @IBAction func skipClicked(_ sender: Any) {
        
        
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let desController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
        
        desController.showNav = false
        
        let newController = UINavigationController.init(rootViewController:desController)
        let LoginNav : UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootloginVC") as! UINavigationController
        
        appDelegate.window?.rootViewController = newController
        
        
        
    }
    
    
    
    
    func getsplashmsgAPICall() {
        
        serviceController.getRequest(strURL: GETSPLASHMSGAPI , success: { (result) in
            
            
            let respVO:splashmsgInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.result!
               
                
//                for eachArray in listArr{
//                    
//                    
//                    if(self.messge == eachArray.desc!){
//                        let countryID = eachArray.Id!
//                        
//                    }
//                    
//                }
                
            }
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    

    

}


    
