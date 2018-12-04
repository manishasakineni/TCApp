//
//  Constants.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

 // MARK: -  API's

let videosURL = "http://192.168.1.198/TeluguChurchesApi/api/GetEmbedLinks/"

//http://192.168.1.121/TeluguChurches/api/Church/GetAllChurches

// constants Old Test Url
var BASEURL:String = "http://183.82.111.111/TeluguChurches/API/"



// New Local Test Url given on 03/12/2018
//var BASEURL:String = "http://192.168.1.121/TeluguChurchesTestAPI/"




// Changed constants Latest Live BASEURL 22/11/2018
//var BASEURL:String = "http://183.82.111.111/TChurchesLive/API/"



//var BASEURL:String = "http://192.168.1.250/TeluguChurches/"

//var BASEURL:String = "http://services.teluguchurches.church/"

let SIGNEUPURL:String = BASEURL.appending("api/Account/Register")

//let LOGINURL : String = BASEURL.appending("api/UserInfo/LoginUser/")

let LOGINURL : String = BASEURL.appending("api/Account/Login/")


let CHANGEPASSWORDURL:String = BASEURL.appending("api/Account/ChangePassword")
let EDITPROFILEURL : String = BASEURL.appending("api/UserInfo/UpdateUserInfo")
let PROFILEGETINFO : String = BASEURL.appending("api/UserInfo/GetUserInfo/")
let GETALLCHURCHES : String = BASEURL.appending("api/Church/GetAllChurches")
let GETALLACTIVECHURCHESAPI : String = BASEURL.appending("api/Church/GetAllActiveChurches")

let GETCHURCHEBYID : String = BASEURL.appending("api/Church/GetChurchbyId/")
let GETALLCHURCHEADMINS : String = BASEURL.appending("api/Church/GetAllChurchAdmins")
//let GETEVENTBYUSERIDMONTHYEAR : String = BASEURL.appending("api/Events/GetEventByUserIdMonthYear/")

let GETEVENTBYUSERIDMONTHYEAR : String = BASEURL.appending("api/Events/GetEventByChurchIdMonthYear/")

let GETEVENTBYDATEANDUSERID : String = BASEURL.appending("api/Events/GetEventByDateAndChurchId/")

let GETUPCOMIMGEVENTSINFO : String = BASEURL.appending("api/Events/GetUpcomingEventsInfo/")


let BANNERIMAGESURL : String = BASEURL.appending("api/Banners/GetAllBannersById/")

let GETACTIVECHURCHES : String = BASEURL.appending("api/Church/GetActiveChurches")
let GETEVENTINFOBYCHURCHIDMONTHYEAR : String = BASEURL.appending("api/Events/GetEventInfoByMonthYear")

let UPCOMMINGEVENTS : String = BASEURL.appending("api/Events/GetUpcomingEventsInfo")

let AUTHORDETAILS : String = BASEURL.appending("api/Church/GetAuthorbyId/")

let GETALLCATEGORIES : String = BASEURL.appending("api/Category/GetAllCategories")


let GETPOSTBYCATEGORYIDOFVIDEOSONGS : String = BASEURL.appending("api/Post/GetPostbyCategoryId/")

let GETAUTHOREVENTSBYMONTHYEAR : String = BASEURL.appending("api/Events/GetEventInfoByUserIdMonthYear/")

let GETEVENTSBYMONTHYEAR : String = BASEURL.appending("api/Events/GetEventByDateAndUserId/")


let GETAUTHOREVENTSCOUNTBYMONTH : String = BASEURL.appending("api/Events/GetEventByUserIdMonthYear/")

let GETEVENTDETAILSBYID : String = BASEURL.appending("api/Events/GetEventById/")

let BIBLEAPIENGLISHURL : String = "http://192.168.1.121/TeluguChurchesRepository/FileRepository/Bible//EnglishBible.json"

let BIBLEAPITELUGUURL : String = "https://raw.githubusercontent.com/godlytalias/Bible-Database/master/Telugu/bible.json"

let CHURCHAUTHORSUBSCIPTIONAPI : String = BASEURL.appending("api/Church/ChurchAuthorSubscription")


let GETBIBLEAPITELUGUURL : String = "http://192.168.1.121/TeluguChurches/api/BibleChapter/GetBibleChapter/"

let LIKEDISLIKECOMMENTSAPI : String = BASEURL.appending("api/Post/GetPostByPostId/")

let ADDUPDATECOMMENTAPI : String = BASEURL.appending("api/Post/AddUpdateComments")

let LIKEANDDISLIKECOUNTAPI : String = BASEURL.appending("api/Post/LikeOrDislikePost")

let GETPOSTBYEVENTIDAPI : String = BASEURL.appending("api/Post/GetPostbyEventId/")

let EVENTSLIKEDISLIKEAPI : String = BASEURL.appending("api/Events/EventLikeOrDisLike")

//http://192.168.1.168/TeluguChurchesTestAPI/api/Post/LikeOrDislikePost

let EVENTCOMMENTAPI : String = BASEURL.appending("api/Events/AddUpdateEventComments")

let EVENTPOSTCOMMENTAPI : String = BASEURL.appending("api/Post/AddUpdateComments")

let VIDEOVIEWALLCOMMENTSAPI : String = BASEURL.appending("api/Post/GetPostCommentReplies/")

let EVENTCOMMENTREPLIESSAPI : String = BASEURL.appending("api/Events/GetEventCommentReplies/")

//  mmmmmmmm

