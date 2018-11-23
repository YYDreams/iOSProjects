//
//  NLDropDown.m
//  导航栏下拉菜单1
//
//  Created by sensefun on 2017/3/2.
//  Copyright © 2017年 sensefun. All rights reserved.
//

#import "NLDropDown.h"
//#import "FTUIManager.h"

#define NL_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define NL_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NL_CELL_HEIGHT 40.0f

#define NL_SECTIONBUTTON_HEIGHT 32.f

#define NL_TITLE_BUTTON_FONT 17.f

#define NL_CELL_IDENTIFILE @"cellID"

//#define NL_DROP_DOWN_MENU_BACKCOLOR [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]
#define NL_DROP_DOWN_MENU_BACKCOLOR [UIColor whiteColor]

#define BASETAG 555

@interface NLDropDown ()<UICollectionViewDelegate,UICollectionViewDataSource>



@property (nonatomic,strong) UIView *dropDownContentView;

@property (nonatomic,strong) UIButton *backGroundBtn;

@property (nonatomic,weak) UIViewController *rootViewController;

@property (nonatomic, assign)CGFloat cellWidth;

@property (nonatomic, assign)CGFloat contentHeight;

@property (nonatomic, strong)UIButton *lastSelctedButton;

@property (nonatomic, weak)UINavigationBar *navigationBar;

@property (nonatomic, weak)UINavigationController  *navigationController;

@property (nonatomic, weak)UICollectionView  *collectionView;

//设置标签数组
@property (nonatomic, copy)NSArray *titlesArr;

@property (nonatomic, copy)NSArray *currentTitles;

@property (nonatomic, copy)NSArray *sectionTitles;

@end

@implementation NLDropDown{
    NSInteger _currentSectionIndex;
    NSInteger _currentItemIndex;
    NSIndexPath *_currentIndexPath;
    NSIndexPath *_lastIndexPath;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSet];
    }
    return self;
}

- (void)initSet {
    self.cellMargin = 20.0f;
    self.eachRowNum = 3;
    self.offsetY = 64.f;
}

#pragma mark - getter & setter

-(void)setInitSelctedIndex:(NSInteger)initSelctedIndex {
    _initSelctedIndex = initSelctedIndex;
    _currentItemIndex = initSelctedIndex;
    _currentIndexPath = [NSIndexPath indexPathForRow:_currentItemIndex inSection:_currentSectionIndex];
    [self setSubTitle:self.currentTitles[initSelctedIndex]];
}

- (void)setInitSelctedSection:(NSInteger)initSelctedSection
{
    _initSelctedSection = initSelctedSection;
    _currentSectionIndex = initSelctedSection;
    _currentIndexPath = [NSIndexPath indexPathForRow:_currentItemIndex inSection:_currentSectionIndex];
    for (UIView *view in self.dropDownContentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.selected = NO;
        }
    }
    UIButton *button = [self.dropDownContentView viewWithTag:initSelctedSection + BASETAG];
    
    button.selected = YES;
    [self sectionButtonClick:button];
    [self setSubTitle:self.currentTitles[_currentItemIndex]];
}




- (UIColor *)seletctedColor {
    if (!_seletctedColor) {
        _seletctedColor = [UIColor greenColor];
    }
    return _seletctedColor;
}

- (UIColor *)normarlColor {
    if (!_normarlColor) {
        _normarlColor = [UIColor grayColor];
    }
    return _normarlColor;
}

-(UIColor *)sectionTitleColorNormal {
    if (!_sectionTitleColorNormal) {
        _sectionTitleColorNormal = [UIColor grayColor];
    }
    return _sectionTitleColorNormal;
}

