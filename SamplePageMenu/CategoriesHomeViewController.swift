//
//  CategoriesHomeViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/1/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class CategoriesHomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating{

    @IBOutlet weak var recordsLabel: UILabel!
    
 @IBOutlet weak var collectionView: UICollectionView!
    
   //MARK: -  variable declaration
    
    var churchAdminArray:[CategoriesResultVo] = Array<CategoriesResultVo>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categorieImageArray = Array<UIImage>()
    var categorieNamesArray = Array<String>()
    var pageMenu : CAPSPageMenu?
    var bibleString = Bool()
    var bibleInt = Int()
    var appVersion          : String = ""
    var loginStatusString    =   String()
    var showNav = false
    var filteredData: [String]!
    var searchController: UISearchController!
    var searchTextStr:String = ""
    
    var searchActive : Bool = false
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var sectionTittles = ["Church","Latest Posts","Categories","Event Posts"]
    var data = [" ","Categories"]
    var cagegoriesArray:[CategoriesResultVo] = Array<CategoriesResultVo>()
    var filtered:[CategoriesResultVo] = []

    var imageArray = [UIImage(named:"Bible apps"),UIImage(named:"Bible study"),UIImage(named:"Book shop"),UIImage(named:"Donation"),UIImage(named:"Doubts"),UIImage(named:"Events"),UIImage(named:"film"),UIImage(named:"Gospel messages"),UIImage(named:"Gospel"),UIImage(named:"help"),UIImage(named:"Holy bible"),UIImage(named:"Images"),UIImage(named:"Live"),UIImage(named:"Map"),UIImage(named:"Messages"),UIImage(named:"Movies"),UIImage(named:"pamphlet"),UIImage(named:"Quatation"),UIImage(named:"Scientific"),UIImage(named:"Songs"),UIImage(named:"Suggestion"),UIImage(named:"Sunday school"),UIImage(named:"Testimonial"),UIImage(named:"Videos"),UIImage(named:"ic_admin"),UIImage(named:"Languages"),UIImage(named:"Login"),UIImage(named:"pamphlet")]
    
    
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
//MARK: -  view Did Load
    
override func viewDidLoad() {
            super.viewDidLoad()
    
    print(kLoginSucessStatus)
            
            
    searchBar = UISearchBar()
    searchBar.sizeToFit()
    searchBar.delegate = self
    self.recordsLabel.isHidden = true
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    searchBar.placeholder = "Search by category Name".localize()
            
    self.searchController.searchBar.delegate = self
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    navigationItem.titleView = searchBar
            
    let defaults = UserDefaults.standard
            
    if let loginSucess = defaults.string(forKey: kLoginSucessStatus) {
                print(loginSucess)
    print("defaults savedString: \(loginSucess)")
                
            }
    let cellColl = UINib(nibName: "homeCollectionViewCell", bundle: nil)
    collectionView.register(cellColl, forCellWithReuseIdentifier: "homeCollectionViewCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    self.navigationController?.isNavigationBarHidden = false
            
    }
    
 //MARK: -  view Will Appear
    
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    self.cagegoriesArray.removeAll()
    self.getAllCategoriesAPICall()
        
    Utilities.categoriesViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "Categories".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
//MARK: -  Get All Categories API Call
    
func getAllCategoriesAPICall(){
        
        let paramsDict = ["active": 1,
                          "pageIndex": PageIndex,
                          "pageSize": 30,
                          "sortbyColumnName": "UpdatedDate",
                          "sortDirection": "desc",
                          "searchName": ""
            ] as [String : Any]
        
    let dictHeaders = ["":"","":""] as NSDictionary
        
        
    serviceController.postRequest(strURL: GETALLCATEGORIES as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
    print(result)
            
    let respVO:GetAllCategoriesVo = Mapper().map(JSONObject: result)!
    let isSuccess = respVO.isSuccess
    print("StatusCode:\(String(describing: isSuccess))")
            
    if isSuccess == true {
                
                
    let listArr = respVO.listResult!
                
    for eachArray in listArr{
                    
    self.cagegoriesArray.append(eachArray)
    }
                
                
    print(self.cagegoriesArray.count)
                
    let pageCout  = (respVO.totalRecords)! / 30
                
    let remander = (respVO.totalRecords)! % 30
                
    self.totalPages = pageCout
                
    if remander != 0 {
                    
    self.totalPages = self.totalPages! + 1
                    
    }
                
   self.collectionView.reloadData()
                
    }
                
    else {
                
                
    }
            
}) { (failureMessage) in
            
            
    print(failureMessage)
            
        }
    }
  //MARK: - Get All Search Categories API Call
    
