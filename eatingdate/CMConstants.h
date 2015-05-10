//
//  CMConstants.h
//  chatMessenger
//
//  Created by Ayi on 2014/3/2.
//  Copyright (c) 2014年 Ayi. All rights reserved.
//

#define SYSTEM_NAVIBAR_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:1]
#define ISIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue] >= 8.0)
#define ISIOS71 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] floatValue] >= 7.1)
#define ISIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] >= 7.0)
#define ISIOS6 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6)
#define IS40 ([self windowHeight]>=640)
#define IS400 (self.view.frame.size.height > 460)

#pragma mark - NSUserDefaults
extern NSString *const kPAPUserDefaultsCacheHelpersKey;
extern NSString *const kPAPUserDefaultsActivityFeedViewControllerLastRefreshKey;        //用戶默認設置的活動資訊 - 視圖 - 控制器刷新鍵
extern NSString *const kPAPUserDefaultsCreateCaseTableViewControllerLastRefreshKey;

extern NSString *const kPAPUserDefaultsCacheFacebookFriendsKey;                         //用戶默認緩存給好友鍵
extern NSString *const kPAPUserDefaultsCacheFacebookFriendsNumberKey;
extern NSString *const kPAPUserDefaultsCachePhonesFriendsKey;
extern NSString *const kPAPUserDefaultsCacheFacebookGroupsKey;                          //用戶默認緩存社團鍵
extern NSString *const kPAPUserDefaultsMyTasksTableViewControllerLastRefreshKey;        //我的任務最後一次刷新鍵
extern NSString *const kPAPUserDefaultsWaitTasksTableViewControllerLastRefreshKey;      //等待回應任務最後一次刷新鍵
extern NSString *const kPAPUserDefaultsEndTasksTableViewControllerLastRefreshKey;       //結案任務最後一次刷新鍵
extern NSString *const kPAPUserDefaultsSelectHelperTableViewControllerLastRefreshKey;   //接案幫手選擇頁面最後一次刷新鍵

#pragma mark - Launch URLs
extern NSString *const kPAPLaunchURLHostTakePicture;

#pragma mark - NSNotification
extern NSString *const PAPAppDelegateApplicationDidReceiveRemoteNotification;
extern NSString *const PAPUtilityUserFollowingChangedNotification;
extern NSString *const PAPUtilityUserAddingChangedNotification;
extern NSString *const PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification;
extern NSString *const PAPUtilityDidFinishProcessingProfilePictureNotification;
extern NSString *const PAPTabBarControllerDidFinishEditingPhotoNotification;
extern NSString *const PAPTabBarControllerDidFinishImageFileUploadNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserDeletedPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification;
extern NSString *const PAPPhotoDetailsViewControlleerUserGetedOnPhotoNotification;
// Notification names:
extern NSString * const kPAWFilterDistanceChangeNotification;
extern NSString * const kPAWLocationChangeNotification;
extern NSString * const kPAWFilterHelperTypeChangeNotification;
extern NSString * const kPAWFilterCumtomerTypeChangeNotification;

#pragma mark - User Info Keys
extern NSString *const PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey;
extern NSString *const kPAPEditPhotoViewControllerUserInfoCommentKey;

#pragma mark - Installation Class
// Field keys
extern NSString *const kPAPInstallationUserKey;
extern NSString *const kPAPInstallationChannelsKey;

#pragma mark - PFObject Activity Class
// Class key
extern NSString *const kPAPActivityClassKey;

// Field keys
extern NSString *const kPAPActivityTypeKey;
extern NSString *const kPAPActivityFromUserKey;
extern NSString *const kPAPActivityToUserKey;
extern NSString *const kPAPActivityCommentKey;
extern NSString *const kPAPActivityPhotoKey;
extern NSString *const kPAPActivityIsReadedKey;

// Type values
extern NSString *const kPAPActivityTypePost;               //發案
extern NSString *const kPAPActivityTypeTake;                //接案
extern NSString *const kPAPActivityTypeOwnerCheckHelper;   //確定幫手
extern NSString *const kPAPActivityTypeOwnerDidntCheckHelper; //確定選擇其他幫手
extern NSString *const kPAPActivityTypeJoined;             //加入，通知好友我也安裝了
extern NSString *const kPAPActivityTypeSpan;               //封鎖
extern NSString *const kPAPActivityTypeLike;               //喜歡
extern NSString *const kPAPActivityTypeRate;               //評價
extern NSString *const kPAPActivityTypeComment;            //留言
extern NSString *const kPAPActivityTypeFollow;             //跟隨
extern NSString *const kPAPActivityTypeReject;             //取消接案
extern NSString *const kPAPActivityTypePassCheck;           //通過驗證
extern NSString *const kPAPPushPayloadActivitySMSKey;
extern NSString *const kPAPPushPayloadActivitySMSResultKey;

