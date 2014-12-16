

#pragma mark - Parameter

#define kTestJSONHost @"http://douban.fm/j/mine/playlist?type=n&h=&channel=0&from=mainsite&r=4941e23d79"

#define kDefaultCityId @"5395652ee4b08cd56b62dc4e"


#pragma mark - file


#define kFontName @"STHeitiSC-Light"
#define kFontBoldName @"STHeitiSC-Medium"


#pragma mark - ViewTag


#pragma mark - Key
#define kUmengAppKey @"5469be08fd98c53e5b0015b1" // 在share的时候要用到


#pragma mark - Notification


#pragma mark - UI


#define kColorGreen  [UIColor colorWithRed:112.0/255 green:196.0/255 blue:189.0/255 alpha:1]  //主色调
#define kColorLightGreen [UIColor colorWithRed:181.0/255 green:219.0/255 blue:214.0/255 alpha:1]
#define kColorYellow  [UIColor colorWithRed:255.0/255 green:142.0/255 blue:0.0/255 alpha:1]
#define kColorDarkYellow  [UIColor colorWithRed:255.0/255 green:134.0/255 blue:36.0/255 alpha:1]
#define kColorLightYellow  [UIColor colorWithRed:255.0/255 green:164.0/255 blue:0.0/255 alpha:1]
#define kColorBlack  [UIColor colorWithRed:23.0/255 green:33.0/255 blue:42.0/255 alpha:1]
#define kColorDardGray [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1]
#define kColorGray  [UIColor colorWithRed:168.0/255 green:168.0/255 blue:168.0/255 alpha:1]
#define kColorLightGray  [UIColor colorWithRed:213.0/255 green:213.0/255 blue:213.0/255 alpha:1]
#define kColorWhite [UIColor colorWithWhite:.97 alpha:1]
#define kColorBG    [UIColor colorWithRed:240.0/255 green:239.0/255 blue:229.0/255 alpha:1]
#define kColorRed    [UIColor colorWithRed:239.0/255 green:102.0/255 blue:47.0/255 alpha:1]
#define kColorBlue    [UIColor colorWithRed:10.0/255 green:10.0/255 blue:247.0/255 alpha:1]

#define kHNavigationbar (isPad?44.0:32.0)
#define kHPopNavigationbar (isPad?44.0:32.0)


#define kOpenBeaconNotificationKey @"openBeacon"
#define kCloseBeaconNotificationKey @"closeBeacon"
#define kListBeaconsNotificationKey @"listBeacons"

#define kOpenExhiBeaconNotificationKey @"openExhiBeacon"
#define kCloseExhiBeaconNotificationKey @"closeExhiBeacon"



typedef void (^VoidBlock)();
typedef void (^BooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^IntegerResultBlock)(int number, NSError *error);
typedef void (^ArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^SetResultBlock)(NSSet *channels, NSError *error);
typedef void (^DataResultBlock)(NSData *data, NSError *error);
typedef void (^DataStreamResultBlock)(NSInputStream *stream, NSError *error);
typedef void (^StringResultBlock)(NSString *string, NSError *error);
typedef void (^IdResultBlock)(id object, NSError *error);
typedef void (^ProgressBlock)(int percentDone);

#pragma mark - Debug & Release

#ifdef DEBUG



#else




#endif