func getAllSearchCategoriesAPICall(string:String){
        
        let paramsDict = ["active": 1,
                          "pageIndex": PageIndex,
                          "pageSize": 50,
                          "sortbyColumnName": "UpdatedDate",
                          "sortDirection": "desc",
                          "searchName": string
        ] as [String : Any]
        
    let dictHeaders = ["":"","":""] as NSDictionary
        
        
    serviceController.postRequest(strURL: GETALLCATEGORIES as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
    print(result)
            
    let respVO:GetAllCategoriesVo = Mapper().map(JSONObject: result)!
            
    let isSuccess = respVO.isSuccess
    print("StatusCode:\(String(describing: isSuccess))")
            
            
    self.cagegoriesArray.removeAll()
    if isSuccess == true {
                
                
    let listArr = respVO.listResult!
    if listArr.count > 0 {
                    
    self.collectionView.isHidden = false
                    
    self.recordsLabel.isHidden = true
                
                
    for eachArray in listArr{
                    
    self.cagegoriesArray.append(eachArray)
    }
                    
    print(self.cagegoriesArray.count)
                    
    let pageCout  = (respVO.totalRecords)! / 50
                
    let remander = (respVO.totalRecords)! % 50
                
    self.totalPages = pageCout
            
    if remander != 0 {
                    
    self.totalPages = self.totalPages! + 1
                    
    }
            
    self.collectionView.reloadData()
                
    }
    else {
    self.recordsLabel.isHidden = false
    self.collectionView.isHidden = true
                    
      }

    }
            
    }) { (failureMessage) in
            
            
    print(failureMessage)
        
   }
}
    
  //MARK: - search Bar
    
func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.searchBar.showsCancelButton = true
        
    self.getAllSearchCategoriesAPICall(string: searchBar.text!)
    self.collectionView.reloadData()
        
    }
    
func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
        self.collectionView.reloadData()

    }
    
private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
    self.searchTextStr = searchBar.text!
        
    filtered = cagegoriesArray.filter({ (text) -> Bool in
            
    let tmp = text
   let range = ((tmp.categoryName?.range(of: self.searchTextStr, options: NSString.CompareOptions.caseInsensitive)) != nil)
            
    return range
            
        })
    self.getAllSearchCategoriesAPICall(string: searchBar.text!)
        
    if(filtered.count == 0){
    searchActive = false
    } else {
    searchActive = true
    }
    self.collectionView.reloadData()
    searchBar.resignFirstResponder()
        
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
        self.collectionView.reloadData()
        searchBar.resignFirstResponder()
      
        
    self.searchTextStr = searchBar.text!
        
    filtered = churchAdminArray.filter({ (text) -> Bool in
                    
    let tmp = text
    let range = ((tmp.categoryName?.range(of: self.searchTextStr, options: NSString.CompareOptions.caseInsensitive)) != nil) || ((tmp.fileName?.range(of: self.searchTextStr, options: NSString.CompareOptions.caseInsensitive)) != nil)
                    
                    
    return range
    })
                

    self.getAllSearchCategoriesAPICall(string: searchBar.text!)
                
   if(filtered.count == 0){
    searchActive = false
    } else {
    searchActive = true
    }
    self.collectionView.reloadData()
                
    searchBar.resignFirstResponder()
        }
    
func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            
            
        } else {
            
    }
        
    }
    
//MARK: -  collectionView delegate & DataSource  methods
    
func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(searchActive) {
            
            return filtered.count
        }
        else {
            
            return cagegoriesArray.count
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! homeCollectionViewCell
        
    if(searchActive){

    let categoryList:CategoriesResultVo = filtered[indexPath.row]
        
    cell.nameLabel.text = categoryList.categoryName
        
    let imgUrl = categoryList.categoryImage
        
    let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        
    if newString != nil {
            
        let url = URL(string:newString!)
            
        if url != nil {
                
        let dataImg = try? Data(contentsOf: url!)
                
        if dataImg != nil {
        
        cell.collectionImgView.image = UIImage(data: dataImg!)
            }
        else {
                    
cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
}
    }
            
    }
    else {
            
    cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
    }
            
    return cell
            
    }else{
        
        if cagegoriesArray.count > 0 {
           
            let categoryList:CategoriesResultVo = cagegoriesArray[indexPath.row]
            cell.nameLabel.text = categoryList.categoryName
            
            let imgUrl = categoryList.categoryImage
            
            let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                if url != nil {
                    
                    let dataImg = try? Data(contentsOf: url!)
                    
                    if dataImg != nil {
                        
                        cell.collectionImgView.image = UIImage(data: dataImg!)
                    }
                    else {
                        
                        cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
                    }
                }
                
            }
            else {
                
                cell.collectionImgView.image =  #imageLiteral(resourceName: "Church-logo")
            }

        }
        
//    let nibName  = UINib(nibName: "homeTableViewCell" , bundle: nil)
        }
        return cell
        
    }

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {

    let cellsPerRow = 5

    let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth)
            
        }
        else {


    let cellsPerRow = 3

    let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
    let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth)
        }


    }


func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("You selected cell #\(indexPath.item)!")
        
    if cagegoriesArray.count > 0 {
            
            
    let categoryList:CategoriesResultVo = cagegoriesArray[indexPath.row]
            
            
    let categoryId = categoryList.id
            
    let catImg = categoryList.categoryImage
            
    let catName = categoryList.categoryName
            
    let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "VideoSongsViewController") as! VideoSongsViewController
            
    churchDetailsViewController.catgoryID = categoryId!
            
    churchDetailsViewController.catgoryName = catName!
            
    if catImg != nil {
                
    churchDetailsViewController.catgoryImg = catImg!
        }
            
    self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
            
        }
            
    else {
            
        appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == (cagegoriesArray.count) - 1 {
            
            if(self.totalPages! > PageIndex){
                
                PageIndex = PageIndex + 1
                
                getAllCategoriesAPICall()
                
                
                
            }
        }
        
    }

//MARK: -    Back Left Button Tapped
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set("1", forKey: "1")

        
         self.navigationController?.popViewController(animated: true)
        
           navigationItem.leftBarButtonItems = []
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        print("Back Button Clicked......")
        
    }
}
