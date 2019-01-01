// 
//  NullNotificationViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 11/21/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class NullNotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var notificationDetailsLbl: UILabel!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var nullNotificationTableView: UITableView!
    
    var titleString = ""
    var descriptionString = ""
    var generatedOn = ""
    var generatedBy = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()

        nullNotificationTableView.delegate = self
        nullNotificationTableView.dataSource = self
        notificationDetailsLbl.text = "Notification Details".localize()
//        let nullNotificationCell  = UINib(nibName: "NullNotificationCell" , bundle: nil)
//        nullNotificationTableView.register(nullNotificationCell, forCellReuseIdentifier: "NullNotificationCell")
        
        let getJobByIDTableViewCell  = UINib(nibName: "GetJobByIDTableViewCell" , bundle: nil)
        nullNotificationTableView.register(getJobByIDTableViewCell, forCellReuseIdentifier: "GetJobByIDTableViewCell")
        
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        cancelBtnOutlet.layer.cornerRadius = 3.0
        cancelBtnOutlet.layer.shadowColor = UIColor.lightGray.cgColor
        cancelBtnOutlet.layer.shadowOffset = CGSize(width: 0, height: 3)
        cancelBtnOutlet.layer.shadowOpacity = 0.6
        cancelBtnOutlet.layer.shadowRadius = 2.0
        
        //NullNotificationCell
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeAnimate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let informationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "GetJobByIDTableViewCell", for: indexPath) as! GetJobByIDTableViewCell
        if indexPath.row == 0 {
             informationTableViewCell.jobIDNameLabel.text = "Title".localize()
             informationTableViewCell.jobIDDetailsLabel.text = titleString
        } else if indexPath.row == 1 {
             informationTableViewCell.jobIDNameLabel.text = "Description".localize()
             informationTableViewCell.jobIDDetailsLabel.text = descriptionString
        } else if indexPath.row == 2 {
             informationTableViewCell.jobIDNameLabel.text = "Generated on".localize()
             informationTableViewCell.jobIDDetailsLabel.text = generatedOn
        } else if indexPath.row == 3 {
             informationTableViewCell.jobIDNameLabel.text = "Generated by".localize()
             informationTableViewCell.jobIDDetailsLabel.text = generatedBy
        }
        return informationTableViewCell
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        
        
        removeAnimate()
        
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
