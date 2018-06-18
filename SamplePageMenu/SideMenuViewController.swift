//
//  SideMenuViewController.swift
//  SamplePageMenu
//
//  Created by Manoj on 09/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    
    @IBOutlet weak var chooseLanguageBtn: UIButton!

   
    
    @IBOutlet weak var headerView: UIView!
    
 //MARK: -  variable declaration
    
    var menuArray = [String]()
    let utillites =  Utilities()
    
    var userID = String()
    
    let imageView = ["category_menu","churches_menu","events_menu","author_menu1","BibleBook","BibleBook","noun_1209595_cc","careers (1)","shopping (2)","EditProfile","noun_793900_cc","noun_638526_cc"]
    

  //MARK: -   View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName2  = UINib(nibName: "menuNameTableViewCell" , bundle: nil)
        menuTableView.register(nibName2, forCellReuseIdentifier: "menuNameTableViewCell")

        self.chooseLanguageBtn.setTitle("ChooseLanguage".localize(), for: .normal)

        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        
        self.menuArray = [" All Categories".localize(),"All Churches".localize(),"Events".localize(),"Authors".localize(),"Holy Bible - Telugu".localize(),"Holy Bible - English".localize(),"Notifications".localize(),"Careers".localize(),"Online Shoping".localize(),"EditProfile".localize(),"ChangePassword".localize(),"LogOut".localize()]

        borderColor()
        
        self.headerView.backgroundColor = Utilities.appColor
        
        chooseLanguageBtn.setTitleColor(Utilities.appColor, for: .normal)
        
        chooseLanguageBtn.layer.borderColor = Utilities.bordrColor
        
        if kUserDefaults.value(forKey: kuserIdKey) as? String != nil {
            
            self.userID = (kUserDefaults.value(forKey: kuserIdKey) as? String)!
            
        }
        
        kUserDefaults.synchronize()
        
        
        print(kUserId)
        
        print(kId)
        
        
    }
    
    //MARK: -   View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.menuArray = [" All Categories".localize(),"All Churches".localize(),"Events".localize(),"Authors".localize(),"Holy Bible - Telugu".localize(),"Holy Bible - English".localize(),"Notifications".localize(),"Careers".localize(),"Online Shoping".localize(),"EditProfile".localize(),"ChangePassword".localize(),"LogOut".localize()]

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -   border Color
    
    func borderColor(){
        
        
        chooseLanguageBtn.layer.cornerRadius = 3.0
        chooseLanguageBtn.layer.shadowColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        chooseLanguageBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        chooseLanguageBtn.layer.shadowOpacity = 0.6
        chooseLanguageBtn.layer.shadowRadius = 10.0
        
        chooseLanguageBtn.layer.cornerRadius = 5.0
        chooseLanguageBtn.layer.borderWidth = 1
        chooseLanguageBtn.layer.borderColor = UIColor(red: 122.0/255.0, green: 186.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
        
        
    }
    
//MARK: -   TableView Delegate & DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    
   

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       
       
        
       return menuArray.count
        
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        if  (self.userID.isEmpty) {
        
            if indexPath.row == 9 || indexPath.row == 10 {
                
                
            
            return 0
            
            }
            
            else {
            
            return 43
                
            }
        }
        
    
        return 43
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if (self.userID.isEmpty) {
            
            if indexPath.row == 9 || indexPath.row == 10 {
                
                
                
                return 0
                
            }
                
            else {
                
                return UITableViewAutomaticDimension
                
            }
        }
        return UITableViewAutomaticDimension

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "menuNameTableViewCell")
            as!menuNameTableViewCell
        
        cell1.selectionStyle = .none
        
        if (self.userID.isEmpty) {
            
            if indexPath.row == 9 || indexPath.row == 10 {
                
              cell1.isHidden = true
             
            }
        
        }
        
        else{
        
            cell1.isHidden = false
        }
        
        if(indexPath.row == menuArray.count - 1){
            
            cell1.menuNameImg.image = UIImage(named: String(imageView[indexPath.row]))
            
              if UserDefaults.standard.value(forKey: KFirstTimeLogin) as? String == "true" {
                  cell1.menuNameLabel.text! = "LogOut".localize()
                
               
                
              }else{
                  cell1.menuNameLabel.text! = "Login".localize()
                
            }
          
        }else{
            
            cell1.menuNameImg.image = UIImage(named: String(imageView[indexPath.row]))
            
            cell1.menuNameLabel.text! = menuArray[indexPath.row]
        }
        

        return cell1
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
        
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        let cell:menuNameTableViewCell = tableView.cellForRow(at: indexPath) as!menuNameTableViewCell
        

        if cell.menuNameLabel.text == "EditProfile".localize()
        {
            if UserDefaults.standard.value(forKey: KFirstTimeLogin) as? String == "true" {

            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            
            let desController = mainstoryboard.instantiateViewController(withIdentifier: "ProfileViewController") as!ProfileViewController
            
            
            let newController = UINavigationController.init(rootViewController:desController)
            
            revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            }else{
                 utillites.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login".localize(), clickAction: {
                    
                    UserDefaults.standard.set("1", forKey: "1")
                    UserDefaults.standard.synchronize()
                    let defaults = UserDefaults.standard
                    defaults.set("false", forKey: KFirstTimeLogin)
                    UserDefaults.standard.synchronize()
                    
                    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let desController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
                    desController.showNav = true
                    let newController = UINavigationController.init(rootViewController:desController)
                    revealviewcontroller.pushFrontViewController(newController, animated: true)

                 })

                print("Cancel")
            }
        }
        else if cell.menuNameLabel.text == "ChangePassword".localize(){
        
        if UserDefaults.standard.value(forKey: KFirstTimeLogin) as? String == "true" {

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {

        let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePassWordViewController") as! ChangePassWordViewController
                
        revealviewcontroller.addChildViewController(reOrderPopOverVC)
                
        reOrderPopOverVC.view.center = CGPoint(x:UIScreen.main.bounds.size.width/2,y:UIScreen.main.bounds.size.height/1.5)
                
        revealviewcontroller.view.addSubview(reOrderPopOverVC.view)
        reOrderPopOverVC.didMove(toParentViewController: self)
        self.revealViewController().revealToggle(animated: true)
            

                
            }
        
        else {
                
        let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePassWordViewController") as! ChangePassWordViewController

                
                
        revealviewcontroller.addChildViewController(reOrderPopOverVC)
                
        reOrderPopOverVC.view.center = CGPoint(x:UIScreen.main.bounds.size.width/2,y:UIScreen.main.bounds.size.height/2)
                
        revealviewcontroller.view.addSubview(reOrderPopOverVC.view)
        reOrderPopOverVC.didMove(toParentViewController: self)
        self.revealViewController().revealToggle(animated: true)
                
            }
                
            }
            
    else  {
                
    utillites.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Please Login".localize(), clickAction: {
                    
    UserDefaults.standard.set("1", forKey: "1")
    UserDefaults.standard.synchronize()
    let defaults = UserDefaults.standard
    defaults.set("false", forKey: KFirstTimeLogin)
                    
    UserDefaults.standard.synchronize()
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
    desController.showNav = true
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
                    
        })
                
    print("Cancel")
            
            }
            
        }
        else  if cell.menuNameLabel.text == " All Categories".localize() {
            
            
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "CategoriesHomeViewController") as!CategoriesHomeViewController
    desController.showNav = true
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            
            
        }
        else  if cell.menuNameLabel.text == "All Churches".localize() {
            
            
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "ChurchDetailsViewController") as! ChurchDetailsViewController
    desController.showNav = true
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            
           
        }
            
        else  if cell.menuNameLabel.text == "Events".localize() {

    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "AllEventsAndUpComingEventsViewController") as! AllEventsAndUpComingEventsViewController
            
    desController.showNav = true
            
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            
        }
        else  if cell.menuNameLabel.text == "Authors".localize() {
            
            
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "ChurchAdminViewController") as!ChurchAdminViewController
            desController.showNav = true
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
        }
            
            
            
            
      

        else  if cell.menuNameLabel.text == "Holy Bible - Telugu".localize() {
            
            
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let booksController = mainstoryboard.instantiateViewController(withIdentifier: "BibleDetailsViewController") as! BibleDetailsViewController
            
    booksController.showNav = true
            
    booksController.LangText = "12"
            
    let newController = UINavigationController.init(rootViewController:booksController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            
        }
        else  if cell.menuNameLabel.text == "Holy Bible - English".localize() {
            
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let booksController = mainstoryboard.instantiateViewController(withIdentifier: "BibleDetailsViewController") as! BibleDetailsViewController
            
    booksController.showNav = true
            
    booksController.LangText = "11"
            
    let newController = UINavigationController.init(rootViewController:booksController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            
        }
            
        else  if cell.menuNameLabel.text == "Careers".localize() {
            
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainstoryboard.instantiateViewController(withIdentifier: "GetAllJobDetailsViewController") as! GetAllJobDetailsViewController
            
            desController.showNav = true
            
            let newController = UINavigationController.init(rootViewController:desController)
            revealviewcontroller.pushFrontViewController(newController, animated: true)
            
        }
            
        else  if cell.menuNameLabel.text == "Online Shoping".localize() {
            
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainstoryboard.instantiateViewController(withIdentifier: "GetAllItemsViewController") as! GetAllItemsViewController
            
            desController.showNav = true
            
            let newController = UINavigationController.init(rootViewController:desController)
            revealviewcontroller.pushFrontViewController(newController, animated: true)
            
        }
        else  if cell.menuNameLabel.text == "Notifications".localize() {
            
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainstoryboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
            
            desController.showNav = true
            
            let newController = UINavigationController.init(rootViewController:desController)
            revealviewcontroller.pushFrontViewController(newController, animated: true)
            
        }
            
            
            
    else  if cell.menuNameLabel.text == "LogOut".localize() {
            
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            
    UserDefaults.standard.synchronize()
            
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
    desController.showNav = true
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
                
                
        }
        else  if cell.menuNameLabel.text == "Login".localize() {
            
    let defaults = UserDefaults.standard
    defaults.set("false", forKey: KFirstTimeLogin)
    UserDefaults.standard.synchronize()
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let desController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
    desController.showNav = true
    let newController = UINavigationController.init(rootViewController:desController)
    revealviewcontroller.pushFrontViewController(newController, animated: true)
            
            
        }
        
        
        
       
    }
    
    //MARK: -   choose Language Clicked
    
    
    @IBAction func chooseLanguageClicked(_ sender: Any) {
        
        
    let actionSheet = UIAlertController(title: nil, message: "ChooseLanguage".localize(), preferredStyle: UIAlertControllerStyle.actionSheet)
    for language in Localize.availableLanguages() {
    let displayName = Localize.displayNameForLanguage(language)
            
    let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
    (alert: UIAlertAction!) -> Void in
    Localize.update(language: language)
    self.chooseLanguageBtn.setTitle("ChooseLanguage".localize(), for: .normal)
                
    self.menuArray = [" All Categories".localize(),"All Churches".localize(),"Events".localize(),"Authors".localize(),"Holy Bible - Telugu".localize(),"Holy Bible - English".localize(),"Notifications".localize(),"Careers".localize(),"Online Shoping".localize(),"EditProfile".localize(),"ChangePassword".localize(),"LogOut".localize()]
        
                self.menuTableView.reloadData()
        })
        actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localize(), style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
        self.present(actionSheet, animated: true, completion: nil)
        }
            
        else{
            
            let popup = UIPopoverController.init(contentViewController: actionSheet)
            
  popup.present(from: CGRect(x:self.chooseLanguageBtn.frame.midX - 50, y:self.chooseLanguageBtn.frame.maxY - self.chooseLanguageBtn.frame.height, width:0, height:0), in: self.chooseLanguageBtn, permittedArrowDirections: UIPopoverArrowDirection.down, animated: true)
                     
            
        }
        
        
    }
    
    
    
}
