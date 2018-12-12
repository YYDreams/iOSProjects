//
//  HHNumbersCell.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHNumbersCell.h"

#import "HHOptionSwithView.h"

#import "HHSelectNumbersView.h"

@interface HHNumbersCell()<UIScrollViewDelegate>

@property(nonatomic,strong)HHOptionSwithView *optionView; //选项卡切换


@property(nonatomic, strong)UIScrollView *scrollView;;


@property(nonatomic,copy)NSArray  *letterArr; //


@end

@implementation HHNumbersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self setupSubView];
        
    }
    
    return self;
    
}

#pragma mark - Custom Methods
-(void)adjustScrollView:(NSInteger)index{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
}


- (void)setupSubView{
    
    [self.contentView addSubview:self.optionView];
    
    [self.contentView addSubview:self.scrollView];
    
    self.optionView.itemsArr = self.letterArr;
    
    for (int i = 0; i < self.letterArr.count ; i++) {
        
        HHSelectNumbersView *view = [[HHSelectNumbersView alloc]initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Width, _scrollView.height)];
        view.backgroundColor =[UIColor hh_redomColor];
        [_scrollView addSubview:view];

        
    }
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];

    
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_optionView setSelectAtIndex:index];
    
    
}


- (HHOptionSwithView *)optionView{

    if (!_optionView) {
        _optionView = [[HHOptionSwithView alloc]initWithFrame:CGRectMake(10, 10, Screen_Width - 2 * 10, 45)];
        WeakSelf;
        _optionView.itemHandlerOnClick = ^(NSInteger index){
            
            [weakSelf adjustScrollView:index];
            
        };
        
    }
    return _optionView;

}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_optionView.frame),Screen_Width,200)];
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * self.letterArr.count, _scrollView.bounds.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.directionalLockEnabled = YES;
    }
    
    return _scrollView;
}
- (NSArray *)letterArr{
    if (!_letterArr) {
        _letterArr = @[@"A",@"B",@"C",@"D",@"E"];
    }
    
    return _letterArr;
}



@end
