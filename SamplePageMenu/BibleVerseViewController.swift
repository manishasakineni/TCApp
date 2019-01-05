//
//  BibleVerseViewController.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BibleVerseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var verseTableView: UITableView!
    
//MARK:- variable declaration
    var bibleCArr = Array<Int>()
    var bibleChaptersArr:[BibleChapterVo] = Array<BibleChapterVo>()
    var bibleVerseArr:[BibleVerseVo] = Array<BibleVerseVo>()
    var bibleVerseCArr = Array<String>()
    var versDetailArray = Array<String>()
    var verseCountStr:Int = 0
    var chapterCount:Int = 0
    var verseStringCount = Array<BibleResultVo>()
    var backTitleStr:String = ""
    var appVersion:String = ""
    private var activityViewController : UIActivityViewController!
    private var isPopoverPresented  : Bool = false

 //MARK: -  view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        for i in 0 ... verseCountStr - 1 {
            print (i)
            self.bibleCArr.append(i)
        }
        print(verseStringCount.count)
        
        // Register for Custom TableviewCell
        let nibName  = UINib(nibName: "BibleVerseTableViewCell" , bundle: nil)
        self.verseTableView.register(nibName, forCellReuseIdentifier: "BibleVerseTableViewCell")
        
        verseTableView.delegate = self
        verseTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
//MARK: -  view Will Appear
    override func viewWillAppear(_ animated: Bool) {
        //   super.viewWillAppear(animated)
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "\(backTitleStr) \(chapterCount + 1)", backTitle: "mbhjbhb", rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
//MARK:- :::::::::::::::::::::::::::::::::::::::::: Tableview Delegate & DataSource Methods :::::::::::::::::::::::::::::::::::::::::://
    
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
        
       return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BibleVerseTableViewCell", for: indexPath) as! BibleVerseTableViewCell
        
        let booksList = self.verseStringCount[indexPath.row]
           cell.verseLabel.text = "\(indexPath.row + 1)" + "." + booksList.Verse!
           cell.selectionStyle = .none
       
        return cell
    }
    
//MARK:- shareBtnClicked
    func shareBtnClicked(_sender: UIButton){
        
        let indexPath : IndexPath = IndexPath(row: _sender.tag, section: 0)
        if let newCell : BibleVerseTableViewCell = verseTableView.cellForRow(at: indexPath) as? BibleVerseTableViewCell {
           activityViewController =  UIActivityViewController(activityItems: [MyStringItemSource()], applicationActivities: nil)
            let subject = "Telugu Churches"
            activityViewController.setValue(subject, forKey: "Subject")
            if UIScreen.main.bounds.size.width > 500 {
                if activityViewController.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                    isPopoverPresented = true
                    if let popView = activityViewController.popoverPresentationController {
                        popView.sourceView = verseTableView
                        popView.sourceRect = verseTableView.cellForRow(at: indexPath)!.frame
                    }
                }
            }
            self.present(activityViewController, animated: true, completion: nil)
        }
}
    
//MARK: -  bible Book API Call
    func bibleBookAPICall(){
        let strUrl = BIBLEAPITELUGUURL
        print(strUrl)
        serviceController.getRequest(strURL:strUrl, success:{(result) in
            DispatchQueue.main.async()
                {
                    print(result)
                    let respVO:BibleBookVo = Mapper().map(JSONObject: result)!
                    let bookResp = respVO.Book
                    print("bookResp:\(String(describing: bookResp?.count))")
                    for eachArray in bookResp! {
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
            }
            
        }) { (failureMessage) in
            
            print(failureMessage)
        }
    }
    
//MARK: -  back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
    }
    
//MARK: -  home Button Tapped
    
    @IBAction func homeButtonTapped(_ sender:UIButton) {
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(1)
        navigationController?.setViewControllers(viewControllers!, animated: true)
        print("Home Button Clicked......")
    }
}

//MARK: -  Based on text dynamically change Label width
extension String {
    func heightLabel(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    func widthLabel(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
