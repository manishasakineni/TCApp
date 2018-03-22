//
//  BibleVerseViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleVerseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var verseTableView: UITableView!
    
    var bibleCArr = Array<Int>()
    
    var bibleChaptersArr:[BibleChapterVo] = Array<BibleChapterVo>()
    
    var bibleVerseArr:[BibleVerseVo] = Array<BibleVerseVo>()
    
    var bibleVerseCArr = Array<String>()
    
    var versDetailArray = Array<String>()
    
    var verseCountStr:Int = 0
    
    var verseStringCount = Array<BibleResultVo>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ... verseCountStr - 1 {
            
            print (i)
            
            self.bibleCArr.append(i)
            
        }
        
        print(verseStringCount.count)
//        self.bibleBookAPICall()
        
        let nibName  = UINib(nibName: "BibleBooksTableViewCell" , bundle: nil)
        self.verseTableView.register(nibName, forCellReuseIdentifier: "BibleBooksTableViewCell")
        
        verseTableView.delegate = self
        verseTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return verseStringCount.count
        
        
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
        
                let booksList = self.verseStringCount[indexPath.row]
        
        cell.bibleBookLabel.text = booksList.Verse
        
//        cell.bibleBookLabel.text = self.versDetailArray[indexPath.row]
//        
//        cell.chapterCountLabel.text = "\(bibleCArr[indexPath.row])"
        
        
        cell.selectionStyle = .none
        
        
        
        
        return cell
    }

    func bibleBookAPICall(){
        
        
        
        let strUrl = BIBLEAPIURL
        
        print(strUrl)
        
        serviceController.getRequest(strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    print(result)
                    
                    let respVO:BibleBookVo = Mapper().map(JSONObject: result)!
                    
                    let bookResp = respVO.Book
                    
                    print("bookResp:\(String(describing: bookResp?.count))")
                    
                    
                    for eachArray in bookResp! {
                        
//                        let countt = eachArray.Chapter?.count
//                        
//                        self.bibleCArr.append(countt!)
                        
//                        print("Count:\(countt)")
                        
                        self.bibleChaptersArr.append(eachArray)
                        
                        print(self.bibleChaptersArr.count)
                        
                    }
                    
                    for eacObj in self.bibleChaptersArr {
                        
                        let chapterObj = eacObj.Chapter
                        
                        for verseObj in chapterObj! {
                            
                            let countt = verseObj.Verse?.count
                            
                            self.bibleCArr.append(countt!)
                            
                            print("Count:\(countt)")
                            
                            let oj = verseObj.Verse
                            
                            for verseList in oj! {
                                
                                let objjj = verseList.Verse
                                
                                self.bibleVerseCArr.append(objjj!)
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    
                    self.verseTableView.reloadData()
                    
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

}
