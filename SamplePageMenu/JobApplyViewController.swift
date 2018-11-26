//
//  JobApplyViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 15/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit


func getDocumentsURL() -> URL {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return documentsURL
}

func fileInDocumentsDirectory(_ filename: String) -> String {
    
    let fileURL = getDocumentsURL().appendingPathComponent(filename)
    return fileURL.path
    
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}




class JobApplyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
  @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var docsCollectionView: UICollectionView!
    
    @IBOutlet weak var jobApplyTableView: UITableView!
    
    @IBOutlet weak var uploadViewheight: NSLayoutConstraint!
    
    @IBOutlet weak var applyBtnOutLet: UIButton!

    
    @IBOutlet weak var uploadresumeOutLet: UIButton!
    
    
    @IBOutlet weak var uploadView: UIView!
    
    @IBOutlet weak var uploadBtnOutLet: UIButton!
    
    
    @IBOutlet weak var uploadLblOutLet: UILabel!
    
    //MARK: -  variable declaration
    
     var selectedImagesArray: Array<UIImage> = []
     var filename : String = ""
     var docsUrlArray:Array<String> = Array()
     var docUrl : URL = NSURL() as URL
     var image  = UIImage()
     var newImage = UIImage()
     var myImagePicker = UIImagePickerController()
     var fileextension : Bool = false
    let pickerView = UIPickerView()
    private var imagePicked = 0
    
    var activeTextField = UITextField()
    var appVersion          : String = ""
    let utillites =  Utilities()
    var jobtitle    :String = ""
    var jobId = 0
    var id = 0
    var firstname     :String = ""
    var middlename   :String = ""
    var lastname      :String = ""
    var email           : String = ""
    var mobileNumber     : String = ""
    var qualification       : String = ""
    var yearofexperience       : String = ""
    var currentorganization   : String = ""
    var currentsalary         :String = ""
    var expectedsalary        :String = ""
    var uploadresume        :String = ""
    
    var isActive:Bool = true
    var createdByUserId:Int = 0
    var createdDate : String = ""
    var updatedByUserId : Int = 0
    var updatedDate:String =  ""
    let dateFormatter = DateFormatter()
    let datepicker = UIDatePicker()
    var selectedMonths : String = ""
    var selectedYears : String = ""
    var pickerData = Array<String>()
    var myPickerView: UIPickerView!
    var dateString :String = ""
    var selectedData : String = ""
    var financierType : Array = Array<String>()
    
    var alertTag = Int()
    var isjobtitle = false
    var addressInfo:[GetAllJobDetailsListResultVO] = Array<GetAllJobDetailsListResultVO>()
    var months = ""
    var isResumeUploaded = false
    var docCount = 0
    var docCountArray : Array = Array<UIImage>()
    var documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes:  ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: UIDocumentPickerMode.open)
    

    var yearsArray : Array = ["0 Year","1 Year","2 Years","3 Years","4 Years","5 Years","6 Years","7 Years","8 Years","9 Years","10 Years","11 Years","12 Years","13 Years","14 Years","15 Years","16 Years","17 Years","18 Years","19 Years","20 Years","21 Years","22 Years","23 Years","24 Years","25 Years","26 Years","27 Years","28 Years","29 Years","30 Years","31 Years","32 Years","33 Years","34 Years","35 Years","36 Years","37 Years","38 Years","39 Years","40 Years","41 Years","42 Years","43 Years","44 Years","45 Years","46 Years","47 Years","48 Years","49 Years","50 Years"]

     var monthArray : Array = ["0 Month","1 Month","2 Months","3 Months","4 Months","5 Months","6 Months","7 Months","8 Months","9 Months","10 Months","11 Months","12 Months"]
    
    var docBase64String = ""
    
    var fileNameString = ""
  //MARK: - view Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobApplyTableView.delegate = self
        jobApplyTableView.dataSource = self
        
        activeTextField.delegate = self
        
        let categorieHomeCell  = UINib(nibName: "JobApplyTableViewCell" , bundle: nil)
        jobApplyTableView.register(categorieHomeCell, forCellReuseIdentifier: "JobApplyTableViewCell")
        
        let jobApplymonthTableViewCell  = UINib(nibName: "jobApplymonthTableViewCell" , bundle: nil)
        jobApplyTableView.register(jobApplymonthTableViewCell, forCellReuseIdentifier: "jobApplymonthTableViewCell")
      
        let resumeUploadCell  = UINib(nibName: "ExpandedResumeCell" , bundle: nil)
        jobApplyTableView.register(resumeUploadCell, forCellReuseIdentifier: "ExpandedResumeCell")
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let result = formatter.string(from: date)
        
       
        
        createdDate =  result
        updatedDate =  result
        print("createdDateupdatedDateupdatedDate",updatedDate)
//        uploadresumeOutLet.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        uploadresumeOutLet.layer.borderWidth = 1
//        uploadresumeOutLet.layer.masksToBounds = false
//        uploadresumeOutLet.layer.borderColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
//        uploadresumeOutLet.layer.cornerRadius = 6.0
//        uploadresumeOutLet.clipsToBounds = true
  //      uploadViewheight.constant = 0
       // uploadBtnOutLet.isHidden = true
        //imageView.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - view Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Apply".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
    }
    
    
