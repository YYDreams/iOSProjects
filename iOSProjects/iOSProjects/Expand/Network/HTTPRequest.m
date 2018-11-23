//
//  HTTPRequest.m
//  Headline
//
//  Created by 花花 on 2017/2/14.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager+Config.h"
#import "MBProgressHUD+LYProgressHUD.h"
#import "HTTPRequest+NotLogin.h"
//#import "HTTPRequest+SingleLogin.h"
#import "Reachability.h"


@implementation LYRequestModel

+ (LYRequestModel *)newWithTask:(id)task{
    LYRequestModel * model = [[LYRequestModel alloc]init];
    model.task = task;
    
    return  model;
}

- (BOOL)isFinish{
    NSURLSessionDataTask *task = self.task;
    return task.state == NSURLSessionTaskStateCompleted;
}

- (void)cancel{
    NSURLSessionDataTask *task = self.task;
    [task cancel];
}
@end
#pragma mark - ______________________________________

@implementation HTTPRequest

#pragma mark - 单例
+(AFHTTPSessionManager *)requestManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        
        [manager configSetting];
        
        //申明返回的结果是json类型
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        //申明请求的数据是json类型
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        manager.requestSerializer.HTTPShouldHandleCookies = YES;

        //解决不接受类型为"text/html"
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpeg",@"image/png", nil];
    });
    //检测网络状态的改变
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //                YSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //                YSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //                YSLog(@"3G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //                YSLog(@"WIFI");
                break;
            default:
                break;
        }
    }];
    
    //3.开始监听
    [manager.reachabilityManager startMonitoring];
    return manager;
    
}

+ (BOOL)isNetworkAvailable{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    if (status == ReachableViaWiFi || status == ReachableViaWWAN) {
        return YES;
    }
    return NO;
}


#pragma mark - host管理
+(NSString *)InterfaceUrl:(NSString *)url{
    
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@",MAIN_URL,url];
    
    NSLog(@"urlstring:%@",urlstring);
    
    return urlstring;
    
}

#pragma mark - 网络请求
+ (LYRequestModel *)GET:(NSString *)urlString parameter:(NSDictionary *)parameter success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue{
    
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    
    /**
     错误: HTTPS请求报错Error Code=-999 "cancelled"
     
     Printing description of error:
     Error Domain=NSURLErrorDomain Code=-999 "cancelled" UserInfo={NSErrorFailingURLKey=https://www-api2.tctest2.com/v2/block/condition/capital?type=2, NSLocalizedDescription=cancelled, NSErrorFailingURLStringKey=https://www-api2.tctest2.com/v2/block/condition/capital?type=2}
     
     */
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates =  YES;
    manager.securityPolicy = securityPolicy;
    
    
    //设置请求头
//   [manager.requestSerializer setValue:LH.token forHTTPHeaderField:@"token"];
    [HTTPRequest setCookie];
    //配置公共参数
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    NSLog(@"url:%@,parameter:%@",[HTTPRequest InterfaceUrl:urlString],parameter);
    NSURLSessionDataTask *task = [manager GET:[HTTPRequest InterfaceUrl:urlString] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //---
        NSString *response = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            id dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if ([dic isKindOfClass:[NSArray class]]) {
                dic = [dic firstObject];
            }
                       [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
            return;
        }
        //--
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]])
        {
            
            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }else if (responseObject&&[responseObject isKindOfClass:[NSArray class]])
        {

            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }

        else
        {
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failue];
    }];
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}
/*POST请求*/
+ (LYRequestModel *)POST:(NSString *)urlString  parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue{

    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    //配置公共参数  直接将token放到里面的  后来token作为请求头了
    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
//    [manager.requestSerializer setValue:LH.token forHTTPHeaderField:@"token"];
    [HTTPRequest setCookie];
    [HTTPRequest showActive];
    NSURLSessionDataTask *task = [manager POST:[self InterfaceUrl:urlString] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //---
        NSString *response = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            BOOL isSingle = [HTTPRequest singleLoginWithResult:[responseObject[@"result"] intValue]];
            if (isSingle){
                [HTTPRequest hideActive];
                return;
            }
        [HTTPRequest handelSuccessRequest:task responseObject:dic success:success fail:failue];
            return;
        }
        //--
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]]) {
            //
            BOOL isSingle = [HTTPRequest singleLoginWithResult:[responseObject[@"result"] intValue]];
            if (isSingle){
                [HTTPRequest hideActive];
                return;
            }
            
            
            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }
        else
        {
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failue];
    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

