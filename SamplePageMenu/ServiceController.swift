//
//  ServiceController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

//MARK:-  Reachability Use For Checking Tha Internet Connection Available are not

let reachability = Reachability()!

var appDelegate = AppDelegate()

let content_type = "application/json; charset=utf-8"

class ServiceController: NSObject {
    
//MARK:- Post Request
    
func postRequest(strURL:NSString,postParams:NSDictionary,postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ error:String)->Void) -> Void {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if appDelegate.checkInternetConnectivity() == false {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
            return
        }
        showLoadingHUD(to_view: appDelegate.window!)
        let urlStr:NSString = strURL.addingPercentEscapes(using:String.Encoding.utf8.rawValue)! as NSString
        let url: NSURL = NSURL(string: urlStr as String)!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        request.addValue("application/json",forHTTPHeaderField:"Accept")
        if postHeaders["Authorization"] != nil  {
        }
        if let authToken = kUserDefaults.string(forKey: kAccess_token) {
            if let tokenType = kUserDefaults.string(forKey: kTokenType) {
                request.setValue(tokenType + " " + authToken,forHTTPHeaderField: "Authorization")
            }
        }
        do {
            let data = try! JSONSerialization.data(withJSONObject:postParams, options:.prettyPrinted)
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            let headerData = try! JSONSerialization.data(withJSONObject:postHeaders, options:.prettyPrinted)
            let headerDataString = String(data: headerData, encoding: String.Encoding.utf8)!
            print("Request Url :\(url)")
            print("Request Header Data :\(headerDataString)")
            print("Request Data : \(dataString)")
            request.httpBody = data
            // do other stuff on success
        }
        catch {
            DispatchQueue.main.async(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print("JSON serialization failed:  \(error)")
                appDelegate.window?.makeToast("Network is either slow or not Connected", duration:kToastDuration , position:CSToastPositionCenter)
            }
        }
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            //            print(data)
            //            print(response)
            //            print(error)
            DispatchQueue.main.async(){
                self.hideLoadingHUD(for_view: appDelegate.window!)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if response != nil {
                    // Response Status Code
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    if statusCode == 401 {
                        failureHandler("unAuthorized")
                    }
                    if statusCode == 500 {
                        print("failuer 1")
                        failureHandler("unAuthorized")
                    }
                    else if error != nil
                        {
                        print("error=\(String(describing: error))")
                        appDelegate.window?.makeToast(kRequestTimedOutMessage, duration:kToastDuration , position:CSToastPositionCenter)
                        return
                    }
                    else{
                        do {
                            let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
                            print(parsedData)
                            successHandler(parsedData as AnyObject)
                        } catch let error as NSError {
                            
                            print("error=\(error)")
                            return
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
//MARK:- Post Request for Refresh
    
    func refreshPostRequest(strURL:NSString,postParams:NSDictionary, postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ error:String)->Void) -> Void {
        
        DispatchQueue.main.async {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
        }
        if appDelegate.checkInternetConnectivity() == false {

            return
        }
        let urlStr:NSString = strURL.addingPercentEscapes(using:String.Encoding.utf8.rawValue)! as NSString
        let url: NSURL = NSURL(string: urlStr as String)!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        request.addValue("application/json",forHTTPHeaderField:"Accept")
        if postHeaders["Authorization"] != nil  {

        }
        do {
            let data = try! JSONSerialization.data(withJSONObject:postParams, options:.prettyPrinted)
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            let headerData = try! JSONSerialization.data(withJSONObject:postHeaders, options:.prettyPrinted)
            let headerDataString = String(data: headerData, encoding: String.Encoding.utf8)!
            print("Request Url :\(url)")
            print("Request Header Data :\(headerDataString)")
            print("Request Data : \(dataString)")
            request.httpBody = data
            // do other stuff on success
        }
        catch {
            DispatchQueue.main.async(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                print("JSON serialization failed:  \(error)")
                appDelegate.window?.makeToast("Network is either slow or not Connected", duration:kToastDuration , position:CSToastPositionCenter)
            }
        }
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            //            print(data)
            //            print(response)
            //            print(error)
            DispatchQueue.main.async(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = false

                if response != nil {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    
                    if statusCode == 401 {
                       failureHandler("unAuthorized")
                    }
                    if statusCode == 500 {
                        print("failuer 1")
                        failureHandler("unAuthorized")
                    }
                    else if error != nil
                        {
                        print("error=\(String(describing: error))")
                        return
                    } else{
                        do {
                            let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
                            print(parsedData)
                            successHandler(parsedData as AnyObject)
                        } catch let error as NSError {
                            
                            print("error=\(error)")
                            return
                        }
                    }
                }
            }
        }
        task.resume()
        
    }
    
//MARK:- Get Request
    
    func getRequest(strURL:String,success:@escaping(_ _result:AnyObject)->Void,failure:@escaping(_ error:String) -> Void) {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if appDelegate.checkInternetConnectivity() == false
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            appDelegate.window?.makeToast(kNetworkStatusMessage, duration: kToastDuration, position: CSToastPositionBottom)
            return
        }
        showLoadingHUD(to_view: appDelegate.window!)
        let fileUrl = NSURL(string: strURL)
        let request = NSMutableURLRequest(url: fileUrl! as URL)
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        request.addValue(content_type, forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        if let authToken = kUserDefaults.string(forKey: kAccess_token) {
            if let tokenType = kUserDefaults.string(forKey: kTokenType) {
                request.setValue(tokenType + " " + authToken,forHTTPHeaderField: "Authorization")
            }
        }
        let task = URLSession.shared.dataTask(with:request as URLRequest){(data,response,error) in
            DispatchQueue.main.async(){
                self.hideLoadingHUD(for_view: appDelegate.window!)
                print(response)
                if response != nil {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    if statusCode == 401 {
                        print("failuer 1")
                        failure("unAuthorized")
                    }
                    if statusCode == 500 {
                        print("failuer 1")
                        failure("unAuthorized")
                    }
                    if statusCode == 404 {
                        print("failuer 1")
                        failure("Enter Valid Credentials")
                    }
                    else if error != nil
                    {
                        print("failuer 1")
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        //  failure(error! as NSError)
                        appDelegate.window?.makeToast(error?.localizedDescription, duration:kToastDuration , position:CSToastPositionCenter)
                    }
                    else
                       {
                        print(statusCode)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        do{
                            print("success 1")
                            
                            let parsedData = try JSONSerialization.jsonObject(with:data!,options:.mutableContainers) as![String:Any]
                            //                            print(parsedData)
                            success(parsedData as AnyObject)
                        }
                        catch{
                            print("error=\(error)")
                            return
                        }
                    }
                }
                else{
                    print(error)
                }
            }
        }
        task.resume()
    }
    func showLoadingHUD(to_view: UIView) {
        MBProgressHUD.showAdded(to: to_view, animated: true)
        //  hud.label.text = "Loading..."
    }
    func hideLoadingHUD(for_view: UIView) {
        MBProgressHUD.hideAllHUDs(for: for_view, animated: true)
    }
}