//MARK:- textField delegate methods
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        textField.autocorrectionType = .no
        textField.keyboardType = .asciiCapable
        
        if activeTextField.tag == 0 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
        else if activeTextField.tag == 1 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
        else if activeTextField.tag == 2 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
        else if activeTextField.tag == 3 {
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
        }
            
        else if activeTextField.tag == 4{
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .emailAddress
            
        }
            
        else if activeTextField.tag == 5{
            
            textField.maxLengthTextField = 10
            if #available(iOS 10.0, *) {
                textField.keyboardType = .asciiCapableNumberPad
            } else {
                // Fallback on earlier versions
            }
            
        }
        else if activeTextField.tag == 6{
            
            textField.maxLengthTextField = 50
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }
        else if activeTextField.tag == 7{
            
            textField.maxLengthTextField = 10
            textField.keyboardType = .default
            
            
        }
        
        else if activeTextField.tag == 8{
            
            textField.maxLengthTextField = 30
            textField.clearButtonMode = .never
            textField.keyboardType = .default
            
            
        }
        
        else if activeTextField.tag == 9{
            
            textField.maxLengthTextField = 7
            textField.clearButtonMode = .never
            if #available(iOS 10.0, *) {
                textField.keyboardType = .asciiCapableNumberPad
            }
           
        }
       
        else if activeTextField.tag == 10{
            
            textField.maxLengthTextField = 7
            textField.clearButtonMode = .never
            if #available(iOS 10.0, *) {
                textField.keyboardType = .asciiCapableNumberPad
            }
            
            
        }
        
        else if activeTextField.tag == 20{
           
            
            self.pickerUp(textField)
            pickerData = yearsArray
            myPickerView.reloadAllComponents()
            myPickerView.selectRow(0, inComponent: 0, animated: false)
            
        
        }

        
        else if activeTextField.tag == 30{
            
            self.pickerUp(textField)
            pickerData = monthArray
            myPickerView.reloadAllComponents()
            myPickerView.selectRow(0, inComponent: 0, animated: false)
        
        }


    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
        if textField.tag == 1 || textField.tag == 2 || textField.tag == 3{
            if string.characters.count > 0 {
                let allowedCharacters = CharacterSet.letters
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                return unwantedStr.characters.count == 0
            }
 
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        }
            
        else if textField.tag == 4 {

            
            if string.characters.count > 0 {
//                let allowedCharacters = CharacterSet.letters
//                let allowedCharacterss = CharacterSet.init(charactersIn: "0123456789@.")
//
//
//                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
//                let unwantedStrs = string.trimmingCharacters(in: allowedCharacterss)
//                return unwantedStr.characters.count == 0
                
                let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.@"
                
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
            
        }
        
        else if textField.tag == 5 {
            
            if string.characters.count > 0 {
                let allowedCharacters = CharacterSet.decimalDigits
                
                let unwantedStr = string.trimmingCharacters(in: allowedCharacters)
                
                if let text = textField.text,
                    let textRange = Range(range, in: text) {
                    let updatedText = text.replacingCharacters(in: textRange, with: string)
                    if updatedText.count == 1 && updatedText == "0" {
                        return false
                    }
                }

                return unwantedStr.characters.count == 0
            }

            
            
        }
       
        
        else if textField.tag == 6 {
            
            
            if string.characters.count > 0 {

                
                let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz."
                
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
            
        }
        
        activeTextField = textField
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.keyboardType = .asciiCapable
             if let newRegCell : JobApplyTableViewCell = textField.superview?.superview as? JobApplyTableViewCell {
            
        
            
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.keyboardType = .asciiCapable
        activeTextField = textField
        
        
        if activeTextField.tag == 0{
            
            jobtitle = textField.text!
            
        }
        else if activeTextField.tag == 1{
            
            firstname = textField.text!
            
        }
        else if activeTextField.tag == 2{
            
            middlename = textField.text!
            
        }
        else if activeTextField.tag == 3{
            
            lastname = textField.text!
            
        }
            
        else if activeTextField.tag == 4 {
            
            email = textField.text!
            
        }
            
        else if activeTextField.tag == 5{
            
            mobileNumber = textField.text!
            
        }
        else if activeTextField.tag == 6{
            
            qualification = textField.text!
            
            
        }
            
        else if activeTextField.tag == 7{
            
            
            yearofexperience = textField.text!
            
            
        }
        
        
        else if activeTextField.tag == 8{
            
            
            currentorganization = textField.text!
            
            
        }

        else if activeTextField.tag == 9{
            
            
            currentsalary = textField.text!
            
            
        }
        else if activeTextField.tag == 10{
            
            
            expectedsalary = textField.text!
            
            
        }

        
    }
    
 
    
    func donePressed(){
        
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateString = dateFormatter.string(from: datepicker.date)
    
        print(dateString)
        self.view.endEditing(true)
        jobApplyTableView.reloadData()
        
    }
  
    //MARK:-  cancel Clicked
    
    func cancel(){
        
        activeTextField.resignFirstResponder()
        jobApplyTableView.endEditing(true)
        
        
    }
    
   
//MARK: - Table view delegate and datasource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0 {
            
            return 7
        }
        else if section == 1  {
            
            return 1
        
        }else if section == 2  {
            
            return 3
            
        }else if section == 3  {
            
            return 1
            
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return 70;
        }
        else
        {
            // Iphone
            if indexPath.section == 0 {
                return 45;
            
            } else if indexPath.section == 1 {
                return 60;
                
            } else if indexPath.section == 2 {
                return 45;
                
            }else if indexPath.section == 3 {
                if docBase64String == "" {
                    
                    return 81;
                }else{
                    return 175;
                }
            }else{
                return 0;
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        if indexPath.section == 0 {
        
            let jobApp = tableView.dequeueReusableCell(withIdentifier: "JobApplyTableViewCell", for: indexPath) as! JobApplyTableViewCell
            
        jobApp.jobApplyTF.delegate = self
         jobApp.jobApplyTF.tag = indexPath.row
        
            
            if indexPath.row == 0{
                
            jobApp.jobApplyTF.placeholder = "Job Title".localize()
            jobApp.jobApplyTF.text = jobtitle
            jobApp.jobApplyTF.isUserInteractionEnabled = false
                if(self.isjobtitle == true){
                    self.readDataSource()
                }
                
            }
            else if indexPath.row == 1{
                
                jobApp.jobApplyTF.placeholder = "First Name".localize()
                jobApp.jobApplyTF.text = firstname
                jobApp.jobApplyTF.isUserInteractionEnabled = true
            }
            else if indexPath.row == 2{
                
                jobApp.jobApplyTF.placeholder = "Middle Name".localize()
                jobApp.jobApplyTF.text = middlename
                jobApp.jobApplyTF.isUserInteractionEnabled = true
                
            }
            else if indexPath.row == 3{
                
            jobApp.jobApplyTF.placeholder = "Last Name".localize()
             jobApp.jobApplyTF.text = lastname
                jobApp.jobApplyTF.isUserInteractionEnabled = true
                
            }
            else if indexPath.row == 4{
                
            jobApp.jobApplyTF.placeholder = "Email".localize()
              jobApp.jobApplyTF.text = email
                jobApp.jobApplyTF.isUserInteractionEnabled = true
            }
            else if indexPath.row == 5{
                
            jobApp.jobApplyTF.placeholder = "Mobile Number".localize()
              jobApp.jobApplyTF.text = mobileNumber
                jobApp.jobApplyTF.isUserInteractionEnabled = true
            }
            else if indexPath.row == 6{
                
            jobApp.jobApplyTF.placeholder = "Qualification".localize()
                
             jobApp.jobApplyTF.text = qualification
             jobApp.jobApplyTF.isUserInteractionEnabled = true
            }
            
         return jobApp
        
        }
         else  if indexPath.section == 1 {
            
            
            let jobApplymonth = jobApplyTableView.dequeueReusableCell(withIdentifier: "jobApplymonthTableViewCell", for: indexPath) as! jobApplymonthTableViewCell
            jobApplymonth.monthTF.isUserInteractionEnabled = true
            jobApplymonth.yearTF.isUserInteractionEnabled = true
            
            jobApplymonth.monthTF.delegate = self
            jobApplymonth.yearTF.delegate = self
            
            jobApplymonth.yearTF.tag = 20
            jobApplymonth.monthTF.tag = 30
            
            jobApplymonth.monthTF.text = selectedMonths
            jobApplymonth.yearTF.text = selectedYears
            
        return jobApplymonth
            
        }
            
        else if indexPath.section == 2 {
        
            let JobApply = tableView.dequeueReusableCell(withIdentifier: "JobApplyTableViewCell", for: indexPath) as! JobApplyTableViewCell
            
            JobApply.jobApplyTF.delegate = self
            JobApply.jobApplyTF.isUserInteractionEnabled = true
            
            if indexPath.row == 0{
            
             JobApply.jobApplyTF.tag = 8
                    
    JobApply.jobApplyTF.placeholder = "Current Organization".localize()
    JobApply.jobApplyTF.text = currentorganization
                
                    
        JobApply.jobApplyTF.maxLengthTextField = 30
            
        }
       else if indexPath.row == 1{
                    
          JobApply.jobApplyTF.tag = 9
            
            JobApply.jobApplyTF.placeholder = "Current Salary".localize()
            
            JobApply.jobApplyTF.text = currentsalary
                   JobApply.jobApplyTF.maxLengthTextField = 7
                    
                    }
                    
    else if indexPath.row == 2{
                    
         JobApply.jobApplyTF.tag = 10
        JobApply.jobApplyTF.placeholder = "Expected Salary".localize()
        JobApply.jobApplyTF.text = expectedsalary
        JobApply.jobApplyTF.isUserInteractionEnabled = true
                    
        JobApply.jobApplyTF.maxLengthTextField = 7
                            
                    }

        return JobApply
        
        }else if indexPath.section == 3 {
            
            
            if docBase64String == "" {
                
                let resumeUploadCell = tableView.dequeueReusableCell(withIdentifier: "ExpandedResumeCell", for: indexPath) as! ExpandedResumeCell
                resumeUploadCell.docCollactionView.register(UINib.init(nibName: "UploadCell", bundle: nil),forCellWithReuseIdentifier: "UploadCell")
                resumeUploadCell.docCollactionView.delegate = self
                resumeUploadCell.docCollactionView.dataSource = self
                //resumeUploadCell.docBackGroundView.isHidden = true
                  resumeUploadCell.docCollactionView.collectionViewLayout.invalidateLayout()
                resumeUploadCell.docCollactionView.reloadData()
              
                resumeUploadCell.docViewHeightConst.constant = 0
                resumeUploadCell.uploadResumeBtn.addTarget(self, action: #selector(resumeUploadClicked(_:)), for: UIControlEvents.touchUpInside)
                resumeUploadCell.applayBtn.addTarget(self, action: #selector(applyBtnClicked(_:)), for: UIControlEvents.touchUpInside)
                
                
                return resumeUploadCell
            }else{
                let resumeUploadCell = tableView.dequeueReusableCell(withIdentifier: "ExpandedResumeCell", for: indexPath) as! ExpandedResumeCell
                
               // resumeUploadCell.docBackGroundView.isHidden = false
                resumeUploadCell.docCollactionView.register(UINib.init(nibName: "UploadCell", bundle: nil),forCellWithReuseIdentifier: "UploadCell")
                resumeUploadCell.docCollactionView.delegate = self
                resumeUploadCell.docCollactionView.dataSource = self
                 resumeUploadCell.docCollactionView.collectionViewLayout.invalidateLayout()
                resumeUploadCell.docCollactionView.reloadData()
               
                 resumeUploadCell.docViewHeightConst.constant = 77
                resumeUploadCell.uploadResumeBtn.addTarget(self, action: #selector(resumeUploadClicked(_:)), for: UIControlEvents.touchUpInside)
                resumeUploadCell.applayBtn.addTarget(self, action: #selector(applyBtnClicked(_:)), for: UIControlEvents.touchUpInside)
                

                
   
                return resumeUploadCell
            }
      
        }else{
            
            return UITableViewCell()
        }
  
//            return UITableViewCell()
        }
    //MARK: - collection view delegate and datasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if isResumeUploaded == true {
            
           
            return 1
            
            
        }else{
            
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
            
            let uploadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for:
                indexPath) as! UploadCell
                uploadCell.clearBtn.tag = indexPath.row
                uploadCell.fileNameLbl.text = fileNameString
            //        if (filename == ".pdf") || (filename == ".docs") || (filename == ".docx")  || (filename == ".txt") || (filename == ".rtf"){
            //
            //
            //
            //        }
            //uploadCell.imageDoc.image = docsUrlArray[indexPath.row]
            uploadCell.clearBtn.addTarget(self, action: #selector(clearBtnClicked(_:)), for: UIControlEvents.touchUpInside)
              //     uploadCell.nameLbl.text = yearsArray[indexPath.row]
            return uploadCell
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if (filename == ".pdf") || (filename == ".docs") || (filename == ".docx") || (filename == ".txt") || (filename == ".rtf"){
            
            print("Pdfs and docs")
            
            let embededUrlImage =  docUrl
            
            print(embededUrlImage)
            
            
            let docViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocViewController") as! DocViewController
            
            self.navigationController?.pushViewController(docViewController, animated: true)
            
        }
        
        
        
    }
//    func collectionView(_ collectionView: UICollectionView,willDisplay cell: UICollectionViewCell,forItemAt indexPath: IndexPath) {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 88, height: 70)
        
    }
    func  clearBtnClicked(_ sendre:UIButton) {
        
        let selectedDoc = sendre.tag

                Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Are You Sure Want To Remove".localize(), clickAction: {

                   //self.docsUrlArray.remove(at: selectedDoc)
                 //   print("selectedDoc",selectedDoc)
                  //  print("docsUrlArray",self.docsUrlArray)
                    self.docBase64String = ""
               
                    
                    
                    self.jobApplyTableView.reloadData()
                    
                })

        //jobApplyTableView.reloadData()

        print("applyBtnClicked")

    }
    //MARK: - back Left Button Tapped
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        UserDefaults.standard.removeObject(forKey: "1")
        UserDefaults.standard.removeObject(forKey: kLoginSucessStatus)
        UserDefaults.standard.set("1", forKey: "1")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
        print("Back Button Clicked......")
        
    }
    
    
    
    //MARK: -    Home Button Tapped
    
    
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
   

    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
        
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }

    
    //MARK:- validateAllFields
    
    func validateAllFields() -> Bool
    {
        
        var errorMessage:NSString?
        let jobtitleStr:NSString = jobtitle as NSString
        let firstnameStr:NSString = firstname as NSString
        let middlenameStr:NSString =  middlename  as NSString
        
        let lastnameStr:NSString = lastname as NSString
        let emailStr:NSString = email as NSString
        let mobileNumberStr:NSString =  mobileNumber  as NSString
        let qualificationStr:NSString = qualification   as NSString
        let yearofexperienceStr:NSString =  selectedYears  as NSString
        
        let monthsofexperienceStr:NSString = selectedMonths   as NSString
        
         let uploadresumeStr:NSString = uploadresume   as NSString
        
        
//        let currentorganizationStr:NSString =  currentorganization  as NSString
//        let currentsalaryStr:NSString = currentsalary   as NSString
//        let expectedsalaryStr:NSString =  expectedsalary  as NSString
        
        
        if (jobtitleStr.length <= 1){
            
            
            errorMessage=GlobalSupportingClass.blankjobtitleErrorMessage() as String as String as NSString?
            
        }
            
        else if (firstnameStr.length <= 0){
            
            
            errorMessage=GlobalSupportingClass.blankFirstNameErrorMessage() as String as String as NSString?
            
        }
            
        else if (lastnameStr.length <= 0){
            
            
            errorMessage=GlobalSupportingClass.blankLastNameErrorMessage() as String as String as NSString?
            
        }
            
            
        else if (emailStr.length<=0) {
            
            
            errorMessage=GlobalSupportingClass.blankEmailIDErrorMessage() as String as String as NSString?
        }
            
        else  if (emailStr.length < 5) {
            
            
            errorMessage=GlobalSupportingClass.miniCharEmailIDErrorMessage() as String as String as NSString?
        }
        else  if(!GlobalSupportingClass.isValidEmail(emailStr as NSString))
        {
            errorMessage=GlobalSupportingClass.invalidEmaildIDFormatErrorMessage() as String as String as NSString?
        }
            
        else if (mobileNumberStr.length <= 0){
            
            
            errorMessage=GlobalSupportingClass.blankMobilenumberErrorMessage() as String as String as NSString?
            
        }
        else if (mobileNumberStr.length <= 9) {
            
            
            errorMessage=GlobalSupportingClass.invalidMobilenumberErrorMessage() as String as String as NSString?
        }
            
        else if (qualificationStr.length <= 0){
            
            
            errorMessage=GlobalSupportingClass.blankqualificationErrorMessage() as String as String as NSString?
            
        }
            
        else if (yearofexperienceStr.length <= 2){
            
            
            errorMessage=GlobalSupportingClass.blankyearofexperienceErrorMessage() as String as String as NSString?
            
        }
        else if (monthsofexperienceStr.length <= 2){
            
            
            errorMessage=GlobalSupportingClass.blankmonthofexperienceErrorMessage() as String as String as NSString?
            
        }
        
        
        else if (self.docBase64String == ""){
            
            
        errorMessage=GlobalSupportingClass.blankresumeErrorMessage() as String as String as NSString?
            
        }
//
//
//        else if (currentorganizationStr.length <= 0){
//            
//            
//            errorMessage=GlobalSupportingClass.blankcurrentorganizationErrorMessage() as String as String as NSString?
//            
//        }
//            
//        else if (currentsalaryStr.length <= 2){
//            
//            
//            errorMessage=GlobalSupportingClass.blankcurrentsalaryErrorMessage() as String as String as NSString?
//            
//        }
//
//        else if (expectedsalaryStr.length <= 2){
//            
//            
//            errorMessage=GlobalSupportingClass.blankexpectedsalaryErrorMessage() as String as String as NSString?
//            
//        }
//        
//        
        
        
        if let errorMsg = errorMessage{
            
            
            alertWithTitle(title: "Alert".localize(), message: errorMsg as String, ViewController: self, toFocus: activeTextField)
            return false
        }
        return true
    }
    
    
    
    
