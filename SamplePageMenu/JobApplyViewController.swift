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




class JobApplyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate,UICollectionViewDelegate,UICollectionViewDataSource  {
    
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
    
     var selectedImagesArray: Array<UIImage> = []
    var filename : String = ""
    
    var docsUrlArray:Array<String> = []
    
    var docUrl : URL = NSURL() as URL

    var image  = UIImage()
    var newImage = UIImage()
    
    var myImagePicker = UIImagePickerController()
    
     var fileextension : Bool = false
    
    var documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes:  ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: UIDocumentPickerMode.open)
    
    let pickerView = UIPickerView()
    
    private var imagePicked = 0
    
    
    
     var activeTextField = UITextField()
      var appVersion          : String = ""
    
     let utillites =  Utilities()
    
    var jobtitle    :String = ""
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
    var createdByUserId:Int = 1
    var createdDate : String = "2018-05-14T11:15:41.9952665+05:30"
    var updatedByUserId : Int = 1
    var updatedDate:String =  "2018-05-14T11:15:41.9952665+05:30"
    
    let dateFormatter = DateFormatter()
    
    let datepicker = UIDatePicker()
    
    var selectedMonths : String = ""
     var selectedYears : String = ""
    var pickerData = Array<String>()
    var myPickerView: UIPickerView!
      var dateString :String = ""
      var selectedData : String = ""
    var financierType : Array = Array<String>()
    
    var createddate : String = "2018-04-24T11:17:41.5268377+05:30"
    
  var alertTag = Int()
    
    var isjobtitle = false
    
    var addressInfo:[GetAllJobDetailsListResultVO] = Array<GetAllJobDetailsListResultVO>()
    
    var months = ""
    
    
    var yearsArray : Array = ["0 Year","1 Year","2 Years","3 Years","4 Years","5 Years","6 Years","7 Years","8 Years","9 Years","10 Years","11 Years","12 Years","13 Years","14 Years","15 Years","16 Years","17 Years","18 Years","19 Years","20 Years","21 Years","22 Years","23 Years","24 Years","25 Years","26 Years","27 Years","28 Years","29 Years","30 Years","31 Years","32 Years","33 Years","34 Years","35 Years","36 Years","37 Years","38 Years","39 Years","40 Years","41 Years","42 Years","43 Years","44 Years","45 Years","46 Years","47 Years","48 Years","49 Years","50 Years"]

     var monthArray : Array = ["0 Month","1 Month","2 Months","3 Months","4 Months","5 Months","6 Months","7 Months","8 Months","9 Months","10 Months","11 Months","12 Months"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobApplyTableView.delegate = self
        jobApplyTableView.dataSource = self
        
        activeTextField.delegate = self
        
        let categorieHomeCell  = UINib(nibName: "JobApplyTableViewCell" , bundle: nil)
        jobApplyTableView.register(categorieHomeCell, forCellReuseIdentifier: "JobApplyTableViewCell")
        
        let jobApplymonthTableViewCell  = UINib(nibName: "jobApplymonthTableViewCell" , bundle: nil)
        jobApplyTableView.register(jobApplymonthTableViewCell, forCellReuseIdentifier: "jobApplymonthTableViewCell")
        
        uploadresumeOutLet.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        uploadresumeOutLet.layer.borderWidth = 1
        uploadresumeOutLet.layer.masksToBounds = false
        uploadresumeOutLet.layer.borderColor = UIColor(red: 113.0/255.0, green: 173.0/255.0, blue: 208.0/255.0, alpha: 1.0).cgColor
       uploadresumeOutLet.layer.cornerRadius = 6.0
        
        uploadresumeOutLet.clipsToBounds = true
        
        uploadViewheight.constant = 0
        uploadBtnOutLet.isHidden = true
        imageView.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setChurchuInfoViewControllerNavBarColorInCntrWithColor(backImage: "icons8-arrows_long_left", cntr:self, titleView: nil, withText: "Apply".localize(), backTitle: " " , rightImage: "homeImg", secondRightImage: "Up", thirdRightImage: "Up")
        
       
        
        
    }
    
    
    //MARK:- textField Should End Editing
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        activeTextField = textField
        
        textField.autocorrectionType = .no
        
        
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
            textField.keyboardType = .phonePad
            
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
            textField.keyboardType = .numberPad
            
            
        }
       
        else if activeTextField.tag == 10{
            
            textField.maxLengthTextField = 7
            textField.clearButtonMode = .never
            textField.keyboardType = .numberPad
            
            
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
        
        
        if !string.canBeConverted(to: String.Encoding.ascii){
            return false
        }
        activeTextField = textField
        
        return true
        
    }
      //MARK:- textField Should Should End Editing
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        
        
        if let newRegCell : JobApplyTableViewCell = textField.superview?.superview as? JobApplyTableViewCell {
            
            
            
        }
        return true
    }
    
    
    
    
    //MARK:- textField Did End Editing
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
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
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return docsUrlArray.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocsCollectionViewCell", for:
            indexPath) as! DocsCollectionViewCell
        
        if (filename == ".pdf") || (filename == ".docs") || (filename == ".docx") {
            
            cell.docsImage.contentMode = .scaleAspectFit
            cell.docsImage.image = #imageLiteral(resourceName: "docImg")
            
            
            
        }
       
        
        cell.closeBtn?.layer.setValue(indexPath.row, forKey: "index")
        cell.closeBtn.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        

        
        if (filename == ".pdf") || (filename == ".docs") || (filename == ".docx"){
            
            print("Pdfs and docs")
            
            
            let embededUrlImage =  docUrl
            
            print(embededUrlImage)
            
            
                       let docViewController = self.storyboard?.instantiateViewController(withIdentifier: "DocViewController") as! DocViewController
            
            
            
            
            self.navigationController?.pushViewController(docViewController, animated: true)
            
           
                       
        }

        
        
    }
   
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0 {
            
            return 7
        }
        else if section == 1  {
            
            return 1
        
        }
        
        return 3
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
            if indexPath.section == 1 {
                return 60;
            
            }
            
            return 45;
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        if indexPath.section == 0 {
  
        
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "JobApplyTableViewCell", for: indexPath) as! JobApplyTableViewCell
            
        signUPCell.jobApplyTF.delegate = self
         signUPCell.jobApplyTF.tag = indexPath.row
        
            
            if indexPath.row == 0{
                
            signUPCell.jobApplyTF.placeholder = "Job Title".localize()
            signUPCell.jobApplyTF.text = jobtitle
           signUPCell.jobApplyTF.isUserInteractionEnabled = false
                if(self.isjobtitle == true){
                    self.readDataSource()
                }

                
            }
            else if indexPath.row == 1{
                
                signUPCell.jobApplyTF.placeholder = "First Name".localize()
                signUPCell.jobApplyTF.text = firstname
            }
            else if indexPath.row == 2{
                
                signUPCell.jobApplyTF.placeholder = "Middle Name".localize()
                signUPCell.jobApplyTF.text = middlename
                
            }
            else if indexPath.row == 3{
                
                
            signUPCell.jobApplyTF.placeholder = "Last Name".localize()
             signUPCell.jobApplyTF.text = lastname
                
            }
            else if indexPath.row == 4{
                
            signUPCell.jobApplyTF.placeholder = "Email".localize()
              signUPCell.jobApplyTF.text = email
                
            }
            else if indexPath.row == 5{
                
            signUPCell.jobApplyTF.placeholder = "Mobile Number".localize()
              signUPCell.jobApplyTF.text = mobileNumber
                
            }
            else if indexPath.row == 6{
                
            signUPCell.jobApplyTF.placeholder = "Qualification".localize()
                
             signUPCell.jobApplyTF.text = qualification
            }
            
         return signUPCell
        
        }
         else  if indexPath.section == 1 {
            
            
            let signUPCell1 = jobApplyTableView.dequeueReusableCell(withIdentifier: "jobApplymonthTableViewCell", for: indexPath) as! jobApplymonthTableViewCell
            
            signUPCell1.monthTF.delegate = self
            signUPCell1.yearTF.delegate = self
            
            signUPCell1.yearTF.tag = 20
            signUPCell1.monthTF.tag = 30
            
            
      
            signUPCell1.monthTF.text = selectedMonths
            signUPCell1.yearTF.text = selectedYears
            
            
          
            
            
        return signUPCell1
            
        }
            
        else{
        
        
            let signUPCell = tableView.dequeueReusableCell(withIdentifier: "JobApplyTableViewCell", for: indexPath) as! JobApplyTableViewCell
            
            signUPCell.jobApplyTF.delegate = self
            
            
            
                 if indexPath.row == 0{
            
             signUPCell.jobApplyTF.tag = 8
                    
    signUPCell.jobApplyTF.placeholder = "Current Organization".localize()
    signUPCell.jobApplyTF.text = currentorganization
                    
        signUPCell.jobApplyTF.maxLengthTextField = 30
            
        }
       else if indexPath.row == 1{
                    
          signUPCell.jobApplyTF.tag = 9
            
            signUPCell.jobApplyTF.placeholder = "Current Salary".localize()
            
            signUPCell.jobApplyTF.text = currentsalary
                   signUPCell.jobApplyTF.maxLengthTextField = 7
                    
                    }
                    
    else if indexPath.row == 2{
                    
         signUPCell.jobApplyTF.tag = 10
                            
        signUPCell.jobApplyTF.placeholder = "Expected Salary".localize()
        signUPCell.jobApplyTF.text = expectedsalary
        signUPCell.jobApplyTF.isUserInteractionEnabled = true
                    
        signUPCell.jobApplyTF.maxLengthTextField = 7
                            
                    }

        return signUPCell
        
        }
        
        
        
        
            return UITableViewCell()
        }
    
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
        let yearofexperienceStr:NSString =  selectedYears + "" + selectedMonths as NSString
        
 //        let uploadresumeStr:NSString = uploadresume   as NSString
        
        
