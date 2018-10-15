#import <UIKit/UIKit.h>



//指示箭头到右边界的距离
NSInteger kIndicatorToRightMargin = 15;
/*----------------------------------购物车数量----------------------------------*/

NSInteger shopCartTotal = 0;

NSString *locationStr = nil;
/*----------------------------------通知----------------------------------*/
NSInteger margin = 10;

//监听tabBar的切换
NSString * const kTabBarDidSelectedNotification = @"kTabBarDidSelectedNotification" ;


//支付 美点余额 - > 我的界面 美点余额 更新
NSString * const kMPointUpDataNotification = @"kMPointUpDataNotification";

//再次购买->购物车
NSString * const kageinPayNotification = @"kageinPayNotification";

//支付完成  -> 刷新购物车列表
NSString * const kPayDoneUpDataShopNotification = @"kPayDoneUpDataShopNotification";

//退出登录
NSString  * const kLogoutNotification = @"kLogoutNotification";
//登陆成功
NSString  * const kLoginSuccessNotification = @"kLoginSuccessNotification";

// ali 支付完成通知
NSString  * const kAliPayCompleteNotification = @"kAliPayCompleteNotification";
// wechat 支付完成通知
NSString  * const kWeChatPayCompleteNotification = @"kWeChatPayCompleteNotification";


/*----------------------------------网络提示----------------------------------*/
NSString  * const kNoNetworkTips = @"当前网络不可用,请检查网络设置";


/*----------------------------------网络请求平台key----------------------------------*/
//网络请求不需要平台参数key
NSString  * const kNoTerminalKey = @"noTerminal";


/*-----------------------------NSUserDefaults-----------------------------*/
NSString  * const kLoginStatus = @"kLoginStatus";
NSString  * const kToken = @"kToken";
NSString  * const isLogin = @"loginStatus";
NSString  * const kUserId = @"kUserId";
NSString  * const kDeviceId = @"kDeviceId";
NSString  * const kAccount = @"kAccount";
NSString  * const kPassword = @"kPassword";
NSString  * const kFreeCash = @"kFreeCash";
NSString  * const kMerchantName = @"kMerchantName";
NSString  * const kStoreHouseName = @"kStoreHouseName";
NSString  * const kServicePhone = @"kServicePhone";
NSString  * const kUserType = @"kUserType";


NSString  * const kAreaId = @"kAreaId";

NSString  * const klongitude = @"klongitude";

NSString  * const klatitude = @"klatitude";






