//
//  CPpageMenuViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 08/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class CPpageMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var cppagemenuTableview: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        cppagemenuTableview.delegate = self
        cppagemenuTableview.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 1
        
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        
        
        return 43
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "menuNameTableViewCell")
            as!menuNameTableViewCell
        
        
        
        
        return cell1
        
    }
    
    
}
