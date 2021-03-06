//
//  ViewController.swift
//  CollectionViewChurchSample
//
//  Created by Manoj on 31/01/18.
//  Copyright © 2018 Manoj. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class VideoSongsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var hometableView: UITableView!
   

//MARK: -  variable declaration
    
    var documentController  : UIDocumentInteractionController = UIDocumentInteractionController()
    var saveLocationString  = ""
    var pdfTitle            = ""
    var appVersion          = ""
    var catgoryID:Int       = 0
    var catgoryImg          = ""
    var catgoryName         = ""
    var viewTitle           = ""
    var idStr               = ""
    var null                = NSNull()
    var imageView           = UIImageView()
    
    var isSavingPDF              = false
    var isDownloadingOnProgress  = false
    var showBack                 = true
    var isResponseFromServer     = false
    var allCagegoryArray    : [ImagesResultVo] = Array<ImagesResultVo>()
    var audioArray          : [ImagesResultVo] = Array<ImagesResultVo>()
    var documentArray       : [ImagesResultVo] = Array<ImagesResultVo>()
    var imagesArray         : [ImagesResultVo] = Array<ImagesResultVo>()
    var allCagegoryListArray : CategoriesListResultVo?
    
    var churchNameAry       : Array<String> = Array()
    var splitArray          : Array<String> = Array()
    var categoryStr         : Array<String> = Array()
    var videoIDArray        : Array<String> = Array()
    var docsIDArray         : Array<String> = Array()
    var audioIDArray        : Array<String> = Array()
    
    var gggg              = String()
    var thumbnailImageURL = String()
    var userID            = String()
    
    var noOfRows        : Array<Dictionary<String,Any>> = Array()
    var numberOfRows    : Dictionary<String,Any>        = Dictionary()
    var imagesArrayTag  : Dictionary<String,Any>        = Dictionary()

    let pdfThumbnillImage = [UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf")]
    
    var imageArray3 = [UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"books"),UIImage(named:"Churches")]
    
    var imageArray = [UIImage(named:"holybible"),UIImage(named:"Audio"),UIImage(named:"Seminor"),UIImage(named:"Songs"),UIImage(named:"books"),UIImage(named:"Churches")]
    
    var imageArray2 = [UIImage(named:"rootmap"),UIImage(named:"Science"),UIImage(named:"movies"),UIImage(named:"language"),UIImage(named:"jobs"),UIImage(named:"donation")]
    
    var namesarra1 = ["Holy Bible","Audio Bible","Bible Study","Songs","Scientific Proofs","Gospel Messages","Short Messages","Images","Login id Creation","Help to develop the small churches","Book Shop","Movies","Daily Quotations","Video Songs","Testimonials","Quotations","Sunday School","Cell numbers for daily messages(Bulk sms)","Bible Apps","Short Films","Jobs","Route maps buds numbers","Events","Donation","Live","Doubts","Suggetions","Pamplets","languages(Tel/Eng)","Admin can add multiple menu pages"]
    
    
    var sectionTitleArray = ["Images","Document","Audio","Video"]
    var titleArr = ["3","4","5","6"]
    
    let pdfUrl = ["https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf","https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf","https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf","https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf","https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf","https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf"]
    
 
  
//MARK:- view Did Load
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        nameLbl.text = "\(catgoryName)"
        self.norecordsfoundLbl.isHidden = true
        if let useid = kUserDefaults.value(forKey: kuserIdKey) as? String {
            
            self.userID = useid
        }
        
        let newString = catgoryImg.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            let url = URL(string:newString)
        
            if url != nil {
                let dataImg = try? Data(contentsOf: url!)
            
                if dataImg != nil {
                    infoImage.image = UIImage(data: dataImg!)
                }
                else {
                    infoImage.image = #imageLiteral(resourceName: "Church-logo")
                }
            }
        else {
            infoImage.image = #imageLiteral(resourceName: "Church-logo")
        }
        
        let nibName  = UINib(nibName: "homeCategoriesCell" , bundle: nil)
        hometableView.register(nibName, forCellReuseIdentifier: "homeCategoriesCell")
    
        hometableView.dataSource = self
        hometableView.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        
        //MARK:- Calling getVideosAPICall
        
        self.getVideosAPICall()
        
        
    }
    
//MARK:- view Will Appear
  
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "\(catgoryName)", backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
         NotificationCenter.default.addObserver(self, selector: #selector(RefreshTokenIn), name: Notification.Name("RefreshTokenIn"), object: nil)

    }
    
 //MARK:- view Will Disappear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)

        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func RefreshTokenIn(){
        
        print("refresh Token")
    }
    
