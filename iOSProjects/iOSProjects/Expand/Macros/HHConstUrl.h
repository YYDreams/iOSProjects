#import <UIKit/UIKit.h>


/*----------------------------------登陆注册----------------------------------*/
//登录
UIKIT_EXTERN NSString  * const kLoginUrl;
//注册
UIKIT_EXTERN NSString  * const kRegistUrl;

//获取短信验证码
UIKIT_EXTERN NSString  * const kGetSmsCodeUrl;

//修改/找回 用户密码
UIKIT_EXTERN NSString  * const kUpdateUserLoginPassUrl;

//商户收货地址
UIKIT_EXTERN NSString  * const kUserReceivingAddressUrl;

//添加商户收货地址
UIKIT_EXTERN NSString  * const kAddUserReceivingAddressUrl;

//C端添加收货地址
UIKIT_EXTERN NSString  * const kAddCuserReceivingAddress;




//删除地址 与默认地址
UIKIT_EXTERN NSString  * const kUpdateAddressStatus;

//修改收货地址
UIKIT_EXTERN NSString  * const kUpdateUserRecAddress;

//商户退出/注销
UIKIT_EXTERN NSString  * const kUserExitUrl;

//商家信息 ->查询用户区域名称 (即地址)
UIKIT_EXTERN NSString  * const kSelUserReceivingAreaUrl;

/*----------------------------------首页----------------------------------*/
//获取商品列表信息
UIKIT_EXTERN NSString  * const kFrontGoodsUrl;
//C端接口商品列表
UIKIT_EXTERN NSString  *const kFrontCGoodsUrl;

//轮播图URL
UIKIT_EXTERN NSString  * const kSlideShowUrl;

//获取商品分类接口
UIKIT_EXTERN NSString  * const kCategorysUrl;


//C端轮播图URL
UIKIT_EXTERN NSString  * const kSlideShowClistUrl;

//C端获取商品分类接口
UIKIT_EXTERN NSString  * const kCategoryCAreaListUrl;



//批量添加用户常用清单
UIKIT_EXTERN NSString  * const kAddCommonUserGreensUrl;
////C端才要调 完善系统用户信息
UIKIT_EXTERN NSString *const kCompleteSysUserinfoUrl;

/*----------------------------------常用清单----------------------------------*/

//常用清单
UIKIT_EXTERN NSString  * const kCommonUserGreensListUrl;

//删除常用清单
UIKIT_EXTERN NSString  * const kDeleteCommonUserGreensUrl;

/*----------------------------------购物车----------------------------------*/


//获得用户购物车里面商品数量
UIKIT_EXTERN NSString  * const kUserShoppingTrolleyGoodsTotalUrl;

//用户购物车列表
UIKIT_EXTERN NSString  * const kUserShoppingTrolleyListUrl;

//删除用户购物车
UIKIT_EXTERN NSString  * const kDeleteuserShoppingTrolleyUrl;

//批量添加/修改用户购物车
UIKIT_EXTERN NSString  * const kAdduserShoppingTrolleyUrl;

//提交订单 < 购物车结算 后台起的名字>
UIKIT_EXTERN NSString  * const kConfirmUrl;

//提交订单C端用户
UIKIT_EXTERN NSString  * const  kOrderclientconfirmUrl;
//获取用户待补差金额
UIKIT_EXTERN NSString  * const kUserOrderCompensationUrl;


/*----------------------------------我的----------------------------------*/

//检查app更新最新版本
UIKIT_EXTERN NSString  * const kheckNewestAppVersionUrl;

//获取美点账户信息
UIKIT_EXTERN NSString  * const kGetaccountUrl;
//获取美点流水明细信息列表
UIKIT_EXTERN NSString  * const kBalanceListUrl;

// 根据用户Id查询用户订单
UIKIT_EXTERN NSString  * const kGetUserOrdersUrl;

// C端根据用户Id查询用户订单
UIKIT_EXTERN NSString  * const kOrderclientGetUserOrdersUrl;


/*---------------------------------支付相关----------------------------------*/

//请求支付订单
UIKIT_EXTERN NSString  * const kPayUrl;
// 查询订单支付状态
UIKIT_EXTERN NSString  * const kGetPayStatusUrl;

//根据用户Id查询用户货到付款订单
UIKIT_EXTERN NSString  * const kUserCollectedOrdersUrl;

//取消订单
UIKIT_EXTERN NSString  * const kcancelUrl;

//确认收货
UIKIT_EXTERN NSString  * const kSignUrl;

//再次购买
UIKIT_EXTERN NSString  * const kOrdersOneMoreUrl;
// 美点账户充值
UIKIT_EXTERN NSString  * const kRechargeUrl;

// 获取美点流水明细信息
UIKIT_EXTERN NSString  * const kBalanceDetailUrl;
// 订单评价
UIKIT_EXTERN NSString  * const kAddEvaluateUrl;

//支付开关
UIKIT_EXTERN NSString  * const kGetPaymentsUrl;


//查询C端用户支付开关
UIKIT_EXTERN NSString  * const kGetCuserPaymentsUrl;

//C获取用户下单送达时间
UIKIT_EXTERN NSString  * const kGetUserDeliveryTimeUrl;


// 获取B端用户下单送达时间
UIKIT_EXTERN NSString  * const kBGetUserDeliveryTimeUrl;
