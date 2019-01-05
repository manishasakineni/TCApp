//
//  AddToCartViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 17/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AddToCartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

//MARK:- variable declaration
    
     @IBOutlet weak var addToCartTableView  : UITableView!
     @IBOutlet weak var noitemsLbl          : UILabel!
     var itemID     :Int = 0
     var quantity        = ""
     var userId     :Int = 0
     var allitemsArray   : [GetCartListResultVO]    = Array<GetCartListResultVO>()
     var filtered        : [GetCartListResultVO]    = []
     var deletelist      : [deleteCartInfoResultVO] = []
     var AddToCart       = LoginViewController()
     var addCartCountdelegate: UpDateCartValueDelegate?
     var activeTextField = UITextField()

//MARK:-  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        activeTextField.delegate        = self
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.AddToCart = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.AddToCart.showNav = true
        self.AddToCart.navigationString = "AddToCart"
        
        //  Registering tableview cells
        
        let nibName1  = UINib(nibName: "AddToCareTableViewCell" , bundle: nil)
        addToCartTableView.register(nibName1, forCellReuseIdentifier: "AddToCareTableViewCell")
        
        // Delegate methods
        
        addToCartTableView.dataSource = self
        addToCartTableView.delegate = self
        
        if kUserDefaults.value(forKey: kIdKey) != nil {
            userId = kUserDefaults.value(forKey: kIdKey) as! Int
        }
        
        //  Calling getcartAPI Service
        getCartInfoAPIService()
        
        addToCartTableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK:-  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        noitemsLbl.isHidden = true
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Cart".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
    }
    
 //MARK:-  view Dis Will Appear 
    
    override func viewWillDisappear(_ animated: Bool) {
        
        Utilities.setLoginViewControllerNavBarColorInCntrWithColor(backImage: "homeImg", cntr:self, titleView: nil, withText: "".localize(), backTitle: "", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
    }
    
//MARK: -   TableView delegate & DataSource  methods
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddToCareTableViewCell", for: indexPath) as! AddToCareTableViewCell
        
        activeTextField          = cell.quantityField
        activeTextField.tag      = indexPath.row
        activeTextField.delegate = self
        
        let listStr    : GetCartListResultVO = filtered[indexPath.row]
        let postImgUrl = listStr.itemImage
        let newString  = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        let url        = URL(string:newString!)
        let dataImg    = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.addToCartImage.image = UIImage(data: dataImg!)
        }
        else {
            cell.addToCartImage.image = #imageLiteral(resourceName: "j4")
        }
        
        cell.addToCartNameLbl.text = listStr.itemName
        
        if listStr.quantity != nil {
            cell.quantityField.text = "\(listStr.quantity!)"
        }
        
        cell.updateBtn.tag           =  indexPath.row
        cell.addToCartPriceLbl.text  =  "\(listStr.price!)"
        cell.addToCartAuthorLbl.text =  listStr.author
        cell.deleteBtn.tag           = indexPath.row
        cell.quantityField.tag       = indexPath.row
        cell.addToCartPriceLbl.tag   = indexPath.row
        cell.totalPrice.text         = "Total Price".localize()
        
        let a:Double     =  Double(cell.quantityField.text!)!
        let b:Double     =  Double(cell.addToCartPriceLbl.text!)!
        cell.totalPriceLbl.text = "\(a * b)"
        
        cell.deleteBtn.addTarget(self, action: #selector(self.deleteAPIService(_:)), for: UIControlEvents.touchUpInside)
        cell.updateBtn.addTarget(self, action: #selector(updateBtnClicked(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
        
    }

 //MARK:- Textfield delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if #available(iOS 10.0, *) {
            textField.keyboardType = .asciiCapableNumberPad
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        activeTextField = textField
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if  updatedText.count == 1 && updatedText == "0" {
                return false
            }
        }
        let indexPath = IndexPath.init(row: activeTextField.tag, section: 0)

        if let cell = addToCartTableView.cellForRow(at: indexPath) as? AddToCareTableViewCell {

            let listStr:GetCartListResultVO = filtered[activeTextField.tag]

            var newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if newString == "0" ||  newString == "" {
                
              cell.updateBtn.isHidden = true
            }
            else{
              
                cell.updateBtn.isHidden = false
            }
       }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let indexPath = IndexPath.init(row: activeTextField.tag, section: 0)
        
        if let cell = addToCartTableView.cellForRow(at: indexPath) as? AddToCareTableViewCell {

            let listStr:GetCartListResultVO = filtered[activeTextField.tag]
            
            cell.updateBtn.isHidden = true
            
        }
    }
    
    @objc func  updateBtnClicked(_ sendre:UIButton) {
        
        let indexPath = IndexPath.init(row: sendre.tag, section: 0)
        let cartArr:GetCartListResultVO = self.filtered[indexPath.row]
        
        let id = cartArr.id
        let itemId = cartArr.itemId
        
        if let cell = addToCartTableView.cellForRow(at: indexPath) as? AddToCareTableViewCell {
            
            let quantityNum = cell.quantityField.text
            
            cell.updateBtn.isHidden = true
  
            let strUrl = UPDATECARTAPI
            
            let dictParams = [  "id": id ?? 0,
                                "itemId": itemId ?? 0,
                                "userId": self.userId,
                                "quantity": Int(quantityNum!) ?? 0
                
                            ] as [String : Any]
            
            print("dic params \(dictParams)")
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            print("dictHeader:\(dictHeaders)")
            
            if(appDelegate.checkInternetConnectivity()){
                
                serviceController.postRequest(strURL: strUrl as NSString, postParams: dictParams as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                    DispatchQueue.main.async()
                        {
                            print("\(result)")
                            
                            let respVO:UpdatedCartVo = Mapper().map(JSONObject: result)!
                            
                            print("responseString = \(respVO)")
                            
                            
                            let statusCode = respVO.isSuccess
                            print("StatusCode:\(String(describing: statusCode))")
                            
                            if statusCode == true
                            {
                                if  let successMsg = respVO.endUserMessage {
                                    print(successMsg)
                                    
                                    // get cart api calling..
                                    self.getCartInfoAPIService()
                                    
                                    self.showAlertViewWithTitle("Alert".localize(), message: successMsg, buttonTitle: "Ok".localize())
                                    
                                    return
                                }
                            }
                                
                            else {
                                
                                if  let failMsg = respVO.endUserMessage {
                                    print(failMsg)
                                    
                                    self.showAlertViewWithTitle("Alert".localize(), message: failMsg, buttonTitle: "Ok".localize())
                                    
                                    return
                                }
                            }
                            
                            print("success")
                            
                    }
                    
                }, failureHandler:  {(error) in
                    
                    print(error)
                })
                
            }
            else {
                
                return
            }
        }
        
    }
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
//MARK:-  back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        
        
        if let delegate = self.addCartCountdelegate{
            delegate.updateCountOfAddCart()
        }
        if let navController = self.navigationController, navController.viewControllers.count >= 2 {
            if let viewController = navController.viewControllers[navController.viewControllers.count - 2] as? LoginViewController{
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                for moveToVC in viewControllers {
                    if moveToVC is HomeViewController {
                           Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
                        _ = self.navigationController?.popToViewController(moveToVC, animated: true)
                    }
                }
              
            }else{
                let poppedVC = navigationController?.popViewController(animated: true)
                print(poppedVC as Any)
            }
        }
        
        
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
    
