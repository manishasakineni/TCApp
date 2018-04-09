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
    
//MARK: -  variable declaration
 
    
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
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
   
        
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
            
            
            
            
            if isSuccess == true {
                
                
                
                
                let listArr = respVO.listResult!
                
                
                for eachArray in listArr{
                    self.bannerImageScrollArray.append(eachArray)
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
    
//MARK: -  loadScrollView


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
        
        
        
    }
    
//MARK: -  doSomeAnimation

    func doSomeAnimation() {
  
        
        let imgsCount:CGFloat = CGFloat(arrImages.count)
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * imgsCount
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        let currentPage:CGFloat = slideToX / pageWidth
        
        self.pageController.currentPage = Int(currentPage)
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
    
//MARK: UIScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
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

    
  

    @IBAction func pageControllerButtonTapped(_ sender: Any) {
        
   pageChanged()
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
