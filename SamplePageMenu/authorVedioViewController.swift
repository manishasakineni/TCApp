//
//  authorVedioViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 09/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class authorVedioViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var authorVedioTableView: UITableView!
    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
    
    

    var imageView  = ["bible1","bible1","bible1","bible1","bible1"]
    
     var videoResults : Array<PostByAutorIdResultInfoVO> = Array()
    
     var audioIDArray : Array<String> = Array()
    
     var thumbnailImageURL = String()
    
     var imagesArrayTag : Dictionary<String,Any> = Dictionary()
 
    //MARK: -   View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorVedioTableView.delegate = self
        authorVedioTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorVedioTableViewCell" , bundle: nil)
        authorVedioTableView.register(nibName1, forCellReuseIdentifier: "AuthorVedioTableViewCell")
        
        if(videoResults.count > 0){
            self.norecordsfoundLbl.isHidden = true
        }else{
            self.norecordsfoundLbl.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -   UItable view delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return videoResults.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorVedioTableViewCell", for: indexPath) as! AuthorVedioTableViewCell
        
        
        let title = (videoResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.title
        

        
                
                let thumbnillImage : String = ((videoResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.embededUrl)!
                
                
                let audioIDArray = thumbnillImage.components(separatedBy: "embed/")
                
                let thumbnailImageURL = "https://img.youtube.com/vi/\(audioIDArray[1])/default.jpg"
                
                let videothumb = URL(string: thumbnailImageURL)
                
                if videothumb != nil{
                    
                    let request = URLRequest(url: videothumb!)
                    
                    let session = URLSession.shared
                    
                    let dataTask = session.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        DispatchQueue.main.async()
                            {
                                
                                if data != nil {
                                    
                                    cell.authorVedioImage.image = UIImage(data: data!)
                                    
                                }
                                
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
        
        
        cell.authorVedioLabel.text = title
        

        
        
        
        
        return cell
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
      let imageTag = self.videoResults[indexPath.row]
            
            
            let postImgUrl = imageTag.embededUrl
            let title = imageTag.title
            let categoryId = imageTag.categoryId
            
        
            let videoID = imageTag.id
            
            if let embededUrlImage =  postImgUrl {
                
                let thumbnillImage : String = embededUrlImage
                
                
                self.audioIDArray = thumbnillImage.components(separatedBy: "embed/")
                
                self.thumbnailImageURL = "https://img.m.youtube.com/vi/\(self.audioIDArray[1])/default.jpg"
                
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
                                
                                videosVC.videoId = videoID!
                                kUserDefaults.set(categoryId, forKey: "categoryId")
                                kUserDefaults.set(videoID, forKey: "videoID")
                                kUserDefaults.synchronize()
                                self.navigationController?.pushViewController(videosVC, animated: true)
                        }
                        
                    })
                    
                    dataTask.resume()
                    
                }
            }
            
        
    }
    
    
    
}
