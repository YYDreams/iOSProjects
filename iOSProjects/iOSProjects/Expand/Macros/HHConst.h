#import <UIKit/UIKit.h>



/*----------------------------------购物车数量----------------------------------*/
extern  NSInteger shopCartTotal;

extern NSString *locationStr;


//指示箭头到右边界的距离
UIKIT_EXTERN NSInteger kIndicatorToRightMargin;
/*---------------------------------通知 ---------------------------------*/
UIKIT_EXTERN NSInteger margin;
//监听tabBar的切换
UIKIT_EXTERN NSString * const kTabBarDidSelectedNotification;

//再次购买->购物车
UIKIT_EXTERN NSString * const kageinPayNotification;

//支付 美点余额 - > 我的界面 美点余额 更新
UIKIT_EXTERN NSString * const kMPointUpDataNotification;
//支付完成  -> 刷新购物车列表
UIKIT_EXTERN NSString * const kPayDoneUpDataShopNotification;

//退出账号
UIKIT_EXTERN NSString  * const kLogoutNotification;
//登陆成功
UIKIT_EXTERN NSString  * const kLoginSuccessNotification;

// ali 支付完成通知
UIKIT_EXTERN NSString  * const kAliPayCompleteNotification;
// wechat 支付完成通知
UIKIT_EXTERN NSString  * const kWeChatPayCompleteNotification;

/*----------------------------------网络提示----------------------------------*/
//网络断开的提示语
UIKIT_EXTERN NSString  * const kNoNetworkTips;

/*----------------------------------网络请求平台key----------------------------------*/
//网络请求不需要平台参数key
UIKIT_EXTERN NSString  * const kNoTerminalKey;

/*-----------------------------NSUserDefaults-----------------------------*/

UIKIT_EXTERN NSString  * const kLoginStatus;
UIKIT_EXTERN NSString  * const kToken;
UIKIT_EXTERN NSString  * const isLogin;

UIKIT_EXTERN NSString  * const kUserId;
UIKIT_EXTERN NSString  * const kDeviceId; 

UIKIT_EXTERN NSString  * const kAccount;
UIKIT_EXTERN NSString  * const kPassword;
UIKIT_EXTERN NSString  * const kFreeCash;
UIKIT_EXTERN NSString  * const kMerchantName;
//所属仓库
UIKIT_EXTERN NSString  * const kStoreHouseName;
//客服号码
UIKIT_EXTERN NSString  * const kServicePhone;

UIKIT_EXTERN NSString  * const kUserType;

UIKIT_EXTERN NSString  * const kAreaId;

UIKIT_EXTERN NSString  * const klongitude;

UIKIT_EXTERN NSString  * const klatitude;


/*----------------------------------枚举----------------------------------*/


typedef NS_ENUM(NSInteger,JYOrderType) {
    JYOrderType_all = 0, // 全部
    JYOrderType_pay = 1,//待付款
    JYOrderType_shipping = 2,//待发货
    JYOrderType_goods = 3,//待收货
    JYOrderType_complete = 4,//已完成
};


//header and footer
typedef NS_ENUM(NSUInteger, HHRefreshType) {
    HHRefreshTypeHeader,//只集成头部刷新
    HHRefreshTypeFooter,//只集成底部刷新
    HHRefreshTypeHeaderAndFooter,//集成头部和底部刷新
};


//订单支付方式 0：微信 1：支付宝 2：银行卡 3：美点 4：现结 5：货到付款
typedef enum : NSUInteger {
    JYThirdPayTypeCashSettlement  = 5,//货到付款
    JYThirdPayTypeWechat = 0, //微信
    JYThirdPayTypeAli = 1, //支付宝
    JYThirdPayTypeMPoint = 3 //美点
    
} JYThirdPayType;


typedef NS_ENUM(NSInteger,JYAddressType){ //收货地址
    JYAddressType_MerchantName, //商家名称
    JYAddressType_ReceivingName,//收货人
    JYAddressType_Contactnumber,//收货人电话
    JYAddressType_Address, //收货地址
    JYAddressType_DistributionTime,//配送时间
};
//用户注册类型 1、4都属于B端用户  5属于C端用户
typedef NS_ENUM(NSInteger,JYUserType){
    
    JYUserTypeRestaurant = 1,  //餐饮店
    JYUserTypeCommunity = 4 , //社区店
    JYUserTypeFamily = 5, //家庭用户
    
};


//单例创建
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