func alertWithTitle(title: String!, message: String, ViewController: UIViewController, toFocus:UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localize(), style: UIAlertActionStyle.cancel,handler: {_ in
            
            
            let indexPath : IndexPath = IndexPath(row: self.alertTag, section: 0)
            
            self.jobApplyTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            if let cell = self.jobApplyTableView.cellForRow(at: indexPath) as? SignUPTableViewCell {
                
                cell.registrationTextfield.becomeFirstResponder()
            }
            
            
        });
        alert.addAction(action)
        ViewController.present(alert, animated: true, completion:nil)
    }
    
   //MARK: - apply Btn Action

    @IBAction func applyBtnAction(_ sender: Any) {
        
        jobApplyTableView.endEditing(true)
        
        if(appDelegate.checkInternetConnectivity()){
            
            if self.validateAllFields()
            {
             getjobApplicationAPICall()
                
            }
        }
        else {
            
            return
            
        }
        print("Submit Button Clicked......")
        
    }
    
   //MARK: - upload Btn Action
    
//    @IBAction func uploadBtnAction(_ sender: Any) {
//
//
//        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Are You Sure Want To Remove".localize(), clickAction: {
//
//
//      // self.uploadViewheight.constant = 0
//       self.uploadView.isHidden = true
//        self.uploadBtnOutLet.isHidden = true
//        self.imageView.isHidden = true
//
//        self.docsUrlArray.removeAll()
//
//        })
//
//
//
//    }
    
    func  resumeUploadClicked(_ sendre:UIButton) {
        
            fileextension = false
        if docBase64String == "" {
            
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
            
            //   let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text", "com.apple.iwork.pages.pages", "public.data"], in: .import)
            
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
            
            //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //
            self.jobApplyTableView.reloadData()
            //
            //        }
            
            
            //
            //        let menu = UIAlertController(title: nil, message: "Select Image", preferredStyle: .actionSheet)
            //
            //        let document = UIAlertAction(title: "Upload Document", style: .default, handler: { (alert : UIAlertAction!)
            //            -> Void in
            //
            //            self.documentPicker.delegate = self
            //            self.present(self.documentPicker, animated: true, completion: {
            //
            //                print("documentPicker presented")
            //            })
            //
            //        })
            //
            //
            //        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            //        menu.addAction(document)
            //        menu.addAction(cancel)
            //
            //        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            //
            //            present(menu, animated: true, completion: nil)
            //        }
            //
            //        else{
            //
            //            let popup = UIPopoverController.init(contentViewController: menu)
            //
            //            popup.present(from: CGRect(x:self.view.frame.size.width/2, y:self.view.frame.size.height/4, width:0, height:0), in: self.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
            //
            //        }
            //
            print("resumeUploadClicked")
            
        }else{
            
            print("limit one DocumentFile")
            
        }
     
    }
    
    func  applyBtnClicked(_ sendre:UIButton) {
        
        jobApplyTableView.endEditing(true)
        
        if(appDelegate.checkInternetConnectivity()){
            
            if self.validateAllFields()
            {
                getjobApplicationAPICall()
                
            }
        }
        else {
            
            return
            
        }
        
        print("applyBtnClicked")
        
    }
  //MARK: - upload resume Action
    
    @IBAction func uploadresumeAction(_ sender: Any) {
        
        fileextension = false
        let menu = UIAlertController(title: nil, message: "Select Image", preferredStyle: .actionSheet)
        
        let document = UIAlertAction(title: "Upload Document", style: .default, handler: { (alert : UIAlertAction!)
            -> Void in
            
            self.documentPicker.delegate = self
            self.present(self.documentPicker, animated: true, completion: {
                
                print("documentPicker presented")
            })
            
        })
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(document)
        menu.addAction(cancel)
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            
            present(menu, animated: true, completion: nil)
        }
            
        else{
            
            let popup = UIPopoverController.init(contentViewController: menu)
            
            popup.present(from: CGRect(x:self.view.frame.size.width/2, y:self.view.frame.size.height/4, width:0, height:0), in: self.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
            
        }
        
    
    }
    
    //MARK: - close Btn Clicked
    
    func closeBtnClicked(sender:UIButton){
        
        let i : Int = (sender.layer.value(forKey: "index")) as! Int
        
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Areyousurewanttodeletethisimage?") {
            
            self.selectedImagesArray.remove(at: i)
            
            if self.selectedImagesArray.count > 0{
                
                
            }
            else {
                
                
            }
            
            self.jobApplyTableView.reloadData()
            
        }
        
    }
  
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }

  //MARK: - get job Application API Call
    
