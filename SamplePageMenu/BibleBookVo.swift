//
//  BibleBookVo.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 21/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class BibleBookVo: Mappable {
    
    
    //MARK:-  Declaration of BibleBookVo

    
    var Book: [BibleChapterVo]?
    
    //MARK:-  initialization of BibleBookVo
    
    init(Book: [BibleChapterVo]) {
        
        self.Book = Book
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        Book <- map["Book"]
        
        
    }
}
