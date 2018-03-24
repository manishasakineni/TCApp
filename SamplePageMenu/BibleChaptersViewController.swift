//
//  BibleChaptersViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleChaptersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var chaptersTableView: UITableView!
    
    var chapterCountStr:Int = 0
    
//    var verseCountStr:Int = 0
    
    var indexCount:Int = 0
    
    var appVersion:String = ""
    
    var backTitleStr:String = ""
    
    var LangText:String = ""

    var verseCountStr = Array<Int>()
    
    var bibleCArr = Array<Int>()
    
    var vDetailArray = Array<String>()
    
    var verseStringCount : Dictionary = Dictionary<String,Any>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0 ... chapterCountStr - 1 {
            
            print (i)
            
            self.bibleCArr.append(i)
            
        }
        
        print("verseCountStr:\(verseCountStr)")
        
        let nibName  = UINib(nibName: "BibleBooksTableViewCell" , bundle: nil)
        
        self.chaptersTableView.register(nibName, forCellReuseIdentifier: "BibleBooksTableViewCell")
        
        
        chaptersTableView.delegate = self
        chaptersTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
        override func viewWillAppear(_ animated: Bool) {
    
            super.viewWillAppear(animated)
    
    
           Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "\(backTitleStr)", backTitle: "\(backTitleStr)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
    
        }
        
    

    

    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return bibleCArr.count
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
            
            
            return 50.0
        }
        else {
            
            return 40.0
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BibleBooksTableViewCell", for: indexPath) as! BibleBooksTableViewCell
        
        
        //        let cell:UITableViewCell = self.booksTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        //        let booksList = bibleChaptersArr[indexPath.row]
         //"అధ్యాయము"

        if LangText == "English" {
            
            cell.bibleBookLabel.text = "Chapter \(indexPath.row)"
        }
        else {
            
            cell.bibleBookLabel.text = "అధ్యాయము \(indexPath.row)"
        }
        
        
//        cell.chapterCountLabel.text = "\(verseCountStr[indexPath.row])"
        
        cell.chapterCountLabel.text = ""
        
         cell.accessoryType = .disclosureIndicator
        
        cell.selectionStyle = .none
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //        let eventList: UpcomingEventsResultVO = upComingEventsArray[indexPath.row]
        
        
        let verseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BibleVerseViewController") as! BibleVerseViewController
        
        verseViewController.verseCountStr = self.verseCountStr[indexPath.row]
        
        verseViewController.versDetailArray = self.vDetailArray
        
        verseViewController.backTitleStr = backTitleStr
        
        verseViewController.chapterCount = indexPath.row
        
        let versesDict = verseStringCount["\(indexCount)"] as? Dictionary<String,Any>
        
        let capter = versesDict?["\(indexPath.row)"] as? [BibleResultVo]
        
        verseViewController.verseStringCount = capter!
        
        print(capter)
        
        self.navigationController?.pushViewController(verseViewController, animated: true)
        
        
    }
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        
        UserDefaults.standard.set("1", forKey: "1")
        
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.synchronize()
        
        
        self.navigationController?.popViewController(animated: true)
        
    
        print("Back Button Clicked......")
        
    }
    


}