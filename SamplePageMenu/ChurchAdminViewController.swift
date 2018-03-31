//
//  ChurchAdminViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 2/22/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class ChurchAdminViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating {

    @IBOutlet weak var churchAdminTableView: UITableView!
    
    @IBOutlet weak var searchLabel: UILabel!
    
//    searchLabel
    var churchAdminArray:[GetAllChurchAdminsResultVo] = Array<GetAllChurchAdminsResultVo>()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var appVersion          : String = ""
    
    var showNav = false

    
    var listResultArray = Array<Any>()
    var churchNamesArray = Array<String>()
    var churchAdminNameArray = Array<String>()
    var mobileNumberArray = Array<String>()
    var emailArray = Array<String>()

    var churchAdmin = Array<String>()
    
    
    
    
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    var churchName1 : String = ""

    var isSubscribed = Int()
    var subscribeClick = 0
    var subscribe : Bool = true

    var churchId = 0
    var authorId = 0
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var searchController: UISearchController!
    
    var searchActive : Bool = false
    
    var filteredData: [String]!
    
    var filtered:[GetAllChurchAdminsResultVo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      //  self.getAdminDetailsAPICall(string: searchBar.text!)

        
        
        churchAdminTableView.rowHeight = UITableViewAutomaticDimension
        churchAdminTableView.estimatedRowHeight = 44
        churchAdminTableView.reloadData()
        

        
        let nibName1  = UINib(nibName: "ChurchAdminDetailCell" , bundle: nil)
        churchAdminTableView.register(nibName1, forCellReuseIdentifier: "ChurchAdminDetailCell")
        
        
        Utilities.setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " " , rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        

        self.searchLabel.isHidden = true
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        searchBar.tintColor = UIColor.black
        
        searchBar.delegate = self
        
        searchBar.placeholder = "Search by Author".localize()
        
        searchBar.showsCancelButton = false
        
        //  filteredData = sectionTittles
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchBar
        self.searchController.searchBar.delegate = self
        
        definesPresentationContext = true

       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
            super.viewWillAppear(animated)

    
        
//        let backgroundImage = UIImage(named: "Church-logo")
//        let imageView = UIImageView(image: backgroundImage)
//        self.churchAdminTableView.backgroundView = imageView
        
        
        
        PageIndex = 1
        totalPages = 0
        searchBar.showsCancelButton = false
        churchAdminArray.removeAll()

         self.getAdminDetailsAPICall(string: searchBar.text!)
        

     
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
        
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
        searchActive = false
        
        PageIndex = 1
        totalPages = 0
        self.churchAdminArray.removeAll()
        self.getAdminDetailsAPICall(string: searchBar.text!)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
         searchBar.resignFirstResponder()
        
    }
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.resignFirstResponder()
        
        PageIndex = 1
        totalPages = 0
        self.churchAdminArray.removeAll()
        self.getAdminDetailsAPICall(string: searchBar.text!)
        
        self.churchAdminTableView.reloadData()
    }
    
    @objc(searchBarBookmarkButtonClicked:) func searchBarBookmarkButtonClicked(_ rchBar: UISearchBar) {
        
        searchActive = false
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
//        filtered = churchAdminArray.filter({ (text) -> Bool in
//            let tmp = text
//            let range = ((tmp.churchName?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil) || ((tmp.mobileNumber?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil) || ((tmp.churchAdmin?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)) != nil)
//            
//            return range
//        })
        
//        if searchText.characters.count == 0 {
//            searchActive = false;
//            self.churchAdminTableView.reloadData()
//            
//        } else {
//            
//        
//        self.getAdminDetailsAPICall(string: searchText)
//        
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.churchAdminTableView.reloadData()
//            
//            
//        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false
        PageIndex = 1
        totalPages = 0
        self.churchAdminArray.removeAll()
        self.getAdminDetailsAPICall(string: searchBar.text!)
        self.churchAdminTableView.reloadData()
        searchBar.resignFirstResponder()
        
        
    }

    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            
            
        } else {
            
            
            
        }
        
        
    }
      //MARK: -  churchDetailsTableView delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         if(searchActive) {
            
            return filtered.count
        }
         else {
            
            return churchAdminArray.count
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
//            
//            return 180
//            
//        }
//            
//        else {
//            
//            return 140
//            
//        }
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        if indexPath.row == churchAdminArray.count - 1 {
            
            if(self.totalPages! > PageIndex){
                
                
                PageIndex = PageIndex + 1
                
                getAdminDetailsAPICall(string: searchBar.text!)
                
                
                
            }
        }
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChurchAdminDetailCell", for: indexPath) as! ChurchAdminDetailCell
        
      if(searchActive){
        
//        cell.backgroundColor = UIColor.clear
        
//        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        
        let listStr:GetAllChurchAdminsResultVo = filtered[indexPath.row]

        
        isSubscribed = listStr.isSubscribed!
        
        
        if isSubscribed == 0{
            
            cell.subscribeButtton.setTitle("Subscribe",for: .normal)
        }
            
        else{
            
            cell.subscribeButtton.setTitle("Unsubscribe",for: .normal)
            
        }
        

        
        if let churchAdmin =  listStr.churchAdmin {
            cell.adminNameLabel.text = churchAdmin
        }else{
          //  cell.adminNameLabel.text = "Name:".localize()
        }
        
        if let churchName =  listStr.churchName {
            cell.churchName.text = churchName
        }else{
          //  cell.churchName.text = "Church Name:".localize()
        }
        
        if let mobileNumber =  listStr.mobileNumber {
            cell.mobileNumber.text =  mobileNumber
        }else{
         //   cell.mobileNumber.text = "Mobile Number:".localize()
        }
        
        if let email = listStr.email {
            cell.email.text = email
        }else{
           // cell.email.text = "Email:".localize()
        }
        
        let imgUrl = listStr.churchImage
        
        let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        
        if newString != nil {
            
            let url = URL(string:newString!)
            
            
            let dataImg = try? Data(contentsOf: url!)
            
            if dataImg != nil {
                
                cell.adminImageView.image = UIImage(data: dataImg!)
            }
            else {
                
                cell.adminImageView.image = #imageLiteral(resourceName: "j4")
            }
        }
        else {
            
            cell.adminImageView.image = #imageLiteral(resourceName: "j4")
        }
        
        return cell
        
      }
      else {
        
        if churchAdminArray.count > 0 {
          
            let listStr:GetAllChurchAdminsResultVo = churchAdminArray[indexPath.row]

            cell.subscribeButtton.tag = indexPath.row
            
            isSubscribed = listStr.isSubscribed!
            
            print(isSubscribed)
           
            
            self.churchId = listStr.churchId!
            self.authorId = listStr.Id!
            
            
            if let churchAdmin =  listStr.churchAdmin {
                cell.adminNameLabel.text = churchAdmin
            
            }else{
            }
            
            if let churchName =  listStr.churchName {
                cell.churchName.text =  churchName
                
            }else{
                //  cell.churchName.text = "Church Name:".localize()
            }
            
            if let mobileNumber =  listStr.mobileNumber {
                cell.mobileNumber.text = mobileNumber
            }else{
                //   cell.mobileNumber.text = "Mobile Number:".localize()
            }
            
            if let email = listStr.email {
                cell.email.text =  email
            }else{
                //    cell.email.text = "Email:".localize()
            }
            
            
            
            let imgUrl = listStr.churchImage
            
            let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            print("filteredUrlString:\(String(describing: newString))")
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.adminImageView.image = UIImage(data: dataImg!)
                }
                else {
                    
                    cell.adminImageView.image = #imageLiteral(resourceName: "churchLogoo")
                }
            }
            else {
                
                cell.adminImageView.image = #imageLiteral(resourceName: "churchLogoo")
            }
        }
        
       
        
        return cell
        
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let listStr:GetAllChurchAdminsResultVo = churchAdminArray[indexPath.row]
        
        let authorDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
        
        authorDetailsViewController.authorID = listStr.Id!
        
        authorDetailsViewController.churchName1 = listStr.churchName!
        
        authorDetailsViewController.isSubscribed = isSubscribed
        
        self.navigationController?.pushViewController(authorDetailsViewController, animated: true)
        

        
    }
    
    
    //MARK: -  Church Details API Call
    
