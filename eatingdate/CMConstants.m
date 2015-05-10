//
//  CMConstants.m
//  chatMessenger
//
//  Created by Ayi on 2014/3/2.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#import "CMConstants.h"


#pragma mark - NSUserDefaults
NSString *const kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey    = @"tw.taiwan8.userDefaults.activityFeedViewController.lastRefresh";        //用戶默認設置的活動資訊 - 視圖 - 控制器刷新鍵
NSString *const kPAPUserDefaultsCreateCaseTableViewControllerLastRefreshKey = @"tw.taiwan8.userDefaults.kPAPUserDefaultsCreateCaseTableViewControllerLastRefreshKey.lastRefresh";
NSString *const kPAPUserDefaultsCacheHelpersKey                             = @"tw.taiwan8.userDefaults.cache.helpers";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCacheFacebookFriendsKey                     = @"tw.taiwan8.userDefaults.cache.facebookFriends";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCachePhonesFriendsKey                       = @"tw.taiwan8.userDefaults.cache.phonesFriends";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCacheFacebookFriendsNumberKey                     = @"tw.taiwan8.userDefaults.cache.facebookFriendsNumber";                         //用戶默認緩存給好友鍵
NSString *const kPAPUserDefaultsCacheFacebookGroupsKey                     = @"tw.taiwan8.userDefaults.cache.facebookGroups";                         //用戶默認緩存社團鍵
NSString *const kPAPUserDefaultsMyTasksTableViewControllerLastRefreshKey    = @"tw.taiwan8.userDefaults.myTasksTableViewController.lastRefresh";        //我的任務最後一次刷新鍵
NSString *const kPAPUserDefaultsWaitTasksTableViewControllerLastRefreshKey  = @"tw.taiwan8.userDefaults.waitTasksTableViewController.lastRefresh";      //等待回應任務最後一次刷新鍵
NSString *const kPAPUserDefaultsEndTasksTableViewControllerLastRefreshKey   = @"tw.taiwan8.userDefaults.endTasksTableViewController.lastRefresh";       //結案任務最後一次刷新鍵
NSString *const kPAPUserDefaultsSelectHelperTableViewControllerLastRefreshKey   =
@"tw.taiwan8.userDefaults.selectHelperTableViewControllerLastRefresh";        //接案幫手選擇頁面最後一次刷新鍵

#pragma mark - Launch URLs
NSString *const kPAPLaunchURLHostTakePicture = @"camera";

#pragma mark - NSNotification
NSString *const PAPAppDelegateApplicationDidReceiveRemoteNotification           = @"tw.taiwan8.appDelegate.applicationDidReceiveRemoteNotification";
NSString *const PAPUtilityUserFollowingChangedNotification                      = @"tw.taiwan8.utility.userFollowingChanged";
NSString *const PAPUtilityUserAddingChangedNotification                      = @"tw.taiwan8.utility.userAddingChanged";
NSString *const PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification     = @"tw.taiwan8.utility.userLikedUnlikedPhotoCallbackFinished";
NSString *const PAPUtilityDidFinishProcessingProfilePictureNotification         = @"tw.taiwan8.utility.didFinishProcessingProfilePictureNotification";
NSString *const PAPTabBarControllerDidFinishEditingPhotoNotification            = @"tw.taiwan8.tabBarController.didFinishEditingPhoto";
NSString *const PAPTabBarControllerDidFinishImageFileUploadNotification         = @"tw.taiwan8.tabBarController.didFinishImageFileUploadNotification";
NSString *const PAPPhotoDetailsViewControllerUserDeletedPhotoNotification       = @"tw.taiwan8.photoDetailsViewController.userDeletedPhoto";
NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification  = @"tw.taiwan8.photoDetailsViewController.userLikedUnlikedPhotoInDetailsViewNotification";
NSString *const PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification   = @"tw.taiwan8.photoDetailsViewController.userCommentedOnPhotoInDetailsViewNotification";
NSString *const PAPPhotoDetailsViewControlleerUserGetedOnPhotoNotification      = @"tw.taiwan8.photoDetailsViewController.userGetdPhotoInDetailsViewNotification";
#pragma mark - Notification Location names:
NSString *const kPAWFilterDistanceChangeNotification = @"kPAWFilterDistanceChangeNotification";
NSString *const kPAWLocationChangeNotification = @"kPAWLocationChangeNotification";
NSString *const kPAWFilterHelperTypeChangeNotification = @"kPAWFilterHelperTypeChangeNotification";
NSString *const kPAWFilterCumtomerTypeChangeNotification = @"kPAWFilterCumtomerTypeChangeNotification";