//MARK:- get Videos API Call
    
    func getVideosAPICall(){
        
        let urlStr = GETPOSTBYCATEGORYIDOFVIDEOSONGS + "" + "\(catgoryID)" + "/" + kUserId
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS -> ",urlStr)
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async()
                {
                    
                    print(result)
                    
                    let respVO:GetCategoriesResultVo = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    
                    self.imagesArray.removeAll()
                    
                    if isSuccess == true {
                        
                        self.norecordsfoundLbl.isHidden = true
                        self.hometableView.isHidden     = false
                        self.allCagegoryListArray       = respVO.result
                        
                        if self.allCagegoryListArray != nil {
                            
                            self.norecordsfoundLbl.isHidden = true
                            self.hometableView.isHidden     = false
                            
                            let videoList = self.allCagegoryListArray?.videos
                            
                            if !(videoList?.isEmpty)! {
                                self.categoryStr.append("Videos")
                            }
                            var i = 0
                            for authorDetails in videoList!{
                                
                                self.numberOfRows.updateValue(videoList?.count, forKey: "\(i)")
                                self.imagesArrayTag.updateValue(videoList, forKey: "\(i)")
                                self.imagesArray.append(authorDetails)
                            }
                            
                            i = (videoList?.count)! > 0 ? i + 1 : i

                            let audioList = self.allCagegoryListArray?.audios
                            
                            if !(audioList?.isEmpty)! {
                                self.categoryStr.append("Audios")
                            }
                            
                            for audioDetails in audioList!{
                                
                                self.numberOfRows.updateValue(audioList?.count, forKey: "\(i)")
                                self.imagesArrayTag.updateValue(audioList, forKey: "\(i)")
                                self.imagesArray.append(audioDetails)
                            }
                            
                            i = (audioList?.count)! > 0 ? i + 1 : i
                            let docsList = self.allCagegoryListArray?.documents
                            
                            if !(docsList?.isEmpty)! {
                                self.categoryStr.append("Documents")
                            }
                            
                            for docsDetails in docsList!{
                                self.numberOfRows.updateValue(docsList?.count, forKey: "\(i)")
                                self.imagesArrayTag.updateValue(docsList, forKey: "\(i)")
                                self.imagesArray.append(docsDetails)
                            }
                            
                            i = (docsList?.count)! > 0 ? i + 1 : i
                            let imageList = self.allCagegoryListArray?.images
                            if !(imageList?.isEmpty)! {
                                self.categoryStr.append("Images")
                            }
                            for imageDetails in imageList!{
                                
                                self.numberOfRows.updateValue(imageList?.count, forKey: "\(i)")
                                self.imagesArrayTag.updateValue(imageList, forKey: "\(i)")
                                self.imagesArray.append(imageDetails)
                            }
                            print("categoryStr:\(self.categoryStr.count)")
                            self.isResponseFromServer = true
                            self.hometableView.reloadData()
                        }
                        else {
                           self.norecordsfoundLbl.isHidden = false
                           self.hometableView.isHidden = true
                        }
                    }
                        
                    else{
                        self.norecordsfoundLbl.isHidden = false
                        self.hometableView.isHidden = true
                    }
            }
            
        }) { (failureMessage) in
            
            print(failureMessage)
        }
    }

    
    private func openPDFinPDFReader() {
        
    }
    
