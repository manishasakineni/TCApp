//
//  BibleDetailsVerseViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class BibleDetailsVerseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
    
    @IBOutlet weak var chapterStr: UILabel!
    
    
    @IBOutlet weak var bacwordBtn: UIButton!
    
    @IBOutlet weak var forwardBtn: UIButton!
    
    
    @IBOutlet weak var BibleVerseTableView: UITableView!
    
    
    @IBOutlet weak var homeIconOutLet: UIButton!
    
    //MARK: -  variable declaration
    
    var catgoryName:String = ""
    var appVersion:String = ""
    var nameStr:String = ""
    var indexCount:Int = 0
    var index:Int = 0
    var eventNum:Int = 0
    var bibleVerseArr:[BibleDetailsCellIResultVo] = Array<BibleDetailsCellIResultVo>()
    var verseStringDict : Dictionary = Dictionary<String,Any>()
    var verseStringCount = Array<BibleDetailsCellIResultVo>()
    var chapterCount:Int = 0
    
    var backTitleStr:String = ""
    var versDetailArray = Array<String>()
    var verseCountStr:Int = 0
    var bibleChaptersArr:String = ""

    
   //MARK:- view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        
        self.norecordsfoundLbl.isHidden = true
        
        let nibName  = UINib(nibName: "BibleVerseTableViewCell" , bundle: nil)
        self.BibleVerseTableView.register(nibName, forCellReuseIdentifier: "BibleVerseTableViewCell")
        
        eventNum = indexCount
        self.chapterStr.text = "\(nameStr) \(eventNum + 1)"
        
        BibleVerseTableView.delegate = self
        BibleVerseTableView.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //MARK:- view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.navigationController?.isNavigationBarHidden = false
        
        super.viewWillAppear(animated)
        
    }
   
   //MARK:- TableView  DataSource & Delegate Methods
    
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
        
        if self.verseStringCount.count > 0 {
            
            self.norecordsfoundLbl.isHidden = true
            self.BibleVerseTableView.isHidden = false
            
            let booksList = self.verseStringCount[indexPath.row]
            
            cell.verseLabel.text = "\(indexPath.row + 1)" + "." + booksList.Verse!
            
            
            let colorView = UIView()
            colorView.backgroundColor = Utilities.appColor
            cell.selectedBackgroundView = colorView
            cell.textLabel?.highlightedTextColor = UIColor.white
            
            }
        else {
            
            self.norecordsfoundLbl.isHidden = false
            self.BibleVerseTableView.isHidden = true
        }
        
        return cell
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
   //MARK: -    Home Left Button Tapped
    
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
    
 //MARK: -    backward Btn Action
    
    @IBAction func backwardBtnAction(_ sender: UIButton) {
        
        forwardBtn.isHidden = false

        
        if (eventNum >= 1) {
            
            eventNum = eventNum - 1
            
            let versesDict = verseStringDict["\(index)"] as? Dictionary<String,Any>
            let capter = versesDict?["\(eventNum)"] as? [BibleDetailsCellIResultVo]
            self.chapterStr.text = "\(nameStr) \(eventNum + 1)"
            
            if capter != nil {
                
                self.verseStringCount = capter!
            }
            
        }
        else {
            
            print("No Records Found")
            bacwordBtn.isHidden = true
            
//            appDelegate.window?.makeToast("No Records Found".localize(), duration:kToastDuration, position:CSToastPositionCenter)
        }
        
       
//        let indexPath = IndexPath(item: eventNum, section: 0)
//        self.BibleVerseTableView.reloadRows(at: [indexPath], with: .top)
        
        self.BibleVerseTableView.reloadData()
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        self.BibleVerseTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
        
    }
    
  //MARK: -    forward Btn Action
    
    @IBAction func forwardBtnAction(_ sender: UIButton) {
        
        bacwordBtn.isHidden = false

    
         let versesDict = verseStringDict["\(index)"] as? Dictionary<String,Any>
        
        if (eventNum < (versesDict?.count)! - 1) {
            
            eventNum = eventNum + 1
            
            self.chapterStr.text = "\(nameStr) \(eventNum + 1)"
            
            let capter = versesDict?["\(eventNum)"] as? [BibleDetailsCellIResultVo]
            
            if capter != nil {
                
                self.verseStringCount = capter!
            }
            
//            let indexPath = IndexPath(item: 0, section: 0)
//            self.BibleVerseTableView.reloadRows(at: [indexPath], with: .top)
            
            
            
//            let indexPath = IndexPath(item: 0, section: 0)
//            if let visibleIndexPaths = self.BibleVerseTableView.indexPathsForVisibleRows?.index(of: indexPath as IndexPath) {
//                if visibleIndexPaths != NSNotFound {
//                    self.BibleVerseTableView.reloadRows(at: [indexPath], with: .top)
//                }
//            }
            
        }
    else {
            
            print("No Records Found")
            forwardBtn.isHidden = true

            
//    appDelegate.window?.makeToast("No Records Found".localize(), duration:kToastDuration, position:CSToastPositionCenter)
            
    }
        
        
    self.BibleVerseTableView.reloadData()
        
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        self.BibleVerseTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
        
    }
    
 //MARK: -    Back Left Button Tapped
    
    @IBAction func backAction(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set("1", forKey: "1")
        
        
        self.navigationController?.popViewController(animated: true)
        navigationItem.leftBarButtonItems = []
        print("Back Button Clicked......")

        
    }
   //MARK: -    Home Left Button Tapped
    
    @IBAction func homeIconAction(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.isNavigationBarHidden = true
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(2) // views to pop
        
        navigationController?.setViewControllers(viewControllers!, animated: true)
        
//        self.navigationController?.popViewController(animated: true)
//        
//        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//        
//        appDelegate.window?.rootViewController = rootController
        
        print("Home Button Clicked......")
        
    }
   
    
}
