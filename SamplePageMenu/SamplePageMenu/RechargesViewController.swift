//
//  RechargesViewController.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import youtube_ios_player_helper


class RechargesViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,UIWebViewDelegate{

    @IBOutlet weak var rechargeTableView: UITableView!
    
    
    
    
    

    
    
    
    
    var delegate: churchChangeSubtitleOfIndexDelegate?

    
    var playerVars = Dictionary<String, Any>()

    
    
    
    
    
    let imageView = ["bible6","bible7","bible8","bible9","images.jpeg","bible3","bible8","bible2","bible1"]
    
    let imageView1 = ["bible1","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible7","bible6"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rechargeTableView.delegate = self
        rechargeTableView.dataSource = self
        
        
    

        
        
        
//        audioWebView.delegate = self
//        if let url = URL(string:"http://radio.spainmedia.es/wp-content/uploads/2015/12/ogilvy.mp3") {
//            let request = URLRequest(url: url)
//            audioWebView.loadRequest(request)
//        }
        
        registerTableViewCells()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func registerTableViewCells() {
        
        
        let nibName3  = UINib(nibName: "AllOffersCell" , bundle: nil)
        rechargeTableView.register(nibName3, forCellReuseIdentifier: "AllOffersCell")
        
        
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
        
        
                    let allOffersCell = tableView.dequeueReusableCell(withIdentifier: "AllOffersCell", for: indexPath) as! AllOffersCell
        
        
        
        allOffersCell.allOffersImageView.image = UIImage(named: String(imageView[indexPath.row]))
        
        
        allOffersCell.allOffersImg.image = UIImage(named: String(imageView1[indexPath.row]))
        

        

                    return allOffersCell
        
 
        
    }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
   
    
}

