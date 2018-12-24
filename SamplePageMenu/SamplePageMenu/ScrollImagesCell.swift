//
//  ScrollImagesCell.swift
//  OffersScreen
//
//  Created by Mac OS on 22/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class ScrollImagesCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var scrollViewHeightLayoutConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var scrollViewWidthLayoutConstraint: NSLayoutConstraint!
    
    
    var offSet: CGFloat = 0
    var timer : Timer!
    var counter = 0
    
    let arrImages = ["j1", "j2", "jesues","skyJSU", "j3", "j4","j6", "jesues", "j1","j2", "jesues"]
    
    var PageIndex = 1
    var totalPages : Int? = 0
    var totalRecords : Int? = 0
    
    var bannerImageScrollArray:[BannerImageScrollResultVo] = Array<BannerImageScrollResultVo>()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.scrollView.frame = CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height)
//
//        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
   
//loadScrollView()
        
    }
    
    //MARK: -  BannerImageScroll API Call
    
    func bannerImageScrollAPICall(){
        
        
        
        let paramsDict = [ "pageIndex": PageIndex,
                           "pageSize": 10,
                           "sortbyColumnName": "UpdatedDate",
                           "sortDirection": "desc",
                           ] as [String : Any]
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
        
        serviceController.postRequest(strURL: BANNERIMAGESURL as NSString, postParams: paramsDict as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
            
            print(result)
            
            let respVO:BannerImageScrollVo = Mapper().map(JSONObject: result)!
            
            let isSuccess = respVO.isSuccess
            print("StatusCode:\(String(describing: isSuccess))")
            
            
            //      self.churchNamesArray.removeAll()
            
            
            if isSuccess == true {
                
                
                
                //self.listResultArray = respVO.listResult!
                
                let listArr = respVO.listResult!
                
                
                for eachArray in listArr{
                    //  print(self.churchNamesArray)
                    // print(eachArray)
                    self.bannerImageScrollArray.append(eachArray)
                    //  print(self.churchNamesArray)
                }
                
                print(self.bannerImageScrollArray.count)
                
                
                
                let pageCout  = (respVO.totalRecords)! / 10
                
                let remander = (respVO.totalRecords)! % 10
                
                self.totalPages = pageCout
                
                if remander != 0 {
                    
                    self.totalPages = self.totalPages! + 1
                    
                }
                
                
                
            }
                
            else {
                
                
                
            }
            
            
            
            
        }) { (failureMessage) in
            
            
            print(failureMessage)
            
        }
        
        
        
    }

    func loadScrollView() {
        
        self.offSet = 0
         timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(doSomeAnimation), userInfo: nil, repeats: true)
        
        pageController.numberOfPages = arrImages.count
        scrollView.isPagingEnabled = true
        scrollView.contentSize.height = 200
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize.width = UIScreen.main.bounds.size.width * CGFloat(arrImages.count)
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        for (index, image) in arrImages.enumerated() {
            let image = image
            let imageView = UIImageView(image: UIImage(named: image)!)
            imageView.contentMode = .scaleToFill
            imageView.frame.size.width = UIScreen.main.bounds.size.width
            imageView.backgroundColor = UIColor.red
            imageView.frame.size.height = 200
            imageView.frame.origin.x = CGFloat(index) * UIScreen.main.bounds.size.width
            print(UIScreen.main.bounds.size.width)
            scrollView.addSubview(imageView)
        }
        
//        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, sizeOfContent);

        
        
//        let pageCount : CGFloat = CGFloat(arrImages.count)
//
//        scrollView.backgroundColor = UIColor.clear
//        scrollView.delegate = self
//        scrollView.isPagingEnabled = true
//        scrollView.contentSize = CGSize(width:scrollView.frame.size.width * pageCount, height:scrollView.frame.size.height)
//        scrollView.showsHorizontalScrollIndicator = false
//        
//        pageController.numberOfPages = Int(pageCount)
//        pageController.addTarget(self, action: #selector(self.pageChanged), for: .valueChanged)
//        
//        
//        for i in 0..<Int(pageCount) {
//            //print(self.scrollView.frame.size.width)
//            let image = UIImageView(frame: CGRect(x:self.scrollView.frame.size.width * CGFloat(i), y:0, width:self.scrollView.frame.size.width, height:self.scrollView.frame.size.height))
//            image.image = UIImage(named: arrImages[i])!
//            image.contentMode = UIViewContentMode.scaleAspectFit
//            self.scrollView.addSubview(image)
//        }
    
        
    }
    
    
    func doSomeAnimation() {
        //I have four pngs in my project, which are named frame1.png ... and so on
        
//        
//        let totalPossibleOffset = CGFloat(arrImages.count - 1) * self.bounds.size.width
//        var offSet : CGFloat = 0.0
//        if offSet == totalPossibleOffset {
//            offSet = 0 // come back to the first image after the last image
//        }
//        else {
//            offSet += self.bounds.size.width
//        }
//        DispatchQueue.main.async() {
//            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
//                self.scrollView.contentOffset.x = CGFloat(offSet)
//            }, completion: nil)
//        }
        
        let imgsCount:CGFloat = CGFloat(arrImages.count)
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * imgsCount
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        let currentPage:CGFloat = slideToX / pageWidth
        
       // print(currentPage)
        // Change the indicator
        self.pageController.currentPage = Int(currentPage)
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
    
    //MARK: UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
        // content offset - tells by how much the scroll view has scrolled.
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
        pageController.currentPage = Int(pageNumber)
    }
    
    //MARK: Page tap action
    func pageChanged() {
        let pageNumber = pageController.currentPage
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: true)
    }

    
//    func scrollImage(){
//        // Test the offset and calculate the current page after scrolling ends
//        let pageWidth:CGFloat = scrollView.frame.width
//        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
//        // Change the indicator
//        self.pageController.currentPage = Int(currentPage);
//        // Change the text accordingly
//        if Int(currentPage) != 5{
//            print("Initial Page")
//            //    skipButton.isHidden = false
//            //  skipButton.setTitle("Skip", for: UIControlState.normal)
//        }else{
//            // Show the "Let's Start" button in the last slide (with a fade in animation)
//            //     skipButton.isHidden = true
//            UIView.animate(withDuration: 1.0, animations: { () -> Void in
//            })
//        }
//        
//        
//    }
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
//      scrollImage()
//    }
  

    @IBAction func pageControllerButtonTapped(_ sender: Any) {
        
   pageChanged()
        
        
      //  scrollImage()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
