//
//  HHDorpDownController.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHDorpDownController.h"
#import "NLDropDown.h"
#import "HHNavTitleView.h"
#import "HHDropDownView.h"
@interface HHDorpDownController ()<NLDropDownDelegate>


@property(nonatomic, strong)HHNavTitleView *titleView;
@property (nonatomic,strong)NLDropDown *dropDownMenue;

@property (nonatomic,strong)HHDropDownView *dropDownView;

@end

@implementation HHDorpDownController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleView;
    
    
    [self.view addSubview:self.dropDownView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        [self.titleView setType:HHNavTitleViewTypePlayFast title:@"哈哈哈哈哈"];
        
//    });
//    [self.dropDownMenue setDropDownWithNavigation:self.navigationController title:nil titlesArr:@[@"基本走势",@"前五走势",@"后五走势",@"龙虎斗"]];

}

- (HHNavTitleView *)titleView{
    if (!_titleView) {
        WeakSelf;
        _titleView = [[HHNavTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        _titleView.handlerTitleOnClick = ^(HHNavTitleView * _Nonnull titleView) {
          
            self.dropDownView.isShow ? [self.dropDownView  close] : [self.dropDownView show];

            
            NSLog(@"-----------------");
            
        };
    }
    return _titleView;
    
}



-(HHDropDownView *)dropDownView{
    if (!_dropDownView) {
        _dropDownView = [[HHDropDownView alloc]initWithFrame:self.view.bounds];

    }
    return _dropDownView;
}











- (NLDropDown *)dropDownMenue{
    if (!_dropDownMenue) {
        NLDropDown *dropDown = [[NLDropDown alloc]init];
        _dropDownMenue = dropDown;
        
        _dropDownMenue.offsetY = self.navigationController.navigationBar.translucent ? 64:0;;
        _dropDownMenue.contentInset = 10;
        _dropDownMenue.eachRowNum = 3;
        _dropDownMenue.cellMargin = 8;
        _dropDownMenue.initSelctedIndex = 0;
        _dropDownMenue.delegate = self;
    }
    return _dropDownMenue;
}

- (void)dropDownMenuedidSelectedItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%zd-----------%zd",indexPath.section,indexPath.row);
}
#pragma mark - setupNav

#pragma mark - setupTableView

#pragma mark - loadDataFromNetwork

#pragma mark - <UITableViewDataSource,UITableViewDelegate>@end

#pragma mark - SEL Methods

#pragma mark - Setter && Getter Methods


@end
