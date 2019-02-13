//
//  HHScrollPageView.m
//  iOSProjects
//
//  Created by funtSui on 2019/2/13.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import "HHScrollPageView.h"
@interface HHScrollPageView()<UIScrollViewDelegate>

/** 标题数组*/
@property(nonatomic,strong)NSArray *titleArray;

/** 控制器类名数组*/
@property(nonatomic,strong)NSArray *controllerClassNameArray;

/** 标题默认颜色*/
@property(nonatomic,strong)UIColor *titleNormalColor;

/** 标题选中颜色*/
@property(nonatomic,strong)UIColor *titleSelectedColor;

/** 选择的下标*/
@property(nonatomic,assign)NSInteger selectedIndex;

/** 当前页面显示的总数量*/
@property(nonatomic,assign)NSInteger total;

/** 父控制器*/
@property (nonatomic,weak) UIViewController *fatherController;

/** 标题滑动视图*/
@property (nonatomic,weak) UIScrollView *titlesView;

/** 滑动视图*/
@property (nonatomic,weak) UIScrollView *scrollView;

/** 标题按钮选中标记*/
@property (nonatomic,weak) UIButton *selectedButton;

/** 选中下标控件*/
@property (nonatomic,weak) UIView *selectedView;

/** 是否被点击数组*/
@property (nonatomic,strong) NSMutableArray *clickArray;

@end

static NSInteger const titlesViewHeight = 40;

@implementation HHScrollPageView
#pragma mark - Init Method
- (instancetype)initWithTitleArray:(NSArray *)titleArray
          controllerClassNameArray:(NSArray *)controllerClassNameArray
                  titleNormalColor:(UIColor *)titleNormalColor
                titleSelectedColor:(UIColor *)titleSelectedColor
                      defaultIndex:(NSInteger)defaultIndex
                             total:(NSInteger)total
                  fatherController:(UIViewController *)fatherController;{
    
    
    if (titleArray.count != controllerClassNameArray.count) {
          NSLog(@"创建的控制器与titleArray数量不一致");
        return nil;
        
    }
    
    if (self = [super init]) {
        
        _titleArray = [titleArray copy];
        _controllerClassNameArray = [controllerClassNameArray copy];
        _titleNormalColor = titleNormalColor;
        _titleSelectedColor = titleSelectedColor;
        if (defaultIndex < 0 || defaultIndex >= titleArray.count) {
            NSLog(@"设置的默认下标不合法, 将被设置为0");

            defaultIndex = 0;
        }
        if (total > titleArray.count) {
            NSLog(@"设置当前显示的数量与总数量不一致,将被设置总数量的一半");
            total = titleArray.count/2;
        }
            
        _selectedIndex = defaultIndex;
        _total = total;
        _fatherController = fatherController;
        [self commonInit];
        
        
    }
    return self;
}
#pragma mark - commonInit Method
- (void)commonInit{
    //关掉自动上移
    _fatherController.automaticallyAdjustsScrollViewInsets = NO;
    //调用懒加载
    self.titlesView.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    
}
- (void)buttonAction:(UIButton *)button{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    self.titlesView.userInteractionEnabled = NO;
    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:0.5];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.selectedView.width = button.titleLabel.width;
        self.selectedView.centerX = button.centerX;
        self.selectedView.backgroundColor = [button titleColorForState:UIControlStateSelected];
    }];
    
    
    //计算按钮和屏幕中间需要的偏移量
    CGFloat offsetX = button.centerX - Screen_Width / 2.0;
    //屏幕左边按钮,重置偏移
    if (offsetX < 0){
        offsetX = 0;
    }else{
        //得到最大偏移量
        CGFloat maxOffsetX = _titlesView.contentSize.width - Screen_Width;
        // 处理最大偏移量
        if (offsetX > maxOffsetX){
            offsetX = maxOffsetX;
        }
    }
    //设置偏移
    [_titlesView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    // 滚动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = (button.tag - 10086) * _scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];



}
#pragma mark - 延迟执行
- (void)changeButtonStatus{
    self.titlesView.userInteractionEnabled = YES;
}

#pragma mark - <UIScrollViewDelegate>
//手动拖拽不会触发
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 当前的按钮所在索引
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    NSNumber *num = _clickArray[index];
    //为0代表没有被点击过，需要创建控制器
    if ([num integerValue] == 0)
    {
        UIViewController *vc = [NSClassFromString(_controllerClassNameArray[index]) new];
        vc.title = self.titleArray[index];
        // 创建控制器
        vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:vc.view];
        //将当前控制器添加到父控制器
        [_fatherController addChildViewController:vc];
        //将被点击按钮标记为1
        [_clickArray replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:1]];
    }
}
#pragma mark - 手动拖拽结束
//通过代码调用滑动时不会触发的
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动拖拽不会触发scrollViewDidEndScrollingAnimation，这里通过代码调用
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self buttonAction:self.titlesView.subviews[index]];
}

#pragma mark - <UIScrollViewDelegate>

#pragma mark - Setter && Getter Methods
- (UIScrollView *)titlesView{
    if (!_titlesView) {
        UIScrollView *titlesView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, titlesViewHeight)];
        titlesView.bounces = NO;
        titlesView.showsVerticalScrollIndicator = NO;
        titlesView.showsHorizontalScrollIndicator = NO;
        [self addSubview:titlesView];
        _titlesView = titlesView;
        _clickArray = [NSMutableArray array];

        //根据标题数组创建标题按钮
        __block UIButton *lastButton;
        //计算文字占用宽度
        __block NSString *string = @"";
        [_titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *s = [string stringByAppendingString:obj];
            string = s;
            if (idx == (_total - 1)) {
                *stop = YES;
            }
        }];
        
        
        CGSize size = [string boundingRectWithSize:CGSizeMake(1000, titlesView.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
        CGFloat padding = MAX((Screen_Width - size.width)/(_total + 1), 10);

        
        [_titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(lastButton.right + padding , 0, 0, titlesView.height);
            [btn setTitle:obj forState:UIControlStateNormal];
            btn.tag = 10086 + idx;
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
            [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn sizeToFit];
            [titlesView addSubview:btn];
            lastButton = btn;
            //将所有按钮都标记为0
            [self->_clickArray addObject:[NSNumber numberWithInteger:0]];

            
        }];
        _titlesView.contentSize = CGSizeMake(lastButton.right + padding, titlesView.height);

        //取出第一个按钮
        //取出选中的按钮
        UIButton *fristButton =   self.titlesView.subviews.firstObject;

        UIView *selectedView = [[UIView alloc]init];
        selectedView.height = 2;
        selectedView.top = titlesView.height - selectedView.height;
        [titlesView addSubview:selectedView];
        self.selectedView = selectedView;
        
        //根据文字内容计算宽高
        [fristButton.titleLabel sizeToFit];

        selectedView.width = fristButton.titleLabel.width;
        selectedView.centerX = fristButton.centerX;
        //默认选中第一个按钮
        [self buttonAction:fristButton];
        
    }
    return _titlesView;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.titlesView.bottom, Screen_Width, Screen_Height - self.titlesView.height)];
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * _controllerClassNameArray.count, 0);
        _scrollView = scrollView;
        // 默认为0 添加第一个控制器的view
        if (_selectedIndex == 0) {
            [self scrollViewDidEndScrollingAnimation:_scrollView];
        }
    }
    return _scrollView;
    
    
}

@end
