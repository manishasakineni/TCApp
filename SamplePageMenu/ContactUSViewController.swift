//
//  ContactUSViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class ContactUSViewController: UIViewController {
    
    
    @IBOutlet weak var contactNoLbl: UILabel!
    
    @IBOutlet weak var mailIDLbl: UILabel!
    
    
    @IBOutlet weak var addressLbl: UILabel!
    
    
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
        
        Utilities.setSignUpViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Contact Details".localize(), backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        serviceController.getRequest(strURL: CONTACTUSAPI, success: { (result) in
            
            print(result)
            
            if result.count > 0{
                
             let respVO:ContactUsVO = Mapper().map(JSONObject: result)!
                
                self.contactNoLbl.text = respVO.contactNo
                self.mailIDLbl.text    = respVO.email
                
                
                let address = respVO.address
                let companyName = respVO.companyName
                let landmark = respVO.landmark
                let village = respVO.village
                let mandal = respVO.mandal
                let district = respVO.district
                let state = respVO.state
                
                let addressStr = address! + "," + companyName! + "," + landmark!
                let addressStr1 = village! + "," + mandal!
                let addressStr2 = district! + "," + state!
                self.addressLbl.text   = addressStr + "," + addressStr1 + "," + addressStr2


                
                
            }
            
        }) { (failureMessage) in
            
            
        }
    }
    

    //MARK: -    Back Left Button Tapped
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
//        UserDefaults.standard.removeObject(forKey: "1")
//        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
//        UserDefaults.standard.set("1", forKey: "1")
//        UserDefaults.standard.synchronize()
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        print("Back Button Clicked......")
        
    }
    
    //MARK: -    Home Button Tapped
    
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        
//        UserDefaults.standard.removeObject(forKey: "1")
//        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
//        UserDefaults.standard.set("1", forKey: "1")
//        UserDefaults.standard.synchronize()
//        self.navigationController?.popViewController(animated: true)
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        print("Home Button Clicked......")
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
