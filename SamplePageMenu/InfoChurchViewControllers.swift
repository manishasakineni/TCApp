//
//  InfoChurchViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 20/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import Localize
import MapKit
import CoreLocation
import Contacts

class InfoChurchViewControllers: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    @IBOutlet weak var infoChurchView: UIView!
    
    @IBOutlet weak var infoChurchTableView: UITableView!
    
    
    @IBOutlet weak var noRecordsFoundLbl: UILabel!
    
    //MARK: -  variable declaration
    
    let manager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    var delegate: churchChangeSubtitleOfIndexDelegate?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appVersion          : String = ""
    var listResultArray:[GetChurchByIDResultVo]?
    var churchNamesString = ""
    var churchCountryArray = Array<String>()
    var churchStateArray = Array<String>()
    var churchDistrictNameArray = Array<String>()
    var churchVillageNameArray = Array<String>()
    var churchImageLogoArray = Array<String>()
    var churchImageLogoString = ""
    var landMarkString = ""
    var address1String = ""
    var address2String = ""
    var openTimeString = ""
    var closeTimeString = ""
    var contactNumberString = ""
    var mandalNameString = ""
    
    var villageNamesString = ""
    var phoneNoString = ""
    var regNoString = ""
    var emailString = ""
    var emailStr = ""
    var nameString = ""
    var timeString = ""
    var descriptionString = ""
    var MissionString = ""
    var VissionString = ""
    var stateString = ""
    
    var wedAddressString = ""
    var districtString = ""
    var villageString = ""
    var pinCodeString = ""
    var authorNameString = ""
    var dobString = ""
    var genderString = ""
    var userId : Int = 0
    var uid : Int = 0
    var authorID : Int = 0
    var isSubscribed = Int()
    var subscribeClick = 0
    
    var lat: Double = 0.0
    var long: Double = 0.0
    
    let utillites =  Utilities()
    
    var ChurchDetailsAry  = ["REG001".localize(),"Aishwarya Satish".localize(),"Church@crist.com".localize(),"1234567898".localize(),"9AM-5Pm".localize()]
    
    var ChurchInfoAry  = ["1".localize(),"REG001".localize(),"Holv Church".localize(),"LandMark".localize(),"Aishwarya Sateesh".localize(),"Contact No".localize(),"Church@gmail.com".localize()]
    
    var churchID            : Int = 0
    var churchName          : String = ""

    var loginVC = LoginViewController()
    
    let array = ["","ssss","ddddd","gggg"]
    
    //MARK: -  view Did Load
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        infoChurchTableView.frame = self.view.bounds
        
        if UserDefaults.standard.value(forKey: kIdKey) != nil {
            
            self.userId = UserDefaults.standard.value(forKey: kIdKey) as! Int
            
        }
        
        infoChurchTableView.delegate = self
        infoChurchTableView.dataSource = self
        
        infoChurchTableView.rowHeight = UITableViewAutomaticDimension
        infoChurchTableView.estimatedRowHeight = 44
        infoChurchTableView.reloadData()
        
        self.infoChurchTableView.isHidden = true
        
        let nibName1  = UINib(nibName: "HeadImgTableViewCell" , bundle: nil)
        infoChurchTableView.register(nibName1, forCellReuseIdentifier: "HeadImgTableViewCell")
        let nibName2  = UINib(nibName: "InformationTableViewCell" , bundle: nil)
        infoChurchTableView.register(nibName2, forCellReuseIdentifier: "InformationTableViewCell")
        let nibName3  = UINib(nibName: "InfoMapTableViewCell" , bundle: nil)
        infoChurchTableView.register(nibName3, forCellReuseIdentifier: "InfoMapTableViewCell")
        let nibName4  = UINib(nibName: "AboutInfoTableViewCell" , bundle: nil)
        infoChurchTableView.register(nibName4, forCellReuseIdentifier: "AboutInfoTableViewCell")
        
        let nibName5  = UINib(nibName: "InfoHeaderCell" , bundle: nil)
        infoChurchTableView.register(nibName5, forCellReuseIdentifier: "InfoHeaderCell")
    
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.loginVC = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
        
        self.loginVC.showNav = true
        self.loginVC.navigationString = "churchInfoString"
        
        
        getChurchuByIDAPIService()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: -  view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    //MARK: -  view Did Appear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    //MARK: -  Get Church By ID API Service
    
    func getChurchuByIDAPIService(){
        
        if(appDelegate.checkInternetConnectivity()){
            
    let strUrl = GETCHURCHEBYID + "" + "\(churchID)" + "/" + String(self.userId)
            
    serviceController.getRequest(strURL:strUrl, success:{(result) in
    DispatchQueue.main.async()
        {
                        
                        
    print("result:\(result)")
                        
    let respVO:GetChurchByIDVo = Mapper().map(JSONObject: result)!
                        
    print("responseString = \(respVO)")
            
    let isSuccess = respVO.isSuccess
    print("StatusCode:\(String(describing: isSuccess))")
                        
    self.churchCountryArray.removeAll()
    self.churchStateArray.removeAll()
    self.churchDistrictNameArray.removeAll()
    self.churchVillageNameArray.removeAll()
                        
    if isSuccess == true {
                            
    if !(respVO.listResult!.isEmpty){
                                
    self.noRecordsFoundLbl.isHidden = true
    self.infoChurchTableView.isHidden = false
                                
    let successMsg = respVO.endUserMessage
    self.listResultArray = respVO.listResult!
        
        if (respVO.listResult?[0].latitude != nil)  {
            
             self.lat = (respVO.listResult?[0].latitude)!
        }
        if (respVO.listResult?[0].longitude != nil) {
            
            self.long = (respVO.listResult?[0].longitude)!
        }
       
        
//        kUserDefaults.set(lat, forKey: kLatitude)
//        kUserDefaults.set(long, forKey: kLongitude)
//        kUserDefaults.synchronize()
        
    self.churchNamesString = (respVO.listResult?[0].name == nil ? "" : respVO.listResult?[0].name)!
    self.phoneNoString = (respVO.listResult?[0].userContactNumbar == nil ? "" : respVO.listResult?[0].userContactNumbar)!
    self.regNoString = (respVO.listResult?[0].registrationNumber == nil ? "" : respVO.listResult?[0].registrationNumber)!
    self.emailString = (respVO.listResult?[0].email == nil ? "" : respVO.listResult?[0].userEmail)!
     self.emailStr = (respVO.listResult?[0].email == nil ? "" : respVO.listResult?[0].email)!
        
        
    self.nameString = (respVO.listResult?[0].pasterUser == nil ? "" : respVO.listResult?[0].pasterUser)!
    self.descriptionString = (respVO.listResult?[0].description == nil ? "" : respVO.listResult?[0].description)!
    self.churchImageLogoString = (respVO.listResult?[0].churchImage == nil ? "" : respVO.listResult?[0].churchImage!.replacingOccurrences(of: "\\", with: "//"))!
                                
    self.landMarkString = (respVO.listResult?[0].landMark == nil ? "" : respVO.listResult?[0].landMark)!
    self.address1String = (respVO.listResult?[0].address1 == nil ? "" : respVO.listResult?[0].address1)!
    self.address2String = (respVO.listResult?[0].address2 == nil ? "" : respVO.listResult?[0].address2)!
    self.openTimeString = (respVO.listResult?[0].openingTime == nil ? "" : respVO.listResult?[0].openingTime)!
    self.closeTimeString = (respVO.listResult?[0].closingTime == nil ? "" : respVO.listResult?[0].closingTime)!
    self.contactNumberString = (respVO.listResult?[0].contactNumber == nil ? "" : respVO.listResult?[0].contactNumber)!
    self.mandalNameString = (respVO.listResult?[0].mandalName == nil ? "" : respVO.listResult?[0].mandalName)!
    self.timeString = self.amAppend(str: ( (respVO.listResult?[0].openingTime == nil ? "" : respVO.listResult?[0].openingTime)! + "-" + (respVO.listResult?[0].closingTime == nil ? "" : respVO.listResult?[0].closingTime)!))
                                
    self.MissionString = (respVO.listResult?[0].mission == nil ? "" : (respVO.listResult?[0].mission)!)
                                
    self.VissionString = (respVO.listResult?[0].vision == nil ? "" : (respVO.listResult?[0].vision)!)
                                
    self.stateString = (respVO.listResult?[0].stateName == nil ? "" : (respVO.listResult?[0].stateName)!)
                                
                                
    self.wedAddressString = (respVO.listResult?[0].websiteAddress == nil ? "" : (respVO.listResult?[0].websiteAddress)!)
                                
    self.districtString = (respVO.listResult?[0].districtName == nil ? "" : (respVO.listResult?[0].districtName)!)
                                
    self.villageString = (respVO.listResult?[0].villageName == nil ? "" : (respVO.listResult?[0].villageName)!)
        
    self.genderString = (respVO.listResult?[0].gender == nil ? "" : (respVO.listResult?[0].gender)!)
                                
    self.authorNameString = (respVO.listResult?[0].userName == nil ? "" : (respVO.listResult?[0].pasterUser)!)
                                
    self.dobString = (respVO.listResult?[0].dob == nil ? "" : (respVO.listResult?[0].dob)!)
                                
                                
    let stringgg = (respVO.listResult?[0].pinCode)
    if stringgg != nil {
        
    self.pinCodeString = "\(stringgg!)"
                                    
    }
                                
   self.isSubscribed = (respVO.listResult?[0].isSubscribed)!
    print(self.churchCountryArray)
                                
                                
    print(self.timeString)
    print(self.churchNamesString)
    self.infoChurchTableView.reloadData()
                                
                                
    }else{
                                
    self.noRecordsFoundLbl.isHidden = false
    self.infoChurchTableView.isHidden = true
    }
        
}
                            
    else {
        
}
                        
}
}, failure:  {(error) in
                
print(error)
                
if(error == "unAuthorized"){
                    
                    
self.showAlertViewWithTitle("Alert".localize(), message: error, buttonTitle: "Ok".localize())
    
        }
    
    })
            
        }
        else {
            
    appDelegate.window?.makeToast(kNetworkStatusMessage, duration:kToastDuration, position:CSToastPositionCenter)
    return
            
        }
        
    }
    
   //MARK: -   TableView Delegate & DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }else if section == 1 {
            
            
            return 5
            
            
            
        }else if section == 2 {
            
            return 9
            
        }
        else if section == 3 {
            
            return 5
            
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        if indexPath.section == 0 {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad) {
                
                return 300
            }
            else {
                
                return 124
            }
            
            
            
        }else if indexPath.section == 1{
            
            return UITableViewAutomaticDimension
        }
            
        else if indexPath.section == 2{
            
            return UITableViewAutomaticDimension
            
        }
            
            
        else if indexPath.section == 3{
            
            return UITableViewAutomaticDimension
        }
        else if indexPath.section == 4{
            
            return 150
        }
        
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    if (indexPath.section == 0) {
            
    let cell = tableView.dequeueReusableCell(withIdentifier: "HeadImgTableViewCell", for: indexPath) as! HeadImgTableViewCell
            
    if indexPath.row == 0 {
        
    cell.churchNameLabel.text = churchNamesString
                
    if(churchImageLogoArray.count >= indexPath.section){
    if let url = URL(string:churchImageLogoString) {
    cell.churchImage.sd_setImage(with:url , placeholderImage:  #imageLiteral(resourceName: "church16"))
        
        }else{
                        
        cell.churchImage.image =  #imageLiteral(resourceName: "church16")
                        
            }
        }
                
        return cell
                
    }
            
            
    return cell
            
        }
        else if (indexPath.section == 1) {
            
    let cell1 = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
            
        if indexPath.row == 0 {
                
        cell1.infoLabel.text = "Registration Number".localize()
                
        cell1.addressLabel.text = regNoString
                
                
        } else if indexPath.row == 1 {
                
        cell1.infoLabel.text = "Name".localize()
                
        cell1.addressLabel.text = churchNamesString
               
            
        } else if indexPath.row == 2 {
                
        cell1.infoLabel.text = "Description".localize()
                
        cell1.addressLabel.text =  descriptionString
                
                
        }else if indexPath.row == 3 {
                
        cell1.infoLabel.text = "Vision".localize()
                
        cell1.addressLabel.text = VissionString
                
                
        }else if indexPath.row == 4 {
                
        cell1.infoLabel.text = "Mission".localize()
                
                
        cell1.addressLabel.text = MissionString
                
               
        }
            
            
    return cell1
    }
            
    else if (indexPath.section == 2){
            
    let cell3 = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
            
            
    if indexPath.row == 0 {
                
    cell3.infoLabel.text = "Address".localize()
                
    cell3.addressLabel.text = address1String + "," + address2String
                
    } else if indexPath.row == 1 {
                
    cell3.infoLabel.text = "Email".localize()
                
                
    cell3.addressLabel.text =  emailStr
                
                
    } else if indexPath.row == 2 {
                
    cell3.infoLabel.text = "Web Address".localize()
                
    cell3.addressLabel.text =  wedAddressString
            
        }else if indexPath.row == 3 {
                
        cell3.infoLabel.text = "Landmark".localize()
                
                
        cell3.addressLabel.text = landMarkString
                
                
                
        }else if indexPath.row == 4 {
                
    cell3.infoLabel.text = "State".localize()
                
                
    cell3.addressLabel.text = stateString
            
            }
    else if indexPath.row == 5 {
                
    cell3.infoLabel.text = "District".localize()
                
                
    cell3.addressLabel.text = districtString
                
                
            }
    else if indexPath.row == 6 {
                
    cell3.infoLabel.text = "Mandal".localize()
                
    cell3.addressLabel.text = mandalNameString
                
            }
    else if indexPath.row == 7 {
                
    cell3.infoLabel.text = "Village".localize()
                
    cell3.addressLabel.text = villageString
        
            }
        
    else if indexPath.row == 8 {
            
    cell3.infoLabel.text = "Pin Code".localize()
                
    cell3.addressLabel.text = pinCodeString
                
            }
            
        return cell3
            
            
        }
    else if (indexPath.section == 3){
            
    let cell2 = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell", for: indexPath) as! InformationTableViewCell
    if indexPath.row == 0 {
                
    cell2.infoLabel.text = "Author Name".localize()
        
    cell2.addressLabel.text = authorNameString
                
                
    } else if indexPath.row == 1 {
                
    cell2.infoLabel.text = "Email".localize()
                
    cell2.addressLabel.text =  emailString
                
                
    } else if indexPath.row == 2 {
                
    cell2.infoLabel.text = "Contact Number".localize()
                
    cell2.addressLabel.text =  contactNumberString
                
                
        }else if indexPath.row == 3 {
                
        cell2.infoLabel.text = "Date Of Birth".localize()
        
    
                
        let startAndEndDate1 =   returnEventDateWithoutTim1(selectedDateString : dobString)
                
        cell2.addressLabel.text = startAndEndDate1
        
       
    
        
        

        }else if indexPath.row == 4 {
                
    cell2.infoLabel.text = "Gender".localize()
                
    cell2.addressLabel.text = genderString
                
        }
            
            
        return cell2
            
        }
            
            
            
        else if (indexPath.section == 4){
            
        if #available(iOS 11.0, *) {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "InfoMapTableViewCell", for: indexPath) as! InfoMapTableViewCell
            
//            if let lat = kUserDefaults.string(forKey: kLatitude) {
//
//                if let long = kUserDefaults.string(forKey: kLongitude) {
            
                   
                    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    cell3.mapViewOutLet.addAnnotation(annotation)
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
                    cell3.mapViewOutLet.setRegion(region, animated: true)
                    cell3.mapViewOutLet.delegate = self
                    
                    print(myLocation.latitude)
                    print(myLocation.longitude)
                    cell3.mapViewOutLet.showsUserLocation = true
                    
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long)) { (placemark, error) in
                        
                        if error != nil
                        {
                            print("There was as error")
                        }
                        else
                        {
                            if let place = placemark?[0]
                            {
//                                self.annotation.subtitle = place.subLocality
//                                self.annotation.title = place.name
                                self.annotation.title = "\(self.churchNamesString)"
                                self.annotation.subtitle = "\(self.districtString),\(self.stateString)"
                                //self.label.text = "\(String(describing: place.locality!)) \n \(String(describing: place.country!)) \n \(String(describing: place.location!))"
                            }
                            else {
                                
//                                let london = MKPointAnnotation()
//                                london.title = "My Location"
//                                london.coordinate = CLLocationCoordinate2D(latitude: london.coordinate.latitude, longitude: london.coordinate.longitude)
//                                cell3.mapViewOutLet.addAnnotation(london)
                            }
                            
                        }
                    }
