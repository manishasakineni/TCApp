//
//  EventDetailsViewController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize

class EventDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var eventDetailsTableView: UITableView!
    
    var documentController: UIDocumentInteractionController = UIDocumentInteractionController()
    
    var saveLocationString : String             = ""
    var isSavingPDF     : Bool                  = false
    var pdfTitle        : String                = ""
    var isDownloadingOnProgress : Bool  = false
    
    var eventsDetailsArray:[EventDetailsListResultVO] = Array<EventDetailsListResultVO>()
  //  EventDetailsListResultVO
    
    var eventID = Int()
    
    var eventChurchName = ""
    
    var eventName = ""

    var catgoryID:Int = 0
    var churchName1 : String = ""

    
    var imagesArray : [ImagesResultVo] = Array<ImagesResultVo>()
    
    var allCagegoryListArray : CategoriesListResultVo?

    
    var noOfRows : Array<Dictionary<String,Any>> = Array()
    var numberOfRows : Dictionary<String,Any> = Dictionary()
    
    var imagesArrayTag : Dictionary<String,Any> = Dictionary()
    var isResponseFromServer = false

    var videoIDArray : Array<String> = Array()
    
    var docsIDArray : Array<String> = Array()
    
    var audioIDArray : Array<String> = Array()
    
    var gggg = String()
    
    var categoryStr : Array<String> = Array()
    
    
    var authorName : String = ""
    var appVersion  : String = ""
    
     var imageView = UIImageView()

    
    var thumbnailImageURL = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        eventDetailsTableView.delegate = self
        eventDetailsTableView.dataSource = self
        
        let headImgTableViewCell = UINib(nibName: "HeadImgTableViewCell", bundle: nil)
        eventDetailsTableView.register(headImgTableViewCell, forCellReuseIdentifier: "HeadImgTableViewCell")
        
        let informationTableViewCell  = UINib(nibName: "InformationTableViewCell" , bundle: nil)
        eventDetailsTableView.register(informationTableViewCell, forCellReuseIdentifier: "InformationTableViewCell")
        
        let nibName  = UINib(nibName: "homeCategoriesCell" , bundle: nil)
        eventDetailsTableView.register(nibName, forCellReuseIdentifier: "homeCategoriesCell")
        
        getEventDetailsByIdApiCall()
        getVideosAPICall()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        

        Utilities.authorDetailsnextViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr: self, titleView: nil, withText: self.eventName, backTitle: "  \(authorName)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        
        
    }
    

    
    
    func getEventDetailsByIdApiCall(){
    
     let getEventDetailsByIdApi = GETEVENTDETAILSBYID + String(eventID)
        
        serviceController.getRequest(strURL: getEventDetailsByIdApi, success: { (result) in
            
            if result.count > 0{
            
                let responseVO:EventDetailsVO = Mapper().map(JSONObject: result)!
                
                let isSuccess = responseVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
                
                if isSuccess == true{
                    
                    
                    self.eventsDetailsArray = (responseVO.listResult)!
                    
                    print(self.eventsDetailsArray)
                
                }
                
                
                else{
                
                
                
                }
                
            
            }
            
            else{
            
            
                print(" No result Found ")
            
            }
            self.eventDetailsTableView.reloadData()
            
        }) { (failureMessege) in
            
            print(failureMessege)
            
        }
    
    
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
                        
                        if !(videoList?.isEmpty)! {
                            
                            self.categoryStr.append("Videos")
                        }

                        
                        for authorDetails in videoList!{
                            
                            self.numberOfRows.updateValue(videoList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(videoList, forKey: "\(i)")
                            
                            self.imagesArray.append(authorDetails)
                        }
                        
                        i = (videoList?.count)! > 0 ? i + 1 : i
                        
                        let audioList = self.allCagegoryListArray?.audios
                        
                        if !(videoList?.isEmpty)! {
                            
                            self.categoryStr.append("Audios")
                        }
                        
                        for audioDetails in audioList!{
                            
                            self.numberOfRows.updateValue(audioList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(audioList, forKey: "\(i)")
                            
                            self.imagesArray.append(audioDetails)
                        }
                        
                        i = (audioList?.count)! > 0 ? i + 1 : i
                        
                        let docsList = self.allCagegoryListArray?.documents
                        
                        if !(videoList?.isEmpty)! {
                            
                            self.categoryStr.append("Documents")
                        }

                        
                        for docsDetails in docsList!{
                            
                            self.numberOfRows.updateValue(docsList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(docsList, forKey: "\(i)")
                            
                            self.imagesArray.append(docsDetails)
                        }
                        
                        i = (docsList?.count)! > 0 ? i + 1 : i
                        
                        let imageList = self.allCagegoryListArray?.images
                        
                        if !(videoList?.isEmpty)! {
                            
                            self.categoryStr.append("Images")
                        }
                        
                        for imageDetails in imageList!{
                            
                            self.numberOfRows.updateValue(imageList?.count, forKey: "\(i)")
                            
                            self.imagesArrayTag.updateValue(imageList, forKey: "\(i)")
                            
                            self.imagesArray.append(imageDetails)
                        }
                        
                        //                        let videoList = self.allCagegoryListArray?.audios
                        self.isResponseFromServer = true
                        self.eventDetailsTableView.reloadData()
                        // print(self.authorDetailsArray)
                        
                    }
                        
                    else{
                        
                        
                    }
                    
                    
                    //  }
            }
            
            
            
        }) { (failureMessage) in
            
            
            
            
        }
        
        
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {

        return 7
        }
       
        else{
        
            if(isResponseFromServer == true){
                
                return numberOfRows.count
                
            }
            
        return 0
            
        }
        
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
        
        if indexPath.row == 0{
            
            return 140
        
        }

        else{
        
            return UITableViewAutomaticDimension
        
        }
    }
        
        else {
        
        
        return 150 
        
        }
    
}
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
         
        if eventsDetailsArray.count > 0 {
            
            let eventList: EventDetailsListResultVO = self.eventsDetailsArray[0]
            
            
        
        if indexPath.row == 0{
        
        let headImgTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
        
        headImgTableViewCell.churchNameLabel.text = eventList.churchName
          

            
        return headImgTableViewCell
        
        }
        
        else{
        
        let informationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
            
            if indexPath.row == 1 {
            
                informationTableViewCell.infoLabel.text = "Church Name".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.churchName
            
            }
            
            if indexPath.row == 2 {
                
                informationTableViewCell.infoLabel.text = "Registration Number".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.registrationNumber
                
            }
            
            if indexPath.row == 3 {
                
                informationTableViewCell.infoLabel.text = "Event Name:".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.title
                
            }
            
            if indexPath.row == 4 {
                
                informationTableViewCell.infoLabel.text = "Contact Number".localize()
                
                informationTableViewCell.addressLabel.text =  eventList.contactNumber
                
            }

            
            if indexPath.row == 5 {
                
                informationTableViewCell.infoLabel.text = "Start Date".localize()
                
                let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.startDate!)
                
                

                
                informationTableViewCell.addressLabel.text =  startAndEndDate1
            }
            
            if indexPath.row == 6 {
                
                informationTableViewCell.infoLabel.text = "End Date".localize()
                
                let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString: eventList.endDate!)
                
                informationTableViewCell.addressLabel.text =  startAndEndDate1
                
            }
            
            return informationTableViewCell
        }
            
        }
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCategoriesCell", for: indexPath) as! homeCategoriesCell
            
            cell.homeCollectionView.register(UINib.init(nibName: "homeCategoriesCollectionCell", bundle: nil),
                                             forCellWithReuseIdentifier: "homeCategoriesCollectionCell")
            cell.homeCollectionView.tag = indexPath.row
            
            cell.selectionStyle = .none
            
            cell.homeCollectionView.collectionViewLayout.invalidateLayout()
            
            
            cell.homeCollectionView.delegate = self
            cell.homeCollectionView.dataSource = self
            
           cell.categorieName.text = self.categoryStr[indexPath.row]

            
            return cell
            
        
        }
        return UITableViewCell()
        
    }
    
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            let dateString3 = invDtArray2[0]
            
            print(dateString1)
            //   let timeString = invDtArray[1]
            //  print(timeString)
            
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString3 != "" || dateString != "."){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString3)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "," + newDateStr1
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


    
}

    
    
   // Mark :- Collectionview  Delegate methods
    
    extension EventDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.numberOfRows.count > 0 {
        
        let totalItems = self.numberOfRows["\(collectionView.tag)"] as? Int
        
        print("totalItems:\(String(describing: totalItems))")
        
        return totalItems!
            
        }
        
        return 0
        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCategoriesCollectionCell", for: indexPath) as! homeCategoriesCollectionCell
        
        let imageTag = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        
        let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
        
