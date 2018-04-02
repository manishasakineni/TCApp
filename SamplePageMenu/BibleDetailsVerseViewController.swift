//
//  BibleDetailsVerseViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 30/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class BibleDetailsVerseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var catgoryName:String = ""
    
    var appVersion:String = ""
    
    var nameStr:String = ""
    
    var indexCount:Int = 0
    
    //    var bibleVerseArr = Array<String>()
    
    var bibleVerseArr:[BibleDetailsCellIResultVo] = Array<BibleDetailsCellIResultVo>()
    
    
    //    var verseStringCount : Dictionary = Dictionary<String,Any>()
    
    var verseStringCount = Array<BibleDetailsCellIResultVo>()
    
    var chapterCount:Int = 0
    
    var backTitleStr:String = ""
    var versDetailArray = Array<String>()
    var verseCountStr:Int = 0
    
    var bibleChaptersArr:String = ""
    
    
    @IBOutlet weak var BibleVerseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName  = UINib(nibName: "BibleVerseTableViewCell" , bundle: nil)
        
        self.BibleVerseTableView.register(nibName, forCellReuseIdentifier: "BibleVerseTableViewCell")
        
        
        BibleVerseTableView.delegate = self
        BibleVerseTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        Utilities.AllInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "\(nameStr) \(indexCount + 1)".localize(), backTitle: "  \(catgoryName)".localize(), rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
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
        
        
        return UITableViewAutomaticDimension
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BibleVerseTableViewCell", for: indexPath) as! BibleVerseTableViewCell
        
        
        let booksList = self.verseStringCount[indexPath.row]
        
        
        cell.verseLabel.text = "\(indexPath.row + 1)" + "." + booksList.Verse!
        
        
        cell.selectionStyle = .none
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        
        
        UserDefaults.standard.removeObject(forKey: "1")
//        UserDefaults.standard.removeObject(forKey: kuserIdKey)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set("1", forKey: "1")
        
        
        self.navigationController?.popViewController(animated: true)
        
        navigationItem.leftBarButtonItems = []
        
        print("Back Button Clicked......")
        
    }
    
    
    
    
    
    
    
    
}
