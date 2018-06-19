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
    
//    var imageView  = ["bible1","bible1","bible1"]
    
     var imageResults : Array<PostByAutorIdResultInfoVO> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorImagesTableView.delegate = self
        authorImagesTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorImageTableViewCell" , bundle: nil)
        authorImagesTableView.register(nibName1, forCellReuseIdentifier: "AuthorImageTableViewCell")
       
         self.norecordsfoundLbl.isHidden = true
        
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
        
         let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
           let url = URL(string:newString!)
        
        let dataImg = try? Data(contentsOf: url!)
        
        if dataImg != nil {
            
            cell.authorImageView.image = UIImage(data: dataImg!)
            
        }
            
        else {
            
            cell.authorImageView.image = #imageLiteral(resourceName: "j4")
        }

        
        
        
        
        
        
        return cell
        
        
        
    }
    
    
    

}