#pragma mark - User Info Keys
NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey = @"liked";
NSString *const kPAPEditPhotoViewControllerUserInfoCommentKey = @"comment";

#pragma mark - Installation Class
// Field keys
NSString *const kPAPInstallationUserKey = @"user";
NSString *const kPAPInstallationChannelsKey = @"channels";


#pragma mark - Activity Class
// Class key
NSString *const kPAPActivityClassKey = @"Activity";

// Field keys
NSString *const kPAPActivityTypeKey         = @"type";
NSString *const kPAPActivityFromUserKey     = @"fromUser";
NSString *const kPAPActivityToUserKey       = @"toUser";
NSString *const kPAPActivityCommentKey      = @"comment";
NSString *const kPAPActivityPhotoKey        = @"caseID";
NSString *const kPAPActivityIsReadedKey     = @"isReaded";

// Type values
NSString *const kPAPActivityTypePost                = @"post";          //發案
NSString *const kPAPActivityTypeTake                 = @"take";           //接案
NSString *const kPAPActivityTypeOwnerCheckHelper    = @"check";         //確定幫手
NSString *const kPAPActivityTypeOwnerDidntCheckHelper= @"fail";         //確定選擇其他幫手通知
NSString *const kPAPActivityTypeJoined              = @"joined";        //加入，通知好友我也安裝了
NSString *const kPAPActivityTypeSpan                = @"span";          //封鎖
NSString *const kPAPActivityTypeLike                = @"like";          //喜歡
NSString *const kPAPActivityTypeRate                = @"rating";        //評價
NSString *const kPAPActivityTypeComment             = @"comment";       //留言
NSString *const kPAPActivityTypeFollow              = @"follow";        //跟隨
NSString *const kPAPActivityTypeReject              = @"reject";        //取消接案
NSString *const kPAPActivityTypePassCheck           = @"pass";



#pragma mark - NSNotification userInfo keys:
NSString * const kPAWFilterDistanceKey      = @"filterDistance";
NSString * const kPAWLocationKey            = @"location";


#pragma mark - User Class
// Field keys
NSString *const kPAPUserDisplayNameKey                          = @"displayName";
NSString *const kPAPUserFacebookIDKey                           = @"facebookId";
NSString *const kPAPUserPhotoIDKey                              = @"photoId";
NSString *const kPAPUserProfilePicSmallKey                      = @"picSmall";
NSString *const kPAPUserProfilePicMediumKey                     = @"picMedium";
NSString *const kPAPUserFacebookFriendsKey                      = @"facebookFriends";
NSString *const kPAPUserAlreadyAutoFollowedFacebookFriendsKey   = @"userAlreadyAutoFollowedFacebookFriends";
NSString *const kPAPUserPrivateChannelKey                       = @"channel";
//資料表新增生日、性別、email、地區、姓氏、名字
NSString *const kPAPUserFacebookBirthdayKey                     = @"birthday";
NSString *const kPAPUserFacebookGenderKey                       = @"gender";
NSString *const kPAPUserFacebookEmailKey                        = @"email";
NSString *const kPAPUserFacebookLocalsKey                       = @"fbLocale";
NSString *const kPAPUserFacebookFirstNameKey                    = @"fbFirstName";
NSString *const kPAPUserFacebookLastNameKey                     = @"fbLastName";
NSString *const kPAPUserMaxPostQuotaKey                         = @"postQuota";
NSString *const kPAPUserMaxReceiveQuotaKey                      = @"receiveQuota";
NSString *const kPAPUserFrequencyKey                            = @"frequency";