//        let mediaName = (imageTag?[indexPath.row] as? ImagesResultVo)?.mediaType
        
        let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        
        
        //        print(title!)
        //        print(postImgUrl!)
        
        cell.nameLabel.text = title
        
//        if indexPath.row == 0 {
//            
//            cell.mediaTypeLabel.text = mediaName
//        }
//        else {
//            
//            cell.mediaTypeLabel.text = ""
//        }
        
        
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
                                
                                if data != nil {
                                    
                                    cell.collectionImgView.image = UIImage(data: data!)
                                }
                                
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
            }
        }
            
        else if (fileExtension == ".mp3") {
            
            cell.collectionImgView.contentMode = .scaleAspectFit
            cell.collectionImgView.image = #imageLiteral(resourceName: "audio_music")
            
          
            
        }
        else if fileExtension == ".mp4" {
            
            
            if let embededUrlImage =  postImgUrl {
                
                let thumbnillImage : String = embededUrlImage
                
                
                self.audioIDArray = thumbnillImage.components(separatedBy: "embed/")
                
                self.thumbnailImageURL = "https://img.youtube.com/vi/\(self.audioIDArray[1])/default.jpg"
                
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

        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
        
        print("You selected cell #\(indexPath.item)!")
        
        let imageTag = self.imagesArrayTag["\(collectionView.tag)"] as? NSArray
        
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        
        let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        
        
        if (fileExtension == ".png") || (fileExtension == ".jpeg") || (fileExtension == ".jpg") || (fileExtension == ".JPG"){
            
            print("images")
            
            let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
            
            if newString != nil {
                
                let url = URL(string:newString!)
                
                
                let dataImg = try? Data(contentsOf: url!)
                
                if dataImg != nil {
                    
                    
                    imageView.image = UIImage(data: dataImg!)
                    imageView.frame = self.view.bounds
                    imageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    imageView.contentMode = .scaleAspectFit
                    imageView.isUserInteractionEnabled = true
                    
                    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
                    imageView.addGestureRecognizer(tap)
                    
                    self.view.addSubview(imageView)
                }
                else {
                    
                    imageView.image = #imageLiteral(resourceName: "j4")
                }
            }
            else {
                
                imageView.image = #imageLiteral(resourceName: "j4")
                
            }
            
            
            
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
                
                self.thumbnailImageURL = "https://img.youtube.com/vi/\(self.audioIDArray[1])/default.jpg"
                
                let videothumb = URL(string: self.thumbnailImageURL)
                
                if videothumb != nil{
                    
                    let request = URLRequest(url: videothumb!)
                    
                    let session = URLSession.shared
                    
                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        DispatchQueue.main.async()
                            {
                                
                                let  videosView = AllOffersViewController(nibName: "AllOffersViewController", bundle: nil)
                                
                                videosView.videoEmbededIDStr = self.audioIDArray[1]
                                videosView.videoNameStr = title!
                                
                                self.navigationController?.pushViewController(videosView, animated: true)
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
            }
            
        }
        
        
        }
        
        

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return CGSize(width: 150.0, height: 130.0)
    
        
    }
   
        func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
            sender.view?.removeFromSuperview()
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
    
    }
    
    
    
    
    
    
    
    
    
    

