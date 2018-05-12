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

    var imageView  = ["bible1","bible1","bible1","bible1","bible1"]
    
     var videoResults : Array<PostByAutorIdResultInfoVO> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorVedioTableView.delegate = self
        authorVedioTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorVedioTableViewCell" , bundle: nil)
        authorVedioTableView.register(nibName1, forCellReuseIdentifier: "AuthorVedioTableViewCell")
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorVedioTableViewCell", for: indexPath) as! AuthorVedioTableViewCell
        
        
        
        
        
        
        
        return cell
        
        
        
    }
    
    
    
}