func getjobApplicationAPICall(){
    
    let paramsDict = [

        "docString": self.docBase64String,
        "id": 0,
        "jobId": jobId,
        "firstName": firstname,
        "middleName": middlename,
        "lastName": lastname,
        "mobileNumber": mobileNumber,
        "email": email,
        "qualification": qualification,
        "applyingFor": "Accountant",
        "yearsofExp": selectedYears + "" + selectedMonths,
        "fileName": "",
        "fileLocation": "",
        "fileExtention": ".pdf",
        "currentOrganization": currentorganization,
        "currentSalary": currentsalary,
        "expectedSalary": expectedsalary,
        "isActive": isActive,
        "createdByUserId": createdByUserId,
        "createdDate": createdDate,
        "updatedByUserId": updatedByUserId,
        "updatedDate": updatedDate
        
                        ] as [String : Any]
    
            let dictHeaders = ["":"","":""] as NSDictionary
    print(paramsDict)
    
            serviceController.postRequest(strURL: JOBAPPLYAPI as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
    
                print(result)
    
                let respVO:JobApplyVO = Mapper().map(JSONObject: result)!
    
                 let statusMsg = respVO.endUserMessage
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
    
    
                if isSuccess == true {
    
                    let listArr = respVO.listResult
    
                    
                    
                    
//                    self.utillites.alertWithOkButtonAction(vc: self, alertTitle: "Success", messege:statusMsg!, clickAction: {
//
                       self.dismiss(animated: true, completion: nil)
                       let getjobdetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "GetAllJobDetailsViewController") as! GetAllJobDetailsViewController
                        self.navigationController?.pushViewController(getjobdetailsVC, animated: true)
                       appDelegate.window?.makeToast(statusMsg!, duration:kToastDuration, position:CSToastPositionCenter)
//
//                    })
                    
                    
        self.jobApplyTableView.reloadData()
    
                }
    
                else {
    
              
                    
                    
                    self.jobApplyTableView.reloadData()
    
                }
    
            }) { (failureMessage) in
    
    
                print(failureMessage)
    
            }
        }
    
    