NSString *const kCMUserNameString           = @"username";
NSString *const defaultsFilterDistanceKey   = @"filterDistance";
NSString *const defaultsLocationKey         = @"currentLocation";
NSString *const kPAPParseLocationKey        = @"location";
NSString *const kPAPUserTypeKey             = @"type";
NSString *const kPAPUserIsReadLocationKey   = @"isReadLocation";
//Type
NSString *const kPAPUserTypeHelperKey       = @"helper";
NSString *const kPAPUserTypeCustomerKey     = @"unhelper";

#pragma mark - PFObject User Location Class
// Class key
NSString *const kPAPUserLocationClassKey        = @"UserLocation";
// Field keys
NSString *const kPAPUserLocationUserKey         = @"user";
NSString *const kPAPUserLocationLocationKey     = @"location";

//個人檔案照片儲存位置
NSString * const MediumImagefilePath = @"Documents/medium.png";
NSString * const SmallRoundedImagefilePath = @"Documents/small.png";

#pragma mark - Push Notification Payload Keys

NSString *const kAPNSAlertKey = @"alert";
NSString *const kAPNSBadgeKey = @"badge";
NSString *const kAPNSSoundKey = @"sound";

// the following keys are intentionally kept short, APNS has a maximum payload limit
// 下面的鍵被故意盡量短，APNS的最大有效載荷限制
NSString *const kPAPPushPayloadPayloadTypeKey               = @"p";
NSString *const kPAPPushPayloadPayloadTypeActivityKey       = @"a";

NSString *const kPAPPushPayloadActivityTypeKey              = @"t";

NSString *const kPAPPushPayloadActivitySendPlzKey           = @"post";     //業主發案
NSString *const kPAPPushPayloadActivityTakeUpKey            = @"take";     //幫手接案
NSString *const kPAPPushPayloadActivityOwnerCheckHelpKey    = @"check";     //業主確認幫手
NSString *const kPAPPushPayloadActivityOwnerDidntCheckHelpKey = @"fail";    //業主已指派別人
NSString *const kPAPPushPayloadActivityIAmInstallKey        = @"joined";     //當前用戶通知好友
NSString *const kPAPPushPayloadActivityBlockKey             = @"span";     //封鎖
NSString *const kPAPPushPayloadActivityLikeKey              = @"like";     //喜歡
NSString *const kPAPPushPayloadActivityRatingKey            = @"rating";     //評價
NSString *const kPAPPushPayloadActivityCommentKey           = @"comment";     //留言
NSString *const kPAPPushPayloadActivityFollowKey            = @"follow";     //跟隨
NSString *const kPAPPushPayloadActivitySMSKey               = @"aotp";      //AOTP推播
NSString *const kPAPPushPayloadActivitySMSResultKey         = @"result";     // = 2 成功認證

NSString *const kPAPPushPayloadFromUserObjectIdKey          = @"fu";
NSString *const kPAPPushPayloadToUserObjectIdKey            = @"tu";
NSString *const kPAPPushPayloadPhotoObjectIdKey             = @"ca";



#pragma mark - 偏好設定類別
// Class key
NSString *const kPAPUserPreferenceCategoryClassKey          = @"PreferenceCategory";

