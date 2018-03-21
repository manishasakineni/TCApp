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
    
    var verseCountStr = Array<Int>()
    
    var bibleCArr = Array<Int>()
    
    var vDetailArray = Array<String>()

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
            
            return 60.0
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BibleBooksTableViewCell", for: indexPath) as! BibleBooksTableViewCell
        
        
        //        let cell:UITableViewCell = self.booksTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        //        let booksList = bibleChaptersArr[indexPath.row]
        
        cell.bibleBookLabel.text = "Chapter \(indexPath.row)"
        
        cell.chapterCountLabel.text = "\(verseCountStr[indexPath.row])"
        
        
        cell.selectionStyle = .none
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //        let eventList: UpcomingEventsResultVO = upComingEventsArray[indexPath.row]
        
        
        let verseViewController = self.storyboard?.instantiateViewController(withIdentifier: "BibleVerseViewController") as! BibleVerseViewController
        
        verseViewController.verseCountStr = self.verseCountStr[indexPath.row]
        
        verseViewController.versDetailArray = self.vDetailArray
        
        self.navigationController?.pushViewController(verseViewController, animated: true)
        
        
    }

}