//MARK: -  UIpickerView delegate & DataSource  methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedData = pickerData[row]
    }

    func pickerUp(_ textField : UITextField){
        
        // UIPickerView
        
        if(self.myPickerView == nil){
            
            self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        }
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        self.myPickerView.tag = textField.tag
        textField.inputView = self.myPickerView
        
        // ToolBar
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
//MARK:-  done Clicked
    
    func done() {
        
        if(activeTextField.tag == 20) {
          
             selectedYears = selectedData
          
            
        }
        else  {
        
            if(activeTextField.tag == 30) {
                
                selectedMonths = selectedData
                
                
            }
            
        
        }
        
        self.selectedData.removeAll()
        activeTextField.resignFirstResponder()
        jobApplyTableView.reloadData()
        
        
    }
    
    func readDataSource(){
        
        if(addressInfo.count > 0){
            
            let model = addressInfo[0]
            jobtitle = model.jobTitle!
                       
        }
        
    }
    
    //MARK: - documentPicker Delegate methods
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        docUrl = url as URL
        print(docUrl)
        print(url)
        
        print(url.lastPathComponent)
        fileNameString = url.lastPathComponent
        print(url.pathExtension)
        
                do {
                    let data = try Data(contentsOf: self.docUrl)
                    print("The data is : \(data)")
                    //let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                    
                    let base64String = data.base64EncodedString(options: .init(rawValue: 0))
      
                    
         //   let newImage = ConvertBase64StringToImage(imageBase64String: base64String)
              
                   
                    //self.docsUrlArray.append(base64String)
                    self.docBase64String = base64String
                     isResumeUploaded = true
                   
                    print("self.docBase64String ",self.docBase64String)
                    docCount = docCount + 1
                    
                    jobApplyTableView.reloadData()
                   // if(docCount == 2){
                    
                    //}
                } catch {
                    // handle exception
                    print(" handle exception")
        
//                    isResumeUploaded = true
                 
//                    if(docCountArray.count == 0){
//                        docCountArray.append(UIImage(named:"audio_music")!)
//                    }else if(docCountArray.count == 1){
//                        docCountArray.append(UIImage(named:"bibleImgg")!)
//                    }else{
//                        docCountArray.append(UIImage(named:"audio_music")!)
//                    }
//                    print("docCountArray",docCountArray.count)
        
                }
        print("The Url is : \(filename)")
        
        // file:///private/var/mobile/Library/Mobile%20Documents/com~apple~Numbers/Documents/API%20Doubts%20_09-10-17.numbers
        
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        print(documentsUrl)
        
        do
        {
            
            
        }
        catch{
            
            print("Error: \(error)")
        }
        
        let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last
        let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
        
        
        if let iCloudDocumentsURL = iCloudDocumentsURL {
            var error:NSError?
            var isDir:ObjCBool = false
            if (FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir)) {
                
                
                do {
                    
                    try FileManager.default.removeItem(at: iCloudDocumentsURL)
                    
                }
                catch {
                    
                    
                }
                
            }
            
            
        }
        jobApplyTableView.reloadData()
    }
    func getImageFromBase64(base64:String) -> UIImage {
        let data = Data(base64Encoded: base64)
        return UIImage(data: data!)!
    }
    func ConvertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//