// NSNotification userInfo keys:
extern NSString * const kPAWFilterDistanceKey;
extern NSString * const kPAWLocationKey;





#define PAWLocationAccuracy double

#pragma mark - Launch URLs
extern NSString *const kPAPLaunchURLHostTakePicture;                                //啟動URL主機拍照

#pragma mark - PFObject User Class
// Field keys
extern NSString *const kPAPUserDisplayNameKey;
extern NSString *const kPAPUserFacebookIDKey;
extern NSString *const kPAPUserPhotoIDKey;
extern NSString *const kPAPUserProfilePicSmallKey;
extern NSString *const kPAPUserProfilePicMediumKey;
extern NSString *const kPAPUserFacebookFriendsKey;
extern NSString *const kPAPUserAlreadyAutoFollowedFacebookFriendsKey;
extern NSString *const kPAPUserPrivateChannelKey;
//facebook 生日、性別、email、地區、姓氏、名字
extern NSString *const kPAPUserFacebookBirthdayKey;
extern NSString *const kPAPUserFacebookGenderKey;
extern NSString *const kPAPUserFacebookEmailKey;
extern NSString *const kPAPUserFacebookLocalsKey;
extern NSString *const kPAPUserFacebookFirstNameKey;
extern NSString *const kPAPUserFacebookLastNameKey;
extern NSString *const kPAPUserFacebookLocation;
extern NSString *const kPAPUserMaxPostQuotaKey;
extern NSString *const kPAPUserMaxReceiveQuotaKey;
extern NSString *const kPAPUserFrequencyKey;
//個人資訊的key
extern NSString *const kCMUserNameString;
extern NSString *const defaultsFilterDistanceKey;
extern NSString *const defaultsLocationKey;
extern NSString *const kPAPParseLocationKey;
extern NSString *const kPAPUserTypeKey;
extern NSString *const kPAPUserIsReadLocationKey;
//Type的類型
// Type values
extern NSString *const kPAPUserTypeHelperKey;
extern NSString *const kPAPUserTypeCustomerKey;

//Type的類型
extern NSString *const kPAPUserType;

#pragma mark - PFObject User Location Class
// Class key
extern NSString *const kPAPUserLocationClassKey;
// Field keys
extern NSString *const kPAPUserLocationUserKey;
extern NSString *const kPAPUserLocationLocationKey;

// 個人檔案照片儲存位置
extern NSString * const MediumImagefilePath;
extern NSString * const SmallRoundedImagefilePath;

//是否為第一次用戶參數
extern NSString *const myFirstTimeFilePath;
extern NSString *const myFirstTimeManagerPath;

#pragma mark - 偏好設定類別
// Class key
extern NSString *const kPAPUserPreferenceCategoryClassKey;

// Field keys
extern NSString *const kPAPUserPreferenceCategoryCharityKey;
extern NSString *const kPAPUserPreferenceCategoryPurchaseKey;
extern NSString *const kPAPUserPreferenceCategoryDeliveryKey;
extern NSString *const kPAPUserPreferenceCategorySelfDefineKey;
extern NSString *const kPAPUserPreferenceCategoryRallyKey;
extern NSString *const kPAPUserPreferenceCategoryCleanerKey;
extern NSString *const kPAPUserPreferenceCategoryActivitiesKey;
extern NSString *const kPAPUserPreferenceCategoryWaiterKey;
extern NSString *const kPAPUserPreferenceCategoryPromoterKey;
extern NSString *const kPAPUserPreferenceCategoryActorKey;
extern NSString *const kPAPUserPreferenceCategoryConstructionKey;
extern NSString *const kPAPUserPreferenceCategorySurveyKey;
extern NSString *const kPAPUserPreferenceCategoryFactoryKey;
extern NSString *const kPAPUserPreferenceCategoryDmKey;
extern NSString *const kPAPUserPreferenceCategoryDollKey;
extern NSString *const kPAPUserPreferenceCategoryArtKey;
extern NSString *const kPAPUserPreferenceCategoryWebdesignKey;
extern NSString *const kPAPUserPreferenceCategoryElectricianKey;
extern NSString *const kPAPUserPreferenceCategoryComputerKey;
extern NSString *const kPAPUserPreferenceCategoryAccountantKey;
extern NSString *const kPAPUserPreferenceCategoryLawyerKey;
extern NSString *const kPAPUserPreferenceCategoryModelKey;
extern NSString *const kPAPUserPreferenceCategoryTranslatorKey;
extern NSString *const kPAPUserPreferenceCategoryNurseKey;
extern NSString *const kPAPUserPreferenceCategoryDaycareKey;

