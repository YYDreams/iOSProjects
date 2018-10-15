//
//  AppDelegate+Config.m
//  HHToolCategory
//
//  Created by Mac on 2018/8/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppDelegate+Config.h"
#import <GHConsole.h>
@implementation AppDelegate (Config)

- (void)configConsoleLog{
    
    [[GHConsole sharedConsole]startPrintLog];
}
@end
