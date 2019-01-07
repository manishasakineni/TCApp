//
//  ContactUSViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import CoreTelephony
import MessageUI


class ContactUSViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var contactNoLbl: UILabel!
    @IBOutlet weak var mailIDLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
//MARK: - Variable Declaration

    var tapGesture = UITapGestureRecognizer()
   
//MARK: - View Did Load
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(ContactUSViewController.phoneTapFunction))
        contactNoLbl.isUserInteractionEnabled = true
        contactNoLbl.addGestureRecognizer(phoneTap)
        let mailTap = UITapGestureRecognizer(target: self, action: #selector(ContactUSViewController.mailTapFunction))
        mailIDLbl.isUserInteractionEnabled = true
        mailIDLbl.addGestureRecognizer(mailTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Utilities.setSignUpViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Contact Details".localize(), backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        serviceController.getRequest(strURL: CONTACTUSAPI, success: { (result) in
            print(result)
            if result.count > 0{
                let respVO:ContactUsVO = Mapper().map(JSONObject: result)!
                self.contactNoLbl.text = respVO.contactNo
                self.mailIDLbl.text    = respVO.email!
                let address = respVO.address
                let companyName = respVO.companyName
                let landmark = respVO.landmark
                let village = respVO.village
                let mandal = respVO.mandal
                let district = respVO.district
                let state = respVO.state
                let addressStr = address! + companyName! + landmark!
                let addressStr1 = village! + mandal!
                let addressStr2 = district! + state!
                self.addressLbl.text   = addressStr + addressStr1 + addressStr2
            }
        }) { (failureMessage) in
            
        }
    }
    

//MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        appDelegate.window?.rootViewController = rootController
        print("Back Button Clicked......")
    }
    
//MARK: -    Home Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        appDelegate.window?.rootViewController = rootController
        print("Home Button Clicked......")
    }

    @objc func phoneTapFunction(sender:UITapGestureRecognizer) {
        
        print("Phonetap working")
        
        self.callToNumber(telePhoneNumber: self.contactNoLbl.text!)
    }
    
    @objc func mailTapFunction(sender:UITapGestureRecognizer){
        
        print("mailTap working")
        
        if !MFMailComposeViewController.canSendMail() {
           // Utilities.showToast(self.view, text: "Mail services are not available in your device")
            return
        }else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            
            // Configure the fields of the interface.
            composeVC.setToRecipients([self.mailIDLbl.text!])
           // composeVC.setSubject("Feedback from App")
            
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
        
        
        
    }
    
//MARK: - Call to Number
    
    func callToNumber(telePhoneNumber : String){
        
        // Making a Phone Call
        if let phoneCallURL:URL = URL(string: "tel:\(telePhoneNumber)") {
            
            let networkInfo = CTTelephonyNetworkInfo()
            let carrier: CTCarrier? = networkInfo.subscriberCellularProvider
            let code: String? = carrier?.mobileNetworkCode
            let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    
              let message = "Are you sure you want to call?".localize() +  "\n\(telePhoneNumber)?"
                    Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege:  message, clickAction: {() in
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(phoneCallURL)
                        } else {
                            UIApplication.shared.openURL(phoneCallURL)
                        }
                    })
                    
                }
        }
        else{
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Device does not support phone calls".localize(), clickAction: {
            })
        }
    }

//MARK: - Mail Compose
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

}
