//
//  GetAllItemsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class GetAllItemsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var getAllitemsTableView: UITableView!
    
    var showNav = false
     var appVersion          : String = ""
    
   
    
     var allitemsArray:[GetAllitemsListResultVO] = Array<GetAllitemsListResultVO>()
    
     var filtered:[GetAllitemsListResultVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName1  = UINib(nibName: "GetAllItemsTableViewCell" , bundle: nil)
        getAllitemsTableView.register(nibName1, forCellReuseIdentifier: "GetAllItemsTableViewCell")
        
       getAllitemsTableView.dataSource = self
        getAllitemsTableView.delegate = self
        
        getallitemsAPICall()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Online Shoping".localize(), backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    
    
    
    
//MARK: -  churchDetails TableView delegate & DataSource  methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
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
        
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetAllItemsTableViewCell", for: indexPath) as! GetAllItemsTableViewCell
        
        
        let listStr:GetAllitemsListResultVO = filtered[indexPath.row]
        
        cell.allitemsLabel.text = listStr.name
        
         cell.allitemsDescLabel.text = listStr.desc
         cell.allitemsauthorLabel.text = listStr.author
        
         cell.allitemsPriceLabel.text = "\(listStr.price!)"
        
    
        
        let postImgUrl = listStr.itemImage
        
        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        let url = URL(string:newString!)
        
        let dataImg = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.allitemsImage.image = UIImage(data: dataImg!)
            
        }
            
        else {
            
            cell.allitemsImage.image = #imageLiteral(resourceName: "j4")
        }
        
        
        
  
               
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if filtered.count > 0 {
            
            let listStr:GetAllitemsListResultVO = filtered[indexPath.row]
            
        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllItemsIDViewController") as! AllItemsIDViewController
        
           jobIDViewController.itemID = listStr.id!
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
      
      
            

        
    }
        
    }
  
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
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
    

    
    func getallitemsAPICall(){
        
        let paramsDict = [ 	"userId": "",
                           	"pageIndex": 1,
                           	"pageSize": 100,
                           	"sortbyColumnName": "UpdatedDate",
                           	"sortDirection": "desc",
                           	"searchName": ""
            
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLITEMSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:GetAllitemsVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    self.filtered.append(eachArray)
                }
                
                self.getAllitemsTableView.reloadData()
                
            }
                
            else {
                
                
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    

    
    
}