//    func getChurchAdminDetailsAPICall(){
//        
//        let null = NSNull()
//        
//        let paramsDict = [ "pageIndex": PageIndex,
//                           "pageSize": 10,
//                           "uid": null,
//                           "sortbyColumnName": "UpdatedDate",
//                           "sortDirection": "desc",
//                           "searchName": ""
//                           ] as [String : Any]
//        
//        let dictHeaders = ["":"","":""] as NSDictionary
//        
//        
//        serviceController.postRequest(strURL: GETALLCHURCHEADMINS as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
//            
//            print(result)
//            
//            let respVO:GetAllChurchAdminsVo = Mapper().map(JSONObject: result)!
//            
//            
//            let isSuccess = respVO.isSuccess
//            print("StatusCode:\(String(describing: isSuccess))")
//            
//            if isSuccess == true {
//                
////                self.listResultArray = respVO.listResult!
//                
//                let listArr = respVO.listResult
//                
//                
//                if (listArr?.count)! > 0 {
//                    
//                    self.searchLabel.isHidden = true
//                    
//                    self.churchAdminTableView.isHidden = false
//                    
//                let pageCout  = (respVO.totalRecords)! / 10
//                
//                let remander = (respVO.totalRecords)! % 10
//                
//                self.totalPages = pageCout
//                
//                if remander != 0 {
//                    
//                    self.totalPages = self.totalPages! + 1
//                    
//                }
//                
//                for church in listArr!{
//                    
//                    self.churchAdminArray.append(church)
//                    
//                }
//                
//                print("churchAdminArray", self.churchAdminArray)
//                // print("churchNamesArray.Count", self.churchNamesArray.count)
//                    
//                    self.churchAdminTableView.reloadData()
//                
//                }
//                else {
//                    
//                    self.searchLabel.isHidden = false
//                    
//                     self.churchAdminTableView.isHidden = true
//                }
//                
//                
//
//                //   self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
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
    

    
    func getAdminDetailsAPICall(string:String?){
    
    
    
        let null = NSNull()
        
        let paramsDict = [ "pageIndex": PageIndex,
                           "pageSize": 10,
                           "uid": null,
                           "sortbyColumnName": "UpdatedDate",
                           "sortDirection": "desc",
                           "searchName": string!
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLCHURCHEADMINS as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:GetAllChurchAdminsVo = Mapper().map(JSONObject: result)!
            
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            
            if isSuccess == true {
                
                //                self.listResultArray = respVO.listResult!
                
                let listArr = respVO.listResult
                
                
                if (listArr?.count)! > 0 {
                    
                    self.searchLabel.isHidden = true
                    
                    self.churchAdminTableView.isHidden = false
                    
                    for church in listArr!{
                        
                        self.churchAdminArray.append(church)
                        
                    }

                    let pageCout  = (respVO.totalRecords)! / 10
                    
                    let remander = (respVO.totalRecords)! % 10
                    
                    self.totalPages = pageCout
                    
                    if remander != 0 {
                        
                        self.totalPages = self.totalPages! + 1
                        
                    }
                    
                    
                    print("churchAdminArray", self.churchAdminArray)
                    // print("churchNamesArray.Count", self.churchNamesArray.count)
                    
                    self.churchAdminTableView.reloadData()
                    
                }
                else {
                    
                    self.searchLabel.isHidden = false
                    
                    self.churchAdminTableView.isHidden = true
                }
                
                
                
                //   self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                
            }
                
            else {
                
                self.searchLabel.isHidden = false
                
                self.churchAdminTableView.isHidden = true
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    
    
    
    }
    
    
    
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
//
//        UserDefaults.standard.set("1", forKey: "1")
//      //  UserDefaults.standard.removeObject(forKey: "1")
//        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
//        UserDefaults.standard.synchronize()
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)

        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()

        self.navigationController?.popViewController(animated: true)

        
        //let categoriesHomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
       // self.navigationController?.popViewController(animated: true)

        
        
                let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
                appDelegate.window?.rootViewController = rootController
                

        
         print("Back Button Clicked......")
        
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
