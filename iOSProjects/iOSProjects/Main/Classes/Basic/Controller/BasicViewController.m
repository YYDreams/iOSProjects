//
//  BasicViewController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BasicViewController.h"
#import "BaseCell.h"
@interface BasicViewController ()

@property(nonatomic,strong)NSArray *nsDataArr;

@property(nonatomic,strong)NSArray *uiDataArr;

@property(nonatomic,strong)NSArray *viewControllers;

@property(nonatomic,strong)NSMutableArray *sectionDataArr;

@property(nonatomic,strong)NSArray *detailDataArr;

@end

@implementation BasicViewController


/**
 NS
 NSString
 NSArray
 NSDictionary
 
 
 UI
 UILabel
 UIButton
 
 
 */
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = kTableView_rowHeight;
    

}

#pragma mark - setupNav

#pragma mark - setupTableView

#pragma mark - loadDataFromNetwork

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section? self.uiDataArr.count : self.nsDataArr.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    

    return [NSString stringWithFormat:@" %@",[@[@"NS",@"UI"] safeObjectAtIndex:section]];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseCell *cell = [BaseCell cellWithTableView:tableView cellID:@"cellID" style:UITableViewCellStyleSubtitle];
    cell.textLabel.text = indexPath.section?[self.uiDataArr safeObjectAtIndex:indexPath.row]: [self.nsDataArr safeObjectAtIndex:indexPath.row];
    cell.detailTextLabel.text= indexPath.section?[self.detailDataArr[1] safeObjectAtIndex:indexPath.row]:[self.detailDataArr[0] safeObjectAtIndex:indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *className = indexPath.section?[self.viewControllers[1] safeObjectAtIndex:indexPath.row]:[self.viewControllers[0] safeObjectAtIndex:indexPath.row];

    [self.navigationController pushViewController:[[NSClassFromString(className) alloc] init] animated:YES];
    
}


#pragma mark - Setter && Getter Methods
- (NSArray *)nsDataArr{
    
    if (!_nsDataArr) {
        _nsDataArr = @[@"字符串(NSString)",@"字典(NSDictionary+NSMutableDictionary)",@"数组(NSArray+NSMutableArray)"];
    }
    
    return _nsDataArr;
}


- (NSArray *)uiDataArr{
    
    if (!_uiDataArr) {
        _uiDataArr = @[@"UILabel",@"UIButton",@"",@"UITextField",@"UITextView"];
    }
    
    
    return _uiDataArr;
    
    
    
}
- (NSArray *)detailDataArr{
    
    if (!_detailDataArr) {
        _detailDataArr = @[
                            @[@"字符串截取/拼接/替换/比较/分割/大小写转换/遍历/字符串转数组",@"",@""],
                           @[@"",@"",@"",@""],
                           ];
    }
    return _detailDataArr;
}
- (NSArray *)viewControllers{
    
    if (!_viewControllers) {
        _viewControllers = @[
                             @[@"",@"",@""],
                             @[@"",@"",@"",@"HHTextFieldController",@"HHTextViewController"]
                             ];
    }
    return  _viewControllers;
}



@end
