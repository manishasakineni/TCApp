//
//  SettingViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/2/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    var menuArray = ["About-US","Notifications","Help"]
    
    
    
   var delegate : SttingPopOverHomeDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        settingTableView.register(UINib.init(nibName: "SettingTableViewCell", bundle: nil),
                             forCellReuseIdentifier: "SettingTableViewCell")
        
        
        
        
        // Do any additional setup after loading the view.
    }

    
    
    
    //MARK: - UITable View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let popOverTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell",
                                                                 for: indexPath) as! SettingTableViewCell
        
        popOverTableViewCell.menuTitle.text = menuArray[indexPath.row]
        
        return popOverTableViewCell
    }
    
    //MARK: - UITable View Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        let cell:SettingTableViewCell = tableView.cellForRow(at: indexPath) as!SettingTableViewCell
        
        if cell.menuTitle.text! == "About-US"
        {
            
            if let delegate = self.delegate{
                delegate.aboutUS()
            }
            
        }

        if cell.menuTitle.text! == "Notifications"
        {
            
            if let delegate = self.delegate{
                delegate.notificationClicked()
            }
            
            print("You selected cell #\(indexPath.item)!")
            
        }

        if cell.menuTitle.text! == "Help"
        {
            
            if let delegate = self.delegate{
                delegate.helpClicked()
            }

            print("You selected cell #\(indexPath.item)!")

        }
       
            
            print("You selected cell #\(indexPath.item)!")
            
        
            // handle tap events
        
           // if indexPath.item == 0 {
                
             //   let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            //    self.navigationController?.pushViewController(profileViewController, animated: true)
           // }
        
       /* if(indexPath.row == 0){
            if let delegate = self.delegate {
                delegate.addToCartClicked()
            }
        }else if(indexPath.row == 1){
            if let delegate = self.delegate {
                delegate.clearWishlistClicked()
            }
            
        }else if(indexPath.row == 2){
            if let delegate = self.delegate {
                delegate.allShareClicked()
            }
            
        }
 
 */
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
