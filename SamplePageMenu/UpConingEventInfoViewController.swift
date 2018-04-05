//
//  UpConingEventInfoViewController.swift
//  Telugu Churches
//
//  Created by praveen dole on 3/6/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
class UpConingEventInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var upComingTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
     var delegate: eventinfoSubtitleOfIndexDelegate?
    
    
    
    var appVersion          : String = ""
    var upComingEventinfoArray:[GetUpComingEventInfoResultVo] = Array<GetUpComingEventInfoResultVo>()

    var eventDateArray = Array<String>()
    var eventTitleArray = Array<String>()
    var eventStartDateArray = Array<String>()
    var eventEndDateArray = Array<String>()
    var eventChurchNameArray = Array<String>()
    var contactNumberArray = Array<String>()
    var registrationNumberArray = Array<String>()
    
    
    //  let day: Int! = self.gregorian.component(.day, from: date)
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upComingTableView.rowHeight = UITableViewAutomaticDimension
        upComingTableView.estimatedRowHeight = 44
        upComingTableView.reloadData()
        
        

        
        
        upComingTableView.dataSource = self
        upComingTableView.delegate = self
//        
//        upComingTableView.rowHeight = UITableViewAutomaticDimension
//        upComingTableView.estimatedRowHeight = 44
//        upComingTableView.reloadData()
//        
//
        
        let nibName1  = UINib(nibName: "UpComingEventCell" , bundle: nil)
        upComingTableView.register(nibName1, forCellReuseIdentifier: "UpComingEventCell")
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        upComingEventinfoArray.removeAll()
        getUpComingEventInfoAPI()

    }
    
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
        
        
        if let chuechName =  listStr.churchName {
            cell.chuechName.text =  chuechName
        }else{
          //  cell.chuechName.text = "Church Name:".localize()
        }
        
        if let eventTitle =  listStr.title {
            cell.eventTitle.text =  eventTitle
        }else{
          //  cell.eventTitle.text = "Event Title:".localize()
        }
        
        if let eventStart =  listStr.startDate {
            
            cell.eventStart.text = returnEventDateWithoutTime(selectedDateString : eventStart)
        }
        
        else{
            
        }
        
        if let eventEndDate =  listStr.endDate {
            
            cell.eventEndDate.text =  returnEventDateWithoutTime(selectedDateString : eventEndDate)
        }else{
        }
        if let registrationNumber = listStr.registrationNumber {
            cell.registrationNumber.text =  registrationNumber
        }else{
        }
        
        
        let imgUrl = listStr.eventImage
        
        let newString = imgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
        
        print("filteredUrlString:\(newString)")
        
        if newString != nil {
            
            let url = URL(string:newString!)
            
            
            let dataImg = try? Data(contentsOf: url!)
            
            if dataImg != nil {
                
                cell.eventImage.image = UIImage(data: dataImg!)
            }
            else {
                
                cell.eventImage.image = #imageLiteral(resourceName: "churchLogoo")
            }
        }
        else {
            
            cell.eventImage.image = #imageLiteral(resourceName: "churchLogoo")
        }

        
        
        //  cell.adminNameLabel.text = churchNamesArray[indexPath.row]
        
        return cell
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listStr:GetUpComingEventInfoResultVo = upComingEventinfoArray[indexPath.row]
        
        
        let eventDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        
        eventDetailsViewController.eventID = listStr.id!
        eventDetailsViewController.eventChurchName = listStr.churchName!
        eventDetailsViewController.eventName = listStr.title!
        
        eventDetailsViewController.catgoryID = listStr.churchId!
        eventDetailsViewController.navigationStr = "navigationStr"
        
        self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
        
        
        
    }
    
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
//            
//            let parameters = [
//                "fromDate": "2018-03-09T16:23:17.9129341+05:30",
//                "toDate": "2018-03-09T16:23:17.9129341+05:30"
//                ] as [String : Any]
            
            print("dic params \(parameters)")
            
            let dictHeaders = ["":"","":""] as NSDictionary
            
            print("dictHeader:\(dictHeaders)")
            
            
  
            serviceController.postRequest(strURL: strUrl as NSString, postParams: parameters as NSDictionary, postHeaders: dictHeaders, successHandler:{(result) in
                DispatchQueue.main.async()
                    {
                        
                        print(result)
                        
                        let respVO:GetUpComingEventInfo = Mapper().map(JSONObject: result)!
                        
                        let isSuccess = respVO.isSuccess
                        
                        print("StatusCode:\(String(describing: isSuccess))")
                        
                        if isSuccess == true {
                            
                            let successMsg = respVO.endUserMessage
                            
                            
                            for eventsList in respVO.listResult!{
                                
                               self.upComingEventinfoArray.append(eventsList)


                            }
                            
                         
                            
                            self.upComingTableView.reloadData()
                            print("upComingEventinfoArray And Count:",self.upComingEventinfoArray , self.upComingEventinfoArray.count)
                           

                         //   self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                            
                            
                        }

                        
                }
            }, failureHandler:  {(error) in
                
                print(error)
                
                if(error == "unAuthorized"){
                    
                    
                    
                    
                }
                
                
                
            })
            
        }
        else {
            
       //     appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
            return
        }
    }
    
 
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        Utilities.setUpComingEentInfoEventViewControllerNavBarColorInCntrWithColor(backImage: "", cntr:self, titleView: nil, withText: "", backTitle: "", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")

        
        
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        
        UserDefaults.standard.set("1", forKey: "1")

        
        UserDefaults.standard.removeObject(forKey: "1")
      //  UserDefaults.standard.removeObject(forKey: kuserIdKey)
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)

        //   navigationItem.leftBarButtonItems = []
//        let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//        
//        appDelegate.window?.rootViewController = rootController

        print("Back Button Clicked......")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func returnEventDateWithoutTime(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            let dateString3 = invDtArray2[0]
            
            print(dateString1)
            //   let timeString = invDtArray[1]
            //  print(timeString)
            
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
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
