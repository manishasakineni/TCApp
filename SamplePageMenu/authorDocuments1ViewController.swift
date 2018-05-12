//
//  authorDocumentsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 09/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class authorDocumentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var authordocumentTableView: UITableView!
    
    var imageView  = ["bible1","bible1","bible1","bible1","bible1"]
    
     var documentResults : Array<PostByAutorIdResultInfoVO> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authordocumentTableView.delegate = self
        authordocumentTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorDocumentTableViewCell" , bundle: nil)
        authordocumentTableView.register(nibName1, forCellReuseIdentifier: "AuthorDocumentTableViewCell")
        
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
        
        
        return imageView.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        return 124
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorDocumentTableViewCell", for: indexPath) as! AuthorDocumentTableViewCell
        
        
        
   //     cell.churchImage.image = UIImage(named: String(imageView[indexPath.row]))
        
        
        
        
        return cell
        
        
        
    }
    
    
    

}
