//
//  DocViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 19/04/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class DocViewController: UIViewController,UIWebViewDelegate {
    
    var urlStr :String = ""
    
    var titleStr:String = ""
    
    var docUrl : URL = NSURL() as URL
    
    @IBOutlet weak var docWebView: UIWebView!
    
    @IBOutlet weak var noRecorsLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
         Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "\(titleStr)", backTitle: "  \(titleStr)".localize(), rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        let docUrl = NSURL(string: urlStr)
        
        if docUrl != nil {
            
            docWebView.isHidden = false
            noRecorsLabel.isHidden = true
            
            let req = URLRequest(url: docUrl! as URL)
            docWebView.delegate = self
            //here is the sole part
            docWebView.scalesPageToFit = true
            
            docWebView.contentMode = .scaleAspectFit
            
            docWebView.loadRequest(req)
        }
        else {
            
           noRecorsLabel.isHidden = false
           docWebView.isHidden = true
        }
        
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    //MARK: -    Home Left Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
        
        print("Home Button Clicked......")
        
    }
}