#pragma mark - 偏好設定類別
// Class key
extern NSString *const kPAPUserPreferenceTimeClassKey;

// Field keys
extern NSString *const kPAPUserPreferenceTimeMorningKey;
extern NSString *const kPAPUserPreferenceTimeAfternoonKey;
extern NSString *const kPAPUserPreferenceTimeNightKey;
extern NSString *const kPAPUserPreferenceTimeMidNightKey;
extern NSString *const kPAPUserPreferenceTimeAllKey;


#pragma mark - Cached User Attributes
// keys
extern NSString *const kPAPUserAttributesPhotoCountKey;
extern NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey;
extern NSString *const kPAPUserAttributesIsAddedByCurrentUserKey;
extern NSString *const kPAPUserAttributesIsAddedToGroupKey;

#pragma mark - PFPush Notification Payload Keys

extern NSString *const kAPNSAlertKey;
extern NSString *const kAPNSBadgeKey;
extern NSString *const kAPNSSoundKey;

extern NSString *const kPAPPushPayloadPayloadTypeKey;
extern NSString *const kPAPPushPayloadPayloadTypeActivityKey;

extern NSString *const kPAPPushPayloadActivityTypeKey;
extern NSString *const kPAPPushPayloadActivitySendPlzKey;
extern NSString *const kPAPPushPayloadActivityTakeUpKey;
extern NSString *const kPAPPushPayloadActivityOwnerCheckHelpKey;
extern NSString *const kPAPPushPayloadActivityOwnerDidntCheckHelpKey;
extern NSString *const kPAPPushPayloadActivityIAmInstallKey;
extern NSString *const kPAPPushPayloadActivityBlockKey;
extern NSString *const kPAPPushPayloadActivityLikeKey;
extern NSString *const kPAPPushPayloadActivityRatingKey;
extern NSString *const kPAPPushPayloadActivityCommentKey;
extern NSString *const kPAPPushPayloadActivityFollowKey;

extern NSString *const kPAPPushPayloadFromUserObjectIdKey;
extern NSString *const kPAPPushPayloadToUserObjectIdKey;
extern NSString *const kPAPPushPayloadPhotoObjectIdKey;





extern NSUInteger const kPAWWallPostMaximumCharacterCount;

extern NSUInteger const kPAWWallPostsSearch; // query limit for pins and tableviewcells

// Parse API key constants:
//extern NSString * const kPAWParsePostsClassKey;
extern NSString * const kPAWParseUserKey;
extern NSString * const kPAWParseUsernameKey;
extern NSString * const kPAWParseTextKey;
extern NSString * const kPAWParseLocationKey;


//UI strings:
extern NSString * const kPAWWallCantViewPost;

//firstTimeInstall
extern NSString *const firstTimeInstallKey;

//類別的存檔路徑
extern NSString *const mainCategoryFile;
extern NSString *const subCategoryFile;

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
extern NSString *const partTimeSubCategoryFile; //1
extern NSString *const buySubCategoryFile;      //2
extern NSString *const sendSubCategoryFile;     //3
extern NSString *const activitySubCategoryFile; //4
extern NSString *const professionalSubCategoryFile; //5

