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
    
        
        let postImgUrl = (self.audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.postImage
        
        let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        let categoryId = (self.audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.categoryId

        
        let audioID = (self.audioResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.id
        
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
    }
   
    
    