-(UIColor *)sectionTitleColorSelected {
    if (!_sectionTitleColorSelected) {
        _sectionTitleColorSelected = [UIColor greenColor];
    }
    return _sectionTitleColorSelected;
}
//
//- (UIImage *)sectionTitleNormarlImage{
//    if (!_sectionTitleNormarlImage) {
//        _sectionTitleNormarlImage = [UIImage imageNamed:@"jczq_mune.png"];
//    }
//    return _sectionTitleNormarlImage;
//}
//
//- (UIImage *)sectionTitleSelctedImage {
//    if (!_sectionTitleSelctedImage) {
//        _sectionTitleSelctedImage = [UIImage imageNamed:@"jczq_mune1.png"];
//    }
//    return _sectionTitleSelctedImage;
//}
//
//- (UIImage *)cellNormarlImage {
//    if (!_cellNormarlImage) {
//        _cellNormarlImage = [UIImage imageNamed:@"jczq_menu00.png"];
//    }
//    return _cellNormarlImage;
//}
//
//- (UIImage *)cellSelctedImage {
//    if (!_cellSelctedImage) {
//        _cellSelctedImage =[UIImage imageNamed:@"jczq_green.png"];
//    }
//    return _cellSelctedImage;
//}

- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [[NLTitleButton alloc]init];
    }
    return _titleBtn;
}

-(void)setTitleButtonNormarlImage:(UIImage *)titleButtonNormarlImage {
    _titleButtonNormarlImage = titleButtonNormarlImage;
    [self.titleBtn setBackgroundImage:_titleButtonNormarlImage forState:UIControlStateNormal];
}

-(void)setTitleButtonSelectedImage:(UIImage *)titleButtonSelectedImage {
    _titleButtonSelectedImage = titleButtonSelectedImage;
    [self.titleBtn setBackgroundImage:_titleButtonSelectedImage forState:UIControlStateSelected];
}

#pragma mark - function

/**
 更新标题

 @param subTitle 子标题
 */
- (void)setSubTitle:(NSString *)subTitle {
    if (!subTitle) {
        return;
    }
    NSString *newTitle;
    if (!_title) {
        newTitle = subTitle;
    }else
    {
        if (self.sectionTitles) {
            newTitle = [NSString stringWithFormat:@"%@-%@-%@ ",_title,_sectionTitles[_currentSectionIndex],subTitle];
        }else{
            newTitle = [NSString stringWithFormat:@"%@-%@ ",_title,subTitle];
        }
    }
    
    
    
    if (self.titleButtonNormarlImage && self.titleButtonSelectedImage) {
        [self.titleBtn setAttributedTitle:nil forState:UIControlStateNormal];
        [self.titleBtn setAttributedTitle:nil forState:UIControlStateSelected];
//        [self.titleBtn setTitle:newTitle forState:UIControlStateNormal];
        
        [self.titleBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:newTitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
        [self.titleBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:newTitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateSelected];
        
        return;
    }
    
    UIImage *nomal = [UIImage imageNamed:@"DropDownArrow.png"];
    UIImage *highLight = [UIImage imageNamed:@"DropDownArrow.png"];
    
    //旋转三角图片
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 14, 9);
    transform = CGAffineTransformRotate(transform, M_PI);
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, 14, 9,
                                             CGImageGetBitsPerComponent(highLight.CGImage), 0,
                                             CGImageGetColorSpace(highLight.CGImage),
                                             CGImageGetBitmapInfo(highLight.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    CGContextDrawImage(ctx, CGRectMake(0,0,14,9), highLight.CGImage);
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    highLight = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    /** 创建标题右侧图片附件 **/
    NSTextAttachment *normalAttachement = [[NSTextAttachment alloc]init];
    normalAttachement.image = nomal;
    
    NSTextAttachment *seletctedAttachement = [[NSTextAttachment alloc]init];
    seletctedAttachement.image = highLight;
    
    normalAttachement.bounds = CGRectMake(8, 2, nomal.size.width, nomal.size.height);
    seletctedAttachement.bounds = CGRectMake(8, 2, highLight.size.width, highLight.size.height);
    /** 设置标题文字 **/
    NSMutableAttributedString *attributedStrNormal = [[NSMutableAttributedString alloc]initWithString:newTitle];
    NSMutableAttributedString *attributedStrSelected = [[NSMutableAttributedString alloc]initWithString:newTitle];
    [attributedStrNormal setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, newTitle.length)];
    [attributedStrSelected setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, newTitle.length)];

    [attributedStrNormal appendAttributedString:[NSAttributedString attributedStringWithAttachment:normalAttachement]];
    [attributedStrSelected appendAttributedString:[NSAttributedString attributedStringWithAttachment:seletctedAttachement]];
    [self.titleBtn setAttributedTitle:attributedStrNormal forState:UIControlStateNormal];
    [self.titleBtn setAttributedTitle:attributedStrSelected forState:UIControlStateSelected];
    
    [self.titleBtn sizeToFit];
    
    self.rootViewController.navigationItem.titleView = self.titleBtn;

}