//發案子
extern NSString *const tasksSyncNewFormat;
//案子路徑
extern NSString *const WriteTaskFile;
//任務key
extern NSString *const kTaskCasesClassesKey;
//table
extern NSString *const kTaskObjectId;
extern NSString *const kTaskTitle;
extern NSString *const kTaskCategory;               //大類別
extern NSString *const kTaskLitleCategory;          //小類別
extern NSString *const kTaskPhotoFile;              //照片檔案
extern NSString *const kTaskPhotoSmallFile;         //小照片
extern NSString *const kTaskProjectMoney;           //單一商品價格
extern NSString *const kTaskProjectUnit;            //單一商品單位
extern NSString *const kTaskProjectName;            //商品名稱
extern NSString *const kTaskProjectNumber;          //商品數量
extern NSString *const kTaskWaitingTime;            //等待時間
extern NSString *const kTaskProjectWeight;          //物品總重量
extern NSString *const kTaskBuildType;              //建築物類型
extern NSString *const kTaskDepartmentName;         //用人單位
extern NSString *const kTaskDistance;               //兩點間導航距離公尺
extern NSString *const kTaskDuaration;              //兩點間導航秒數
extern NSString *const kTaskEmerFee;                //急件加價
extern NSString *const kTaskStartTime;              //開始時間
extern NSString *const kTaskEndTime;                //結束時間
extern NSString *const kTaskFromAddress;            //起始地址
extern NSString *const kTaskFromAdministrativeArea;
extern NSString *const kTaskFromCity;
extern NSString *const kTaskToAddress;              //結束地址
extern NSString *const kTaskToAdministrativeArea;
extern NSString *const kTaskToCity;
extern NSString *const kTaskFromWhere;              //起始經緯
extern NSString *const kTaskToWhere;                //結束經緯
extern NSString *const kTaskFromFloor;              //起始樓層
extern NSString *const kTaskToFloor;                //結束樓層
extern NSString *const kTaskOwner_User;             //業主
extern NSString *const kTaskFromContactName;        //從-聯絡人
extern NSString *const kTaskFromContactPhone;       //從-聯絡電話
extern NSString *const kTaskToContactName;          //從-聯絡人
extern NSString *const kTaskToContactPhone;         //從-聯絡電話
extern NSString *const kTaskConverner_User;         //幫手
extern NSString *const kTaskHourlyPay;              //時薪
extern NSString *const kTaskIsEmer;                 //是否急件
extern NSString *const kTaskNeedConvener;           //是否要召集人
extern NSString *const kTaskDescript;               //任務描述
extern NSString *const kTaskTotalPeopleNumber;      //需要人數
extern NSString *const kTaskServiceFee;             //服務費
extern NSString *const kTaskServiceTime;            //服務總時
extern NSString *const kTaskSpecialRequirementsA;   //特別要求A
extern NSString *const kTaskSpecialRequirementsB;   //特別要求B
extern NSString *const kTaskTotalMoney;             //總金額
extern NSString *const kTaskTrafficMoney;           //交通費
extern NSString *const kTaskWishPay;                //可以賺的錢 = 服務費＋交通費
extern NSString *const ktaskPaymentMethod;          //付款方式
extern NSString *const kTaskIsFree;                 //是否找義工
extern NSString *const kTaskIsClose;                //是否結案
extern NSString *const kTaskIsAuto;                 //是否系統指派
extern NSString *const kTaskIsYou;                  //是否是你得標，多數人得標的時候用
extern NSString *const kTaskIsResponse;             //你是否已經搶了該案（多數人用）
extern NSString *const kTaskPushAmount;             //推播出去的總人數。
extern NSString *const kTaskCaseDesc;               //備註
extern NSString *const kTaskIsPublish;              //分享FB

extern NSString *const kTaskMapDirectionIOS7;
extern NSString *const kTaskMapDirectionIOS6;

extern NSString *const kTaskNotes;
extern NSString *const kTaskOrganization;
extern NSString *const kTaskOwnerCheck;
extern NSString *const kTaskConvernerCheck;

extern NSString *const kTaskActivitiesForm;
extern NSString *const kTaskChoseArray;

#pragma mark - Cached Photo Attributes
// keys
extern NSString *const kPAPPhotoAttributesIsLikedByCurrentUserKey;
extern NSString *const kPAPPhotoAttributesIsReadedByCurrentUserKey;
extern NSString *const kPAPPhotoAttributesLikeCountKey;
extern NSString *const kPAPPhotoAttributesLikersKey;
extern NSString *const kPAPPhotoAttributesCommentCountKey;
extern NSString *const kPAPPhotoAttributesCommentersKey;

#pragma mark - Cached User Attributes
// keys
extern NSString *const kPAPUserAttributesPhotoCountKey;
extern NSString *const kPAPUserAttributesIsFollowedByCurrentUserKey;

// Map Needs
extern double const kPAWFeetToMeters;                               // this is an exact value.
extern double const kPAWFeetToMiles;                                // this is an exact value.
extern double const kPAWWallPostMaximumSearchDistance;
extern double const kPAWMetersInAKilometer;                         // this is an exact value.

extern NSUInteger const kPAWMapCarsSearch;

// ***************** Share To Facebook Switch *****************

extern BOOL isFacebookSwitchOn;


extern PFObject *casesConstants;

extern PFObject *myGroupCategoryObject;

extern PFUser *ratingUser;

extern NSNumber *newBadgeValue;

extern NSArray *loveAddress;


extern NSString *const UploadDataNoti;

extern BOOL isFromPostTaskFlow;
extern BOOL hasCenterButton;

// ***************** 用戶的基本資料 ****************************
extern NSUserDefaults *userDefaults;

// ***************** 餐廳的類別 ****************************
extern NSArray *categoriesForRestaurant;