//
//  authorAudioaViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 10/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class authorAudioaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var authorAudioTableView: UITableView!
    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
   
    //MARK: -  variable declaration
    
    var imageView  = ["bible1","bible1","bible1"]
    var audioArray = Array<Any>()
    var audioResults : Array<PostByAutorIdResultInfoVO> = Array()
     var PageIndex = 1
     var audioIDArray : Array<String> = Array()
    var videoEmbededIDStr = String()
    var thumbnailImageURL = String()
    
    //MARK: -   View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorAudioTableView.delegate = self
        authorAudioTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorAudiioTableViewCell" , bundle: nil)
        authorAudioTableView.register(nibName1, forCellReuseIdentifier: "AuthorAudiioTableViewCell")
        
        if(audioResults.count > 0){
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
    
    //MARK: -   UITable view delegate and datasource methods

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return audioResults.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorAudiioTableViewCell", for: indexPath) as! AuthorAudiioTableViewCell
                
                
        let title = (audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.title
        
        
              cell.audioLabel.text = title
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
//        let postImgUrl = (self.audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.postImage
//
//        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
//
//        let categoryId = (self.audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.categoryId
//
//
//        let audioID = (self.audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.id
//
//        if newString != nil {
//
//
//            let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController") as! AudioViewController

       //   audioViewController.audioIDArr = "https://archive.org/download/testmp3testfile/mpthreetest.mp3"
//            audioViewController.audioIDArr = newString!
//            audioViewController.audioIDNameArr = title!
//            audioViewController.audioID = audioID!
//            audioViewController.categoryID = categoryId!
//            self.navigationController?.pushViewController(audioViewController, animated: true)


       // } else {


       // }
        
        let imageTag = self.audioResults[indexPath.row]
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
                           // videosVC.videoEmbededIDStr = "_9D_v6unOl0"
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
        
        
       
        
            
        print("audio")
        
        }
    }
   
    
    








