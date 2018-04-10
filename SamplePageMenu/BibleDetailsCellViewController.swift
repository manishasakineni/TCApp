//
//  BibleDetailsCellViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleDetailsCellViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var bibleDetailsCellTableView: UITableView!
    
    @IBOutlet weak var noRecordsFoundLbl: UILabel!
    
   //MARK: -  variable declaration
    
    var catgoryName:String = ""
    
    var LangStr:String = ""
    
    var appVersion:String = ""
    var listUrl :String = ""
    
    var nameStr:String = ""
    
    var bibleCArr = Array<Int>()
    
    var chapterCount:Int = 0
    var verseCountStr = Array<Int>()
    var versDetailArray = Array<String>()
    var vDetailArray = Array<String>()
    
    var indexCount:Int = 0
    
    var backTitleStr:String = ""
    
    var chaptersCount : Dictionary = Dictionary<String,Any>()
    var versesCount : Dictionary = Dictionary<String,Any>()
    var verseStringCount : Dictionary = Dictionary<String,Any>()
    
    
    var bibleChaptersArr:[BibleDetailsCellVO] = Array<BibleDetailsCellVO>()
    
    var bibleVerseArr:[BibleDetailsCellIResultVo] = Array<BibleDetailsCellIResultVo>()
    
    //MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noRecordsFoundLbl.isHidden = true
        print("verseCountStr:\(verseCountStr)")
        
        getBibleDetailsCellAPICall()
        
        let nibName  = UINib(nibName: "BibleBooksTableViewCell" , bundle: nil)
        
        self.bibleDetailsCellTableView.register(nibName, forCellReuseIdentifier: "BibleBooksTableViewCell")
        
        
        bibleDetailsCellTableView.delegate = self
        bibleDetailsCellTableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
         self.navigationController?.navigationBar.isHidden = false
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "\(nameStr)".localize(), backTitle: "  \(catgoryName)".localize(), rightImage: "home icon", secondRightImage: "Up", thirdRightImage: "Up")
        
    }
    
    
   //MARK:- TableView  DataSource & Delegate Methods
    
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
        
        
        
        cell.accessoryType = .disclosureIndicator
        
        cell.chapterCountLabel.text = ""
        
        if LangStr == "11" {
            
           cell.bibleBookLabel.text = "Chapter \(indexPath.row + 1)"
        }
        else {
            
            cell.bibleBookLabel.text = "అధ్యాయము \(indexPath.row + 1)"
        }
        
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        let booksList:BibleDetailsCellVO = bibleChaptersArr[indexPath.row]
        
        
        let verseCount = booksList.Verse?.count
        
        
        let verseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BibleDetailsVerseViewController") as! BibleDetailsVerseViewController
        
        
        let versesDict = verseStringCount["\(indexCount)"] as? Dictionary<String,Any>
        
        let capter = versesDict?["\(indexPath.row)"] as? [BibleDetailsCellIResultVo]
        
        verseViewController.verseStringCount = capter!
        
        verseViewController.verseStringDict = verseStringCount
        
        verseViewController.nameStr = nameStr
        
        verseViewController.indexCount = indexPath.row
        
        
        verseViewController.bibleVerseArr = self.bibleVerseArr
        
        
        self.navigationController?.pushViewController(verseViewController, animated: true)
        
        
    }

    
    //MARK: -    Get Bible Details Cell API Call
    
    func getBibleDetailsCellAPICall(){
        
        
        let newString = listUrl.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        let newStr = newString.replacingOccurrences(of: " ", with: "", options: .backwards, range: nil)
        
        let bibleDetailsCellAPI = newStr
        
        
        serviceController.getRequest(strURL: bibleDetailsCellAPI, success: { (result) in
            
            
            if result.count > 0 {
                
                print(result)
                

                
                let respVO:BibleDetailsCellInfoVo = Mapper().map(JSONObject: result)!
                
            
                
                self.bibleChaptersArr = respVO.Chapter!
                
                if self.bibleChaptersArr.count > 0 {
                    
                    self.noRecordsFoundLbl.isHidden = true
                    
                    self.bibleDetailsCellTableView.isHidden = false
                    
                    
                    
                    var i = 0
                    
                    let countt = respVO.Chapter?.count
                    
                    self.chaptersCount.updateValue(countt!, forKey: "\(i)")
                    
                    let chapterArray = respVO.Chapter
                    var j = 0
                    for eachChapter in chapterArray!{
                        
                        _ = eachChapter.Verse?.count
                        
                        let verseDict = eachChapter.Verse
                        
                        for eachVerseDict in verseDict!{
                            
                            print(eachVerseDict.Verse!)
                            
                        }
                        self.versesCount.updateValue(verseDict!, forKey: "\(j)")
                        self.verseStringCount.updateValue(self.versesCount, forKey: "\(i)")
                        
                        j = j + 1
                    }
                    
                    
                    
                    self.bibleCArr.append(countt!)
                    
                    
                    i = i + 1
                    
                    
                    self.bibleDetailsCellTableView.reloadData()
                }
                else {
                    
                    self.noRecordsFoundLbl.isHidden = false
                    
                    self.bibleDetailsCellTableView.isHidden = true
                }
                
                
            }
            
            
        }) { (failureMassege) in
            
            
            
            
        }
        
        
    }
    
  
    //MARK: -    Back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set("1", forKey: "1")
        
        
        self.navigationController?.popViewController(animated: true)
        
        navigationItem.leftBarButtonItems = []
        
        print("Back Button Clicked......")
        
    }
    
    //MARK: -    Home  Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
        
        
        
        print("Home Button Clicked......")
        
    }

    
    
    
    
}
