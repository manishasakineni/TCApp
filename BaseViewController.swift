//
//  BaseViewController.swift
//  Telugu Churches
//
//  Created by Mac OS on 29/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    
    
    var appDelegate = AppDelegate()
    let sharedController = ServiceController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // BYE
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        
        
        
        // Do any additional setup after loading the view.
    }
    
    
  
    
    // MARK: -
    
    func showAlertView1WithTitle(_ title:String,message:String,buttonTitle:String)
    {
        
        let alertController = UIAlertController(title: "", message: "" , preferredStyle: UIAlertControllerStyle.alert)
        
        let DestructiveAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(DestructiveAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
    func showAlertViewWithTitleAndButtons(_ title:String,message:String,arrButtons:
        
        NSArray,delegate:AnyObject)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.delegate=delegate
        for  buttonTitle in arrButtons
        {
            alertView.addButton(withTitle: buttonTitle as! String)
        }
        alertView.show()
    }
    
    
 
    
}



 

extension BaseViewController{
    
    
}
   
