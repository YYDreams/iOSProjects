
#import <UIKit/UIKit.h>

/*----------------------------------登陆注册----------------------------------*/
//登录
NSString  * const kLoginUrl = @"user/login";

//注册
NSString  * const kRegistUrl = @"user/regist";

//获取短信验证码
NSString  * const kGetSmsCodeUrl = @"user/getSmsCode" ;

//修改/找回 用户密码
NSString  * const kUpdateUserLoginPassUrl = @"user/updateUserLoginPass" ;

//商户收货地址
NSString  * const kUserReceivingAddressUrl = @"user/userReceivingAddress" ;

//添加商户收货地址
NSString  * const kAddUserReceivingAddressUrl = @"user/addUserReceivingAddress";
//C端添加收货地址
NSString  * const kAddCuserReceivingAddress = @"user/addCuserReceivingAddress";

//删除地址 与默认地址
NSString  * const kUpdateAddressStatus = @"user/updateAddressStatus";

//修改收货地址
NSString  * const kUpdateUserRecAddress = @"user/updateUserRecAddress";


//商户退出/注销
NSString  * const kUserExitUrl = @"user/userExit";
//商家信息 ->查询用户区域名称 (即地址)  user/selUserReceivingArea
NSString  * const kSelUserReceivingAreaUrl = @"user/selUserReceivingArea";

/*----------------------------------首页----------------------------------*/
//轮播图URL
NSString  * const kSlideShowUrl = @"activity/slideShow/listF";

//获取商品分类接口
NSString  * const kCategorysUrl = @"goods/category/areaList";

//C端轮播图URL
NSString  * const kSlideShowClistUrl = @"activity/slideShow/cListF";

//C端获取商品分类接口
NSString  * const kCategoryCAreaListUrl = @"goods/category/cAreaList";


//获取商品列表信息
NSString  * const kFrontGoodsUrl = @"goods/front/goods";

//C端接口商品列表
NSString *const kFrontCGoodsUrl = @"goods/front/cGoods";

//批量添加用户常用清单
NSString  * const kAddCommonUserGreensUrl = @"user/addCommonUserGreens";

//完善系统用户信息
NSString  * const kCompleteSysUserinfoUrl = @"user/completeSysUserinfo";

/*----------------------------------常用清单----------------------------------*/
//常用清单
NSString  * const kCommonUserGreensListUrl = @"user/commonUserGreensList";

//删除常用清单
NSString  * const kDeleteCommonUserGreensUrl = @"user/deleteCommonUserGreens";

/*----------------------------------购物车----------------------------------*/

//获得用户购物车里面商品数量
NSString  * const kUserShoppingTrolleyGoodsTotalUrl = @"user/userShoppingTrolleyGoodsTotal";
//用户购物车列表
NSString  * const kUserShoppingTrolleyListUrl = @"user/userShoppingTrolleyList";

//删除用户购物车
NSString  * const kDeleteuserShoppingTrolleyUrl = @"user/deleteUserShoppingTrolley";

//批量添加/修改用户购物车
NSString  * const kAdduserShoppingTrolleyUrl = @"user/addUserShoppingTrolley";

//提交订单 < 购物车结算 后台起的名字>
NSString  * const kConfirmUrl = @"order/order/confirm";

//提交订单C端用户
NSString *const  kOrderclientconfirmUrl = @"order/orderclient/confirm";
//获取用户待补差金额
NSString  * const kUserOrderCompensationUrl = @"order/compensate/userOrderCompensation";

/*----------------------------------我的----------------------------------*/

//检查app更新最新版本
NSString  * const kheckNewestAppVersionUrl = @"user/checkNewestAppVersion";
//获取美点账户信息
NSString  * const kGetaccountUrl = @"user/account/getaccount";
//获取美点流水明细信息列表
NSString  * const kBalanceListUrl = @"user/accountbalance/balanceList";

// 根据用户Id查询用户订单
NSString  * const kGetUserOrdersUrl = @"order/order/getUserOrders";
// C端根据用户Id查询用户订单
NSString  * const kOrderclientGetUserOrdersUrl  = @"order/orderclient/getUserOrders";


/*----------------------------------支付相关----------------------------------*/
//请求支付订单
NSString  * const kPayUrl = @"order/order/pay";

// 查询订单支付状态
NSString  * const kGetPayStatusUrl = @"order/order/getPayStatus";


//根据用户Id查询用户货到付款订单
NSString  * const kUserCollectedOrdersUrl = @"order/order/userCollectedOrders";

//取消订单
NSString  * const kcancelUrl = @"order/order/cancle";


//确认收货
NSString  * const kSignUrl = @"order/order/sign";

//再次购买
NSString  * const kOrdersOneMoreUrl = @"order/shop/ordersOneMore";

// 美点账户充值
NSString  * const kRechargeUrl = @"user/accountRecharge/recharge";

// 获取美点流水明细信息
NSString  * const kBalanceDetailUrl = @"user/accountbalance/balanceDetail";

// 订单评价
NSString  * const kAddEvaluateUrl = @"order/order/addEvaluate";

//支付开关
NSString  * const kGetPaymentsUrl = @"user/getPayments";


//查询C端用户支付开关
NSString  * const kGetCuserPaymentsUrl = @"user/getCuserPayments";

//查询配送时间
NSString  * const kGetUserDeliveryTimeUrl  = @"order/orderclient/getUserDeliveryTime";

// 获取B端用户下单送达时间
NSString  * const kBGetUserDeliveryTimeUrl  = @"/order/order/getUserDeliveryTime";



