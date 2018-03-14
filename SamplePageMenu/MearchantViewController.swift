//
//  MearchantViewController.swift
//  OffersScreen
//
//  Created by Mac OS on 21/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class MearchantViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {

    
    @IBOutlet weak var mearchantTableView: UITableView!
    
   // var delegate: changeSubtitleOfIndexDelegate?

    
    let imageView = ["bible7","bible2","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible8","bible2","bible1"]

    
    let imageView1 = ["bible2","bible8","bible3","images.jpeg","7c26c4322705738c08d90691d32ff29b-brown-bible","bible9","bible2","bible7","bible6"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mearchantTableView.delegate = self
        mearchantTableView.dataSource = self
        
           
        registerTableViewCells()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func registerTableViewCells() {
        
        let nibName1  = UINib(nibName: "AllOffersCell" , bundle: nil)
        mearchantTableView.register(nibName1, forCellReuseIdentifier: "AllOffersCell")
        
        
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

