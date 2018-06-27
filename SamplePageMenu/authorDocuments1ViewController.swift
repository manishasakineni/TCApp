//
//  authorDocumentsViewController.swift
//  Telugu Churches
//
//  Created by Manoj on 09/05/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class authorDocumentsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate {
    

    @IBOutlet weak var authordocumentTableView: UITableView!
    
    @IBOutlet weak var norecordsfoundLbl: UILabel!
    
    
    
    var imageView  = ["bible1","bible1","bible1","bible1","bible1"]
    
     var documentResults : Array<PostByAutorIdResultInfoVO> = Array()
    var documentController: UIDocumentInteractionController = UIDocumentInteractionController()
    
    var saveLocationString      : String        = ""
    var isSavingPDF             : Bool          = false
    var pdfTitle                : String        = ""
    var isDownloadingOnProgress : Bool          = false
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authordocumentTableView.delegate = self
        authordocumentTableView.dataSource = self
        
        let nibName1  = UINib(nibName: "AuthorDocumentTableViewCell" , bundle: nil)
        authordocumentTableView.register(nibName1, forCellReuseIdentifier: "AuthorDocumentTableViewCell")
        
        if(documentResults.count > 0){
            self.norecordsfoundLbl.isHidden = true
        }else{
            self.norecordsfoundLbl.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return documentResults.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorDocumentTableViewCell", for: indexPath) as! AuthorDocumentTableViewCell
        
        
        
        
        if(documentResults.count > indexPath.row){
        let postImgUrl = (documentResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.postImage
        
            cell.documentImage.image = #imageLiteral(resourceName: "docImg")
            
            

        }
            
       


        
        return cell
        
        
        
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
       
        
            let postImgUrl = (documentResults[indexPath.row] as? PostByAutorIdResultInfoVO)?.postImage
      
                let newString = postImgUrl?.replacingOccurrences(of: "\\", with: "//", options: .backwards, range: nil)
            
        let docViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocViewController") as! DocViewController
                
                
        docViewController.urlStr = newString!
                
        docViewController.titleStr = title!
                
                
        self.navigationController?.pushViewController(docViewController, animated: true)
        
        
        
    }
   
    
    private func savePDFWithUrl(_ urlString: String) {
        
        var filePath : URL?
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
            
            if let url = URL.init(string: urlString) {
                
                let documentDirUrlString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
                
                if let documentDirUrl = URL.init(string: documentDirUrlString) {
                    
                    let pdfNameArray = urlString.characters.split(separator: "/").map(String.init)
                    
                    if let pdfName = pdfNameArray.last {
                        
                        let saveLocation = documentDirUrl.appendingPathComponent(pdfName)
                        self.saveLocationString = saveLocation.absoluteString
                        filePath = URL.init(fileURLWithPath: saveLocation.path)
                        print( self.saveLocationString)
                        
                        let fileExists = FileManager().fileExists(atPath: self.saveLocationString)
                        
                        if fileExists {
                            
                            if !self.isSavingPDF {
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    self.openSelectedDocumentFromURL(documentURLString: self.saveLocationString)
                                    print( self.saveLocationString)
                                    print(  self.openSelectedDocumentFromURL)
                                    
                                    
                                    self.openPDFinPDFReader()
                                }
                                
                            } else {
                                
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                    
                                })
                            }
                            
                        } else {
                            
                            do {
                                
                                self.isDownloadingOnProgress = true
                                
                                let imageData : Data? = try Data.init(contentsOf: url)
                                
                                if imageData == nil {
                                    
                                    self.isDownloadingOnProgress = false
                                    
                                    DispatchQueue.main.async {
                                        
                                    }
                                    
                                } else {
                                    
                                    do {
                                        
                                        try imageData?.write(to: filePath!, options: Data.WritingOptions.withoutOverwriting)
                                        
                                        if !self.isSavingPDF {
                                            
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                self.openPDFinPDFReader()
                                            }
                                            
                                            
                                        } else {
                                            
                                            self.isDownloadingOnProgress = false
                                            
                                            DispatchQueue.main.async {
                                                
                                                
                                            }
                                        }
                                        
                                    } catch let error {
                                        
                                        self.isDownloadingOnProgress = false
                                        
                                        DispatchQueue.main.async {
                                            
                                            
                                        }
                                    }
                                }
                                
                            } catch let error {
                                
                                print(error.localizedDescription)
                                
                                self.isDownloadingOnProgress = false
                                
                                DispatchQueue.main.async {
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }

    private func openPDFinPDFReader() {
        
    }
    
    func openSelectedDocumentFromURL(documentURLString: String) {
        
        let documentURL: NSURL = NSURL(fileURLWithPath: documentURLString)
        documentController = UIDocumentInteractionController(url: documentURL as URL)
        documentController.delegate = self
        documentController.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    

}
