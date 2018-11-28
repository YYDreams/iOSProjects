//
//  SSCViewController.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCViewController.h"
#import "HHNavTitleView.h"

@interface SSCViewController ()
@property(nonatomic, strong)HHNavTitleView *titleView;

@end

@implementation SSCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubView];
    

    self.view.backgroundColor = [UIColor hh_redomColor];
    
}

- (void)setupSubView{
    
    self.navigationItem.titleView = self.titleView;

    
    
}

-(HHNavTitleView *)titleView{
    if (!_titleView) {
        WeakSelf;
        _titleView = [[HHNavTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        [_titleView setType:HHNavTitleViewTypePlayFast title:@"哈哈哈哈哈"];

        _titleView.handlerTitleOnClick = ^(BOOL isSelected ) {
            
            NSLog(@"%d------------",isSelected);
            weakSelf.titleView.isSelected = !isSelected;
            
//            !isSelected ?  [weakSelf.dropDownView show]: [weakSelf.dropDownView  close];
            

        };
    }
    return _titleView;
    
}







@end
