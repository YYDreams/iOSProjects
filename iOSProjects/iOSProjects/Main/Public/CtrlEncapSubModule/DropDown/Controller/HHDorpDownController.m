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
    [self.titleView setType:HHNavTitleViewTypeNormal title:@"哈哈哈哈哈"];
    
    //    [self.dropDownMenue setDropDownWithNavigation:self.navigationController title:nil titlesArr:@[@"基本走势",@"前五走势",@"后五走势",@"龙虎斗"] sectionTitles:@[@"dda",@"dada"]];
    
    //    [self.dropDownMenue setDropDownWithNavigation:self.navigationController title:nil titlesArr:@[@"基本走势",@"前五走势",@"后五走势",@"龙虎斗"]];
    
}

- (HHNavTitleView *)titleView{
    if (!_titleView) {
        WeakSelf;
        _titleView = [[HHNavTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        
        _titleView.handlerTitleOnClick = ^(BOOL isSelected ) {
            
            NSLog(@"%d------------",isSelected);
            weakSelf.titleView.isSelected = !isSelected;
            
            !isSelected ?  [weakSelf.dropDownView show]: [weakSelf.dropDownView  close];
            
//             [weakSelf.dropDownView setdataArr:nil standardArray:nil fastArray:nil];
            [weakSelf.dropDownView setdataArr:@[@"基本走势",@"前五走势",@"后五走势",@"xxx",@"DDAD"] standardArray:nil fastArray:nil];
            
//            [weakSelf.dropDownView setdataArr:nil standardArray:@[@"基本走势",@"前五走势",@"后五走势",@"xxx",@"DDAD"] fastArray:nil];
//            [weakSelf.dropDownView setdataArr:nil standardArray:nil fastArray:@[@"基本走势",@"前五走势",@"后五走势"]];
//             [weakSelf.dropDownView setdataArr:nil standardArray:@[@"基本走势",@"前五走势",@"后五走势",@"大大大",@"dadae",@"dadafsdff",@"dsfsdf"] fastArray:@[@"xx",@"xxx",@"xxxx",@"xxxxxxx",@"dadadweeeeweweew"]];

//            
//            [weakSelf.dropDownView setStandardMehtods:@[@"基本走势",@"前五走势",@"后五走势",@"龙虎斗",@"基本走势",@"前五走势",@"后五走势",@"龙虎斗",@"基本走势",@"前五走势",@"后五走势",@"龙虎斗",@"基本走势",@"前五走势",@"后五走势",@"龙虎斗"] fastMethods:nil];
//            
            
        };
    }
    return _titleView;
    
}

-(HHDropDownView *)dropDownView{
    if (!_dropDownView) {
        _dropDownView = [[HHDropDownView alloc]initWithFrame:self.view.bounds rootView:self.view];
        [self.view addSubview:_dropDownView];
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