//MARK:-  continue Shoping Action
    
    @IBAction func continueShopingAction(_ sender: Any) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainstoryboard.instantiateViewController(withIdentifier: "GetAllItemsViewController") as! GetAllItemsViewController
        desController.showNav = true
        let newController = UINavigationController.init(rootViewController:desController)
        revealviewcontroller.pushFrontViewController(newController, animated: true)

    }
    
//MARK:-  check out Action
    
    @IBAction func checkoutAction(_ sender: Any) {
        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
        
    }
    
//MARK:-  get Cart Info API Service
    
    func getCartInfoAPIService(){
        
          self.filtered.removeAll()
        
            let strUrl = GETCARTINFOAPI  + "\(userId)"
        
            serviceController.getRequest(strURL: strUrl, success: { (result) in
            
                let respVO:GetCartInfoVO = Mapper().map(JSONObject: result)!
            
                let isSuccess = respVO.isSuccess
        
                if isSuccess == true {
                
                    let listArr = respVO.listResult!
                
                    if (listArr.count > 0){
                    self.noitemsLbl.isHidden = true
                        
                    for eachArray in listArr{
                        self.filtered.append(eachArray)
                        print(self.filtered.count)
                    }
                    self.addToCartTableView.reloadData()
                    
                } else {
                    self.noitemsLbl.isHidden = false
                    self.noitemsLbl.text = "Your Cart is Empty".localize()
                }
            }
  
        }) { (failureMessage) in
            
        }
        
    }
    
 
    
//MARK:-  delete API Service
    
    
func deleteAPIService(_ sender : UIButton){
    
    print(sender.tag)
    print(filtered.count)
    
     let deleteAddressInfo  = filtered[sender.tag]
    
     let strUrl = DELETEFROMCARTAPI  + "\(deleteAddressInfo.id!)" + "/" + "\(userId)"
    
     Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert".localize(), messege: "Are You Sure Want To Remove Item From Your Cart".localize(), clickAction: {
    
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            
            let respVO:deleteCartInfoVO = Mapper().map(JSONObject: result)!
            let isSuccess = respVO.isSuccess
            
            if isSuccess == true {
 
               if self.filtered.count > 0{

                 self.filtered.remove(at: sender.tag)
                 self.addToCartTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
                
                   // get cartinfo api calling
                    self.getCartInfoAPIService()
                
                   self.addToCartTableView.reloadData()

               }
                
                self.noitemsLbl.isHidden = false
                self.noitemsLbl.text = "Your Cart is Empty".localize()
                
            }

            })
        
        { (failureMessage) in
            
            print(failureMessage)
        }

        })

}
 
}
    


