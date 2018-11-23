//
//  NLDropDown.h
//  导航栏下拉菜单1
//
//  Created by sensefun on 2017/3/2.
//  Copyright © 2017年 sensefun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIImage+Extension.h"

@protocol NLDropDownDelegate <NSObject>

@optional
// 选择
- (void)dropDownMenuedidSelectedItemAtIndexPath:(NSIndexPath* )indexPath;

// 获取焦点
- (void)dropDownMenuViewDidGetFocus;

@end

@interface NLDropDown : NSObject<UINavigationBarDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak)id<NLDropDownDelegate> delegate;

//设置每行cell个数 默认:3
@property (nonatomic, assign)NSInteger eachRowNum;
//设置cell间距 默认:30
@property (nonatomic, assign)CGFloat cellMargin;
//设置colletionView 边缘间距
@property (nonatomic, assign)CGFloat contentInset;

//@property (nonatomic, copy)NSArray *sectionArr;

//设置下拉菜单垂直方向偏移 默认:64
@property (nonatomic, assign)CGFloat offsetY;

@property (nonatomic,copy)NSString *title;

//cell选中颜色 默认绿色
@property (nonatomic, strong)UIColor *seletctedColor;
//cell选中颜色 默认灰色
@property (nonatomic, strong)UIColor *normarlColor;
//组标题选中颜色 默认灰色
@property (nonatomic,strong)UIColor *sectionTitleColorNormal;
//组标题选中颜色 默认绿色
@property (nonatomic,strong)UIColor *sectionTitleColorSelected;
/*
 cell默认图片
 */
@property (nonatomic,strong)UIImage *cellNormarlImage;
/*
 cell选中图片
 */
@property (nonatomic,strong)UIImage *cellSelctedImage;

/*
 组标题默认图片
 */
@property (nonatomic,strong)UIImage *sectionTitleNormarlImage;
/*
 组标题选中图片
 */
@property (nonatomic,strong)UIImage *sectionTitleSelctedImage;

/*
 默认选中下标
 */
@property (nonatomic,assign)NSInteger initSelctedIndex;
/*
 默认选中
 */
@property (nonatomic,assign)NSInteger initSelctedSection;



/*
 设置标题背景图片
 */
@property (nonatomic,strong)UIImage *titleButtonNormarlImage;
/*
 设置标题背景选中图片
 */
@property (nonatomic,strong)UIImage *titleButtonSelectedImage;

@property (nonatomic,strong) UIButton *titleBtn;

/**
 配置下拉菜单(有导航栏控制器多组)

 @param naviVC 要添加的导航栏
 @param title 标题
 @param titlesArr 标签数组
 @param sectionTitles 组标题
 */
- (void)setDropDownWithNavigation:(UINavigationController *)naviVC title:(NSString *)title titlesArr:(NSArray *)titlesArr sectionTitles:(NSArray *)sectionTitles;


/**
 配置下拉菜单(有导航栏控制器单组)
 
 @param naviVC 要添加的导航栏
 @param title 标题
 @param titlesArr 标签数组
 */
- (void)setDropDownWithNavigation:(UINavigationController *)naviVC title:(NSString *)title titlesArr:(NSArray *)titlesArr;

/**
 配置下拉菜单(无导航栏控制器单组)

 @param navigationBar 要添加的导航栏
 @param title 标题
 @param rootViewController 控制器
 @param titlesArr 标签数组
 */
- (void)setDropDownWithNavigationBar:(UINavigationBar *)navigationBar title:(NSString *)title rootViewController:(__kindof UIViewController *)rootViewController titlesArr:(NSArray *)titlesArr;


/**
 配置下拉菜单
 
 @param navigationBar 要添加的导航栏
 @param title 标题
 @param rootViewController 控制器
 @param titlesArr 标签数组
 */
- (void)setDropDownWithNavigationController:(UINavigationController *)naviVC title:(NSString *)title titlesArr:(NSArray *)titlesArr;



/**
 设置标题

 @param subTitle 
 */
- (void)setSubTitle:(NSString *)subTitle;

//打开
- (void)openMenue;
// 关闭
- (void)closeMenue;


@end


@interface NLDropDownCell : UICollectionViewCell

@property (nonatomic, weak)UIButton *button;

@end



@interface NLTitleButton : UIButton


@end