//                }
                
//            }
            
            return cell3
        } else {
            // Fallback on earlier versions
        }
            
        
            
        }
        
    let cell3 = tableView.dequeueReusableCell(withIdentifier: "AboutInfoTableViewCell", for: indexPath) as! AboutInfoTableViewCell
        
    return cell3
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let infoHeaderCell = tableView.dequeueReusableCell(withIdentifier: "InfoHeaderCell") as! InfoHeaderCell
        
        if section == 1 {
          
          infoHeaderCell.subscribeBtn.isHidden = false
            
            if self.isSubscribed == 0{
                
                infoHeaderCell.subscribeBtn.setTitle("Subscribe".localize(),for: .normal)
            }
                
            else{
                
                infoHeaderCell.subscribeBtn.setTitle("Unsubscribe",for: .normal)
                
            }
            
            infoHeaderCell.subscribeBtn.addTarget(self, action: #selector(subscribeBtnClicked), for: .touchUpInside)
        }
        else {
        
         infoHeaderCell.subscribeBtn.isHidden = true
        }
        if section == 1 {
            
            infoHeaderCell.headerLabel.text = "Church Details".localize()
            
            
        }else if section == 2 {
            
            infoHeaderCell.headerLabel.text = "Address".localize()
          
            
        }
        else if section == 3 {
            
        infoHeaderCell.headerLabel.text = "Church Author".localize()
            
            
        }
            
        else if section == 4 {
                        
            infoHeaderCell.headerLabel.text = "Map".localize()
            
        }
                return infoHeaderCell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0.0
        }
        
        return 44.0
        
    }
   
