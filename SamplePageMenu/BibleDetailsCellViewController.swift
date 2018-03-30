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
    
    
    var catgoryName:String = ""
    
    var appVersion:String = ""
    var listUrl :String = ""
    
    var bibleCArr = Array<Int>()
    
    var chapterCount:Int = 0
    var verseCountStr = Array<Int>()
    var versDetailArray = Array<String>()
    var vDetailArray = Array<String>()
    
    var indexCount:Int = 0
    
    var backTitleStr:String = ""
    
    //    var verseStringCount : Dictionary = Dictionary<String,Any>()
    
    var chaptersCount : Dictionary = Dictionary<String,Any>()
    var versesCount : Dictionary = Dictionary<String,Any>()
    var verseStringCount : Dictionary = Dictionary<String,Any>()
    
    
    var bibleChaptersArr:[BibleDetailsCellVO] = Array<BibleDetailsCellVO>()
    
    //    var bibleChaptersArr:[BibleChapterVo] = Array<BibleChapterVo>()
    
    //    var bibleVerseArr = Array<String>()
    
    var bibleVerseArr:[BibleDetailsCellIResultVo] = Array<BibleDetailsCellIResultVo>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("verseCountStr:\(verseCountStr)")
        
        
        getBibleDetailsCellAPICall()
        
        let nibName  = UINib(nibName: "BibleBooksTableViewCell" , bundle: nil)
        
        self.bibleDetailsCellTableView.register(nibName, forCellReuseIdentifier: "BibleBooksTableViewCell")
        
        
        bibleDetailsCellTableView.delegate = self
        bibleDetailsCellTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Holy Bible Books".localize(), backTitle: "  \(catgoryName)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
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
        
        
        let booksList:BibleDetailsCellVO = bibleChaptersArr[indexPath.row]
        
        
        let verseCount = booksList.Verse?.count
        
        cell.chapterCountLabel.text = "\(verseCount!)"
        
        cell.bibleBookLabel.text = "Chapter \(indexPath.row)"
        
        
        return cell
    }
    
    
    
    func getBibleDetailsCellAPICall(){
        
        
        let newString = listUrl.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        
        let bibleDetailsCellAPI = newString
        
        
        serviceController.getRequest(strURL: bibleDetailsCellAPI, success: { (result) in
            
            
            if result.count > 0 {
                
                print(result)
                
                let respVO:BibleDetailsCellInfoVo = Mapper().map(JSONObject: result)!
                
                
                let verseArr = respVO.Chapter
                
                self.bibleChaptersArr = respVO.Chapter!
                
                
                var i = 0
                
                //                for eachArray in bookResp! {
                
                let countt = respVO.Chapter?.count
                
                self.chaptersCount.updateValue(countt!, forKey: "\(i)")
                
                let chapterArray = respVO.Chapter
                var j = 0
                for eachChapter in chapterArray!{
                    
                    let verseCount = eachChapter.Verse?.count
                    
                    let verseDict = eachChapter.Verse
                    
                    for eachVerseDict in verseDict!{
                        
                        print(eachVerseDict.Verse!)
                        
                    }
                    self.versesCount.updateValue(verseDict!, forKey: "\(j)")
                    self.verseStringCount.updateValue(self.versesCount, forKey: "\(i)")
                    
                    j = j + 1
                }
                
                
                
                self.bibleCArr.append(countt!)
                
                //print("Count:\(countt)")
                
                //                    self.bibleChaptersArr.append(chapterArray)
                i = i + 1
                //                }
                
                
                //                for obj in verseArr! {
                //
                //                      let verseCount = obj.Verse
                //
                //                    for list in verseCount! {
                //
                //                        let versee = list.Verse
                //                         let verseId = list.Verseid
                //
                //                        self.bibleVerseArr.append(BibleDetailsCellIResultVo.init(Verseid:verseId, Verse: versee))
                //                    }
                //
                //
                //                }
                
                self.bibleDetailsCellTableView.reloadData()
            }
            
            
        }) { (failureMassege) in
            
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        //        let booksList:BibleDetailsCellIResultVo = bibleVerseArr[indexPath.row]
        
        let booksList:BibleDetailsCellVO = bibleChaptersArr[indexPath.row]
        
        
        let verseCount = booksList.Verse?.count
        
        
        let verseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BibleDetailsVerseViewController") as! BibleDetailsVerseViewController
        
        
        let versesDict = verseStringCount["\(indexCount)"] as? Dictionary<String,Any>
        
        let capter = versesDict?["\(indexPath.row)"] as? [BibleDetailsCellIResultVo]
        
        verseViewController.verseStringCount = capter!
        
        print(capter)
        
        //        verseViewController.verseStringCount = self.verseStringCount
        
        
        verseViewController.bibleVerseArr = self.bibleVerseArr
        
        //       verseViewController.verseCountStr = self.verseCountStr[indexPath.row]
        
        //        verseViewController.versDetailArray = self.vDetailArray
        //
        //        verseViewController.backTitleStr = backTitleStr
        //
        //        verseViewController.chapterCount = indexPath.row
        //
        //        let versesDict = verseStringCount["\(indexCount)"] as? Dictionary<String,Any>
        //
        //        let capter = versesDict?["\(indexPath.row)"] as? [BibleDetailsCellIResultVo]
        //
        //        verseViewController.verseStringCount = capter!
        //
        //        print(capter)
        
        
        
        
        self.navigationController?.pushViewController(verseViewController, animated: true)
        
        
    }
    
    
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kuserId)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set("1", forKey: "1")
        
        
        self.navigationController?.popViewController(animated: true)
        
        navigationItem.leftBarButtonItems = []
        
        print("Back Button Clicked......")
        
    }
    
    
    
    
    
    
}