let POSTBYEVENTIDAPI : String = BASEURL.appending("api/Post/GetPostbyEventId/")

let FORGOTPASSWORDAPI : String = BASEURL.appending("api/UserInfo/ForgotPassword")

let DELETECOMMETAPI : String    = BASEURL.appending("api/Post/DeleteComments")


let EVENTDELETECOMMETAPI : String    = BASEURL.appending("api/Events/DeleteEventComment")


let GETPOSTBYCHURCHIDAPI : String = BASEURL.appending("api/Post/GetPostByChurchId/")

let GETPOSTBYAUTHORIDAPI : String = BASEURL.appending("api/Post/GetPostByAuthorId/")

let POSTBYCHURCHIDAPI : String = BASEURL.appending("api/Post/GetPostByChurchId")


let GETALLJOBDETAILSAPI : String = BASEURL.appending("api/JobDetails/GetAllJobDetails")

let GETJOBBYIDAPI : String = BASEURL.appending("api/JobDetails/GetJobById/")


let JOBAPPLYAPI : String = BASEURL.appending("api/ApplicantInfo/AddUpdateApplicant")

let GETALLITEMSAPI : String = BASEURL.appending("api/ItemDetails/GetAllItems")

let ALLITEMSIDAPI : String = BASEURL.appending("api/ItemDetails/GetItemById/")

let GETCARTINFOAPI : String = BASEURL.appending("api/CartInfo/GetCartInfo/")

let ADDTOCARTAPI : String = BASEURL.appending("api/CartInfo/AddToCart")

let GETUNREADNOTIFICATIONAPI : String = BASEURL.appending("api/Notification/GetUnReadNotification")

let GETREADNOTIFICATIONAPI : String = BASEURL.appending("api/Notification/GetReadNotification")

let READNOTIFICATIONAPI : String = BASEURL.appending("api/Notification/AddUpdateNotifications")


// :-   05/06/2018

let GETSTATESAPI : String = BASEURL.appending("api/States/GetAllStates")

let GETCOUNTRYSAPI : String = BASEURL.appending("api/Countries/GetAllCountries")

// :-   06/06/2018
let GETALLDELIVERYADDRESSAPI : String = BASEURL.appending("api/DeliveryAddress/GetAllDeliveryAddress")


let GETALLADDRESSAPI : String = BASEURL.appending("api/DeliveryAddress/AddUpdateDeliveryAddress")

let DELETEADDRESSAPI : String = BASEURL.appending("api/DeliveryAddress/DeleteDeliveryAddress")

// :-   08/06/2018

//let EDITADDRESSAPI : String = BASEURL.appending("api/DeliveryAddress/GetDeliveryAddressById/")

let EDITADDRESSAPI : String = BASEURL.appending("api/DeliveryAddress/GetAddressById/")

let DELETEFROMCARTAPI : String = BASEURL.appending("api/CartInfo/DeleteFromCart/")


let NOTIFICATIONSAPI : String = BASEURL.appending("api/Notification/GetWebNotification")

let GETSPLASHMSGAPI : String = BASEURL.appending("api/SplashMessage/GetSplashMessageByDate")

let GETEVENTBYIDAPI : String = BASEURL.appending("api/Events/GetEventByEventId/")


// mapper names  :-  AddUpdateJobVO, AddUpdateJobListResultVO
let ADDUPDATEJOBAPI : String = BASEURL.appending("api/JobDetails/AddUpdateJob")

var REFRESHTOKENAPI:String = BASEURL.appending("api/Account/RefreshToken")

var UPDATECARTAPI:String = BASEURL.appending("api/CartInfo/UpdateToCart")

var ADDUPDATENOTIFICATIONS:String = BASEURL.appending("api/Notification/AddUpdateNotifications")

var UPDATEVIEWCOUNTBYPOSTID:String = BASEURL.appending("api/Post/UpdateViewCountByPostId/")


var SHARELINKURL : String = "http://183.82.111.111/TeluguChurches/Web/post/"

//api/Events/GetUpcomingEventsInfo/{fromDate}/{toDate}

// MARK: -  Navigation String


let KFirstTimeLogin = "first Time Login"

let kuserIdKey:String = "kuserId"
let kIdKey:String = "kloginId"
let kUserName : String = "kUserName"
let kfirstName:String  = "kfirsrName"
let kmiddleName:String  = "kmiddleName"
let klastName:String  = "klastName"
let kmobileNumber:String  = "kmobileNumber"
let kpassword:String  = "kpassword"
let kemail:String  = "kemail"
let kLoginSucessStatus:String = "kLoginSucessStatus"
let kRegisterSucessStatus:String = "kRegisterSucessStatus"
let kAccess_token:String = "kAccess_token"
let kToken_type = "kToken_type"
let kClient_id = "kClient_id"
let kRefreshToken = "kRefreshToken"
let kExpires_in = "kExpires_in"
var kLatitude = "kLatitude"
var kLongitude = "kLongitude"
//let kchurchID:String = "kchurchID"


let kTokenType = "tokenType"
let accessToken:String = "accessToken"

var kUserId :  String =  "null"
var kId =  Int ()

let kAddCartQuantity = "AddToCart limit 99 items only"

let kNetworkStatusMessage = "Please Check Your Internet Connection"
let kToastDuration  = 1.5
let kRequestTimedOutMessage = "The request Timed Out"

var kUserDefaults = UserDefaults.standard

let invalidUrlMessage = "This file Could't be download"


struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}