//
//
//
//        self.docUrl = url as URL
//
//  //      self.uploadLblOutLet.text = (self.docUrl.absoluteString.components(separatedBy: "/Documents/"))[1]
//        print("The Url is : \(docUrl)")
//
//       // imageView.isHidden = false
//        self.filename = docUrl.pathExtension
//
//
//        do {
//            let data = try Data(contentsOf: self.docUrl)
//            print("The data is : \(data)")
//            let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//            self.docsUrlArray.append(base64String)
//        } catch {
//            // handle exception
//            print(" handle exception")
//
//            isResumeUploaded = true
//            docCount = docCount + 1
//            if(docCountArray.count == 0){
//                docCountArray.append(UIImage(named:"audio_music")!)
//            }else if(docCountArray.count == 1){
//                docCountArray.append(UIImage(named:"bibleImgg")!)
//            }else{
//                docCountArray.append(UIImage(named:"audio_music")!)
//            }
//            print("docCountArray",docCountArray.count)
//
//            jobApplyTableView.reloadData()
//
//
//
//        }
//
//
//
//     //   uploadViewheight.constant = 50
//      //  uploadView.isHidden = false
//       // uploadBtnOutLet.isHidden = false
//       // imageView.isHidden = false
//
//        print("The Url is : \(filename)")
//
//      // file:///private/var/mobile/Library/Mobile%20Documents/com~apple~Numbers/Documents/API%20Doubts%20_09-10-17.numbers
//
//
//        let fileManager = FileManager.default
//        let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
//        print(documentsUrl)
//
//        do
//        {
//
//
//        }
//        catch{
//
//            print("Error: \(error)")
//        }
//
//        let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last
//        let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
//
//
//        if let iCloudDocumentsURL = iCloudDocumentsURL {
//            var error:NSError?
//            var isDir:ObjCBool = false
//            if (FileManager.default.fileExists(atPath: iCloudDocumentsURL.path, isDirectory: &isDir)) {
//
//
//                do {
//
//                    try FileManager.default.removeItem(at: iCloudDocumentsURL)
//
//                }
//                catch {
//
//
//                }
//
//            }
//
//
//        }
//        jobApplyTableView.reloadData()
//    }
    func uploadFiles(_ urlPath: [URL]){
        
        if let url = URL(string: "YourURL"){
            var request = URLRequest(url: url)
            let boundary:String = "Boundary-\(UUID().uuidString)"
            
            request.httpMethod = "POST"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = ["Content-Type": "multipart/form-data; boundary=----\(boundary)"]
            
            for path in urlPath{
                do{
                    var data2: Data = Data()
                    var data: Data = Data()
                    data2 = try NSData.init(contentsOf: URL.init(fileURLWithPath: path.absoluteString, isDirectory: true)) as Data
                    /* Use this if you have to send a JSON too.
                     let dic:[String:Any] = [
                     "Key":Value,
                     "Key":Value
                     ]
                     
                     
                     for (key,value) in dic{
                     data.append("------\(boundary)\r\n")
                     data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                     data.append("\(value)\r\n")
                     }
                     */
                    data.append("------\(boundary)\r\n")
                    //Here you have to change the Content-Type
                    data.append("Content-Disposition: form-data; name=\"file\"; filename=\"YourFileName\"\r\n")
                    data.append("Content-Type: application/YourType\r\n\r\n")
                    data.append(data2)
                    data.append("\r\n")
                    data.append("------\(boundary)--")
                    
                    request.httpBody = data
                }catch let e{
                    //Your errors
                }
                DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).sync {
                    let session = URLSession.shared
                    let task = session.dataTask(with: request, completionHandler: { (dataS, aResponse, error) in
                        if let erros = error{
                            //Your errors
                        }else{
                            do{
                                let responseObj = try JSONSerialization.jsonObject(with: dataS!, options: JSONSerialization.ReadingOptions(rawValue:0)) as! [String:Any]
                                
                            }catch let e{
                                
                            }
                        }
                    }).resume()
                }
            }
        }
    }
    //MARK: - resize Image
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
    @available(iOS 8.0, *)
    
    public func documentMenu(_ documentMenu:     UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self as UIDocumentPickerDelegate
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    @available(iOS 8.0, *)
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
        self.documentPicker = UIDocumentPickerViewController(documentTypes:  ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: UIDocumentPickerMode.open)

        dismiss(animated: true, completion: {
            print("we cancelled")
            
            
        })
        
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if self.presentedViewController == nil {

        
        } else {

        }
        super.dismiss(animated: flag, completion: completion)
    }
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        
        let size = CGSize(width: 400, height: 400)
        newImage = resizeImage(image: image,targetSize : size)
        
        
        
        selectedImagesArray.append(newImage)
        
        jobApplyTableView.reloadData()
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func getArrayOfBytesFromImage(imageData:NSData) -> NSMutableArray
    {
        
        let count = imageData.length / MemoryLayout<UInt8>.size
        
        var bytes = [UInt8](repeating: 0, count: count)
        
        imageData.getBytes(&bytes, length:count * MemoryLayout<UInt8>.size)
        
        let byteArray:NSMutableArray = NSMutableArray()
        
        
        for i in (0..<bytes.count){
            
            byteArray.add(NSNumber(value: bytes[i]))
        }
        
        return byteArray
        
        
    }