//MARK:- save PDF With Url
    
    private func savePDFWithUrl(_ urlString: String) {
        
        var filePath : URL?
        
        MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        
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
                                    MBProgressHUD.hide(for:appDelegate.window,animated:true)
                                    self.openSelectedDocumentFromURL(documentURLString: self.saveLocationString)
                                    print( self.saveLocationString)
                                    print(  self.openSelectedDocumentFromURL)
                                    
                                    // Calling open PDF Api
                                    
                                    self.openPDFinPDFReader()
                
                                }
                                
                            } else {
                                
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                    MBProgressHUD.hide(for:appDelegate.window,animated:true)
                                })
                            }
                            
                        } else {
                            
                            do {
                                self.isDownloadingOnProgress = true
                                let imageData : Data? = try Data.init(contentsOf: url)
                                
                                if imageData == nil {
                                    self.isDownloadingOnProgress = false
                                    DispatchQueue.main.async {
                                        MBProgressHUD.hide(for:appDelegate.window,animated:true)
                                    }
                                    
                                } else {
                                    
                                    do {
                                        try imageData?.write(to: filePath!, options: Data.WritingOptions.withoutOverwriting)
                                        if !self.isSavingPDF {
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                MBProgressHUD.hide(for:appDelegate.window,animated:true)
                                                // Calling open PDF Api
                                                self.openPDFinPDFReader()
                                            }
                    
                                        } else {
                                            self.isDownloadingOnProgress = false
                                            DispatchQueue.main.async {
                                                MBProgressHUD.hide(for:appDelegate.window,animated:true)
                                            }
                                        }
                                        
                                    } catch let error {
                                        self.isDownloadingOnProgress = false
                                        DispatchQueue.main.async {
                                            MBProgressHUD.hide(for:appDelegate.window,animated:true)
                                        }
                                    }
                                }
                                
                            } catch let error {
                                print(error.localizedDescription)
                                self.isDownloadingOnProgress = false
                                DispatchQueue.main.async {
                                    MBProgressHUD.hide(for:appDelegate.window,animated:true)
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
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return self
    }
    
//MARK:- Table View  DataSource & Delegate Methods
   
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(isResponseFromServer == true){
             return numberOfRows.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCategoriesCell", for: indexPath) as! homeCategoriesCell
        
        // Registering Collectionview cells
        cell.homeCollectionView.register(UINib.init(nibName: "homeCategoriesCollectionCell", bundle: nil),
                                         forCellWithReuseIdentifier: "homeCategoriesCollectionCell")
        
        cell.homeCollectionView.tag = indexPath.row
        cell.selectionStyle         = .none
        cell.homeCollectionView.showsHorizontalScrollIndicator = false
        cell.homeCollectionView.collectionViewLayout.invalidateLayout()
        cell.homeCollectionView.reloadData()
        cell.homeCollectionView.delegate   = self
        cell.homeCollectionView.dataSource = self

        if categoryStr.count > 0 {
            cell.categorieName.text = self.categoryStr[indexPath.row]
        }
        return cell
    }
  
//MARK:- Collection View  DataSource & Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      let totalItems = self.numberOfRows["\(collectionView.tag)"] as? Int
        print("totalItems:\(String(describing: totalItems))")
            return totalItems!
 
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
        
        let imageTag      = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        let title         = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
        let postImgUrl    = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        
        cell.nameLabel.text = title
        cell.collectionImgView.image = #imageLiteral(resourceName: "eventsdetails")

        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG") || (fileExtension == ".PNG") || (fileExtension == ".JPEG"){
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
                if newString != nil {
                    let url = URL(string:newString!)
                    let dataImg = try? Data(contentsOf: url!)
                    if dataImg != nil {
                    cell.collectionImgView.image = UIImage(data: dataImg!)
                    }
                else {
                    cell.collectionImgView.image = #imageLiteral(resourceName: "eventsdetails")
                }
            }
            else {
                cell.collectionImgView.image = #imageLiteral(resourceName: "eventsdetails")
            }
            
        }
        
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") || (fileExtension == ".docx") {
            cell.collectionImgView.contentMode = .scaleAspectFit
            cell.collectionImgView.image = #imageLiteral(resourceName: "defaultdocument")
        }
        else if (fileExtension == ".mp3") {
            cell.collectionImgView.contentMode = .scaleAspectFit
            cell.collectionImgView.image = #imageLiteral(resourceName: "audio3")
        }
        else if fileExtension == ".mp4" {

            if let embededUrlImage =  postImgUrl {
                
                let thumbnillImage : String = embededUrlImage
                self.idStr = String(thumbnillImage.characters.suffix(11))
                
                print(self.idStr)

                self.thumbnailImageURL = "https://img.youtube.com/vi/\(idStr)/default.jpg"
                let videothumb = URL(string: self.thumbnailImageURL)
                if videothumb != nil{
                    let request = URLRequest(url: videothumb!)
                    let session = URLSession.shared
                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        DispatchQueue.main.async()
                            {
                                if data != nil {
                                 cell.collectionImgView.image = UIImage(data: data!)
                                    
                                }
                        }
                    })
                    dataTask.resume()
                    
                }
            }
 
        }

      return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        print("You selected cell #\(indexPath.item)!")
        return CGSize(width: 140.0, height: 105.0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        
        if self.imagesArrayTag.count > 0 {
        
        let imageTag        = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        let fileExtension   = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        let postImgUrl      = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        let categoryId      = (imageTag?[indexPath.row] as? ImagesResultVo)?.categoryId
        let title           = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
        let userID          = (imageTag?[indexPath.row] as? ImagesResultVo)?.id
        
        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG") || (fileExtension == ".PNG") || (fileExtension == ".JPEG"){
            
           print("images")
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                if newString != nil {
                    let url = URL(string:newString!)
                    let dataImg = try? Data(contentsOf: url!)
                    
                    if dataImg != nil {
                        let videosVC = YoutubePlayerViewController(nibName: "YoutubePlayerViewController", bundle: nil)
                        videosVC.videoId = userID!
                        videosVC.videoNameStr = title!
                        videosVC.imgData = dataImg!
                        videosVC.videoImgStr = "image"
                    
                        kUserDefaults.set(categoryId!, forKey: "categoryId")
                        kUserDefaults.synchronize()
                    
                        self.navigationController?.pushViewController(videosVC, animated: true)
                }
                else {
                    
                    let videosVC = YoutubePlayerViewController(nibName: "YoutubePlayerViewController", bundle: nil)
                        videosVC.videoId = userID!
                        videosVC.videoNameStr = title!
                        if dataImg != nil {
                            videosVC.imgData = dataImg!
                        }
                    videosVC.videoImgStr = "image"
                    
                    kUserDefaults.set(categoryId!, forKey: "categoryId")
                    kUserDefaults.synchronize()
                    
                    self.navigationController?.pushViewController(videosVC, animated: true)
                }
            }
            else {
              imageView.image = #imageLiteral(resourceName: "Church-logo")
            }
        }
            
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") || (fileExtension == ".docx"){
            
            print("Pdfs and docs")
            
            let imgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
                let embededUrlImage =  imgUrl
                let newString = embededUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
                let docViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocViewController") as! DocViewController
 
                docViewController.urlStr = newString!
                docViewController.titleStr = title!

                self.navigationController?.pushViewController(docViewController, animated: true)

        }
            
        else if (fileExtension == ".mp3") {
            
            let postImgUrl  = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            let title       = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
            let categoryId  = (imageTag?[indexPath.row] as? ImagesResultVo)?.categoryId
            let audioID     = (imageTag?[indexPath.row] as? ImagesResultVo)?.id
            
            print(postImgUrl)
            
            let audioUrlImage =  postImgUrl
            print(audioUrlImage)
            let newString = audioUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            print(newString)

            if newString != nil {
                
                let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController
                    
                    audioViewController.audioIDArr = newString!
                    audioViewController.audioIDNameArr = title!
                    audioViewController.audioID = audioID!
                    audioViewController.categoryID = categoryId!
                    self.navigationController?.pushViewController(audioViewController, animated: true)
            }
            else {
                
            }

           print("audio")
            
        }
        else if fileExtension == ".mp4" {

            let title       = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
            let categoryId  = (imageTag?[indexPath.row] as? ImagesResultVo)?.categoryId
            let videoID     = (imageTag?[indexPath.row] as? ImagesResultVo)?.id
            let imgUrl      = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
            
            if let embededUrlImage =  imgUrl {
            
                let thumbnillImage : String = embededUrlImage
                            
                    self.idStr = String(thumbnillImage.characters.suffix(11))
                    print(self.idStr)

                let videothumb = URL(string: idStr)
                    if videothumb != nil{
                        let request = URLRequest(url: videothumb!)
                        let session = URLSession.shared
            
                        let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            
                          DispatchQueue.main.async(){
                            let  videosVC = YoutubePlayerViewController(nibName: "YoutubePlayerViewController", bundle: nil)
                                 videosVC.videoId = videoID!
                                 videosVC.videoNameStr = title!
                                 videosVC.videoEmbededIDStr = self.idStr
                                 videosVC.videoImgStr = "video"
                                    
                                kUserDefaults.set(categoryId!, forKey: "categoryId")
                                kUserDefaults.set(videoID!, forKey: "videoID")
                                kUserDefaults.synchronize()

                            self.navigationController?.pushViewController(videosVC, animated: true)
                            }
                        })
                                
                        dataTask.resume()
                                
                        }
                 }
          }
  
      }
        else {
        
            appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
        }
        
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
//MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
    
        
        kUserDefaults.set("1", forKey: "1")
        kUserDefaults.synchronize()
        kUserDefaults.removeObject(forKey: "1")
        kUserDefaults.removeObject(forKey: kLoginSucessStatus)
        self.navigationController?.popViewController(animated: true)
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " ", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
    }
    
//MARK: -    Home Left Button Tapped
    
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
 
}