+ (LYRequestModel *)UPLOAD:(NSString *)url uploadParam:(NSDictionary *)uploadParam params:(id)params progress:(void (^)(NSProgress * uploadProgress))progress success:(requestSuccessCallBack)success  failure:(requestErrorCallBack)failure{
    [HTTPRequest showActive];
    
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    //配置公共参数
//    params = [AFHTTPSessionManager configBaseParmars:params];
    
    [HTTPRequest setCookie];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *key in uploadParam.allKeys) {
            [formData appendPartWithFileData:uploadParam[key] name:key fileName:[NSString stringWithFormat:@"%@.jpg",key] mimeType:@"image/jpg"];
        }
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HTTPRequest handelFailRequest:task err:error fail:failure];
    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}


+ (LYRequestModel *)GET:(NSString *)urlString parameter:(NSDictionary *)parameter success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue view:(UIView*)view progressHubShow:(BOOL)show
{
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    [HTTPRequest setCookie];
    //配置公共参数
//    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    
    if (show) [MBProgressHUD LY_ShowHUD:view animation:YES];
    
    NSURLSessionDataTask *task = [manager GET:[HTTPRequest InterfaceUrl:urlString] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (show) [MBProgressHUD LY_HideHUDForView:view];
        
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]])
        {
         
            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }
        else
        {
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (show) [MBProgressHUD LY_HideHUDForView:view];
        [HTTPRequest handelFailRequest:task err:error fail:failue];
    }];
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
}

+ (LYRequestModel *)POST:(NSString *)urlString parameter:(NSDictionary *)parameter  success:(requestSuccessCallBack)success failure:(requestErrorCallBack)failue view:(UIView*)view progressHubShow:(BOOL)show;
{
    AFHTTPSessionManager *manager = [HTTPRequest requestManager];
    [HTTPRequest setCookie];
    [HTTPRequest showActive];
    if (show) [MBProgressHUD LY_ShowHUD:view animation:YES];
    //配置公共参数
//    parameter = [AFHTTPSessionManager configBaseParmars:parameter];
    
    NSURLSessionDataTask *task = [manager POST:[self InterfaceUrl:urlString] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (show) [MBProgressHUD LY_HideHUDForView:view];
        if (responseObject&&[responseObject isKindOfClass:[NSDictionary class]])
        {
          

            [HTTPRequest handelSuccessRequest:task responseObject:responseObject success:success fail:failue];
        }
        else
        {
            NSError * error = [NSError errorWithDomain:@"服务器出错了" code:-100 userInfo:@{@"message":@"服务器返回的不是json或者是空对象"}];
            [HTTPRequest handelFailRequest:task err:error fail:failue];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (show) [MBProgressHUD LY_HideHUDForView:view];
        [HTTPRequest handelFailRequest:task err:error fail:failue];
        
    }];
    
    LYRequestModel *requestModel = [LYRequestModel newWithTask:task];
    return requestModel;
 
}
#pragma mark - 请求处理
+ (void)handelSuccessRequest:(NSURLSessionDataTask * _Nonnull)task responseObject:(id _Nullable)responseObject success:(requestSuccessCallBack)success fail:(requestErrorCallBack)fail{
    [HTTPRequest saveCookie];
    [HTTPRequest setCookie];
    [HTTPRequest hideActive];
    if (success) {
        success(responseObject);
    }
}


+ (void)handelFailRequest:(NSURLSessionDataTask * _Nonnull)task err:(NSError * _Nullable)err fail:(requestErrorCallBack)fail{
    [self hideActive];
    if (fail) {
        fail(err);
    }
}

#pragma mark - 状态栏网络请求图标
+ (void)showActive {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)hideActive {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //  [MBProgressHUD hide];
}


#pragma mark - 公共参数
+ (NSDictionary *)inputPublicParam:(NSDictionary *)param{
    return param;
}

+ (void)outPublicParam:(id)param{
    
}


#pragma mark - saveCookie
+ (void)saveCookie{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:MAIN_URL]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [HTTPRequest setCookie:data];
}

+ (void)setCookie{
    NSData *cookiesdata = [HTTPRequest getCookie];
    
//    NSLog(@"--===Cookie===%@",cookiesdata);
    
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
}

+ (void)removeCookie{
    NSData *cookiesdata = [HTTPRequest getCookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

static NSString *kCookie = @"HHCookie";
+ (void )setCookie:(NSData *)cookie{
    if(cookie == nil){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCookie];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:kCookie];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSData *)getCookie{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCookie];
}

@end