/**
 配置下拉菜单(无导航栏控制器单组)
 
 @param navigationBar 要添加的导航栏
 @param title 标题
 @param rootViewController 控制器
 @param titlesArr 标签数组
 */
- (void)setDropDownWithNavigationBar:(UINavigationBar *)navigationBar title:(NSString *)title rootViewController:(__kindof UIViewController *)rootViewController titlesArr:(NSArray *)titlesArr
{
    [self setDropDownWithNavigationBar:navigationBar title:title rootViewController:rootViewController titlesArr:titlesArr  sectionTitles:nil];
}


- (void)setDropDownWithNavigationBar:(UINavigationBar *)navigationBar title:(NSString *)title rootViewController:(__kindof UIViewController *)rootViewController titlesArr:(NSArray *)titlesArr sectionTitles:(NSArray *)sectionTitles {
    _title = title;
    self.titlesArr = titlesArr;
    self.sectionTitles = sectionTitles;
    if (self.sectionTitles) {
        self.currentTitles = titlesArr.firstObject;
    }else{
        self.currentTitles = self.titlesArr;
    }
    self.navigationBar = navigationBar;
    self.rootViewController = rootViewController;
    /** 计算菜单高度 **/
    self.contentHeight = [self caculateContentViewHeight];
    /** 设置标题按钮 **/
    
    

    if (self.titleButtonNormarlImage && self.titleButtonSelectedImage) {
        [self.titleBtn setBackgroundImage:_titleButtonNormarlImage forState:UIControlStateNormal];
        [self.titleBtn setBackgroundImage:_titleButtonSelectedImage forState:UIControlStateSelected];
    }
    
    [self setSubTitle:self.currentTitles[_initSelctedIndex]];
    
    
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.titleBtn.titleLabel.font = [UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT];
    
    //self.titleBtn.center = CGPointMake(NL_SCREEN_WIDTH * 0.5, 40);
    
    [self.titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:self.titleBtn];
    
    
    /** 设置菜单 **/
    self.dropDownContentView = [[UIView alloc]initWithFrame:CGRectMake( 0, -_contentHeight, NL_SCREEN_WIDTH, _contentHeight)];
    //    self.dropDownContentView.backgroundColor = [UIColor redColor];
    /** 背景按钮 **/
    UIButton *backGroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NL_SCREEN_WIDTH, NL_SCREEN_HEIGHT)];
    [backGroundBtn addTarget:self action:@selector(backGroundBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backGroundBtn = backGroundBtn;
    [self.backGroundBtn setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.3]];
    [self createCollectionView];
    
    
}

/**
 配置下拉菜单(有导航栏控制器单组)
 
 @param naviVC 要添加的导航栏
 @param title 标题
 @param titlesArr 标签数组
 @param sectionTitles 组标题
 */
- (void)setDropDownWithNavigation:(UINavigationController *)naviVC title:(NSString *)title titlesArr:(NSArray *)titlesArr
{
    [self setDropDownWithNavigation:naviVC title:title titlesArr:titlesArr sectionTitles:nil];
}

/**
 配置下拉菜单(有导航栏控制器多组)
 
 @param naviVC 要添加的导航栏
 @param title 标题
 @param titlesArr 标签数组
 */