//        func getFormattedDate(string: String) -> String{
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//
//            let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
//            print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
//            return dateFormatterPrint.string(from: date!);
//        }
}




struct ImageHeaderData{
    
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47]
    static var TIFF_01: [UInt8] = [0x49]
    static var TIFF_02: [UInt8] = [0x4D]
}

enum ImageFormat{
    case Unknown, PNG, JPEG, GIF, TIFF
}
extension Data {
    
    var format: String {
        let array = [UInt8](self)
        let ext: String
        switch (array[0]) {
        case 0xFF:
            ext = "jpg"
        case 0x89:
            ext = "png"
        case 0x47:
            ext = "gif"
        case 0x49, 0x4D :
            ext = "tiff"
        default:
            ext = "unknown"
        }
        return ext
    }
}
extension JobApplyViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}

extension NSData{
    var imageFormat: ImageFormat{
        var buffer = [UInt8](repeating: 0, count: 1)
        self.getBytes(&buffer, range: NSRange(location: 0,length: 1))
        if buffer == ImageHeaderData.PNG
        {
            return .PNG
        } else if buffer == ImageHeaderData.JPEG
        {
            return .JPEG
        } else if buffer == ImageHeaderData.GIF
        {
            return .GIF
        } else if buffer == ImageHeaderData.TIFF_01 || buffer == ImageHeaderData.TIFF_02{
            return .TIFF
        } else{
            return .Unknown
        }
    }
}

extension Data{
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}