//MARK: -   Subscribe Btn Clicked
    
    func subscribeBtnClicked(sender : UIButton){
        

        if self.userId != 0 {
            
            
            
            let paramsDict = [ "isSubscribed": isSubscribed,
                               "userId": self.userId,
                               "churchId": churchID,
                               "authorId": "null"
                ] as [String : Any]
            
    let dictHeaders = ["":"","":""] as NSDictionary
            
    serviceController.postRequest(strURL: CHURCHAUTHORSUBSCIPTIONAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
    print(result)
                
    let respVO:ChurchAuthorSubscriptionVO = Mapper().map(JSONObject: result)!
                
                
    let isSuccess = respVO.isSuccess
    print("StatusCode:\(String(describing: isSuccess))")
                
    if isSuccess == true {
                    
    let successMsg = respVO.endUserMessage
                    
    let subscribe = respVO.isSuccess
                    
    self.isSubscribed = (respVO.result?.isSubscribed!)!
                    
    self.infoChurchTableView.reloadData()
        
    self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                    
    }
                    
else {
                    
    let unSuccessMsg = respVO.endUserMessage
                    
    self.appDelegate.window?.makeToast(unSuccessMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                    
                    
    }
                
}) { (failureMessage) in
                
                
    print(failureMessage)
                
    }
            
            
    }else {
            
            
     Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Please Login To Subscribe", clickAction: {
        
        self.navigationController?.pushViewController(self.loginVC, animated: true)
        
            })
            
        }
        
    }
    
    
