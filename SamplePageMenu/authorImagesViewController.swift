//
//  authorImagesViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 09/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class authorImagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var authorImagesTableView: UITableView!
    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
    
    //MARK: -  variable declaration
    
     var imageResults : Array<PostByAutorIdResultInfoVO> = Array()
     var imageIDArray : Array<String> = Array()
     var imagesArrayTag : Dictionary<String,Any> = Dictionary()
     var imageView = UIImageView()
     var videoEmbededIDStr = String()
     var thumbnailImageURL = String()
    
    //MARK: -   View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorImagesTableView.delegate = self
        authorImagesTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorImageTableViewCell" , bundle: nil)
        authorImagesTableView.register(nibName1, forCellReuseIdentifier: "AuthorImageTableViewCell")
       
        if(imageResults.count > 0){
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
        
        
        return imageResults.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorImageTableViewCell", for: indexPath) as! AuthorImageTableViewCell
        
        let postImgUrl = (imageResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.postImage
        
        
        let title = (imageResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.title

        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        let url = URL(string:newString!)
        let dataImg = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.authorImageView.image = UIImage(data: dataImg!)
            
        }
            
        else {
            
            cell.authorImageView.image = #imageLiteral(resourceName: "j4")
        }
        
          cell.imageLbl.text = title
        
        return cell
        
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let imageTag = self.imageResults[indexPath.row]
        
        
        let postImgUrl = imageTag.postImage
        let title = imageTag.title
        let categoryId = imageTag.categoryId
        
        
        let userID = imageTag.id
        
        if let embededUrlImage =  postImgUrl {
            
            let thumbnillImage : String = embededUrlImage
            
            self.imageIDArray = thumbnillImage.components(separatedBy: "embed/")
            
            DispatchQueue.main.async()
                        {
                            
            let  videosVC =  YoutubePlayerViewController(nibName: "YoutubePlayerViewController", bundle: nil)
                            
            videosVC.videoNameStr = title!
            videosVC.imageUrl = postImgUrl!
            videosVC.isFromImageView = true
            videosVC.videoId = userID!
                            
            kUserDefaults.set(categoryId, forKey: "categoryId")
            kUserDefaults.set(userID, forKey: "userID")
            kUserDefaults.synchronize()
            self.navigationController?.pushViewController(videosVC, animated: true)
                            
                    }
                    
    
        }
        
    }
    
    
    

}
