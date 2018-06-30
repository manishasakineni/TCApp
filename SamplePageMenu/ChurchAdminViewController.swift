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
    
//MARK: -  variable declaration
    
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
    
  //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PageIndex = 1
        totalPages = 0
        searchBar.showsCancelButton = false
        churchAdminArray.removeAll()
        
        self.getAdminDetailsAPICall(string: searchBar.text!)

        churchAdminTableView.rowHeight = UITableViewAutomaticDimension
        churchAdminTableView.estimatedRowHeight = 44

        let nibName1  = UINib(nibName: "ChurchAdminDetailCell" , bundle: nil)
        churchAdminTableView.register(nibName1, forCellReuseIdentifier: "ChurchAdminDetailCell")
        
        
     
        self.searchLabel.isHidden = true
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        searchBar.tintColor = UIColor.black
        
        searchBar.delegate = self
        
        searchBar.placeholder = " "
        searchBar.placeholder = "Search by Author Name".localize()
        
        searchBar.showsCancelButton = false
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchBar
        self.searchController.searchBar.delegate = self
        
        definesPresentationContext = true

       
    }
    
  //MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
            super.viewWillAppear(animated)

        Utilities.setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " " , rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        

        
    }
    //MARK: -  view Will DisAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        
        self.searchController.isActive = false
        
    }
    
    //MARK: -  search Bar
    
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
    //MARK: -  churchDetails TableView delegate & DataSource  methods
    
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
        
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
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

        
        }
        
        if let churchName =  listStr.churchName {
            
            cell.churchName.text = churchName
            
        }else{
            
        }
        
        if let mobileNumber =  listStr.mobileNumber {
           
        cell.mobileNumber.text =  mobileNumber
            
        }else{
            
        }
        
    if let email = listStr.email {
            
    cell.email.text = email
            
    }else{
            
    }
        
    let imgUrl = listStr.userImage
        
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
        
        if listStr.churchId != nil {
            
          self.churchId = listStr.churchId!
        }
        if listStr.Id != nil {
            
            self.authorId = listStr.Id!
        }
     
            
    if let churchAdmin =  listStr.churchAdmin {
    
        cell.adminNameLabel.text = churchAdmin
            
    }else{
                
    }
            
    if let churchName =  listStr.churchName {
   
        cell.churchName.text =  churchName
                
        }else{

    }
            
    if let mobileNumber =  listStr.mobileNumber {
    
        cell.mobileNumber.text = mobileNumber
        
    }else{
        
        }
            
    if let email = listStr.email {
  
        cell.email.text =  email
                
    }else{
                
    }
            
            
            
    let imgUrl = listStr.userImage
            
    let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
    print("filteredUrlString:\(String(describing: newString))")
            
    if newString != nil {
                
    let url = URL(string:newString!)
                
                
    let dataImg = try? Data(contentsOf: url!)
                
    if dataImg != nil {
                    
    cell.adminImageView.image = UIImage(data: dataImg!)
                    
    }else {
                    
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
        
    if churchAdminArray.count > 0 {
    let listStr:GetAllChurchAdminsResultVo = churchAdminArray[indexPath.row]
            
    let authorDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthorDetailsViewController") as! AuthorDetailsViewController
        
        if listStr.Id != nil {
            
            authorDetailsViewController.authorID = listStr.Id!
        }
        
        if listStr.churchAdmin != nil {
            
            authorDetailsViewController.churchName1 = listStr.churchAdmin!
        }
            authorDetailsViewController.isFromChruch = false
    authorDetailsViewController.isSubscribed = isSubscribed
            
    self.navigationController?.pushViewController(authorDetailsViewController, animated: true)
        }
        
    }
    
    //MARK: -  Get Admin Details API Call  
    
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
                    
        self.churchAdminTableView.reloadData()
                    
        }
        else {
                    
        self.searchLabel.isHidden = false
                    
        self.churchAdminTableView.isHidden = true
        }
            
        }
                
    else {
                
        self.searchLabel.isHidden = false
                
        self.churchAdminTableView.isHidden = true
                
            }
            
        }) { (failureMessage) in
            
            
    print(failureMessage)
            
        }
    
    }
    
 //MARK: -    Home Left Button Tapped
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
