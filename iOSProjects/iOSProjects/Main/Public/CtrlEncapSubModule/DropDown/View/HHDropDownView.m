//
//  HHDropDownView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHDropDownView.h"
#import "RMCollectionViewFlowLayout.h"
typedef NS_ENUM(NSInteger,HHDropDownCellStyle){
    HHDropDownCellStyleDefault,       //无SectionHeader
    HHDropDownCellStyleValue1,
    HHDropDownCellStyleValue2,
    
};

NSInteger const itemHeight = 40;
NSInteger const sectionHeaderHeight = 40;
NSInteger const row = 4;

@interface HHDropDownView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UIView *rootView;

@property (nonatomic,strong)UIButton *backGroundView;

@property (nonatomic,strong)NSArray *standardArray;//标准

@property (nonatomic,strong)NSArray *fastArray;//快捷

@property (nonatomic,strong)NSArray *dataArr;


@property (nonatomic,strong)UICollectionView *collectionView;


@property (nonatomic,strong)NSMutableArray   *standardAndFastArr;//

@property(nonatomic,assign)CGFloat cellHeight;


@property (nonatomic,assign)HHDropDownCellStyle style;



@end
@implementation HHDropDownView

- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView {
    
    if (self = [super initWithFrame:frame]) {
        
        self.rootView = rootView;


        
    }
    return self;
}
- (void)recoveryLastSuperModel{
    
    
    SSCSuperModel *model  = [self getDefaultPlayMethod];
    
  
}

- (SSCSuperModel *)getDefaultPlayMethod{
    
    
    if (self.standardArray.count > 0) {
        
        return self.standardArray.firstObject;
    }
    else{
        return self.fastArray.firstObject;
    }
}
- (void)setdataArr:(NSArray *)dataArr standardArray:(NSArray *)standardArray fastArray:(NSArray *)fastArray{
    
    if (dataArr == nil  && standardArray == nil && fastArray == nil) {
        return;
    }
    _dataArr = dataArr;
    _standardArray = standardArray;
    _fastArray = fastArray;
    HHNavTitleViewType type =  HHNavTitleViewTypeNormal;
    
    
    type  = _standardArray.count>0? HHNavTitleViewTypePlayStandard : HHNavTitleViewTypePlayFast;
    if (_dataArr.count > 0 ) {
        _style = HHDropDownCellStyleDefault;
    }
    if ((_standardArray.count >0 || _fastArray.count >0) ) {
        _style = HHDropDownCellStyleValue1;
        
      
     
    }
    if ((_standardArray.count >0 && _fastArray.count >0) ) {
        [self.standardAndFastArr addObject:_standardArray];
        [self.standardAndFastArr addObject:_fastArray];
        _style = HHDropDownCellStyleValue2;
      
    }
    self.collectionView.height = self.cellHeight;

    [self.collectionView reloadData];


}

- (CGFloat)cellHeight{
    
    CGFloat sectionHeight = 0;
    NSInteger count = 0;
    if (_dataArr.count > 0 ) {
        count = _dataArr.count;
        sectionHeight = margin;
    }
    
    if ((_standardArray.count >0 || _fastArray.count >0) ) {
        count = (_standardArray.count >0) ? _standardArray.count : _fastArray.count;
        sectionHeight = sectionHeaderHeight;
    }
    
    CGFloat rows = (count - 1 )/row + 1;
    
    if ((_standardArray.count >0 && _fastArray.count >0) ) {

        sectionHeight = 80;
        CGFloat standardRows = 0;
        CGFloat fastRows = 0;
        if (_standardArray.count > 0) {
            
            standardRows = (_standardArray.count - 1 )/row + 1;
        }
        if (_fastArray.count >0) {
            
            fastRows = (_fastArray.count  - 1 )/row + 1;
        }
        rows = standardRows + fastRows;
    }
    NSLog(@"====rowsrows======%lf",rows);
    CGFloat height = rows * itemHeight + (rows - 1) * margin + sectionHeight +  margin;
    
    NSLog(@"==========%lf",height);
    
    return height;
}


