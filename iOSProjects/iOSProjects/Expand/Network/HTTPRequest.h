//
//  HTTPRequest.h
//  Headline
//
//  Created by 花花 on 2017/2/14.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface LYRequestModel : NSObject
@property (nonatomic, strong) id task;
@property(assign,nonatomic)BOOL isJsonRequest;//YES: 申明请求的数据是json类型 NO:反之
+ (LYRequestModel *)newWithTask:(id)task;
- (BOOL)isFinish;
- (void)cancel;

@end

//请求成功回调
typedef void(^requestSuccessCallBack)(id resposeObject);
//请求失败回调
typedef void(^requestErrorCallBack)(NSError *error);

@interface HTTPRequest : NSObject


//移除cookie
+ (void)removeCookie;
//保存cookie
+ (void)saveCookie;
//设置cookie
+ (void)setCookie;
//拼接地址
+(NSString *)InterfaceUrl:(NSString *)url;
//是否有网络
+ (BOOL)isNetworkAvailable;

/** @param urlString url地址
 *  @param parameter 参数
 *  @param success   成功回调
 *  @param failue    失败回调
 *
 */

/*GET请求*/
+ (LYRequestModel *)GET:(NSString *)urlString parameter:(NSDictionary *)parameter success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue;

/*POST请求*/
+ (LYRequestModel *)POST:(NSString *)urlString  parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue;

/*POST请求*/
+ (LYRequestModel *)UPLOAD:(NSString *)url uploadParam:(NSDictionary *)uploadParam params:(id)params progress:(void (^)(NSProgress * uploadProgress))progress success:(requestSuccessCallBack)success  failure:(requestErrorCallBack)failure;

/**
 GET请求
 @param urlString 请求地址
 @param parameter 请求参数
 @param success 请求成功的回调
 @param failue 请求失败的回调
 @param view 当前视图
 @param show 是否显示加载菊花
 @return 请求对象
 */
+ (LYRequestModel *)GET:(NSString *)urlString parameter:(NSDictionary *)parameter success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue view:(UIView*)view progressHubShow:(BOOL)show;


/*!
 Post 请求 参数解释同Post
 @param urlString <#urlString description#>
 @param parameter <#parameter description#>
 @param success <#success description#>
 @param failue <#failue description#>
 @param view <#view description#>
 @param show <#show description#>
 @return <#return value description#>
 */
+ (LYRequestModel *)POST:(NSString *)urlString parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue view:(UIView*)view progressHubShow:(BOOL)show;
@end
