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
    
    var catgoryID:Int = 0
    
    var catgoryImg:String = ""
    
    var catgoryName:String = ""

    var imageArray3 = [UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"holybible"),UIImage(named:"books"),UIImage(named:"Churches")]

   var imageArray = [UIImage(named:"holybible"),UIImage(named:"Audio"),UIImage(named:"Seminor"),UIImage(named:"Songs"),UIImage(named:"books"),UIImage(named:"Churches")]
    
    var imageArray2 = [UIImage(named:"rootmap"),UIImage(named:"Science"),UIImage(named:"movies"),UIImage(named:"language"),UIImage(named:"jobs"),UIImage(named:"donation")]
    
var namesarra1 = ["Holy Bible","Audio Bible","Bible Study","Songs","Scientific Proofs","Gospel Messages","Short Messages","Images","Login id Creation","Help to develop the small churches","Book Shop","Movies","Daily Quotations","Video Songs","Testimonials","Quotations","Sunday School","Cell numbers for daily messages(Bulk sms)","Bible Apps","Short Films","Jobs","Route maps buds numbers","Events","Donation","Live","Doubts","Suggetions","Pamplets","languages(Tel/Eng)","Admin can add multiple menu pages"]
    
    @IBOutlet weak var hometableView: UITableView!
    
    var sectionTitleArray = ["Images","Document","Audio","Video"]
    
    var titleArr = ["3","4","5","6"]
    
    let pdfUrl = ["https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf","https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf","https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf","https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf","https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf","https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf"]
    
    
    let pdfThumbnillImage = [UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf"),UIImage(named:"pdf")]
    
    
    var allCagegoryArray : [ImagesResultVo] = Array<ImagesResultVo>()
    
    var audioArray : [ImagesResultVo] = Array<ImagesResultVo>()
    
    var documentArray : [ImagesResultVo] = Array<ImagesResultVo>()
    
    var imagesArray : [ImagesResultVo] = Array<ImagesResultVo>()
    
    var allCagegoryListArray : CategoriesListResultVo?
    
    var churchNameAry : Array<String> = Array()
    var splitArray : Array<String> = Array()
    var strrrr : Array<String> = Array()
    
    var videoIDArray : Array<String> = Array()
    
    var docsIDArray : Array<String> = Array()
    
    var audioIDArray : Array<String> = Array()
    
    var gggg = String()
    
    var thumbnailImageURL = String()
    
    var isResponseFromServer = false
    
   var noOfRows : Array<Dictionary<String,Any>> = Array()
        var numberOfRows : Dictionary<String,Any> = Dictionary()
    
    var imagesArrayTag : Dictionary<String,Any> = Dictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newString = catgoryImg.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        
            let url = URL(string:newString)
        
        if url != nil {
            
            let dataImg = try? Data(contentsOf: url!)
            
            if dataImg != nil {
                
                infoImage.image = UIImage(data: dataImg!)
            }
            else {
                
                infoImage.image = #imageLiteral(resourceName: "j4")
            }
            
        }
        else {
            
            infoImage.image = #imageLiteral(resourceName: "j4")
        }
        
        
        
        
        
        let nibName  = UINib(nibName: "homeCategoriesCell" , bundle: nil)
        hometableView.register(nibName, forCellReuseIdentifier: "homeCategoriesCell")
        
        
        // let string
        
        
      //  Utilities.setChurchuAdminInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: appVersion.localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        hometableView.dataSource = self
        hometableView.delegate = self
        
        
        //   https://rgfigueroa.files.wordpress.com/2008/03/stevesbio.pdf
        //   https://www.antennahouse.com/XSLsample/pdf/sample-link_1.pdf
        self.navigationController?.isNavigationBarHidden = true
        
        getVideosAPICall()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        //  self.navigationController?.navigationBar.isHidden = true
        
        //print(showNav)
        
       // self.navigationController?.navigationBar.isHidden = !showNav
   //     Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: " ", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "  \(catgoryName)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getVideosAPICall(){
        
//        let videoSongsID : Int = 8
        
        let urlStr = GETPOSTBYCATEGORYIDOFVIDEOSONGS + "" + "\(catgoryID)"
        
        print("GETPOSTBYCATEGORYIDOFVIDEOSONGS",urlStr)
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async()
                {
                    
                    print(result)
                    
                    let respVO:GetCategoriesResultVo = Mapper().map(JSONObject: result)!
                    
                    let isSuccess = respVO.isSuccess
                    
                    self.imagesArray.removeAll()
                    
                    if isSuccess == true {
                        
                        
                        self.allCagegoryListArray = respVO.result
                        
                        
                        let videoList = self.allCagegoryListArray?.videos
                        
                      
                        var i = 0
                        
                        
                        for authorDetails in videoList!{
                         
                            self.numberOfRows.updateValue(videoList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(videoList, forKey: "\(i)")
                            
                            self.imagesArray.append(authorDetails)
                        }
                        
                        i = (videoList?.count)! > 0 ? i + 1 : i
                        
                        let audioList = self.allCagegoryListArray?.audios
                        
                        
                        for audioDetails in audioList!{
                         
                           self.numberOfRows.updateValue(audioList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(audioList, forKey: "\(i)")
                            
                            self.imagesArray.append(audioDetails)
                        }
                        
                           i = (audioList?.count)! > 0 ? i + 1 : i
                        
                        let docsList = self.allCagegoryListArray?.documents
                        
                        
                        for docsDetails in docsList!{
                         
                           self.numberOfRows.updateValue(docsList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(docsList, forKey: "\(i)")
                           
                            self.imagesArray.append(docsDetails)
                        }
                        
                         i = (docsList?.count)! > 0 ? i + 1 : i
                        
                        let imageList = self.allCagegoryListArray?.images
                        
                        
                        for imageDetails in imageList!{
                   
                            self.numberOfRows.updateValue(imageList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(imageList, forKey: "\(i)")
                            
                            self.imagesArray.append(imageDetails)
                        }
                        
//                        let videoList = self.allCagegoryListArray?.audios
                        self.isResponseFromServer = true
                        self.hometableView.reloadData()
                        // print(self.authorDetailsArray)
                        
                    }
                        
                    else{
                        
                        
                    }
                    
                    
                    //  }
            }
            
            
            
        }) { (failureMessage) in
            
            
            
            
        }
        
        
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
        
          if(isResponseFromServer == true){
            
             return numberOfRows.count
            
        }
        
        return 0
        
        
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
        
        cell.selectionStyle = .none
        
        cell.homeCollectionView.collectionViewLayout.invalidateLayout()
        
        
        cell.homeCollectionView.delegate = self
        cell.homeCollectionView.dataSource = self
        
        let imageTag = self.imagesArrayTag["\(indexPath.row)"] as? NSArray
        
        let mediaTypeName = (imageTag?[indexPath.row] as? ImagesResultVo)?.mediaType
        
        
        cell.categorieName.text = mediaTypeName
        
        
        
        return cell
    }
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //
    //        return 1
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      let totalItems = self.numberOfRows["\(collectionView.tag)"] as? Int
        
        print("totalItems:\(String(describing: totalItems))")
    
    return totalItems!
        
//        return videoIDArray.count
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
        
        let imageTag = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        
        let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
        
         let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention

        
//        print(title!)
//        print(postImgUrl!)
        
        cell.nameLabel.text = title
        
        cell.collectionImgView.image = #imageLiteral(resourceName: "j4")

        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG"){
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.collectionImgView.image = UIImage(data: dataImg!)
                }
                else {
                    
                    cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
                }
            }
            else {
                
                cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
            }
            
        }
        
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") {
            
            
            if let embededUrlImage =  postImgUrl {
            
            let thumbnillImage : String = embededUrlImage
            
            
                docsIDArray = thumbnillImage.components(separatedBy: "Document\\")
                self.thumbnailImageURL = "http://192.168.1.171/TeluguChurchesRepository/FileRepository/2018/03/09/Post/Document//\(docsIDArray[1])"
            
                let videothumb = URL(string: self.thumbnailImageURL)
            
                if videothumb != nil{
            
                let request = URLRequest(url: videothumb!)
            
                let session = URLSession.shared
            
                let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            
                DispatchQueue.main.async()
                    {
            
                        cell.collectionImgView.image = UIImage(data: data!)
                                            
                        }
                                    
                                })
                                
                                dataTask.resume()
                                
                            }
                        }
        }
        
        else if (fileExtension == ".mp3") {
            
            
            
        //    http://192.168.1.121/TeluguChurchesRepository/FileRepository/2018/03/09/Post/Audio//2018030912455512.mp3
            
            print(postImgUrl)

             let audioUrlImage =  postImgUrl
       print(audioUrlImage)
            
            let newString = audioUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
           
            print(newString)

            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    cell.collectionImgView.image = UIImage(data: dataImg!)
                }
                else {
                    
                    cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
                }
            }
            else {
                
                cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
            }
            
