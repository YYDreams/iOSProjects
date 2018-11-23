//
//  HHDorpDownController.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHDorpDownController.h"
#import "NLDropDown.h"
@interface HHDorpDownController ()<NLDropDownDelegate>
@property (nonatomic,strong)NLDropDown *dropDownMenue;

@end

@implementation HHDorpDownController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.dropDownMenue setDropDownWithNavigation:self.navigationController title:nil titlesArr:@[@"基本走势",@"前五走势",@"后五走势",@"龙虎斗"]];

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
