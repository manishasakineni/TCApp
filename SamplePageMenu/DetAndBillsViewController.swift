//
//  DetAndBillsViewController.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class DetAndBillsViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var detAndBillsTableView: UITableView!
    
    var delegate: churchChangeSubtitleOfIndexDelegate?

    
    
    let imageView = ["bible2","bible8","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible2","bible7","bible6"]
    
    let imageView1 = ["bible6","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible1"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detAndBillsTableView.delegate = self
        detAndBillsTableView.dataSource = self
        
        
        registerTableViewCells()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func registerTableViewCells() {
        
        let nibName1  = UINib(nibName: "YoutubePlayerCell" , bundle: nil)
        detAndBillsTableView.register(nibName1, forCellReuseIdentifier: "YoutubePlayerCell")
        
        
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return imageView.count
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let youtubePlayerCell = tableView.dequeueReusableCell(withIdentifier: "YoutubePlayerCell", for: indexPath) as! YoutubePlayerCell
        
        
        youtubePlayerCell.allOffersImageView.image = UIImage(named: String(imageView[indexPath.row]))
        
        
        youtubePlayerCell.allOffersImg.image = UIImage(named: String(imageView1[indexPath.row]))
        

        
        return youtubePlayerCell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
}

