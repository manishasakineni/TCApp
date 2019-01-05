//
//  UpConingEventInfoViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/6/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
import IQKeyboardManagerSwift

class UpConingEventInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var upComingTableView: UITableView!
    @IBOutlet weak var norecordsfoundLbl: UITableView!
    
//MARK: -  variable declaration
    
    var appVersion : String = ""
    var upComingEventinfoArray:[GetUpComingEventInfoResultVo] = Array<GetUpComingEventInfoResultVo>()
    var eventDateArray = Array<String>()
    var eventTitleArray = Array<String>()
    var eventStartDateArray = Array<String>()
    var eventEndDateArray = Array<String>()
    var eventChurchNameArray = Array<String>()
    var contactNumberArray = Array<String>()
    var registrationNumberArray = Array<String>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: eventinfoSubtitleOfIndexDelegate?
    var whiteSpaces = Bool()
    
//MARK: -  view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().toolbarDoneBarButtonItemText = "Done".localize()
        self.norecordsfoundLbl.isHidden = true
        upComingTableView.rowHeight = UITableViewAutomaticDimension
        upComingTableView.estimatedRowHeight = 44
        upComingTableView.reloadData()
        upComingTableView.dataSource = self
        upComingTableView.delegate = self

        // Registering Tableview Cell

        let nibName1  = UINib(nibName: "UpComingEventCell" , bundle: nil)
        upComingTableView.register(nibName1, forCellReuseIdentifier: "UpComingEventCell")
        
    }
    
//MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        upComingEventinfoArray.removeAll()
        getUpComingEventInfoAPI()
    }
    
 //MARK: -  TableView delegate & DataSource  methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return upComingEventinfoArray.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listStr:GetUpComingEventInfoResultVo = upComingEventinfoArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpComingEventCell", for: indexPath) as! UpComingEventCell
        
            if listStr.churchName  != nil {
                if let churchName = listStr.churchName {
                    cell.chuechName.text = churchName
                    cell.churchName.text = "Church Name".localize()
                }
                else{
                    cell.churchName.text = ""
                }
            }
            else if listStr.authorName != nil {
                if let authorName =  listStr.authorName {
                    cell.chuechName.text = authorName
                    cell.churchName.text = "Pastor Name".localize()
                    }
                else{
                        cell.chuechName.text = ""
                }
            }
            else{
                    cell.chuechName.text = ""
                }
            if let eventTitle =  listStr.title {
            cell.eventTitle.text =  eventTitle
            }
            else{
            }
        
            if listStr.contactNumber  != nil {
                if let contactNumber = listStr.contactNumber {
                    cell.contactNumber.text = contactNumber
                    cell.infoContactNumber.text = "Contact Number".localize()
                }
                else{
                    cell.contactNumber.text = ""
                }
            }
            else if listStr.mobileNumber != nil {
                if let mobileNumber =  listStr.mobileNumber {
                    cell.contactNumber.text = mobileNumber
                    cell.infoContactNumber.text = "Mobile Number".localize()
                }
                else{
                    cell.contactNumber.text = ""
                }
            }
            else{
                cell.contactNumber.text = ""
            }

            if let eventStart =  listStr.startDate {
                cell.eventStart.text = returnEventDateWithoutTime(selectedDateString : eventStart)
            }
            else{
            }
        
            if let eventEndDate =  listStr.endDate {
                cell.eventEndDate.text =  returnEventDateWithoutTime(selectedDateString : eventEndDate)
            }
            else{
            }
        
        let imgUrl = listStr.eventImage
        let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        print("filteredUrlString:\(newString)")
        let whitespace = NSCharacterSet.whitespaces
        if newString != nil{
            let range = newString?.rangeOfCharacter(from: .whitespaces)
            if range != nil {
                print("whitespace found")
                whiteSpaces = true
                cell.eventImage.image = #imageLiteral(resourceName: "Church-logo")
            }
            else {
                print("whitespace not found")
                whiteSpaces = false
                let url = URL(string:newString!)
                let dataImg = try? Data(contentsOf: url!)
                if dataImg != nil {
                    cell.eventImage.image = UIImage(data: dataImg!)
                }
            }
        }
        else {
            cell.eventImage.image = #imageLiteral(resourceName: "Church-logo")
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listStr:GetUpComingEventInfoResultVo = upComingEventinfoArray[indexPath.row]
        let eventDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsAndEventPostDetailsViewController") as! EventDetailsAndEventPostDetailsViewController
        eventDetailsViewController.eventID = listStr.id!
        eventDetailsViewController.eventName = listStr.title!
        eventDetailsViewController.eventImageArrayString = (listStr.eventImage == nil) ? "" : listStr.eventImage!
        eventDetailsViewController.navigationStr = "navigationStr"
        self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
    

//MARK: -  Get UpComing Event Info API Call
    
    func getUpComingEventInfoAPI(){
        
        let date =  (Calendar.current as NSCalendar).date(byAdding: .day, value: 7, to: Date(), options: [])
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = "dd"
        fromDateFormatter.timeZone = NSTimeZone.local
        let fromDateString = fromDateFormatter.string(from: Date())
        let toDateString = fromDateFormatter.string(from: date!)
        print("fromDateString And toDateString",fromDateString,toDateString)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthFormatter.timeZone = NSTimeZone.local
        let fromMonthString = monthFormatter.string(from: Date())
        let toMonthString = monthFormatter.string(from: date!)
        print("fromMonthString and toMonthString",fromMonthString,toMonthString)

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        yearFormatter.timeZone = NSTimeZone.local
        let fromYearString = yearFormatter.string(from: Date())
        let toYearString = yearFormatter.string(from: date!)
        print("fromYearString And toYearString",fromYearString,toYearString)
        
        if(appDelegate.checkInternetConnectivity()){
            let strUrl = GETUPCOMIMGEVENTSINFO
            print(strUrl)
            let parameters = [
                "fromDate": "\(fromYearString)" + "-" + "\(fromMonthString)" + "-" + "\(fromDateString)",
                "toDate": "\(toYearString)" + "-" + "\(toMonthString)" + "-" + "\(toDateString)",
                ] as [String : Any]
            print("dic params \(parameters)")
            let dictHeaders = ["":"","":""] as NSDictionary
            print("dictHeader:\(dictHeaders)")
            serviceController.postRequest(strURL: strUrl as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                DispatchQueue.main.async() {
                    print(result)
                    let respVO:GetUpComingEventInfo = Mapper().map(JSONObject: result)!
                    let isSuccess = respVO.isSuccess
                    print("StatusCode:\(String(describing: isSuccess))")
                    if isSuccess == true {
                        let listResult = respVO.listResult
                        if (listResult?.count)! > 0 {
                            self.norecordsfoundLbl.isHidden = true
                            self.upComingTableView.isHidden = false
                            for eventsList in respVO.listResult!{
                                self.upComingEventinfoArray.append(eventsList)
                            }
                            self.upComingTableView.reloadData()
                            print("upComingEventinfoArray And Count:",self.upComingEventinfoArray , self.upComingEventinfoArray.count)
                        }
                        else {
                            self.norecordsfoundLbl.isHidden = false
                            self.upComingTableView.isHidden = true
                        }
                    }
                }
            }, failureHandler:  {(error) in
                print(error)
                if(error == "unAuthorized"){
                }
                })
        }
        else {
            return
        }
    }
    

//MARK: -    Back Left Button Tapped
 
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        Utilities.setUpComingEentInfoEventViewControllerNavBarColorInCntrWithColor(backImage: "", cntr:self, titleView: nil, withText: "", backTitle: "", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        print("Back Button Clicked......")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//MARK: -   Event Date Without Time
    
  func returnEventDateWithoutTime(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        if(selectedDateString != ""){
            let invDtArray  = selectedDateString.components(separatedBy: "T")
            let dateString  = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            let dateString3 = invDtArray2[0]
            print(dateString1)
            
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "dd-MM-YYYY"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString3 != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString3)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "," + newDateStr1
    }
}
