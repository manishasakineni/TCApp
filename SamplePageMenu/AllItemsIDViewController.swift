//
//  AllItemsIDViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


protocol UpDateCartValueDelegate {
    func updateCountOfAddCart()
}


class AllItemsIDViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UpDateCartValueDelegate {
   
    
 let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var allitemsIDTableView: UITableView!
    
    @IBOutlet weak var quantityTF: UITextField!
   
//MARK:- variable declaration
    
    var appVersion      = ""
    var itemID:Int      = 0
    var churchName1     = ""
    let utillites       =  Utilities()
    var activeTextField = UITextField()
    var alertTag        = Int()
    var userId :  Int   = 0
    var allitemsArray   :   [AllItemIdListResultVO] = Array<AllItemIdListResultVO>()
    var filtered        :   [AllItemIdListResultVO] = []
    var quantity        = ""
    var email : String? = ""
    var previousQuantity     = 0
    var previousQuantityArry = Array<Int>()
    var totalCount : Int     = 0
    var totalQuantityCount : Int = 0
    
//MARK:-  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        allitemsIDTableView.delegate   = self
        allitemsIDTableView.dataSource = self
        quantityTF.delegate            = self
        quantityTF.keyboardType        = .numberPad
        quantityTF.maxLengthTextField  = 3
        
        if kUserDefaults.value(forKey: kIdKey) != nil {
            userId = kUserDefaults.value(forKey: kIdKey) as! Int
        }
      // All items api calling
        
        allitemsIDAPIService()
      
      // Restring tableview cells
        
        let nibName1  = UINib(nibName: "AllitemIDTableViewCell" , bundle: nil)
        allitemsIDTableView.register(nibName1, forCellReuseIdentifier: "AllitemIDTableViewCell")
        
        let nibName2  = UINib(nibName: "AllitemIdDetailsTableViewCell" , bundle: nil)
        allitemsIDTableView.register(nibName2, forCellReuseIdentifier: "AllitemIdDetailsTableViewCell")
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK:-  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: churchName1, backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
    
        quantityTF.text = ""
        
    }
    
    func updateCountOfAddCart() {
         self.previousQuantityArry.removeAll()
         self.filtered.removeAll()
         self.allitemsArray.removeAll()
         allitemsIDAPIService()
         allitemsIDTableView.reloadData()
    }
    
//MARK:-  Textfield Delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if activeTextField.tag == 0 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode    = .never
            textField.maxLengthTextField = 2
            
            if #available(iOS 10.0, *) {
                textField.keyboardType = .asciiCapableNumberPad
            }
        }
    
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        activeTextField = textField
        
        if(textField == quantityTF) {
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                if updatedText.count == 1 && updatedText == "0" {
                    return false
                }
            }
        }
        return true
        
    }
    
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
        
         cell.itemName.text      = listStr.name
         cell.priceLabel.text    = "\(listStr.price!)"
         cell.sellerInfoLbl.text = listStr.author
         cell.authorLabel.text   = listStr.desc
         cell.isactiveLabel.text = listStr.isActive == true ? "InStock".localize() : "Out Of Stock".localize()
        
        return cell
        
        }
        return UITableViewCell()
                                       
    }

    
//MARK:-  back Left Button Tapped
    

    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
        
    }
    
    
 //MARK: -    Home Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        appDelegate.window?.rootViewController = rootController
    
        print("Home Button Clicked......")
        
    }
    
//MARK:-  all items ID API Service
    
    func allitemsIDAPIService(){
        
        self.previousQuantityArry.removeAll()
        
        let strUrl = ALLITEMSIDAPI  + "\(itemID)" + "/" + "\(userId)"
        
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            let respVO:AllItemIdVO = Mapper().map(JSONObject: result)!
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
                if isSuccess == true {
                    
                    let listArr = respVO.listResult!
                    
                    for eachArray in listArr{
                        self.filtered.append(eachArray)
                    
                    }
                    if listArr[0].quantity != nil {
                        self.previousQuantity = listArr[0].quantity!
                        print("previousQuantity",self.previousQuantity)
                    }
                    self.allitemsIDTableView.reloadData()
                
                }
            
            self.allitemsIDTableView.reloadData()
            
            
        }) { (failureMessage) in
            
            print(failureMessage)
            
        }
         self.allitemsIDTableView.reloadData()
    }
    
  
 //MARK:-  add To Cart Action
    
    @IBAction func addToCartAction(_ sender: Any) {

        print("previousQuantity",previousQuantity)
        print("newQuantity",quantity)
        
        if quantity != "" {
            totalQuantityCount = previousQuantity + Int(quantity)!
            print("totalQuantityCount",totalQuantityCount)
        }else {
            quantity = ""
        }
      
        if totalQuantityCount <= 99 {

            allitemsIDTableView.endEditing(true)
            
            if(quantity != "" && quantity != "0"){
                
                // AddToCart API = ADDTOCARTAPI calling
                
                let paramsDict = [     "id": 0,
                                       "itemId": itemID,
                                       "userId": userId,
                                       "quantity": quantity
                    
                    ] as [String : Any]
                
                let dictHeaders = ["":"","":""] as NSDictionary
                
                
                serviceController.postRequest(strURL: ADDTOCARTAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                    
                    print(result)
                    
                    let respVO:AddToCartVO = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    print("StatusCode:\(String(describing: isSuccess))")
                    
                    
                    if isSuccess == true {
                        
                        let successMsg = respVO.endUserMessage
                        
                        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddToCartViewController") as! AddToCartViewController
                        jobIDViewController.addCartCountdelegate = self
                        
                        self.navigationController?.pushViewController(jobIDViewController, animated: true)
                        self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                        
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
        }else{
            
             appDelegate.window?.makeToast(kAddCartQuantity, duration:kToastDuration, position:CSToastPositionCenter)
             print("requied 99 only")
        }
      
        self.allitemsIDTableView.reloadData()
    }
   
 

}
