//
//  AddToCartViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 17/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddToCartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var addToCartTableView: UITableView!
    
     var itemID:Int = 0
     var quantity = ""
    
    
     var userId :  Int = 0
    
    var allitemsArray:[GetCartListResultVO] = Array<GetCartListResultVO>()
    
    var filtered:[GetCartListResultVO] = []
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName1  = UINib(nibName: "AddToCareTableViewCell" , bundle: nil)
        addToCartTableView.register(nibName1, forCellReuseIdentifier: "AddToCareTableViewCell")
        
        addToCartTableView.dataSource = self
        addToCartTableView.delegate = self
        
        getCartInfoAPIService()
        
        
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Online Shoping", backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
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
        
        
        
   return 1
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddToCareTableViewCell", for: indexPath) as! AddToCareTableViewCell
        
        
        let listStr:GetCartListResultVO = filtered[indexPath.row]
        
        
        
        let postImgUrl = listStr.itemImage
        
        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        let url = URL(string:newString!)
        
        let dataImg = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.addToCartImage.image = UIImage(data: dataImg!)
            
        }
            
        else {
            
            cell.addToCartImage.image = #imageLiteral(resourceName: "j4")
        }
        

        
        cell.addToCartNameLbl.text = listStr.itemName
        cell.addToCartQuantityLbl.text = "\(String(describing: listStr.quantity))"
       
        cell.addToCartPriceLbl.text = "\(String(describing: listStr.price))"
        cell.addToCartAuthorLbl.text = listStr.author
        

        return cell
        
        
        
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
    
    
    
    func getCartInfoAPIService(){
        
        let strUrl = GETCARTINFOAPI  + "\(userId)"
        
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            
            
            let respVO:GetCartInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
  
            
        
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    
                    self.filtered.append(eachArray)
                }
                
                self.addToCartTableView.reloadData()
                
            }
            
        
            
            
        }) { (failureMessage) in
            
        }
        
    }
    

    
    
    
    
}


//    func addToCatrAPICall(){
//
//        let paramsDict = [ 	"id": 0,
//                           	"itemId": itemID,
//                           	"userId": 3,
//                           	"quantity": Int(quantity)!
//            
//            ] as [String : Any]
//        
//        let dictHeaders = ["":"","":""] as NSDictionary
//        
//        
//        serviceController.postRequest(strURL: ADDTOCARTAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
//            
//            print(result)
//            
//            let respVO:AddToCartVO = Mapper().map(JSONObject: result)!
//            
//            let isSuccess = respVO.isSuccess
//            print("StatusCode:\(String(describing: isSuccess))")
//            
//            
//            if isSuccess == true {
//                
//                let listArr = respVO.listResult!
//                
//                for eachArray in listArr{
//                    
//                    self.filtered.append(eachArray)
//                }
//                
//                self.addToCartTableView.reloadData()
//                
//            }
//                
//            else {
//                
//                
//                
//            }
//            
//        }) { (failureMessage) in
//            
//            
//            print(failureMessage)
//            
//        }
//    }
    
 
    


