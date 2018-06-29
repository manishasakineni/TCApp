//
//  AllItemsIDViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AllItemsIDViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var allitemsIDTableView: UITableView!
    
    @IBOutlet weak var quantityTF: UITextField!
    
    var appVersion          : String = ""

    var itemID:Int = 0
    
     var churchName1 : String = ""
    
      let utillites =  Utilities()
    var activeTextField = UITextField()
     var alertTag = Int()
    var userId :  Int = 0
    
    var allitemsArray:[AllItemIdListResultVO] = Array<AllItemIdListResultVO>()
    
    var filtered:[AllItemIdListResultVO] = []
    
    var quantity = ""
     var email : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allitemsIDTableView.delegate = self
        allitemsIDTableView.dataSource = self
        quantityTF.delegate = self
        quantityTF.keyboardType = .numberPad
      quantityTF.maxLengthTextField = 3
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
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
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: churchName1, backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
        

        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        if activeTextField.tag == 0 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .numberPad
        }
    
    }
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        activeTextField = textField
        
        return true
        
    }
    //MARK:- textField Should Should End Editing
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        
        
        if let newRegCell : JobApplyTableViewCell = textField.superview?.superview as? JobApplyTableViewCell {
            
            
            
        }
        return true
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        
        if activeTextField.tag == 0{
            
             quantity = textField.text!
            
        }
    }
    
//MARK: -  TableView delegate & DataSource  methods
    
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
        
        
        
      //   cell.nameLabel.text = listStr.name
        
        cell.itemName.text = listStr.name
        
         cell.priceLabel.text = "\(listStr.price!)"
         cell.sellerInfoLbl.text = listStr.author
        
         cell.authorLabel.text = listStr.desc
        
        
        
        cell.isactiveLabel.text = listStr.isActive == true ? "InStock".localize() : "Out Of Stock".localize()
        
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
        
        

        
        let strUrl = ALLITEMSIDAPI  + "\(itemID)" + "/0"
        
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
    
    
    @IBAction func addToCartAction(_ sender: Any) {
        
        
        
        
        allitemsIDTableView.endEditing(true)
        
        if(quantity != "" && quantity != "0"){
            
 // AddToCart API
            
                let paramsDict = [ 	"id": 0,
                                   	"itemId": itemID,
                                   	"userId": userId,
                                   	"quantity": Int(quantity)!
                    
                    ] as [String : Any]
                
                let dictHeaders = ["":"","":""] as NSDictionary
                
                
                serviceController.postRequest(strURL: ADDTOCARTAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                    
                    print(result)
                    
                    let respVO:AddToCartVO = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    print("StatusCode:\(String(describing: isSuccess))")
                    
                    
            if isSuccess == true {
                        
            let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
                        
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
                        

                        
                    }
                
                        
                    else {
                        
                            
                    }
                    
                }) { (failureMessage) in
                    
                    
                    print(failureMessage)
                    
                }
            
        }else{
            
            
            Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: "Message".localize(), messege: "Please Enter Quantity".localize(), clickAction: {
                
                
            })
            
            print("Please enter valid quantity")
            
        }

    }
   
 

}
