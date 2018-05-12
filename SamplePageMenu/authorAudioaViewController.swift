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
    
    
    var imageView  = ["bible1","bible1","bible1"]
    
      var audioArray = Array<Any>()
    
    var audioResults : Array<PostByAutorIdResultInfoVO> = Array()

    
     var PageIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorAudioTableView.delegate = self
        authorAudioTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorAudiioTableViewCell" , bundle: nil)
        authorAudioTableView.register(nibName1, forCellReuseIdentifier: "AuthorAudiioTableViewCell")

        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return audioResults.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        return 124
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorAudiioTableViewCell", for: indexPath) as! AuthorAudiioTableViewCell
                
                
        let postImgUrl = (audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.postImage
        
        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        let url = URL(string:newString!)
        
        let dataImg = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.authorAudioImage.image = UIImage(data: dataImg!)
            
        }
            
        else {
            
            cell.authorAudioImage.image = #imageLiteral(resourceName: "j4")
        }
    
        
        
        return cell
        

        
        
        
    }
    
   
    
    
    }

    
    

    
    
  