- (SSCChildModel *)getDefaultPlay{

    if (self.standardArray.count >0) {
        
        return self.standardArray.firstObject;
    }else{
        return self.fastArray.firstObject;
    }
    
    
    
}
#pragma mark - <UICollectionViewDataSource,UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSInteger count = 0;
    switch (_style) {
        case HHDropDownCellStyleDefault:
            count =  1;
            break;
        case HHDropDownCellStyleValue1:
            count = 1;
            break;
        case HHDropDownCellStyleValue2:
            count =  2;
            break;
        default:
            break;
    }
    return count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(self.frame.size.width, (_style != HHDropDownCellStyleDefault)? sectionHeaderHeight: margin);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSInteger count = 0;
    switch (_style) {
        case HHDropDownCellStyleDefault:
            count =  _dataArr.count;
            break;
        case HHDropDownCellStyleValue1:
            
            count = _standardArray.count > 0 ? _standardArray.count : _fastArray.count;
            
            break;
        case HHDropDownCellStyleValue2:
            
            count =  [self.standardAndFastArr[section] count];
            
            break;
        default:
            break;
    }
    return count;
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    


        HHDropDownSectionHeaderView *headerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HHDropDownSectionHeaderViewID" forIndexPath:indexPath];
    
        switch (_style) {
            case HHDropDownCellStyleValue1:
                
                headerView.title = self.standardArray.count > 0 ? @"标准" : @"快捷";
            
                break;
            case HHDropDownCellStyleValue2:
                
                headerView.title = @[@"标准",@"快捷"][indexPath.section];
                break;
                
          
            default:
                break;
        }
        return headerView;
    
   return   [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableFooter" forIndexPath:indexPath];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HHDropDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHDropDownCellID" forIndexPath:indexPath];
    
    switch (_style) {
        case HHDropDownCellStyleDefault:
            [cell.button setTitle:_dataArr[indexPath.row] forState:UIControlStateNormal];

            break;
        case HHDropDownCellStyleValue1:{
            SSCSuperModel *model =  _standardArray.count> 0?_standardArray[indexPath.row]: _fastArray[indexPath.row];
            [cell.button setTitle:model.nm forState:UIControlStateNormal];

        }
            break;
        case HHDropDownCellStyleValue2:{
            SSCSuperModel *model = _standardAndFastArr[indexPath.section][indexPath.row];
            [cell.button setTitle:model.nm forState:UIControlStateNormal];

        }
       
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HHNavTitleViewType _type = 0;
    SSCSuperModel *model;
    switch (_style) {
        case HHDropDownCellStyleValue1:{
            model =  _standardArray.count> 0?_standardArray[indexPath.row]: _fastArray[indexPath.row];

            _type = (_standardArray.count >0) ? HHNavTitleViewTypePlayStandard : HHNavTitleViewTypePlayFast;
            
        }
            break;
        case HHDropDownCellStyleValue2:{
            
            model = _standardAndFastArr[indexPath.section][indexPath.row];
        }
            
            break;
        default:
            break;
    }
    if (_handlerDropDownDidSelectCallBack) {
        _handlerDropDownDidSelectCallBack(_type, model);
    }
    
    [self close];
}


- (UIButton *)backGroundView{
    
    if (!_backGroundView) {
      _backGroundView = [[UIButton alloc]initWithFrame:_rootView.bounds];
        [_backGroundView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _backGroundView.alpha = 0;
    }
    return _backGroundView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((Screen_Width - 5 * margin )/4, itemHeight);
        layout.minimumLineSpacing = margin; //行间隙
        layout.minimumInteritemSpacing = margin; //列间隙
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.footerReferenceSize = CGSizeMake(Screen_Width, margin);
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[HHDropDownCell class] forCellWithReuseIdentifier:@"HHDropDownCellID"];
        [collectionView registerClass:[HHDropDownSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HHDropDownSectionHeaderViewID"];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableFooter"];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        _collectionView = collectionView;

    }
    return _collectionView;
}

#pragma mark - Actions

- (void)show{
    [self.rootView addSubview:self.backGroundView];
    [self.rootView addSubview:self];
    [self.rootView addSubview:self.collectionView];

    self.backGroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 1;
    }];
    
}

- (void)close{
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backGroundView removeFromSuperview];
        [self.collectionView removeFromSuperview];
    }];
}
- (NSMutableArray *)standardAndFastArr{
    
    if (!_standardAndFastArr) {
        _standardAndFastArr = [NSMutableArray array];
    }
    return _standardAndFastArr;
    
}
@end


@interface HHDropDownSectionHeaderView()

@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation HHDropDownSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.height.mas_equalTo(self);
        }];
    }
    
    return self;
}
- (void)setTitle:(NSString *)title{
    
    self.titleLabel.text = [NSString stringWithFormat:@"— %@玩法 —",title];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = kThemeColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15 ];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

@implementation HHDropDownCell

- (instancetype)initWithFrame:(CGRect)frame{
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
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    UIColor *mainColor = kThemeColor;
    [self.button setTitleColor:mainColor forState:UIControlStateNormal];

    UIImage *normalImage = [HHDropDownCell imageWithColor:[UIColor whiteColor] cornerRidus:4 rect:self.contentView.bounds boardColor:mainColor];
    [self.button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    UIImage *selectedImage = [HHDropDownCell imageWithColor:mainColor cornerRidus:4 rect:self.contentView.bounds boardColor:[UIColor whiteColor]];
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


@end
