//
//  UserManualViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 14/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class UserManualViewController: UIViewController,UIWebViewDelegate {
    
    var serviceController = ServiceController()
    
    @IBOutlet weak var webView: UIWebView!
    var showNav = false

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.delegate = self
        // Do any additional setup after loading the view, typically from a nib. UserManualIOS
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Help".localize(), backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
//        if let url = Bundle.main.path(forResource: "SwiftLanguage", ofType: "pdf"){
//
//
//            print(url)
//
//            let targetURL: NSURL = NSURL.fileURL(withPath: url) as NSURL
//            let request: NSURLRequest = NSURLRequest(url: targetURL as URL)
//
//            webView.loadRequest(request as URLRequest)
//            webView.frame = view.frame
//
//            view.addSubview(webView)
//
//
//        }
        
        // Direct PDF URL : http://183.82.111.111/TeluguChurches/TChurchesRepository/FileRepository/UserManuals/IOSManual.pdf
      
      self.getHelpPDFfromServer()
        
    }
    
    func getHelpPDFfromServer()  {
        
        serviceController.getRequest(strURL: HELPPDFURL, success: { (result) in
            
            print(result)
            
            if result.count > 0 {
                
             let respVO:getHelpPdf = Mapper().map(JSONObject: result)!
               
                 let isSuccess = respVO.isSuccess
                
                     if isSuccess == true{
                        
                        let helpPdfUrl = respVO.result
                        let url: URL! = URL(string: helpPdfUrl!)
                        self.webView.loadRequest(URLRequest(url: url))
                        self.webView.frame = self.view.bounds
                        self.view.addSubview(self.webView)
                        
                }
                
            }
            
        }) { (failureMessage) in
            
            
        }
        
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        serviceController.showLoadingHUD(to_view: appDelegate.window!)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        serviceController.hideLoadingHUD(for_view: appDelegate.window!)
    }
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
//        UserDefaults.standard.set("1", forKey: "1")
//        UserDefaults.standard.synchronize()
//        UserDefaults.standard.removeObject(forKey: "1")
//        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        print("Back Button Clicked......")
        
    }
    
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
