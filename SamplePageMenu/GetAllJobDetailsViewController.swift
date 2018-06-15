//
//  GetAllJobDetailsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 14/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class GetAllJobDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating {
    
    @IBOutlet weak var getAllJobDetailsTableView: UITableView!
    
    @IBOutlet weak var norecordsFoundLbl: UILabel!
    
      var showNav = false
      var totalPages : Int? = 0
    
     var appVersion          : String = ""
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    
    var searchController: UISearchController!
    
    var searchActive : Bool = false
     var searchTextStr:String = ""
    
    var uid : Int = 0
    var PageIndex = 1
    var totalRecords : Int? = 0
    var sortbyColumnName : String = ""
    
    var jobDetailsArray:[GetAllJobDetailsListResultVO] = Array<GetAllJobDetailsListResultVO>()

     var filtered:[GetAllJobDetailsListResultVO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
         // self.getjobdetailsAPICall(string: searchBar.text!)
        
        getAllJobDetailsTableView.dataSource = self
        getAllJobDetailsTableView.delegate = self

        self.norecordsFoundLbl.isHidden = true
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        
        searchBar.tintColor = UIColor.black
        
        searchBar.delegate = self
        
        searchBar.placeholder = "Search by Church Name".localize()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchBar
  
        
        let nibName1  = UINib(nibName: "GetAllJobDetailsTableViewCell" , bundle: nil)
        getAllJobDetailsTableView.register(nibName1, forCellReuseIdentifier: "GetAllJobDetailsTableViewCell")
    //   getjobdetailsAPICall()
        
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        self.searchController.searchBar.delegate = self
        
        definesPresentationContext = true

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
          Utilities.setChurchuDetailViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "Categories".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        searchBar.text = ""
        
        PageIndex = 1
        totalPages = 0
        
        self.jobDetailsArray.removeAll()
        
        self.getjobdetailsAPICall(string: searchBar.text!)
 
        
    }

    //MARK: -  Search function
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
        searchActive = false
        
        PageIndex = 1
        totalPages = 0
        
        self.jobDetailsArray.removeAll()
        self.getjobdetailsAPICall(string: searchBar.text!)
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchActive = false
        searchBar.resignFirstResponder()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        PageIndex = 1
        totalPages = 0
        
        self.jobDetailsArray.removeAll()
        
        self.getjobdetailsAPICall(string: searchBar.text!)
        
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.getAllJobDetailsTableView.reloadData()
        
        
        
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
        
        self.jobDetailsArray.removeAll()
        self.getjobdetailsAPICall(string: searchBar.text!)
        self.getAllJobDetailsTableView.reloadData()
        
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
            
            if jobDetailsArray.count > 0 {
                
                return jobDetailsArray.count
                
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
        
        
        if indexPath.row == (jobDetailsArray.count) - 1 {
            
            if(self.totalPages! > PageIndex){
                
                PageIndex = PageIndex + 1
                
                self.getjobdetailsAPICall(string: searchBar.text!)
                
            }
        }
        
    }

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetAllJobDetailsTableViewCell", for: indexPath) as! GetAllJobDetailsTableViewCell
        

        if(searchActive){
            
            if filtered.count > 0 {
        
        let listStr:GetAllJobDetailsListResultVO = filtered[indexPath.row]
        
        cell.jobtitleLabel.text = listStr.jobTitle
        
        cell.qualificationLabel.text = listStr.qualification
        
        cell.churchNameLabel.text = listStr.churchName
        
        cell.cintactNumberLabel.text = listStr.contactNumber
        
        cell.lastdateToApplyLabel.text = listStr.lastDateToApply

        
        
        if(listStr.lastDateToApply! != ""){
            let dobStringArray = listStr.lastDateToApply?.components(separatedBy: "T")
            let dateString = dobStringArray?[0]
            cell.lastdateToApplyLabel.text  = dateString!
        }else{
            cell.lastdateToApplyLabel.text  = ""
        }
            }
        
        
        }
            

        else {
            
             if jobDetailsArray.count > 0 {
            
            let listStr:GetAllJobDetailsListResultVO = jobDetailsArray[indexPath.row]
            
            cell.jobtitleLabel.text = listStr.jobTitle
            
            cell.qualificationLabel.text = listStr.qualification
            
            cell.churchNameLabel.text = listStr.churchName
            
            cell.cintactNumberLabel.text = listStr.contactNumber
            
            cell.lastdateToApplyLabel.text = listStr.lastDateToApply
            
            
            
            if(listStr.lastDateToApply! != ""){
                let dobStringArray = listStr.lastDateToApply?.components(separatedBy: "T")
                let dateString = dobStringArray?[0]
                cell.lastdateToApplyLabel.text  = dateString!
            }else{
                cell.lastdateToApplyLabel.text  = ""
            }
        }
        

        }
            return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    let jobIDViewController = self.storyboard?.instantiateViewController(withIdentifier: "GetJobByIDViewController") as! GetJobByIDViewController
        if(filtered.count > indexPath.row){
             jobIDViewController.jobId = filtered[indexPath.row].id!
        }
     
        self.navigationController?.pushViewController(jobIDViewController, animated: true)
        
    }

    
    
    
    
    func getjobdetailsAPICall(string:String){
        
        let paramsDict = [ "userId": 0,
                           "pageIndex": PageIndex,
                           "pageSize": 200,
                           "sortbyColumnName": "LastdateToApply",
                           "sortDirection": "desc",
                           "searchName": string
    
            ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETALLJOBDETAILSAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:GetAllJobDetailsVO = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            

            if isSuccess == true {
                
                let listArr = respVO.listResult!
                
                
                if listArr.count > 0 {
                    
                    self.getAllJobDetailsTableView.isHidden = false
                    
                    self.norecordsFoundLbl.isHidden = true
                
                for eachArray in listArr{
                    
                    self.jobDetailsArray.append(eachArray)
                }
                
                
                    self.filtered = self.jobDetailsArray
                    
                    let pageCout  = (respVO.totalRecords)! / 10
                    
                    let remander = (respVO.totalRecords)! % 10
                    
                    self.totalPages = pageCout
                    
                    if remander != 0 {
                        
                        self.totalPages = self.totalPages! + 1
                        
                    }
                    
                
                self.getAllJobDetailsTableView.reloadData()
                
            }
                    
            
            else {
                    if(self.PageIndex == 1){
                self.norecordsFoundLbl.isHidden = false
                self.getAllJobDetailsTableView.isHidden = true
                    }
            }
                
            }
            
            else {
                
                self.norecordsFoundLbl.isHidden = false
                self.getAllJobDetailsTableView.isHidden = true
                
            }
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
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
    
    
    
}
