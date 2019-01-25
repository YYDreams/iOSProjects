//
//  UserModel.h
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic , copy) NSString              * token;
@property (nonatomic , copy) NSString              * account;
@property (nonatomic , copy) NSString              * headImg;
@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * userType;
@property (nonatomic , copy) NSString              * mobile;


@end