// Field keys
NSString *const kPAPUserPreferenceCategoryCharityKey        = @"isDharity";
NSString *const kPAPUserPreferenceCategoryPurchaseKey       = @"isPurchase";
NSString *const kPAPUserPreferenceCategoryDeliveryKey       = @"isDelivery";
NSString *const kPAPUserPreferenceCategorySelfDefineKey     = @"isSelfdefine";
NSString *const kPAPUserPreferenceCategoryRallyKey          = @"isDove";
NSString *const kPAPUserPreferenceCategoryCleanerKey        = @"isCleaner";
NSString *const kPAPUserPreferenceCategoryActivitiesKey     = @"isActivities";
NSString *const kPAPUserPreferenceCategoryWaiterKey         = @"isWaiter";
NSString *const kPAPUserPreferenceCategoryPromoterKey       = @"isPromoter";
NSString *const kPAPUserPreferenceCategoryActorKey          = @"isActor";
NSString *const kPAPUserPreferenceCategoryConstructionKey   = @"isConstruction";
NSString *const kPAPUserPreferenceCategorySurveyKey         = @"isSurvey";
NSString *const kPAPUserPreferenceCategoryFactoryKey        = @"isFactory";
NSString *const kPAPUserPreferenceCategoryDmKey             = @"isDm";
NSString *const kPAPUserPreferenceCategoryDollKey           = @"isDoll";
NSString *const kPAPUserPreferenceCategoryArtKey            = @"isArt";
NSString *const kPAPUserPreferenceCategoryWebdesignKey      = @"isWebdesign";
NSString *const kPAPUserPreferenceCategoryElectricianKey    = @"isElectrician";
NSString *const kPAPUserPreferenceCategoryComputerKey       = @"isComputer";
NSString *const kPAPUserPreferenceCategoryAccountantKey     = @"isAccountant";
NSString *const kPAPUserPreferenceCategoryLawyerKey         = @"isLawyer";
NSString *const kPAPUserPreferenceCategoryModelKey          = @"isModel";
NSString *const kPAPUserPreferenceCategoryTranslatorKey     = @"isTranslator";
NSString *const kPAPUserPreferenceCategoryNurseKey          = @"isNurse";
NSString *const kPAPUserPreferenceCategoryDaycareKey        = @"isDaycare";


#pragma mark - 偏好設定類別
// Class key
NSString *const kPAPUserPreferenceTimeClassKey          = @"PreferenceTime";

// Field keys
NSString *const kPAPUserPreferenceTimeMorningKey        = @"morning";
NSString *const kPAPUserPreferenceTimeAfternoonKey      = @"afternoon";
NSString *const kPAPUserPreferenceTimeNightKey          = @"night";
NSString *const kPAPUserPreferenceTimeMidNightKey       = @"midnight";
NSString *const kPAPUserPreferenceTimeAllKey            = @"all";

NSUInteger const kPAWWallPostMaximumCharacterCount = 140;

NSUInteger const kPAWWallPostsSearch = 20; // query limit for pins and tableviewcells

// Parse API key constants:
//NSString * const kPAWParsePostsClassKey = @"Posts";
NSString * const kPAWParseUserKey = @"user";
NSString * const kPAWParseUsernameKey = @"username";
NSString * const kPAWParseTextKey = @"text";
NSString * const kPAWParseLocationKey = @"toGeo";

// UI strings:
NSString * const kPAWWallCantViewPost = @"距離您太遠！請再靠近";

//紀錄是不是第一次安裝，要出現tutorial
NSString *const firstTimeInstallKey = @"firstTimeInstallKey";

//大類別的存檔路徑
NSString *const mainCategoryFile = @"mainCategoryFile.text";
NSString *const subCategoryFile = @"subCategoryFile.text";


//是否為第一次用戶參數
NSString *const myFirstTimeFilePath = @"myfirstTime.text";
NSString *const myFirstTimeManagerPath = @"myFirstTimeManager.text";

//小類別的存檔路徑
/* index = 0 , 公益志工     0個小項
 * index = 1 , 臨時人力     10個小項
 * index = 2 , 代買        6個小項
 * index = 3 , 代送        6個小項
 * index = 4 , 活動造勢     6個小項
 * index = 5 , 專業人力     8個小項
 * index = 6 , 自定幫手     0個小項
 * index = 7 , 協尋幫手     0個小項
 */
