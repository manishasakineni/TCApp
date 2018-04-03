//
//  Constants.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


 // MARK: -  API's

let videosURL = "http://192.168.1.181/TeluguChurchesApi/api/GetEmbedLinks/"

//http://192.168.1.121/TeluguChurches/api/Church/GetAllChurches


// constants
//var BASEURL:String = "http://calibrage.co.in/"
var BASEURL:String = "http://192.168.1.121/TeluguChurches/"

let SIGNEUPURL:String = BASEURL.appending("api/Account/Register")
let LOGINURL : String = BASEURL.appending("api/UserInfo/LoginUser/")


let CHANGEPASSWORDURL:String = BASEURL.appending("api/Account/ChangePassword")
let EDITPROFILEURL : String = BASEURL.appending("api/UserInfo/UpdateUserInfo")
let PROFILEGETINFO : String = BASEURL.appending("api/UserInfo/GetUserInfo/")
let GETALLCHURCHES : String = BASEURL.appending("api/Church/GetAllChurches")
let GETCHURCHEBYID : String = BASEURL.appending("api/Church/GetChurchbyId/")
let GETALLCHURCHEADMINS : String = BASEURL.appending("api/Church/GetAllChurchAdmins")
let GETEVENTBYUSERIDMONTHYEAR : String = BASEURL.appending("api/Events/GetEventByUserIdMonthYear/")
let GETEVENTBYDATEANDUSERID : String = BASEURL.appending("api/Events/GetEventByDateAndUserId/")
let GETUPCOMIMGEVENTSINFO : String = BASEURL.appending("api/Events/GetUpcomingEventsInfo/")

let BANNERIMAGESURL : String = BASEURL.appending("api/Banners/GetAllBannersById/")

let GETACTIVECHURCHES : String = BASEURL.appending("api/Church/GetActiveChurches")
let GETEVENTINFOBYCHURCHIDMONTHYEAR : String = BASEURL.appending("api/Events/GetEventInfoByChurchIdMonthYear")

let UPCOMMINGEVENTS : String = BASEURL.appending("api/Events/GetUpcomingEventsInfo")

let AUTHORDETAILS : String = BASEURL.appending("api/Church/GetAuthorbyId/")

let GETALLCATEGORIES : String = BASEURL.appending("api/Category/GetAllCategories")


let GETPOSTBYCATEGORYIDOFVIDEOSONGS : String = BASEURL.appending("api/Post/GetPostbyCategoryId/")

let GETAUTHOREVENTSBYMONTHYEAR : String = BASEURL.appending("api/Events/GetEventInfoByUserIdMonthYear/")

let GETAUTHOREVENTSCOUNTBYMONTH : String = BASEURL.appending("api/Events/GetEventByUserIdMonthYear/")

let GETEVENTDETAILSBYID : String = BASEURL.appending("api/Events/GetEventById/")

let BIBLEAPIENGLISHURL : String = "http://192.168.1.121/TeluguChurchesRepository/FileRepository/Bible//EnglishBible.json"

let BIBLEAPITELUGUURL : String = "https://raw.githubusercontent.com/godlytalias/Bible-Database/master/Telugu/bible.json"

let CHURCHAUTHORSUBSCIPTIONAPI : String = BASEURL.appending("api/Church/ChurchAuthorSubscription")


let GETBIBLEAPITELUGUURL : String = "http://192.168.1.121/TeluguChurches/api/BibleChapter/GetBibleChapter/12"

let LIKEDISLIKECOMMENTSAPI : String = BASEURL.appending("api/Post/GetPostById/")

let ADDUPDATECOMMENTAPI : String = BASEURL.appending("api/Post/AddUpdateComments")

let LIKEANDDISLIKECOUNTAPI : String = BASEURL.appending("api/Post/LikeOrDislikePost")
//api/Events/GetUpcomingEventsInfo/{fromDate}/{toDate}

// MARK: -  Navigation String


let KFirstTimeLogin = "first Time Login"

let kuserIdKey:String = "kuserId"
let kIdKey:String = "kloginId"
let kfirstName:String  = "kfirsrName"
let kmiddleName:String  = "kmiddleName"
let klastName:String  = "klastName"
let kmobileNumber:String  = "kmobileNumber"
let kpassword:String  = "kpassword"
let kemail:String  = "kemail"
let kLoginSucessStatus:String = "kLoginSucessStatus"
let kRegisterSucessStatus:String = "kRegisterSucessStatus"
//let kchurchID:String = "kchurchID"


let kTokenType = "tokenType"
let accessToken:String = "accessToken"

var kUserId :  String =  "null"
var kId =  Int ()


let kNetworkStatusMessage = "Please Check Your Internet Connection"
let kToastDuration  = 1.5
let kRequestTimedOutMessage = "Therequest Timed Out"

var kUserDefaults = UserDefaults.standard



struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}









