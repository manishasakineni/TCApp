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
    
      var imageArray = ["audioImg","BibleBook","calvary_cross","audioImg","BibleBook","audioImg","calvary_cross","audioImg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detAndBillsTableView.delegate = self
        detAndBillsTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "HeadImgTableViewCell" , bundle: nil)
        detAndBillsTableView.register(nibName1, forCellReuseIdentifier: "HeadImgTableViewCell")
        

        
        // Do any additional setup after loading the view.
    }
    
    
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return imageArray.count
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        return 124
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
        
        cell.churchImage.image = UIImage(named: String(imageArray[indexPath.row]))
        
        
        
        
        return cell
        
        
    }
  
    
    
    
    
    func churchIdAPIService(){
        
        
        let  EVENTCOMMENTSAPISTR = GETPOSTBYCHURCHIDAPI
        
        let params = ["pageIndex": 1,
                      "pageSize": 100,
                      "sortbyColumnName": "UpdatedDate",
                      "sortDirection": "desc",
                      "authorId": 1,
                      "mediaTypeId": (Any).self
            
            
            ] as [String : Any]
        
        print("dic params \(params)")
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: EVENTCOMMENTSAPISTR as NSString, postParams: params as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            print("\(result)")
            
            let respVO:PostByAutorIdVO = Mapper().map(JSONObject: result)!
            print("responseString = \(respVO)")
            
            
            let statusCode = respVO.isSuccess
            
            print("StatusCode:\(String(describing: statusCode))")
            
            if statusCode == true
            {
                
                
                let successMsg = respVO.endUserMessage
                
                
                
                
            }
                
            else {
                
                let failMsg = respVO.endUserMessage
                
                
                return
                
                
                
            }
            
            
        }) { (failureMessage) in
            
            
            
        }
    }
    
    

    
    
    
}

