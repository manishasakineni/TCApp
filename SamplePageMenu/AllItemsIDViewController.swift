//
//  AllItemsIDViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AllItemsIDViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var allitemsIDTableView: UITableView!
    
    var appVersion          : String = ""

    var churchID:Int = 0
    
    var allitemsArray:[AllItemIdListResultVO] = Array<AllItemIdListResultVO>()
    
    var filtered:[AllItemIdListResultVO] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allitemsIDTableView.delegate = self
        allitemsIDTableView.dataSource = self
        
      allitemsIDAPIService()
        
        
        let nibName1  = UINib(nibName: "AllitemIDTableViewCell" , bundle: nil)
        allitemsIDTableView.register(nibName1, forCellReuseIdentifier: "AllitemIDTableViewCell")
        
        let nibName2  = UINib(nibName: "AllitemIdDetailsTableViewCell" , bundle: nil)
        allitemsIDTableView.register(nibName2, forCellReuseIdentifier: "AllitemIdDetailsTableViewCell")
        
              // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Careers", backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        

        
    }
    
    
    
    
    //MARK: -  churchDetails TableView delegate & DataSource  methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filtered.count > 0 {
            
            return filtered.count
            
        }
        
        return allitemsArray.count
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 200
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      if indexPath.section == 0 {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllitemIDTableViewCell", for: indexPath) as! AllitemIDTableViewCell
        
        
        let listStr:AllItemIdListResultVO = filtered[indexPath.row]
        
 
        let postImgUrl = listStr.itemImage
        
        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        let url = URL(string:newString!)
        
        let dataImg = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.allitemIdImage.image = UIImage(data: dataImg!)
            
        }
            
        else {
            
            cell.allitemIdImage.image = #imageLiteral(resourceName: "j4")
        }
        
        
    
        
        
        return cell
        
        }
        
      else  if indexPath.section == 1 {

        let cell = tableView.dequeueReusableCell(withIdentifier: "AllitemIdDetailsTableViewCell", for: indexPath) as! AllitemIdDetailsTableViewCell
        
        
        let listStr:AllItemIdListResultVO = filtered[indexPath.row]
        
         cell.nameLabel.text = listStr.name
         cell.priceLabel.text = "\(String(describing: listStr.price))"
         cell.authorLabel.text = listStr.author
        cell.isactiveLabel.text = listStr.isActive == true ? "InStock" : "Out Of Stock"
        
        return cell
        
        }
        return UITableViewCell()
        
    }


    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        
       
        
        
        print("Back Button Clicked......")
        
    }
    
    
    //MARK: -    Home Button Tapped
    
    
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
    
    func allitemsIDAPIService(){
        
        

        
        let strUrl = ALLITEMSIDAPI  + "\(churchID)" + "/0"
        
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            
            
            let respVO:AllItemIdVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
 
          
   
                
               
                
                if isSuccess == true {
                    
                    let listArr = respVO.listResult!
                    
                    for eachArray in listArr{
                        self.filtered.append(eachArray)
                    }
                
                }
            
            
            self.allitemsIDTableView.reloadData()
            
            
        }) { (failureMessage) in
            
        }
        
    }
    
    
    


   

}
