//
//  BibleBooksViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleBooksViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var catgoryName:String = ""
    
    var appVersion:String = ""
    
    var showNav = false
    
    let cellReuseIdentifier = "cell"
    
    var bibleCArr = Array<Int>()
    
    var verseCArr = Array<Int>()
    
    var verseDetailArray = Array<String>()
    
    //    var verArray = Array<String>()
    
    var verArray:[BibleResultVo] = Array<BibleResultVo>()
    
    var verseArrCount = Array<Int>()
    
    var bibleVerseCArr = Array<String>()
    
    var bibleChaptersArr:[BibleChapterVo] = Array<BibleChapterVo>()
    
    var bookList = ["Genesis", "Exodus", "Leviticus", "Numbers","Deuteronomy","Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs",  "Ecclesiastes","Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai",  "Zechariah",  "Malachi",  "Matthew", "Mark", "Luke",  "John",  "Acts","Romans",  "1 Corinthians","2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John",  "2 John","3 John", "Jude", "Revelation"]
    
    var chaptersCount : Dictionary = Dictionary<String,Any>()
    var versesCount : Dictionary = Dictionary<String,Any>()
    var verseStringCount : Dictionary = Dictionary<String,Any>()
    
    //    var bibleCArr:[BibleChapterVo] = Array<BibleChapterVo>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bibleBookAPICall()
        
        //        self.booksTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let nibName  = UINib(nibName: "BibleBooksTableViewCell" , bundle: nil)
        self.booksTableView.register(nibName, forCellReuseIdentifier: "BibleBooksTableViewCell")
        
        
        booksTableView.delegate = self
        booksTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "", backTitle: "  \(catgoryName)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            return 50.0
        }
        else {
            
            return 60.0
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BibleBooksTableViewCell", for: indexPath) as! BibleBooksTableViewCell
        
        
        //        let cell:UITableViewCell = self.booksTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        //        let booksList = bibleChaptersArr[indexPath.row]
        
        cell.bibleBookLabel.text = self.bookList[indexPath.row]
        
        cell.chapterCountLabel.text = "\(self.bibleCArr[indexPath.row])"
        
        
        
        
        
        cell.selectionStyle = .none
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        let booksList:BibleChapterVo = bibleChaptersArr[indexPath.row]
        
        let verseObj = booksList.Chapter
        
        for objj in verseObj! {
            
            let count = objj.Verse?.count
            
            self.verseCArr.append(count!)
            
            self.verArray = objj.Verse!
            
            
        }
        
        for obj in self.verArray {
            
            let vers = obj.Verse
            
            self.verseDetailArray.append(vers!)
            
        }
        
        
        let chapterViewController = self.storyboard?.instantiateViewController(withIdentifier: "BibleChaptersViewController") as! BibleChaptersViewController
        
        chapterViewController.chapterCountStr = self.bibleCArr[indexPath.row]
        
        chapterViewController.indexCount = indexPath.row
        
        chapterViewController.verseCountStr = self.verseCArr
        
        chapterViewController.vDetailArray = self.verseDetailArray
        
        chapterViewController.verseStringCount = self.verseStringCount
        
        self.navigationController?.pushViewController(chapterViewController, animated: true)
        
        
    }
    
    
    func bibleBookAPICall(){
        
        
        let strUrl = BIBLEAPIURL
        
        print(strUrl)
        
        
        
        serviceController.getRequest(strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    //                    print(result)
                    
                    let respVO:BibleBookVo = Mapper().map(JSONObject: result)!
                    
                    let bookResp = respVO.Book
                    
                    // print("bookResp:\(String(describing: bookResp?.count))")
                    
                    var i = 0
                    
                    for eachArray in bookResp! {
                        
                        let countt = eachArray.Chapter?.count
                        
                        self.chaptersCount.updateValue(countt!, forKey: "\(i)")
                        
                        let chapterArray = eachArray.Chapter
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
                        
                        self.bibleChaptersArr.append(eachArray)
                        i = i + 1
                        
                        //print(self.bibleChaptersArr.count)
                        
                    }
                    
//                    print(self.chaptersCount)
//                    print(self.versesCount)
//                    
//                    print(self.verseStringCount)
                    //                    for eacObj in self.bibleChaptersArr {
                    //
                    //                        let chapterObj = eacObj.Chapter
                    //
                    //                        for verseObj in chapterObj! {
                    //
                    //                            let countt = verseObj.Verse?.count
                    //
                    //                            self.verseArrCount.append(countt!)
                    //
                    //                            print("Count:\(countt)")
                    //
                    //                            let oj = verseObj.Verse
                    //
                    //                            for verseList in oj! {
                    //
                    //                                let objjj = verseList.Verse
                    //
                    //                                self.bibleVerseCArr.append(objjj!)
                    //                            }
                    //
                    //
                    //                        }
                    //                    }
                    
                    self.booksTableView.reloadData()
                    
                    //                            for (index, image) in self.bannerImageArr.enumerated() {
                    
                    //
                    //
                    //                            }
                    //
                    
                    
                    
            }
            
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
    }
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        
        appDelegate.window?.rootViewController = rootController
        
    }
    
}