- (void)setDropDownWithNavigation:(UINavigationController *)naviVC title:(NSString *)title titlesArr:(NSArray *)titlesArr sectionTitles:(NSArray *)sectionTitles{
    
    _title = title;
    self.titlesArr = titlesArr;
    self.sectionTitles = sectionTitles;
    if (self.sectionTitles) {
        self.currentTitles = titlesArr.firstObject;
    }else{
        self.currentTitles = self.titlesArr;
    }
    self.navigationController = naviVC;
    self.rootViewController = naviVC.topViewController;
//    self.navigationController.delegate = self;
    self.navigationBar = self.navigationController.navigationBar;
    self.contentHeight = [self caculateContentViewHeight];

    /** 设置标题按钮 **/
    
    
    if (self.titleButtonNormarlImage && self.titleButtonSelectedImage) {
        [self.titleBtn setBackgroundImage:_titleButtonNormarlImage forState:UIControlStateNormal];
        [self.titleBtn setBackgroundImage:_titleButtonSelectedImage forState:UIControlStateSelected];
    }
    
    [self setSubTitle:self.currentTitles[_initSelctedIndex]];
    
    
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT];
    [self.titleBtn sizeToFit];
    //self.titleBtn.center = CGPointMake(NL_SCREEN_WIDTH * 0.5, 20);
    
    [self.titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.navigationBar addSubview:self.titleBtn];
    
    self.rootViewController.navigationItem.titleView = self.titleBtn;
    
    
    /** 设置菜单 **/
    self.dropDownContentView = [[UIView alloc]initWithFrame:CGRectMake( 0, -_contentHeight, NL_SCREEN_WIDTH, _contentHeight)];
//    self.dropDownContentView.backgroundColor = [UIColor redColor];
    /** 背景按钮 **/
    UIButton *backGroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NL_SCREEN_WIDTH, NL_SCREEN_HEIGHT)];
    [backGroundBtn addTarget:self action:@selector(backGroundBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backGroundBtn = backGroundBtn;
    [self.backGroundBtn setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.3]];
    [self createCollectionView];
    
}

- (void)setDropDownWithNavigationController:(UINavigationController *)naviVC title:(NSString *)title titlesArr:(NSArray *)titlesArr{
    _title = title;
    self.titlesArr = titlesArr;
    /** 计算菜单高度 **/
    NSInteger rowCount = 0;
    self.navigationController = naviVC;
//    self.navigationController.delegate = self;
    self.navigationBar = self.navigationController.navigationBar;
    
    rowCount = (CGFloat)(self.titlesArr.count - 1) / (CGFloat)_eachRowNum + 1;
    
    //    self.cellWidth = (NL_SCREEN_WIDTH - (_cellMargin * (_eachRowNum + 1)))/ (CGFloat)_eachRowNum;
    self.cellWidth = (NL_SCREEN_WIDTH - self.contentInset * 2 - (self.cellMargin * (self.eachRowNum - 1))) / (CGFloat)self.eachRowNum;
    //    self.contentHeight = (NL_CELL_HEIGHT + _cellMargin) * rowCount + _cellMargin ;
    self.contentHeight = (NL_CELL_HEIGHT + self.cellMargin) * rowCount - self.cellMargin + self.contentInset * 2;
    self.rootViewController = naviVC.topViewController;
    
    /** 设置标题按钮 **/
    
    
    if (self.titleButtonNormarlImage && self.titleButtonSelectedImage) {
        [self.titleBtn setBackgroundImage:_titleButtonNormarlImage forState:UIControlStateNormal];
        [self.titleBtn setBackgroundImage:_titleButtonSelectedImage forState:UIControlStateSelected];
    }
    
    [self setSubTitle:self.titlesArr[_initSelctedIndex]];
    
    
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont systemFontOfSize:NL_TITLE_BUTTON_FONT];
    [self.titleBtn sizeToFit];
   // self.titleBtn.center = CGPointMake(NL_SCREEN_WIDTH * 0.5, 20);
    
    [self.titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationBar addSubview:self.titleBtn];
    self.navigationController.navigationItem.titleView = self.titleBtn;
    
    
    /** 设置菜单 **/
    self.dropDownContentView = [[UIView alloc]initWithFrame:CGRectMake( 0, -_contentHeight, NL_SCREEN_WIDTH, _contentHeight)];
    self.dropDownContentView.backgroundColor = [UIColor clearColor];
    /** 背景按钮 **/
    UIButton *backGroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, NL_SCREEN_WIDTH, NL_SCREEN_HEIGHT)];
    [backGroundBtn addTarget:self action:@selector(backGroundBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.backGroundBtn = backGroundBtn;
    [self.backGroundBtn setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.3]];
    [self createCollectionView];
}

