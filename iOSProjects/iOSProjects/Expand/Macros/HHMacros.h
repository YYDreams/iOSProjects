


#ifndef HHMacros_h
#define HHMacros_h


/*--------------------------------------------------------------------*/

#define Screen_Bounds [UIScreen mainScreen].bounds
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#define Screen_Width [UIScreen mainScreen].bounds.size.width

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
/**
 非iPhone X ：
 StatusBar 高20px，NavigationBar 高44px，底部TabBar高49px
 iPhone X：
 StatusBar 高44px，NavigationBar 高44px，底部TabBar高83px
 */
#define kStatusHeight (iPhoneX ? 20.f : 0.f)
// 导航栏高度
#define kNavHeight (iPhoneX ? 85.f : 64.f)
// tabBar高度
#define kTabBarHeight (iPhoneX ? (49.f+34.f) : 49.f)



/*----------------------------------存储个人信息----------------------------------*/
#define UserDataFilePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.plist"])

/*----------------------------------URL 相关----------------------------------*/

// 正式环境https://www-api2.tctest2.com
//#define MAIN_URL @"http://api.front.jinyoufarm.com/api"
//测试环境
//#define MAIN_URL @"http://www.mocky.io/v2"
#define MAIN_URL @"https://www-api2.tctest2.com"

//https://www-api2.tctest0.com/v2/block/lottery/app/last?page=1&page_size=20

#define  Success [resposeObject[@"code"] isEqualToString:@"200"]
#define  Success [resposeObject[@"code"] isEqualToString:@"200"]


/*----------------------------------账号 相关----------------------------------*/


/*----------------------------------function 相关----------------------------------*/
// 设置view圆角
#define kViewRadius(view, radius)\
\
[view.layer setCornerRadius:(radius)];\
[view.layer setMasksToBounds:YES]

//默认占位图片
#define defaultPlaceholderImage [UIImage imageNamed:@"placeholderImage"]
// 系统字体大小定义  在iPhone4~6中，缩放因子scale=2；在iPhone6+中，缩放因子scale=3
#define kFont(F)  [UIFont systemFontOfSize:(F *([UIScreen mainScreen].scale) / 2)]

// 用于生成weakSelf
//#define WeakSelf(weakSelf)                          __weak typeof(&*self) weakSelf = self;
//#define kWeakSelf(type)                             __weak typeof(type) weak##type = type;
//#define kStrongSelf(type)                           __strong typeof(type) type = weak##type;

#define WeakSelf __weak typeof(self) weakSelf = self


//打印
#if DEBUG
#define NSLog(fmt,...) NSLog((@"%s [Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define NSLog(...)
#endif


/*----------------------------------color 相关----------------------------------*/

//背景色
#define kBgColor [UIColor colorWithHexString:@"F2F2F2"]
//主色 浅蓝色  如导航栏、商品按钮
#define kThemeColor   [UIColor colorWithHexString:@"62C6B2"]
//辅色 红色  如价格、删除
#define kRedColor   [UIColor colorWithHexString:@"FB483E"]
//辅色 蓝色 如我的页面图标
#define kBlueColor   [UIColor colorWithHexString:@"39A1ED"]

//文字  黑色 如导航、标题、正文
#define k3Color   [UIColor colorWithHexString:@"333333"]
//文字   浅灰色  如提示、正文
#define k6Color   [UIColor colorWithHexString:@"666666"]
//文字 浅灰色 如提示、正文
#define k9Color   [UIColor colorWithHexString:@"999999"]
//文字  白色
#define kfColor   [UIColor colorWithHexString:@"ffffff"]
//分割线颜色
#define kSeparatedLineColor   [UIColor colorWithHexString:@"DCDDDD"]

//浅灰色
#define kf2Color   [UIColor colorWithHexString:@"F2F2F2"]


/*----------------------------------常量 相关----------------------------------*/

//全局tableView 行高
#define kTableView_rowHeight 44
//全局tableView 文字字体
#define kTableView_textFont 14
//全局按钮高度
#define kGlobalButtonHeight 44

//获取验证码的时间
#define kGlobalGetVaildCodeTime 60
//全局按钮的高度
#define kBtnHeight  44

#endif
