//
//  ViewController.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit





class VideoSongsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var infoImage: UIImageView!
    var documentController: UIDocumentInteractionController = UIDocumentInteractionController()

    var saveLocationString : String             = ""
    var isSavingPDF     : Bool                  = false
    var pdfTitle        : String                = ""
    private var isDownloadingOnProgress : Bool  = false
    var showBack = true
    
    var appVersion          : String = ""

    var imageArray3 = [UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"books"),UIImage(named:"Churches")]

   var imageArray = [UIImage(named:"holybible"),UIImage(named:"Audio"),UIImage(named:"Seminor"),UIImage(named:"Songs"),UIImage(named:"books"),UIImage(named:"Churches")]
    
    var imageArray2 = [UIImage(named:"rootmap"),UIImage(named:"Science"),UIImage(named:"movies"),UIImage(named:"language"),UIImage(named:"jobs"),UIImage(named:"donation")]
    
var namesarra1 = ["Holy Bible","Audio Bible","Bible Study","Songs","Scientific Proofs","Gospel Messages","Short Messages","Images","Login id Creation","Help to develop the small churches","Book Shop","Movies","Daily Quotations","Video Songs","Testimonials","Quotations","Sunday School","Cell numbers for daily messages(Bulk sms)","Bible Apps","Short Films","Jobs","Route maps buds numbers","Events","Donation","Live","Doubts","Suggetions","Pamplets","languages(Tel/Eng)","Admin can add multiple menu pages"]
    
    @IBOutlet weak var hometableView: UITableView!
    
    let sectionTitleArray = ["Images","Document","Audio","Video"]
    
    let pdfUrl = ["https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf","https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf","https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf","https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf","https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf","https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf"]
    
    
    let pdfThumbnillImage = [UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibName  = UINib(nibName: "homeCategoriesCell" , bundle: nil)
        hometableView.register(nibName, forCellReuseIdentifier: "homeCategoriesCell")
        
        
        // let string
        
        
      //  Utilities.setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: appVersion.localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        hometableView.dataSource = self
        hometableView.delegate = self
        
        
        //   https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf
        //   https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        //  self.navigationController?.navigationBar.isHidden = true
        
        //print(showNav)
        
       // self.navigationController?.navigationBar.isHidden = !showNav
   //     Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " ", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "  InfoView".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func openPDFinPDFReader() {
        
        //self.performSegue(withIdentifier: kToPDFVC, sender: self)
    }
    
    private func savePDFWithUrl(_ urlString: String) {
        
        var filePath : URL?
        //self.showHUD()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            
            if let url = URL.init(string: urlString) {
                
                let documentDirUrlString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                
                if let documentDirUrl = URL.init(string: documentDirUrlString) {
                    
                    let pdfNameArray = urlString.characters.split(separator: "/").map(String.init)
                    
                    if let pdfName = pdfNameArray.last {
                        
                        let saveLocation = documentDirUrl.appendingPathComponent(pdfName)
                        self.saveLocationString = saveLocation.absoluteString
                        filePath = URL.init(fileURLWithPath: saveLocation.path)
                        print( self.saveLocationString)
                        
                        let fileExists = FileManager().fileExists(atPath: self.saveLocationString)
                        
                        if fileExists {
                            
                            if !self.isSavingPDF {
                                
                                DispatchQueue.main.async {
                                    
                                    //    self.hideHUD()
                                    
                                    self.openSelectedDocumentFromURL(documentURLString: self.saveLocationString)
                                    print( self.saveLocationString)
                                    print(  self.openSelectedDocumentFromURL)
                                    
                                    
                                    self.openPDFinPDFReader()
                                }
                                
                            } else {
                                
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                    
                                    //                                    self.hideHUD()
                                    //                                    Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: kAppTitle, messege: self.pdfTitle + " has been already downloaded. Do you want to open?", clickAction: {
                                    //
                                    //                                        self.openPDFinPDFReader()
                                    //                                        return
                                    //                                    })
                                })
                            }
                            
                        } else {
                            
                            do {
                                
                                self.isDownloadingOnProgress = true
                                
                                let imageData : Data? = try Data.init(contentsOf: url)
                                
                                if imageData == nil {
                                    
                                    self.isDownloadingOnProgress = false
                                    
                                    DispatchQueue.main.async {
                                        
                                        //                                        self.hideHUD()
                                        //
                                        //                                        Utilities.sharedInstance.alertWithOkButtonAction(vc: self,
                                        //                                                                                         alertTitle: kAppTitle,
                                        //                                                                                         messege: "Error while loading Catalog", clickAction: {
                                        //
                                        //                                        })
                                    }
                                    
                                } else {
                                    
                                    do {
                                        
                                        try imageData?.write(to: filePath!, options: Data.WritingOptions.withoutOverwriting)
                                        
                                        if !self.isSavingPDF {
                                            
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                //  self.hideHUD()
                                                self.openPDFinPDFReader()
                                            }
                                            
                                            
                                        } else {
                                            
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                //                                                self.hideHUD()
                                                //
                                                //                                                Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: "Catalog has been downloaded to the download folder on your device", clickAction: {
                                                //                                                })
                                            }
                                        }
                                        
                                    } catch let error {
                                        
                                        self.isDownloadingOnProgress = false
                                        
                                        DispatchQueue.main.async {
                                            
                                            //                                            self.hideHUD()
                                            //                                            Utilities.sharedInstance.alertWithOkButtonAction(vc: self,
                                            //                                                                                             alertTitle: kAppTitle,
                                            //                                                                                             messege: error.localizedDescription, clickAction: {
                                            //
                                            //                                            })
                                        }
                                    }
                                }
                                
                            } catch let error {
                                
                                print(error.localizedDescription)
                                
                                self.isDownloadingOnProgress = false
                                
                                DispatchQueue.main.async {
                                    
                                    // self.hideHUD()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func openSelectedDocumentFromURL(documentURLString: String) {
        let documentURL: NSURL = NSURL(fileURLWithPath: documentURLString)
        documentController = UIDocumentInteractionController(url: documentURL as URL)
        documentController.delegate = self
        documentController.presentPreview(animated: true)
    }
    //
    //
    //    // MARK: - UIDocumentInteractionViewController delegate methods
    //
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return sectionTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            return 200.0
        }
        else {
            
            return 150.0
            
            
        }
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCategoriesCell", for: indexPath) as! homeCategoriesCell
        
        cell.homeCollectionView.register(UINib.init(nibName: "homeCategoriesCollectionCell", bundle: nil),
                                         forCellWithReuseIdentifier: "homeCategoriesCollectionCell")
        cell.homeCollectionView.tag = indexPath.row
        
        
        cell.homeCollectionView.collectionViewLayout.invalidateLayout()
        
        
        cell.homeCollectionView.delegate = self
        cell.homeCollectionView.dataSource = self
        cell.categorieName.text = self.sectionTitleArray[indexPath.row]
        
        
        
        return cell
    }
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //
    //        return 1
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            
            return imageArray3.count
            
        }else if collectionView.tag == 1 {
            
            return pdfUrl.count
        }else if collectionView.tag == 2 {
            
            return imageArray.count
        }
        
        return imageArray2.count
        
        
        
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
            
            cell.collectionImgView.image = imageArray3[indexPath.row]
            cell.nameLabel.text = pdfUrl[indexPath.row]
            
            
            
            
            
            
            
            return cell
            
        }else if collectionView.tag == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
            
            cell.collectionImgView.image = pdfThumbnillImage[indexPath.row]
            cell.nameLabel.text = pdfUrl[indexPath.row]
            
            
            
            
            
            
            
            return cell
        }else if collectionView.tag == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
            
            cell.collectionImgView.image = imageArray[indexPath.row]
            cell.nameLabel.text = pdfUrl[indexPath.row]
            
            
            
            
            
            
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
        
        cell.collectionImgView.image = imageArray2[indexPath.row]
        cell.nameLabel.text = pdfUrl[indexPath.row]
        
        
        
        
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
    
    
    
    
    //MARK:- Collectionview didSelectItemAt indexPath
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        
        if collectionView.tag == 0 {
            if indexPath.item == 0 {
                
                savePDFWithUrl(pdfUrl[0])
                
            }
            if indexPath.item == 1 {
                
                savePDFWithUrl(pdfUrl[0])
                
                
            }
            
            
        }
//        if collectionView.tag == 1 {
//            
//            if indexPath.item == 0 {
//                
//                let cableViewController = self.storyboard?.instantiateViewController(withIdentifier: "SongsViewController") as! SongsViewController
//                self.navigationController?.pushViewController(cableViewController, animated: true)
//            }
//            
//        }
//        if collectionView.tag == 2 {
//            if indexPath.item == 2 {
//                
//                let cableViewController = self.storyboard?.instantiateViewController(withIdentifier: "SongsViewController") as! SongsViewController
//                self.navigationController?.pushViewController(cableViewController, animated: true)
//            }
//        }
        
        
    }
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        //
        //        UserDefaults.standard.set("1", forKey: "1")
        //      //  UserDefaults.standard.removeObject(forKey: "1")
        //        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        //        UserDefaults.standard.synchronize()
        
        
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        
        //let categoriesHomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoriesHomeViewController") as! CategoriesHomeViewController
        // self.navigationController?.popViewController(animated: true)
        
        
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
        print("Back Button Clicked......")
        
    }
    
}