/**
 计算菜单高度

 @return 菜单高度
 */
- (CGFloat)caculateContentViewHeight
{
    CGFloat sectionTitleHeight = self.sectionTitles? NL_SECTIONBUTTON_HEIGHT : 0;
    
    /** 计算菜单高度 **/
    NSInteger rowCount = 0;
    
    
    
    rowCount = (CGFloat)(self.currentTitles.count - 1) / (CGFloat)_eachRowNum + 1;
    
    //    self.cellWidth = (NL_SCREEN_WIDTH - (_cellMargin * (_eachRowNum + 1)))/ (CGFloat)_eachRowNum;
    self.cellWidth = (NL_SCREEN_WIDTH - self.contentInset * 2 - (self.cellMargin * (self.eachRowNum - 1))) / (CGFloat)self.eachRowNum;
    //    self.contentHeight = (NL_CELL_HEIGHT + _cellMargin) * rowCount + _cellMargin ;
    return (NL_CELL_HEIGHT + self.cellMargin) * rowCount - self.cellMargin + self.contentInset * 2 + sectionTitleHeight;
}

/**
 创建collectionview
 */
- (void)createCollectionView {
    
    CGFloat sectionButtonHeight = 0;
    // 如有组标题,添加组
    if (self.sectionTitles) {
        sectionButtonHeight = NL_SECTIONBUTTON_HEIGHT;
        CGFloat sectionButtonWidth = NL_SCREEN_WIDTH/self.sectionTitles.count;
        for (int i = 0; i < self.titlesArr.count; i++) {
            UIButton *sectionButton = [[UIButton alloc]init];
            [sectionButton setBackgroundImage:self.sectionTitleNormarlImage forState:UIControlStateNormal];
            [sectionButton setBackgroundImage:self.sectionTitleSelctedImage forState:UIControlStateSelected];
            [sectionButton setBackgroundImage:self.sectionTitleNormarlImage forState:UIControlStateHighlighted];
            [sectionButton setTitle:self.sectionTitles[i] forState:UIControlStateNormal];
            [sectionButton setTitleColor:self.sectionTitleColorNormal forState:UIControlStateNormal];
            [sectionButton setTitleColor:self.sectionTitleColorSelected forState:UIControlStateSelected];
            [sectionButton addTarget:self action:@selector(sectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [sectionButton setTag:i + BASETAG];
            sectionButton.frame = CGRectMake(sectionButtonWidth *i, 0, sectionButtonWidth, NL_SECTIONBUTTON_HEIGHT);
            if (_initSelctedSection == i) {
                sectionButton.selected = YES;
                self.currentTitles = self.titlesArr[_initSelctedSection];
            }
            [self.dropDownContentView addSubview:sectionButton];
        }
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(_cellWidth, NL_CELL_HEIGHT);
    flowLayout.minimumLineSpacing = _cellMargin;
    flowLayout.minimumInteritemSpacing = _cellMargin;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, sectionButtonHeight, self.dropDownContentView.frame.size.width, self.dropDownContentView.frame.size.height - sectionButtonHeight) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = NL_DROP_DOWN_MENU_BACKCOLOR;
    collectionView.bounces = NO;
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentInset = UIEdgeInsetsMake(self.contentInset, self.contentInset, self.contentInset, self.contentInset);
    
    [collectionView registerClass:[NLDropDownCell class] forCellWithReuseIdentifier:NL_CELL_IDENTIFILE];
    
    [self.dropDownContentView addSubview:collectionView];
    
}

// 关闭
- (void)close
{
    self.titleBtn.selected = YES;
    [self titleBtnClick:self.titleBtn];
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NLDropDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NL_CELL_IDENTIFILE forIndexPath:indexPath];
    /** 设置cell选中图片 **/
//    if (self.cellNormarlImage ) {
//        [cell.button setBackgroundImage:self.cellNormarlImage forState:UIControlStateNormal];
//    }
//    if (self.cellSelctedImage) {
//        [cell.button setBackgroundImage:self.cellSelctedImage forState:UIControlStateSelected];
//    }
    /** 设置cell文字 **/
    [cell.button setTitle:self.currentTitles[indexPath.row] forState:UIControlStateNormal];
    [cell.button setTitle:self.currentTitles[indexPath.row] forState:UIControlStateSelected];
////    /** 设置cell文字颜色 **/
//    [cell.button setTitleColor:self.seletctedColor forState:UIControlStateSelected];
//    [cell.button setTitleColor:self.normarlColor forState:UIControlStateNormal];
//    if ([self.currentTitles[indexPath.row] length] > 8) {
//        cell.button.titleLabel.font = [UIFont systemFontOfSize:13];
//    }else
//    {
//        cell.button.titleLabel.font = [UIFont systemFontOfSize:15];
//    }
    
//    [cell.button setSportteryButtonStyle];
    /** 设置初始选中 **/
//    if (_currentItemIndex == indexPath.row) {
//        cell.button.selected = YES;
//        self.lastSelctedButton = cell.button;
//    }else {
//        cell.button.selected = NO;
//    }
//    
//    if (_currentSectionIndex == _currentIndexPath.section && indexPath.row == _currentItemIndex) {
//        cell.button.selected = YES;
//        self.lastSelctedButton = cell.button;
//    }else {
//        cell.button.selected = NO;
//    }
    
    return cell;
}



#pragma mark - UICollectionViewDelegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:collectionView.indexPathsForSelectedItems.firstObject animated:NO];
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:_currentSectionIndex];
    
    
    NLDropDownCell *cell = (NLDropDownCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_currentIndexPath != newIndexPath) {
        
//        _lastSelctedButton.selected = NO;
        _lastSelctedButton = cell.button;
//        cell.button.selected = !cell.button.selected;
        /** 根据选中cell更新标题 **/
        [self setSubTitle:self.currentTitles[indexPath.row]];
        if ([self.delegate respondsToSelector:@selector(dropDownMenuedidSelectedItemAtIndexPath:)]) {
            [self.delegate dropDownMenuedidSelectedItemAtIndexPath:newIndexPath];
        }
        
    }
    _currentItemIndex = indexPath.row;
    _currentIndexPath = newIndexPath;
    /** 隐藏菜单 **/
    [self titleBtnClick:self.titleBtn];
    
}

