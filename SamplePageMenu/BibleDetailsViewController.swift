//
//  BibleDetailsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var showNav = false
    
    var LangText:String = ""
    
    var authorID : Int = 12
    
    var bibleChaptersArr:[BibleDetailsResultVO] = Array<BibleDetailsResultVO>()
    
    var catgoryName:String = ""
    
    var appVersion:String = ""
    
    
    var chapterCountStr:Int = 0
    var indexCount:Int = 0
    
    var bibleCArr = Array<Int>()
    
    
    
    var backTitleStr:String = ""
    
    
    
    @IBOutlet weak var bibleDetailsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName  = UINib(nibName: "BibleBooksTableViewCell" , bundle: nil)
        self.bibleDetailsTableView.register(nibName, forCellReuseIdentifier: "BibleBooksTableViewCell")
        
        
        bibleDetailsTableView.delegate = self
        bibleDetailsTableView.dataSource = self
        
        
        
        getBibleDetailsAPICall()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Holy Bible Books".localize(), backTitle: "  \(catgoryName)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return bibleChaptersArr.count
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 40.0
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BibleBooksTableViewCell", for: indexPath) as! BibleBooksTableViewCell
        
        let booksList:BibleDetailsResultVO = bibleChaptersArr[indexPath.row]
        
        cell.bibleBookLabel.text = booksList.name
        cell.accessoryType = .disclosureIndicator
        cell.chapterCountLabel.text = ""

        
        //        let verseCount = booksList.id
        //        cell.chapterCountLabel.text = "\(verseCount!)"
        
        
        return cell
    }
    
    
    
    func getBibleDetailsAPICall(){
        
        
        let bibleDetailsAPI = GETBIBLEAPITELUGUURL
        
        
        serviceController.getRequest(strURL: bibleDetailsAPI, success: { (result) in
            
            
            if result.count > 0 {
                
                print(result)
                
                let respVO:BibleDetailsInfoVO = Mapper().map(JSONObject: result)!
                
                
                let isSuccess = respVO.isSuccess
                
                if isSuccess == true {
                    
                    self.bibleChaptersArr = respVO.listResult!
                    
                }
                
                self.bibleDetailsTableView.reloadData()
            }
            
            
        }) { (failureMassege) in
            
            
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        let booksList:BibleDetailsResultVO = bibleChaptersArr[indexPath.row]
        
        
        
        
        let chapterViewController = self.storyboard?.instantiateViewController(withIdentifier: "BibleDetailsCellViewController") as! BibleDetailsCellViewController
        
        chapterViewController.listUrl = booksList.url!
        
        
        //        chapterViewController.indexCount = indexPath.row
        
        
        self.navigationController?.pushViewController(chapterViewController, animated: true)
        
        
    }
    
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kuserId)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set("1", forKey: "1")
        
        
        self.navigationController?.popViewController(animated: true)
        
        navigationItem.leftBarButtonItems = []
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        print("Back Button Clicked......")
        
    }
    
    
    
    
    
}
