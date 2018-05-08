//
//  PostEventDetailsViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 5/8/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class PostEventDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var postEventTableView: UITableView!
    @IBOutlet weak var HeadImageTitle: UIImageView!
    var delegate: eventDetailsSubtitleOfIndexDelegate?
    
    //MARK: -  variable declaration
    
    var documentController: UIDocumentInteractionController = UIDocumentInteractionController()
    
    var saveLocationString      : String        = ""
    var isSavingPDF             : Bool          = false
    var pdfTitle                : String        = ""
    var isDownloadingOnProgress : Bool          = false
    var navigationStr = String()
    
    
    
    var catgoryImg:String = ""

    var imagesArray : [ImagesResultVo] = Array<ImagesResultVo>()
    
    var allCagegoryListArray : CategoriesListResultVo?

    var eventID = Int()
    var categoryStr : Array<String> = Array()
    var imagesArrayTag : Dictionary<String,Any> = Dictionary()
    var numberOfRows : Dictionary<String,Any> = Dictionary()

    var isResponseFromServer = false

    var imageView = UIImageView()

    
    var videoIDArray : Array<String> = Array()
    
    var docsIDArray : Array<String> = Array()
    
    var audioIDArray : Array<String> = Array()
    
    var gggg = String()
    
    
    var thumbnailImageURL = String()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postEventTableView.delegate = self
        postEventTableView.dataSource = self
        
        
        let nibName  = UINib(nibName: "homeCategoriesCell" , bundle: nil)
        postEventTableView.register(nibName, forCellReuseIdentifier: "homeCategoriesCell")

        
        let newString = catgoryImg.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        
        let url = URL(string:newString)
        
        if url != nil {
            
            let dataImg = try? Data(contentsOf: url!)
            
            if dataImg != nil {
                
                HeadImageTitle.image = UIImage(data: dataImg!)
            }
            else {
                
                HeadImageTitle.image = #imageLiteral(resourceName: "j4")
            }
            
        }
        else {
            
            HeadImageTitle.image = #imageLiteral(resourceName: "j4")
        }

        
        getVideosAPICall()

        
        // Do any additional setup after loading the view.
    }

    
//MARK: -    Get Videos API Call
    
    
    func getVideosAPICall(){
        
        
        
        let urlStr = POSTBYEVENTIDAPI + String(eventID)
        
        print("POSTBYEVENTIDAPI",urlStr)
        serviceController.getRequest(strURL: urlStr, success: { (result) in
            
            DispatchQueue.main.async()
                {
                    
                    print(result)
                    
                    if result.count > 0 {
                        
                        
                        let respVO:GetCategoriesResultVo = Mapper().map(JSONObject: result)!
                        
                        let isSuccess = respVO.isSuccess
                        
                        self.imagesArray.removeAll()
                        
                        if isSuccess == true {
                            
                            
                            self.allCagegoryListArray = respVO.result
                            
                            if respVO.result != nil{
                                
                                
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
                                
                                self.isResponseFromServer = true
                                self.postEventTableView.reloadData()
                            }
                        }
                            
                        else{
                            
                            
                        }
                        
                        
                    }
                    
            }
            
        }) { (failureMessage) in
            
            
            
            
        }
        
        self.postEventTableView.reloadData()
    }
    //MARK: -   TableView Delegate & DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
            
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
      //  if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCategoriesCell", for: indexPath) as! homeCategoriesCell
            
            cell.homeCollectionView.register(UINib.init(nibName: "homeCategoriesCollectionCell", bundle: nil),
                                             forCellWithReuseIdentifier: "homeCategoriesCollectionCell")
            cell.homeCollectionView.tag = indexPath.row
            
            cell.selectionStyle = .none
            
            cell.homeCollectionView.collectionViewLayout.invalidateLayout()
            
            cell.homeCollectionView.reloadData()
            
            
            cell.homeCollectionView.delegate = self
            cell.homeCollectionView.dataSource = self
            
            if categoryStr.count > 0 {
                
                cell.categorieName.text = self.categoryStr[indexPath.row]
                
            }
            
            return cell
            
            
       // }
        
      
        
       // return UITableViewCell()
    }
    

   

// Mark :- Collectionview  Delegate & DataSource methods


    
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
        
        
        let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
        
        let fileExtension = (imageTag?[indexPath.row] as? ImagesResultVo)?.fileExtention
        
        
        
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
                
                
                let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController
                
                audioViewController.audioIDArr = newString!
                audioViewController.audioIDNameArr = title!
                self.navigationController?.pushViewController(audioViewController, animated: true)
                
                
            }
            else {
                
            }
            
            
            
            
            print("audio")
            
        }
        else if fileExtension == ".mp4" {
            
            
            let postImgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            let title = (imageTag?[indexPath.row] as? ImagesResultVo)?.title
            let categoryId = (imageTag?[indexPath.row] as? ImagesResultVo)?.categoryId
            
            let imgUrl = (imageTag?[indexPath.row] as? ImagesResultVo)?.postImage
            
            let userID = (imageTag?[indexPath.row] as? ImagesResultVo)?.id
            
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
                                
                                let  videosVC =  YoutubePlayerViewController(nibName: "YoutubePlayerViewController", bundle: nil)
                                
                                videosVC.videoEmbededIDStr = self.audioIDArray[1]
                                videosVC.videoNameStr = title!
                                
                                
                                kUserDefaults.set(categoryId, forKey: "categoryId")
                                kUserDefaults.set(userID, forKey: "userID")
                                kUserDefaults.synchronize()
                                self.navigationController?.pushViewController(videosVC, animated: true)
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
        
    }
    
    
    private func savePDFWithUrl(_ urlString: String) {
        
        var filePath : URL?
        
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
                                    
                                    
                                    self.openSelectedDocumentFromURL(documentURLString: self.saveLocationString)
                                    print( self.saveLocationString)
                                    print(  self.openSelectedDocumentFromURL)
                                    
                                    
                                    self.openPDFinPDFReader()
                                }
                                
                            } else {
                                
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                    
                                })
                            }
                            
                        } else {
                            
                            do {
                                
                                self.isDownloadingOnProgress = true
                                
                                let imageData : Data? = try Data.init(contentsOf: url)
                                
                                if imageData == nil {
                                    
                                    self.isDownloadingOnProgress = false
                                    
                                    DispatchQueue.main.async {
                                        
                                    }
                                    
                                } else {
                                    
                                    do {
                                        
                                        try imageData?.write(to: filePath!, options: Data.WritingOptions.withoutOverwriting)
                                        
                                        if !self.isSavingPDF {
                                            
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.openPDFinPDFReader()
                                            }
                                            
                                            
                                        } else {
                                            
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                
                                            }
                                        }
                                        
                                    } catch let error {
                                        
                                        self.isDownloadingOnProgress = false
                                        
                                        DispatchQueue.main.async {
                                            
                                            
                                        }
                                    }
                                }
                                
                            } catch let error {
                                
                                print(error.localizedDescription)
                                
                                self.isDownloadingOnProgress = false
                                
                                DispatchQueue.main.async {
                                    
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