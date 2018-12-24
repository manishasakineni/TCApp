//
//  shareActivity.swift
//  Telugu Churches
//
//  Created by CalibrageMac02 on 31/03/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


class MyStringItemSource: NSObject, UIActivityItemSource {
    
    public func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any
    {
        return ""
    }
    
    public func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType) -> Any?
    {
        if activityType == UIActivityType.message {
            return "String for message"
        } else if activityType == UIActivityType.mail {
            return "String for mail"
        } else if activityType == UIActivityType.postToTwitter {
            return "String for twitter"
        } else if activityType == UIActivityType.postToFacebook {
            return "String for facebook"
        }
        return nil
    }
    
    public func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String
    {
        if activityType == UIActivityType.message {
            return "Subject for message"
        } else if activityType == UIActivityType.mail {
            return "Subject for mail"
        } else if activityType == UIActivityType.postToTwitter {
            return "Subject for twitter"
        } else if activityType == UIActivityType.postToFacebook {
            return "Subject for facebook"
        }
        return ""
    }
    
    public func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivityType?, suggestedSize size: CGSize) -> UIImage?
    {
        if activityType == UIActivityType.message {
            return UIImage(named: "thumbnail-for-message")
        } else if activityType == UIActivityType.mail {
            return UIImage(named: "thumbnail-for-mail")
        } else if activityType == UIActivityType.postToTwitter {
            return UIImage(named: "thumbnail-for-twitter")
        } else if activityType == UIActivityType.postToFacebook {
            return UIImage(named: "thumbnail-for-facebook")
        }
        return UIImage(named: "some-default-thumbnail")
}

}
