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
    
     var PageIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       authorAudioTableView.delegate = self
        authorAudioTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "HeadImgTableViewCell" , bundle: nil)
        authorAudioTableView.register(nibName1, forCellReuseIdentifier: "HeadImgTableViewCell")

        
        authorAPIService()
        
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
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
                
                
        
        cell.churchImage.image = UIImage(named: String(imageView[indexPath.row]))
        
     
        
        
        return cell
        
        
        
    }
    
   
    
    func authorAPIService(){
        
        
        
        
        let params = ["pageIndex": PageIndex,
                      "pageSize": 100,
                      "sortbyColumnName": "UpdatedDate",
                      "sortDirection": "desc",
                      "authorId": 2,
                      "mediaTypeId": ""
            
            
            ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: GETPOSTBYAUTHORIDAPI as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            
            print("\(result)")
            
            let respVO:PostByAutorIdVO = Mapper().map(JSONObject: result)!
            
            print("responseString = \(respVO)")
            
            
            let statusCode = respVO.isSuccess
            
            print("StatusCode:\(String(describing: statusCode))")
            
            
            
            
        }) { (failureMessage) in
            
            
            
        }
    }


    
}