NSString *const partTimeSubCategoryFile = @"partTimeSubCategoryFile";           //1
NSString *const buySubCategoryFile = @"buySubCategoryFile";                     //2
NSString *const sendSubCategoryFile = @"sendSubCategoryFile";                   //3
NSString *const activitySubCategoryFile = @"activitySubCategoryFile";           //4
NSString *const professionalSubCategoryFile = @"professionalSubCategoryFile";   //5


//發案子
NSString *const tasksSyncNewFormat = @"tasksSyncNewFormat";
//案子存檔路徑
NSString *const WriteTaskFile = @"WriteTaskFile.txt";


//任務key
NSString *const kTaskCasesClassesKey = @"Cases";            //主Key
NSString *const kTaskObjectId = @"objectId";
NSString *const kTaskTitle    = @"title";
NSString *const kTaskCategory = @"categoryID";              //大類別
NSString *const kTaskLitleCategory = @"categoryDetailID";   //小類別
NSString *const kTaskPhotoFile = @"picMedium";              //照片檔案
NSString *const kTaskPhotoSmallFile = @"picSmall";          //小照片
NSString *const kTaskProjectMoney = @"itemFee";             //單一商品價格
NSString *const kTaskProjectUnit = @"itemUnit";             //單一商品單位
NSString *const kTaskProjectName  = @"itemName";            //商品名稱
NSString *const kTaskNotes = @"note";                       //任務描述
NSString *const kTaskProjectNumber = @"amount";             //商品數量
NSString *const kTaskWaitingTime   = @"waitTime";           //等待時間
NSString *const kTaskProjectWeight = @"totalWeight";        //物品總重量
NSString *const kTaskBuildType = @"buildType";              //建築物類型
NSString *const kTaskDepartmentName = @"departmentName";    //用人單位
NSString *const kTaskDistance = @"distance";                //兩點間導航距離公尺
NSString *const kTaskDuaration = @"duaration";              //兩點間導航秒數
NSString *const kTaskEmerFee = @"emerFee";                  //急件加價
NSString *const kTaskStartTime = @"startTime";              //開始時間
NSString *const kTaskEndTime = @"endTime";                  //結束時間
NSString *const kTaskFromAddress = @"fromAddress";          //起始地址
NSString *const kTaskFromAdministrativeArea = @"fromAdministrativeArea";//地址縣市
NSString *const kTaskFromCity = @"fromCity";                //市區
NSString *const kTaskToAddress = @"toAddress";              //結束地址
NSString *const kTaskToAdministrativeArea = @"toAdministrativeArea";//地址縣市
NSString *const kTaskToCity = @"toCity";                    //市區
NSString *const kTaskFromWhere = @"fromGeo";                //起始經緯
NSString *const kTaskToWhere = @"toGeo";                    //結束經緯
NSString *const kTaskFromFloor = @"fromFloor";              //起始樓層
NSString *const kTaskToFloor = @"toFloor";                  //結束樓層
NSString *const kTaskOwner_User = @"ownID";                 //業主
NSString *const kTaskFromContactName = @"fromContactName";   //從-聯絡人
NSString *const kTaskFromContactPhone = @"fromContactPhone"; //從-聯絡電話
NSString *const kTaskToContactName = @"toContactName";       //到-聯絡人
NSString *const kTaskToContactPhone = @"toContactPhone";     //到-聯絡電話
NSString *const kTaskConverner_User = @"helperID";          //幫手
NSString *const kTaskHourlyPay = @"hourlyPay";              //時薪
NSString *const kTaskIsEmer = @"isEmer";                    //是否急件
NSString *const kTaskNeedConvener = @"needConvener";        //是否要召集人
NSString *const kTaskTotalPeopleNumber = @"peopleAmount";   //需要人數
NSString *const kTaskServiceFee = @"serviceFee";            //服務費
NSString *const kTaskServiceTime = @"serviceTime";          //服務總時
NSString *const kTaskSpecialRequirementsA = @"specialRequirementsA";    //特別要求A
NSString *const kTaskSpecialRequirementsB = @"specialRequirementsB";    //特別要求B
NSString *const kTaskTotalMoney = @"totalFee";              //總金額
NSString *const kTaskTrafficMoney = @"trafficFee";          //交通費
NSString *const kTaskWishPay = @"wishPay";                  //可以賺的錢 = 服務費＋交通費
NSString *const ktaskPaymentMethod = @"paymentMethod";      //付款方式
NSString *const kTaskIsFree = @"volunteer";                 //是否找義工
NSString *const kTaskIsClose = @"isClosed";                  //是否結案
NSString *const kTaskIsAuto = @"isAuto";                    //是否系統指派
NSString *const kTaskIsYou  = @"isYou";                     //是否參與競標
NSString *const kTaskIsResponse = @"isResponse";            //是否搶過這個案子
NSString *const kTaskPushAmount = @"pushAmount";            //推播出去的總人數
NSString *const kTaskCaseDesc   = @"caseDesc";              //備註
NSString *const kTaskIsPublish  = @"isPublish";             //分享FB