//        let currentorganizationStr:NSString =  currentorganization  as NSString
//        let currentsalaryStr:NSString = currentsalary   as NSString
//        let expectedsalaryStr:NSString =  expectedsalary  as NSString
        
        
        if (jobtitleStr.length <= 2){
            
            
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
        
//        
//        else if (uploadresumeStr.length <= 0){
//            
//            
//        errorMessage=GlobalSupportingClass.blankresumeErrorMessage() as String as String as NSString?
//            
//        }
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
    
    
    @IBAction func uploadBtnAction(_ sender: Any) {
        
        
        Utilities.sharedInstance.alertWithOkAndCancelButtonAction(vc: self, alertTitle: "Alert", messege: "Are You Sure Want To Remove".localize(), clickAction: {
            
  
        
        
       self.uploadViewheight.constant = 0
       self.uploadView.isHidden = true
        self.uploadBtnOutLet.isHidden = true
        self.imageView.isHidden = true
            
     
        })
        
        
        
    }
    
    
    
    
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

    
    
func getjobApplicationAPICall(){
    
    let paramsDict = [
        
        
        "docString": "JVBERi0xLjMNCiXi48/TDQoNCjEgMCBvYmoNCjw8DQovVHlwZSAvQ2F0YWxvZw0KL091dGxpbmVzIDIgMCBSDQovUGFnZXMgMyAwIFINCj4+DQplbmRvYmoNCg0KMiAwIG9iag0KPDwNCi9UeXBlIC9PdXRsaW5lcw0KL0NvdW50IDANCj4+DQplbmRvYmoNCg0KMyAwIG9iag0KPDwNCi9UeXBlIC9QYWdlcw0KL0NvdW50IDINCi9LaWRzIFsgNCAwIFIgNiAwIFIgXSANCj4+DQplbmRvYmoNCg0KNCAwIG9iag0KPDwNCi9UeXBlIC9QYWdlDQovUGFyZW50IDMgMCBSDQovUmVzb3VyY2VzIDw8DQovRm9udCA8PA0KL0YxIDkgMCBSIA0KPj4NCi9Qcm9jU2V0IDggMCBSDQo+Pg0KL01lZGlhQm94IFswIDAgNjEyLjAwMDAgNzkyLjAwMDBdDQovQ29udGVudHMgNSAwIFINCj4+DQplbmRvYmoNCg0KNSAwIG9iag0KPDwgL0xlbmd0aCAxMDc0ID4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTcuMzc1MCA3MjIuMjgwMCBUZA0KKCBBIFNpbXBsZSBQREYgRmlsZSApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIFRoaXMgaXMgYSBzbWFsbCBkZW1vbnN0cmF0aW9uIC5wZGYgZmlsZSAtICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjY0LjcwNDAgVGQNCigganVzdCBmb3IgdXNlIGluIHRoZSBWaXJ0dWFsIE1lY2hhbmljcyB0dXRvcmlhbHMuIE1vcmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NTIuNzUyMCBUZA0KKCB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDYyOC44NDgwIFRkDQooIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjE2Ljg5NjAgVGQNCiggdGV4dC4gQW5kIG1vcmUgdGV4dC4gQm9yaW5nLCB6enp6ei4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNjA0Ljk0NDAgVGQNCiggbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDU5Mi45OTIwIFRkDQooIEFuZCBtb3JlIHRleHQuIEFuZCBtb3JlIHRleHQuICkgVGoNCkVUDQpCVA0KL0YxIDAwMTAgVGYNCjY5LjI1MDAgNTY5LjA4ODAgVGQNCiggQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA1NTcuMTM2MCBUZA0KKCB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBFdmVuIG1vcmUuIENvbnRpbnVlZCBvbiBwYWdlIDIgLi4uKSBUag0KRVQNCmVuZHN0cmVhbQ0KZW5kb2JqDQoNCjYgMCBvYmoNCjw8DQovVHlwZSAvUGFnZQ0KL1BhcmVudCAzIDAgUg0KL1Jlc291cmNlcyA8PA0KL0ZvbnQgPDwNCi9GMSA5IDAgUiANCj4+DQovUHJvY1NldCA4IDAgUg0KPj4NCi9NZWRpYUJveCBbMCAwIDYxMi4wMDAwIDc5Mi4wMDAwXQ0KL0NvbnRlbnRzIDcgMCBSDQo+Pg0KZW5kb2JqDQoNCjcgMCBvYmoNCjw8IC9MZW5ndGggNjc2ID4+DQpzdHJlYW0NCjIgSg0KQlQNCjAgMCAwIHJnDQovRjEgMDAyNyBUZg0KNTcuMzc1MCA3MjIuMjgwMCBUZA0KKCBTaW1wbGUgUERGIEZpbGUgMiApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY4OC42MDgwIFRkDQooIC4uLmNvbnRpbnVlZCBmcm9tIHBhZ2UgMS4gWWV0IG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NzYuNjU2MCBUZA0KKCBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSB0ZXh0LiBBbmQgbW9yZSApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY2NC43MDQwIFRkDQooIHRleHQuIE9oLCBob3cgYm9yaW5nIHR5cGluZyB0aGlzIHN0dWZmLiBCdXQgbm90IGFzIGJvcmluZyBhcyB3YXRjaGluZyApIFRqDQpFVA0KQlQNCi9GMSAwMDEwIFRmDQo2OS4yNTAwIDY1Mi43NTIwIFRkDQooIHBhaW50IGRyeS4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gQW5kIG1vcmUgdGV4dC4gKSBUag0KRVQNCkJUDQovRjEgMDAxMCBUZg0KNjkuMjUwMCA2NDAuODAwMCBUZA0KKCBCb3JpbmcuICBNb3JlLCBhIGxpdHRsZSBtb3JlIHRleHQuIFRoZSBlbmQsIGFuZCBqdXN0IGFzIHdlbGwuICkgVGoNCkVUDQplbmRzdHJlYW0NCmVuZG9iag0KDQo4IDAgb2JqDQpbL1BERiAvVGV4dF0NCmVuZG9iag0KDQo5IDAgb2JqDQo8PA0KL1R5cGUgL0ZvbnQNCi9TdWJ0eXBlIC9UeXBlMQ0KL05hbWUgL0YxDQovQmFzZUZvbnQgL0hlbHZldGljYQ0KL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcNCj4+DQplbmRvYmoNCg0KMTAgMCBvYmoNCjw8DQovQ3JlYXRvciAoUmF2ZSBcKGh0dHA6Ly93d3cubmV2cm9uYS5jb20vcmF2ZVwpKQ0KL1Byb2R1Y2VyIChOZXZyb25hIERlc2lnbnMpDQovQ3JlYXRpb25EYXRlIChEOjIwMDYwMzAxMDcyODI2KQ0KPj4NCmVuZG9iag0KDQp4cmVmDQowIDExDQowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDAwMTkgMDAwMDAgbg0KMDAwMDAwMDA5MyAwMDAwMCBuDQowMDAwMDAwMTQ3IDAwMDAwIG4NCjAwMDAwMDAyMjIgMDAwMDAgbg0KMDAwMDAwMDM5MCAwMDAwMCBuDQowMDAwMDAxNTIyIDAwMDAwIG4NCjAwMDAwMDE2OTAgMDAwMDAgbg0KMDAwMDAwMjQyMyAwMDAwMCBuDQowMDAwMDAyNDU2IDAwMDAwIG4NCjAwMDAwMDI1NzQgMDAwMDAgbg0KDQp0cmFpbGVyDQo8PA0KL1NpemUgMTENCi9Sb290IDEgMCBSDQovSW5mbyAxMCAwIFINCj4+DQoNCnN0YXJ0eHJlZg0KMjcxNA0KJSVFT0YNCg==",
        "id": 0,
        "jobId": 2,
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
    
                 let statusMsg = respVO.endUserMessage!
                let isSuccess = respVO.isSuccess
                print("StatusCode:\(String(describing: isSuccess))")
    
    
                if isSuccess == true {
    
                    let listArr = respVO.listResult!
    
                    self.utillites.alertWithOkButtonAction(vc: self, alertTitle: "Success", messege:String( statusMsg), clickAction: {
                        
              
                    })
                    
                    
        self.jobApplyTableView.reloadData()
    
                }
    
                else {
    
    
    
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
        
        self.docUrl = url as URL
        
  //      self.uploadLblOutLet.text = (self.docUrl.absoluteString.components(separatedBy: "/Documents/"))[1]
        
        
         imageView.isHidden = false
        
        print("The Url is : \(docUrl)")
        
        self.filename = docUrl.pathExtension
        
        
        let data = try! Data(contentsOf: self.docUrl)
        
        print("The data is : \(data)")
        
        let base64String = data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        self.docsUrlArray.append(base64String)
        
        
        uploadViewheight.constant = 50
        uploadView.isHidden = false
        uploadBtnOutLet.isHidden = false
        imageView.isHidden = false
        
        
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