//            let audioArr:audioRessultVo = audioArray[indexPath.row]
            
//            
//                        if let embededUrlImage =  postImgUrl {
//            
//                            let thumbnillImage : String = embededUrlImage
//            
//            
//                            audioIDArray = thumbnillImage.components(separatedBy: "embed/")
//            
//                            self.thumbnailImageURL = "https://img.youtube.com/vi/\(audioIDArray[1])/1.jpg"
//            
//                            let videothumb = URL(string: self.thumbnailImageURL)
//            
//                            if videothumb != nil{
//            
//                                let request = URLRequest(url: videothumb!)
//            
//                                let session = URLSession.shared
//            
//                                let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
//            
//                                    DispatchQueue.main.async()
//                                        {
//            
//                                            cell.collectionImgView.image = UIImage(data: data!)
//                                            
//                                    }
//                                    
//                                })
//                                
//                                dataTask.resume()
//                                
//                            }
//                        }
            
        }
        else if fileExtension == ".mp4" {
            
            
            if let embededUrlImage =  postImgUrl {
                
                let thumbnillImage : String = embededUrlImage
                
                
                self.audioIDArray = thumbnillImage.components(separatedBy: "embed/")
                
                self.thumbnailImageURL = "https://img.youtube.com/vi/\(self.audioIDArray[1])/1.jpg"
                
                let videothumb = URL(string: self.thumbnailImageURL)
                
                if videothumb != nil{
                    
                    let request = URLRequest(url: videothumb!)
                    
                    let session = URLSession.shared
                    
                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        DispatchQueue.main.async()
                            {
                                
                                cell.collectionImgView.image = UIImage(data: data!)
                                
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
            }
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
    
    //MARK:- Collectionview didSelectItemAt indexPath
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        let imageTag = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        
        
        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG"){
            
           print("images")
            
        }
            
        else if (fileExtension == ".pdf") || (fileExtension == ".docs") {
            
            print("Pdfs and docs")
            
            let imgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
                let embededUrlImage =  imgUrl
                let newString = embededUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
                if newString != nil {
            
                    savePDFWithUrl(newString!)
                                
                                
                }
            
        }
            
        else if (fileExtension == ".mp3") {
            
            let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title

            
            print(postImgUrl)
            
            let audioUrlImage =  postImgUrl
            print(audioUrlImage)
            
            let newString = audioUrlImage?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            print(newString)
            
            
            if newString != nil {
                
              //  let url = URL(string:newString!)
                
                
                //let dataImg = try? Data(contentsOf: url!)
                
               // if dataImg != nil {
                    
                    let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController
                    
                    audioViewController.audioIDArr = newString!
                   audioViewController.audioIDNameArr = title!
                    self.navigationController?.pushViewController(audioViewController, animated: true)
                    
              //  }
//                else {
//                    
//                //    cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
//                }
            }
            else {
                
             //   cell.collectionImgView.image = #imageLiteral(resourceName: "j4")
            }

            
            
            
           print("audio")
            
        }
        else if fileExtension == ".mp4" {
            
            
            let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
            

            let imgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
                        if let embededUrlImage =  imgUrl {
            
                            let thumbnillImage : String = embededUrlImage
            
            
                            self.audioIDArray = thumbnillImage.components(separatedBy: "embed/")
            
                            self.thumbnailImageURL = "https://img.youtube.com/vi/\(self.audioIDArray[1])/1.jpg"
            
                            let videothumb = URL(string: self.thumbnailImageURL)
            
                            if videothumb != nil{
            
                                let request = URLRequest(url: videothumb!)
            
                                let session = URLSession.shared
            
                                let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            
                                    DispatchQueue.main.async()
                                        {
            
                                            let  videosView = AllOffersViewController(nibName: "AllOffersViewController", bundle: nil)
                                            
                                            videosView.videoIDArray = self.audioIDArray
                                            videosView.videoIDNameArr = title!
                                            
                                            
                                            self.navigationController?.pushViewController(videosView, animated: true)
                                    }
                                    
                                })
                                
                                dataTask.resume()
                                
                            }
                        }
            
        }
        
        
    }
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
    
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
    }
    
}
