//
//  BaseTableViewController+PageStatus.h
//  LYGame
//
//  Created by 花花 on 2017/7/20.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTableViewController+PageStatus.h"
#import <objc/runtime.h>


static char const * const kCurrentPageStatus = "currentPageStatus";
static char const * const kSucceedEmptyStr  = "succeedEmptyStr";
static char const * const kEmptyViewTapBlock = "emptyViewTapBlock";
static char const * const kSucceedEmptyImage  = "succeedEmptyImage";


@implementation BaseTableViewController (PageStatus)

#pragma mark - life cycle

#pragma mark - private methods

#pragma mark - event response

#pragma mark - UITablViewDelegate

#pragma  mark - DZNEmptyDataSetDelegate
//标题文本，详细描述，富文本样式
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text;
    if (self.currentPageStatus == PageStatusError) {
        text = @"加载失败\n请检查您的当前网络环境";
        
    } else if (self.currentPageStatus == PageStatusSucceed) {
        text =  self.succeedEmptyStr;
//        @"当前暂无商品!";
    }else{
        
        text = @"";
    }

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//空白页图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.currentPageStatus == PageStatusError) {
        return [UIImage imageNamed:@"netError"]; //wifi图片
    } else if (self.currentPageStatus == PageStatusSucceed) {
        
        return self.succeedEmptyImage;
     }
    else {
//        return [UIImage imageNamed:@"pay_loading2"];
        return nil;
    }
}
//按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.currentPageStatus == PageStatusError) {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f],
//                                     NSForegroundColorAttributeName:[UIColor whiteColor]
                                     
                                     };
        return[[NSAttributedString alloc] initWithString:@"重新加载" attributes:attributes];

    }
    else{
        return nil;
    }
}
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667
// 返回可点击按钮的 image
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if (self.currentPageStatus == PageStatusError) {
        
        return  [UIImage imageNamed:@"333"];
    }

    return nil;
}

// 返回自定义 view

//// 标题文字与详情文字同时调整垂直偏移量
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return -30;
//}


//图片的动画效果
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    
    if (self.emptyViewTapBlock) {
        self.emptyViewTapBlock();
    }
}
//空白页点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
    
    if (self.emptyViewTapBlock) {
        self.emptyViewTapBlock();
    }
}
////以自定义
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
//    //加入你自定义的view
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
//}

//- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
//{
//    return self.currentPageStatus == PageStatusLoading;
//}

#pragma mark - DZNEmptyDataSetDelegate Methods
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


#pragma mark - getters / setters

- (void)setCurrentPageStatus:(PageStatus)currentPageStatus
{
    objc_setAssociatedObject(self, kCurrentPageStatus, @(currentPageStatus), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.tableView reloadEmptyDataSet];
}

- (PageStatus)currentPageStatus
{
    return [objc_getAssociatedObject(self, kCurrentPageStatus) integerValue];
}


    
    

- (void)setSucceedEmptyStr:(NSString *)succeedEmptyStr
{
    objc_setAssociatedObject(self, kSucceedEmptyStr, succeedEmptyStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)succeedEmptyStr
{
    return objc_getAssociatedObject(self, kSucceedEmptyStr);
}

- (void)setEmptyViewTapBlock:(EmptyViewTapBlock)emptyViewTapBlock
{
    if (emptyViewTapBlock) {
        objc_setAssociatedObject(self, kEmptyViewTapBlock, emptyViewTapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (EmptyViewTapBlock)emptyViewTapBlock{
    return objc_getAssociatedObject(self, kEmptyViewTapBlock);
}



- (void)setSucceedEmptyImage:(UIImage *)succeedEmptyImage {
    
    objc_setAssociatedObject(self, kSucceedEmptyImage, succeedEmptyImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)succeedEmptyImage {
    
    return objc_getAssociatedObject(self, kSucceedEmptyImage);
}




@end