#pragma mark - ButtonAction

/**
 组标题选中事件
 */
- (void)sectionButtonClick:(UIButton *)sender
{
    for (UIView *view in self.dropDownContentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.selected = NO;
        }
    }
    sender.selected = YES;
    _currentSectionIndex = sender.tag - BASETAG;
    _currentTitles = [self.titlesArr objectAtIndex:_currentSectionIndex];
    
    self.contentHeight = [self caculateContentViewHeight];
    [UIView animateWithDuration:0.25 animations:^{
        self.dropDownContentView.frame = CGRectMake( 0, _offsetY, NL_SCREEN_WIDTH, _contentHeight);
        self.collectionView.frame = CGRectMake(0, NL_SECTIONBUTTON_HEIGHT, NL_SCREEN_WIDTH, _contentHeight - NL_SECTIONBUTTON_HEIGHT);
    }];
    
    
    [self.collectionView reloadData];
}

/**
 标题栏点击事件
 
 @param sender 标题按钮
 */
- (void)titleBtnClick:(UIButton *)sender {
    
    BOOL selected = !sender.selected;
    
    if (selected == YES) {
        [self openMenue];
    }else {
        [self closeMenue];
    }
    
    if ([self.delegate respondsToSelector:@selector(dropDownMenuViewDidGetFocus)]) {
        
        [self.delegate dropDownMenuViewDidGetFocus];
    }
}


