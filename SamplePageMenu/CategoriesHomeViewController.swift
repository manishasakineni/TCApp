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

    

// this Importent

 @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var categorieImageArray = Array<UIImage>()
    var categorieNamesArray = Array<String>()
    
    var pageMenu : CAPSPageMenu?
    
    var bibleString = Bool()
    var bibleInt = Int()
    
    var appVersion          : String = ""
    
    var loginStatusString    =   String()
    
    var filteredData: [String]!
    
    var searchController: UISearchController!
    
    var searchActive : Bool = false
    var filtered:[String] = []
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var sectionTittles = ["Church","Latest Posts","Categories","Event Posts"]
    var data = [" ","Categories"]
    
    var cagegoriesArray:[CategoriesResultVo] = Array<CategoriesResultVo>()
    
    
    var imageArray = [UIImage(named:"Bible apps"),UIImage(named:"Bible study"),UIImage(named:"Book shop"),UIImage(named:"Donation"),UIImage(named:"Doubts"),UIImage(named:"Events"),UIImage(named:"film"),UIImage(named:"Gospel messages"),UIImage(named:"Gospel"),UIImage(named:"help"),UIImage(named:"Holy bible"),UIImage(named:"Images"),UIImage(named:"Live"),UIImage(named:"Map"),UIImage(named:"Messages"),UIImage(named:"Movies"),UIImage(named:"pamphlet"),UIImage(named:"Quatation"),UIImage(named:"Scientific"),UIImage(named:"Songs"),UIImage(named:"Suggestion"),UIImage(named:"Sunday school"),UIImage(named:"Testimonial"),UIImage(named:"Videos"),UIImage(named:"ic_admin"),UIImage(named:"Languages"),UIImage(named:"Login"),UIImage(named:"pamphlet")]
    
    
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
    
    
    
       // var namesarra1 = ["Bible apps","Bible study","Book shop","Donation","Doubts","Events","film","Gospel messages","Gospel","help","Holy bible","Images","live","Map","Messages","Movies","pamphlet","Quatation","Scientific","Songs","Suggestion","Sunday school","Testimonial","Videos","Admin","Languages","Login","pamphlet"]
    
      //  var namesarra1 = ["Bible apps".localize(),"Bible study".localize(),"Book shop".localize(),"Donation".localize(),"Doubts".localize(),"Events".localize(),"film".localize(),"Gospel messages".localize(),"Gospel".localize(),"help".localize(),"Holy bible".localize(),"Images".localize(),"Languages".localize(),"Live".localize(),"Login".localize(),"Map".localize(),"Messages".localize(),"Movies".localize(),"pamphlet".localize(),"Quatation".localize(),"Scientific".localize(),"Songs".localize(),"Suggestion".localize(),"Sunday school".localize(),"Testimonial".localize(),"Videos".localize()]
    
    
    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            print(kLoginSucessStatus)
            
            
            searchBar = UISearchBar()
            searchBar.sizeToFit()
            
            searchBar.delegate = self
            
            filteredData = sectionTittles
            
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            
            searchController.dimsBackgroundDuringPresentation = false
            
            
            
            searchBar.placeholder = "All Categories".localize()
            
            self.searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            navigationItem.titleView = searchBar
            
            let defaults = UserDefaults.standard
            
            if let loginSucess = defaults.string(forKey: kLoginSucessStatus) {
                print(loginSucess)
                self.appDelegate.window?.makeToast(loginSucess, duration:kToastDuration, position:CSToastPositionCenter)
                
                print("defaults savedString: \(loginSucess)")
                
            }
            let cellColl = UINib(nibName: "homeCollectionViewCell", bundle: nil)
            collectionView.register(cellColl, forCellWithReuseIdentifier: "homeCollectionViewCell")
            collectionView.dataSource = self
            collectionView.delegate = self
            self.navigationController?.isNavigationBarHidden = false
            self.getAllCategoriesAPICall()
            
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.getAllCategoriesAPICall()
        
        Utilities.categoriesViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "Categories".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        if bibleInt == 10 {
            
            Utilities.categoriesViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "Categories".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
            
        }
        if bibleInt == 11 {
            
            Utilities.categoriesViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Categories".localize(), backTitle: " Categories".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
            
        }
        if bibleInt == 12 {
            
            Utilities.categoriesViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Events".localize(), backTitle: " Events".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
            
        }
    }
    //MARK: -  Get All Categories API Call
    
    func getAllCategoriesAPICall(){
        
        let paramsDict = ["pageIndex": 1,
                          "pageSize": 15,
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
                
                
                
                let pageCout  = (respVO.totalRecords)! / 10
                
                let remander = (respVO.totalRecords)! % 10
                
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
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    @objc(searchBarBookmarkButtonClicked:) func searchBarBookmarkButtonClicked(_ rchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        //        if(filtered.count == 0){
        searchActive = false
        //        } else {
        //            searchActive = true;
        //        }
        self.collectionView.reloadData()
        searchBar.resignFirstResponder()
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            
            filteredData = searchText.isEmpty ? sectionTittles : sectionTittles.filter({(dataString: String) -> Bool in
                
                return (dataString.range(of: searchText) != nil)
            })
            
            //            categorieTableView.reloadData()
        }
    }
    
    
    




    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return cagegoriesArray.count



    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {



        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! homeCollectionViewCell
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
        
        
        let nibName  = UINib(nibName: "homeTableViewCell" , bundle: nil)
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




  /*  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {



        let cellsPerRow = 3
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    } */




    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        

        if indexPath.item == 0{
            
            if bibleInt == 10 {
                
                let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchDetailsViewController") as! ChurchDetailsViewController
                churchDetailsViewController.appVersion = categorieNamesArray[indexPath.item]
                self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
                
                
            }
            if indexPath.item == 1 {
 
            
            if bibleInt == 11 {
                let churchDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChurchAdminViewController") as! ChurchAdminViewController
                churchDetailsViewController.appVersion = categorieNamesArray[indexPath.item]

                self.navigationController?.pushViewController(churchDetailsViewController, animated: true)
                }
            }
            if bibleInt == 12 {
                
                let holyBibleViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
                holyBibleViewController.appVersion = categorieNamesArray[indexPath.item]

                self.navigationController?.pushViewController(holyBibleViewController, animated: true)
                
            }
            
        }
   
    }

    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: kuserId)
        UserDefaults.standard.synchronize()
        
        //   navigationItem.leftBarButtonItems = []
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        print("Back Button Clicked......")
        
    }
}
