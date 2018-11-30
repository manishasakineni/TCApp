//
//  GetAllItemsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 16/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class GetAllItemsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating {

    
    @IBOutlet weak var getAllitemsTableView: UITableView!
    
    @IBOutlet weak var norecordsFoundLbl: UILabel!
 
     //MARK:- variable declaration
    
    var showNav = false
    var appVersion          : String = ""
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var searchController: UISearchController!
    var searchActive : Bool = false
    var searchTextStr:String = ""
    
    var uid : Int = 0
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    var sortbyColumnName : String = ""
    var allitemsArray:[GetAllitemsListResultVO] = Array<GetAllitemsListResultVO>()
    var filtered:[GetAllitemsListResultVO] = []

    //MARK: -  View Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
      self.norecordsFoundLbl.isHidden = true
        
        
        let nibName1  = UINib(nibName: "GetAllItemsTableViewCell" , bundle: nil)
        getAllitemsTableView.register(nibName1, forCellReuseIdentifier: "GetAllItemsTableViewCell")
        
        getAllitemsTableView.dataSource = self
        getAllitemsTableView.delegate = self
        
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.tintColor = UIColor.black
        searchBar.delegate = self
        searchBar.placeholder = "Search".localize()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.titleView = searchBar

        self.navigationController?.isNavigationBarHidden = false
        self.searchController.searchBar.delegate = self
        definesPresentationContext = true

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -  View will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuDetailViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " ", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
      
        searchBar.text = ""
        PageIndex = 1
        totalPages = 0
        self.allitemsArray.removeAll()
        self.getallitemsAPICall(string: searchBar.text!)
        
        if #available(iOS 11.0, *) {
            
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
        
    }
    
//MARK: -  View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        
       getAllitemsTableView.isHidden = false
        
    }
    
//MARK: -  View Will DisAppear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
        self.searchController.isActive = false
        
    }
    
//MARK: -  Search function
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
        searchActive = false
        PageIndex = 1
        totalPages = 0
        setSearchButtonText(text: "Cancel".localize(), searchBar: searchBar)
        self.allitemsArray.removeAll()
        self.getallitemsAPICall(string: searchBar.text!)
        
    }
    
    func setSearchButtonText(text:String,searchBar:UISearchBar) {
        
        for subview in searchBar.subviews {
            for innerSubViews in subview.subviews {
                if let cancelButton = innerSubViews as? UIButton {
                    cancelButton.setTitleColor(UIColor.white, for: .normal)
                    cancelButton.setTitle(text, for: .normal)
                }
            }
        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false
        searchBar.resignFirstResponder()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        PageIndex = 1
        totalPages = 0
        self.allitemsArray.removeAll()
        self.getallitemsAPICall(string: searchBar.text!)
    
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        
        self.getAllitemsTableView.reloadData()
        searchBar.resignFirstResponder()
        
    }
    
    @objc(searchBarBookmarkButtonClicked:) func searchBarBookmarkButtonClicked(_ rchBar: UISearchBar) {
        searchActive = false
        
        print(sortbyColumnName)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchActive = false
        searchBar.resignFirstResponder()
        
        PageIndex = 1
        totalPages = 0
        
        self.allitemsArray.removeAll()
        self.getallitemsAPICall(string: searchBar.text!)
        self.getAllitemsTableView.reloadData()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            
            sortbyColumnName = ""
            
        } else {
            
            sortbyColumnName = searchController.searchBar.text!
            
        }
        
    }
    
   
    
    
//MARK: -  churchDetails TableView delegate & DataSource  methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    if(searchActive) {
            
        if filtered.count > 0 {
                
        return filtered.count
                
        }
    else {
                
        return 0
            
        }
    }
    else {
            
        if allitemsArray.count > 0 {
                
        return allitemsArray.count
                
        }
        else {
                
        return 0
            
            }
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == (allitemsArray.count) - 1 {
            
            if(self.totalPages! > PageIndex){
                
                PageIndex = PageIndex + 1
                
                print("page indexxx -->> %@",PageIndex)
                
                self.getallitemsAPICall(string: searchBar.text!)
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetAllItemsTableViewCell", for: indexPath) as! GetAllItemsTableViewCell
        
        if(searchActive){
            
            if filtered.count > 0 {
        
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
            
        }
        
        }
        else {
            
            if allitemsArray.count > 0 {

            let listStr:GetAllitemsListResultVO = allitemsArray[indexPath.row]
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
                
            }
            
        }
  
               
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if filtered.count > 0 {
            
            let listStr:GetAllitemsListResultVO = filtered[indexPath.row]
            
        
        let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "AllItemsIDViewController") as! AllItemsIDViewController
        
           jobIDViewController.itemID = listStr.id!
            
        jobIDViewController.churchName1 = listStr.name!

            
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
      
      
            

        
    }
        
    }
    
    //MARK: -  back Left Button Tapped
  
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
    
 //MARK: -  get All items API Call
    
    func getallitemsAPICall(string:String){
        
        self.allitemsArray.removeAll()
        
        let paramsDict = [ 	"userId": "",
                           	"pageIndex": PageIndex,
                           	"pageSize": 30,
                           	"sortbyColumnName": "UpdatedDate",
                           	"sortDirection": "desc",
                           	"searchName": string
            
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLITEMSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:GetAllitemsVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                if listArr.count > 0 {
                    
                    self.getAllitemsTableView.isHidden = false
                    
                    self.norecordsFoundLbl.isHidden = true
                
                for eachArray in listArr{
                    self.allitemsArray.append(eachArray)
                }
                
                    self.filtered = self.allitemsArray
                    
                    let pageCout  = (respVO.totalRecords)! / 10
                    
                    let remander = (respVO.totalRecords)! % 10
                    
                    self.totalPages = pageCout
                    
                    if remander != 0 {
                        
                        self.totalPages = self.totalPages! + 1
                        
                    }
                    
                self.getAllitemsTableView.reloadData()
                }
                else {
                    if(self.PageIndex == 0){
                        self.norecordsFoundLbl.isHidden = false
                        
                        self.getAllitemsTableView.isHidden = true
                    }else{
                        self.norecordsFoundLbl.isHidden = true
                        
                        self.getAllitemsTableView.isHidden = false
                    }
                    
                    
                }
                
            }
                
       
                
            else {
                
                self.norecordsFoundLbl.isHidden = false
                self.getAllitemsTableView.isHidden = true
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
    }
    

    
    
}