/**
 打开菜单
 */
- (void)openMenue {
    UINavigationBar *navigationBar;
    if (self.navigationBar == nil) {
        navigationBar = self.rootViewController.navigationController.navigationBar;
    }else {
        navigationBar = self.navigationBar;
    }
    [self.rootViewController.view insertSubview:self.backGroundBtn belowSubview:navigationBar];
    [self.rootViewController.view insertSubview:self.dropDownContentView belowSubview:navigationBar];
    self.titleBtn.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.dropDownContentView.frame;
        frame.origin.y = self.offsetY;
        self.dropDownContentView.frame = frame;
        self.backGroundBtn.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.titleBtn.enabled = YES;
        self.titleBtn.selected = YES;
    }];
}


/**
 关闭菜单
 */
- (void)closeMenue {
    self.titleBtn.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.dropDownContentView.frame;
        frame.origin.y = -self.contentHeight;
        self.dropDownContentView.frame = frame;
        self.backGroundBtn.alpha = 0;
    } completion:^(BOOL finished) {
        self.titleBtn.enabled = YES;
        [self.backGroundBtn removeFromSuperview];
        [self.dropDownContentView removeFromSuperview];
        self.titleBtn.selected = NO;
    }];
}


- (void)backGroundBtnAction:(UIButton *)sender {
    [self titleBtnClick:self.titleBtn];
}


@end


@implementation NLDropDownCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIButton *button = [[UIButton alloc]initWithFrame:self.contentView.frame];
    button.userInteractionEnabled = NO;
    self.button = button;
    UIColor *mainColor = kThemeColor;
    [self.button setTitleColor:mainColor forState:UIControlStateNormal];
    UIImage *normalImage = [NLDropDownCell imageWithColor:[UIColor whiteColor] cornerRidus:4 rect:self.contentView.bounds boardColor:mainColor];
    [self.button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    UIImage *selectedImage = [NLDropDownCell imageWithColor:mainColor cornerRidus:4 rect:self.contentView.bounds boardColor:[UIColor whiteColor]];
    [self.button setBackgroundImage:selectedImage forState:UIControlStateSelected];
    
    [self.contentView addSubview:button];
    
}
+ (UIImage *)imageWithColor:(UIColor *)color cornerRidus:(CGFloat)cornerRidus rect:(CGRect)rect boardColor:(UIColor*)boardColor
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRidus, cornerRidus)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    
    
    [layer setAnchorPoint:CGPointMake(0, 0)];
    
    
    
    layer.bounds = rect;
    layer.path = bezier.CGPath;
    layer.fillColor = color.CGColor;
    layer.strokeColor = boardColor.CGColor;
    layer.backgroundColor = color.CGColor;
    
    if (boardColor) {
        layer.masksToBounds = YES;
        layer.cornerRadius = cornerRidus;
        layer.borderColor = boardColor.CGColor;
        layer.borderWidth = 1/[UIScreen mainScreen].scale;
    }
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _button.selected = selected;
}


@end

@implementation NLTitleButton

- (void)layoutSubviews{
    [super layoutSubviews];
    if ([[[UIDevice currentDevice] systemVersion]floatValue] >= 11.0) {
        CGRect frame = self.titleLabel.frame;
        frame.size.width += 20;
        self.titleLabel.frame = frame;
    }
    else
    {
        self.center = CGPointMake(self.superview.center.x, self.center.y);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width + 20, self.bounds.size.height);
    }

}

@end