NSString *const kTaskMapDirectionIOS7 = @"mapDirectionIOS7";
NSString *const kTaskMapDirectionIOS6 = @"mapDirectionIOS6";

NSString *const kTaskDescript = @"descript";
NSString *const kTaskOrganization = @"organization";
NSString *const kTaskOwnerCheck = @"ownerCheck";
NSString *const kTaskConvernerCheck = @"convernerCheck";
NSString *const kTaskActivitiesForm = @"activitiesForm";
NSString *const kTaskChoseArray = @"choseArray";

#pragma mark - Cached 任務 Attributes
// keys
NSString *const kPAPPhotoAttributesIsLikedByCurrentUserKey = @"isLikedByCurrentUser";
NSString *const kPAPPhotoAttributesIsReadedByCurrentUserKey = @"isReadedByCurrentUser";
NSString *const kPAPPhotoAttributesLikeCountKey            = @"likeCount";
NSString *const kPAPPhotoAttributesLikersKey               = @"likers";
NSString *const kPAPPhotoAttributesCommentCountKey         = @"commentCount";
NSString *const kPAPPhotoAttributesCommentersKey           = @"commenters";

#pragma mark - Cached User Attributes
// keys
NSString *const kPAPUserAttributesPhotoCountKey                 = @"photoCount";
NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey    = @"isFollowedByCurrentUser";
NSString *const kPAPUserAttributesIsAddedByCurrentUserKey    = @"isAddedByCurrentUser";
NSString *const kPAPUserAttributesIsAddedToGroupKey             = @"isAddedToGroup";

#pragma mark - Map Needs
double const kPAWFeetToMeters = 0.3048;                                 // this is an exact value.
double const kPAWFeetToMiles = 5280.0;                                 // this is an exact value.
double const kPAWWallPostMaximumSearchDistance = 2.0; //公里
double const kPAWMetersInAKilometer = 1000.0;                           // this is an exact value.

NSUInteger const kPAWMapCarsSearch = 5;                              // query limit for cars on Map


// ************* Share Facebook Switch *****************
BOOL isFacebookSwitchOn;
PFObject *casesConstants;
PFObject *myGroupCategoryObject;
PFUser *ratingUser;
NSNumber *newBadgeValue;
NSArray *loveAddress;

NSString *const UploadDataNoti =        @"UploadDataNoti";

BOOL isFromPostTaskFlow;
BOOL hasCenterButton;


// ***************** 用戶的基本資料 ****************************
NSUserDefaults *userDefaults;