//MARK: -   show Alert View With Title
    
    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
    func amAppend(str:String) -> String{
        
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(str != ""){
            let invDtArray = str.components(separatedBy: "-")
            let dateString1 = invDtArray[0]
            let dateString2 = invDtArray[1]
            if(dateString1 != ""){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString1)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString2 != ""){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString2)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "-" + newDateStr1
    }
    
//MARK: -   Event Date Without Time
    
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
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
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
//            if(dateString3 != "" || dateString != "."){
//                
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = .medium
//                dateFormatter.dateFormat = "HH:mm:ss"
//                let dateFromString = dateFormatter.date(from: dateString3)
//                dateFormatter.dateFormat = "hh:mm aa"
//                let newDateString = dateFormatter.string(from: dateFromString!)
//                newDateStr1 = newDateString
//                print(newDateStr1)
//            }
        }
        return newDateStr + "" + newDateStr1
    }

    
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     guard let annotation = annotation as? MKPointAnnotation else { return nil }
     // 3
     let identifier = "marker"
     var mkView = UIView()
     // 4
     if #available(iOS 11.0, *) {
     if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
     as? MKMarkerAnnotationView {
     dequeuedView.annotation = annotation
     mkView = dequeuedView
     } else {
     // 5
     let view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
     view.canShowCallout = true
     view.calloutOffset = CGPoint(x: -5, y: 5)
     view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
     mkView = view
     }
     } else {
     // Fallback on earlier versions
     }
     return mkView as? MKAnnotationView
     }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

