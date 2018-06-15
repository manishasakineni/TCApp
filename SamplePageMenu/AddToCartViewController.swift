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
    var AddToCart = LoginViewController()

    
     var userId :  Int = 0
    
    var allitemsArray:[GetCartListResultVO] = Array<GetCartListResultVO>()
    
    var filtered:[GetCartListResultVO] = []
    
     var deletelist:[deleteCartInfoResultVO] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.AddToCart = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.AddToCart.showNav = true
        self.AddToCart.navigationString = "AddToCart"
        
        
        
        let nibName1  = UINib(nibName: "AddToCareTableViewCell" , bundle: nil)
        addToCartTableView.register(nibName1, forCellReuseIdentifier: "AddToCareTableViewCell")
        
        addToCartTableView.dataSource = self
        addToCartTableView.delegate = self
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        getCartInfoAPIService()
        

        
        
        
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
    
  
    override func viewWillDisappear(_ animated: Bool) {
        
        Utilities.setLoginViewControllerNavBarColorInCntrWithColor(backImage: "home icon", cntr:self, titleView: nil, withText: "".localize(), backTitle: "", rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
        
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
        cell.addToCartQuantityLbl.text = "\(listStr.quantity!)"
       
        cell.addToCartPriceLbl.text = "\(listStr.price!)"
        cell.addToCartAuthorLbl.text = listStr.author
        
        
        
        cell.deleteBtn.addTarget(self, action: #selector(self.deleteAPIService(_:)), for: UIControlEvents.touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        

        return cell
        
        
        
    }
    

    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        if let navController = self.navigationController, navController.viewControllers.count >= 2 {
            if let viewController = navController.viewControllers[navController.viewControllers.count - 2] as? LoginViewController{
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                for moveToVC in viewControllers {
                    if moveToVC is HomeViewController {
                           Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "".localize(), backTitle: " " , rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
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
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
        
        print("Home Button Clicked......")
        
    }
    
    
    @IBAction func continueShopingAction(_ sender: Any) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()

        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desController = mainstoryboard.instantiateViewController(withIdentifier: "GetAllItemsViewController") as! GetAllItemsViewController
        desController.showNav = true
        let newController = UINavigationController.init(rootViewController:desController)
        revealviewcontroller.pushFrontViewController(newController, animated: true)
        
        

    }
    
    
    @IBAction func checkoutAction(_ sender: Any) {
        
        
        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
        
        
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
        
        

        
    }
    
    
    
    func getCartInfoAPIService(){
        
          self.filtered.removeAll()
        
        let strUrl = GETCARTINFOAPI  + "\(userId)"
        
        serviceController.getRequest(strURL: strUrl, success: { (result) in
            
            
            let respVO:GetCartInfoVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
  
            
        
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                for eachArray in listArr{
                    
                    self.filtered.append(eachArray)
                    print(self.filtered.count)
                }
                
                self.addToCartTableView.reloadData()
                
            }
            
        
            
            
        }) { (failureMessage) in
            
        }
        
    }
    
 
    
    
    
    
func deleteAPIService(_ sender : UIButton){
    

     let deleteAddressInfo  = filtered[sender.tag]
    
   
    
     let strUrl = DELETEFROMCARTAPI  + "\(deleteAddressInfo.id!)" + "/" + "\(userId)"
    
       serviceController.getRequest(strURL: strUrl, success: { (result) in
        
        let respVO:deleteCartInfoVO = Mapper().map(JSONObject: result)!
            
      let isSuccess = respVO.isSuccess
            
        if isSuccess == true {
                
      self.filtered.remove(at: sender.tag)
            
            self.addToCartTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
            
     
                
            }
            
        }) { (failureMessage) in
            
        }
        
    }
    
 
    
}
 


    


