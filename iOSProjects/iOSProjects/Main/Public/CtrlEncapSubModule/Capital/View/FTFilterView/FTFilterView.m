//
//  FTFilterView.m
//  Lucky28-TC
//
//  Created by TY.wang on 2017/10/14.
//

#import "FTFilterView.h"
#import "UICustomDatePicker.h"



static NSString *const headID = @"FTFilterViewHeadView";
static NSString *const cellID = @"FTFilterViewCell";

@interface FTFilterView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>;

/**
 collectionView
 */
@property (nonatomic,weak)UICollectionView *collectionView;

/**
 背景视图
 */
@property (nonatomic,strong)UIButton *backGroundView;

/**
 跟视图
 */
@property (nonatomic,weak)UIView *rootView;

/**
 分类数组
 */
@property (nonatomic,strong)NSMutableArray <NSArray *>*lotteryCategory;

/**
 开始时间
 */
@property (nonatomic,strong)NSDate *startDate;

/**
 确认开始时间
 */
@property (nonatomic,copy)NSString *trueStartDate;

/**
 结束时间
 */
@property (nonatomic,strong)NSDate *endDate;

/**
 确认结束时间
 */
@property (nonatomic,copy)NSString *trueEndDate;

/**
 开奖状态 (0.未选择 1.已开奖 2.未开奖) 或者交易类型
 */
@property (nonatomic,assign)NSInteger openState;

/**
 确认状态 (0.未选择 1.已开奖 2.未开奖)
 */
@property (nonatomic,assign)NSInteger trueState;

/**
 当前分类下标 或者交易类别
 */
@property (nonatomic,assign)NSInteger currentIndex;

/**
 确认分类下标
 */
@property (nonatomic,assign)NSInteger trueIndex;

/**
 确认交易类型下标
 */
@property (nonatomic,assign)NSInteger dealIndex;


/**
 当前弹出窗口列别
 */
@property (nonatomic, assign) FTfilterType filterType;

@property (nonatomic, strong) NSMutableArray * currentStates;//当前的交易类型对应的数据源
@property (nonatomic, strong) NSArray * datas;//筛选数据源

@end

@implementation FTFilterView

- (instancetype)initWithFrame:(CGRect)frame rootview:(UIView *)rootView filterType:(FTfilterType)filterType showCategory:(BOOL)showCategory
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rootView = rootView;
        [self initUI];
        self.filterType = filterType;
        
        // 初始化数据
        _dealIndex = 0;
        _openState = -1;
        _trueState = -1;
        _currentIndex = -1;
        _trueIndex = -1;
        self.trueEndDate = nil;
        self.trueStartDate = nil;
        self.endDate = nil;
        self.startDate = nil;

        
        // 根据类型选择Plist文件
        NSMutableArray *temp = [NSMutableArray array];
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
        documentPath = [documentPath stringByAppendingString:@"/capital.json"];
        
        NSData *jsondata = [NSData dataWithContentsOfFile:documentPath];
        
        
        NSArray *categorys ;
        if (filterType == FTfilteraFromsearch) {
            
            if (jsondata) {
                self.datas = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
                for (NSDictionary *dic in self.datas) {
                    [temp addObject:@{dic[@"name"]:dic[@"id"]}];
                }
                
            }

            categorys = temp;
        }
        else
        {
            NSMutableArray *temp = [NSMutableArray array];
            NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
            
            documentPath = [documentPath stringByAppendingString:@"/allcategory.json"];
            
            NSData *jsondata = [NSData dataWithContentsOfFile:documentPath];
            if (jsondata) {
                NSArray *josnArray = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
                
                for (NSDictionary *dic in josnArray) {
                    [temp addObject:@{dic[@"name"]:dic[@"id"]}];
                }
            }
            
            categorys = temp;
        }
        
        self.currentStates = [NSMutableArray array];
        if (jsondata) {
            self.datas = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
            
            for (NSDictionary *dic in self.datas[0][@"children"]) {
                [self.currentStates addObject:@{dic[@"name"]:dic[@"id"]}];
            }
        }
        self.currentStates = self.currentStates;
      
        
        _lotteryCategory = [NSMutableArray array];
        
        // 先添加时间数组
        [_lotteryCategory addObject:@[@{@"开始时间": @""},@{@"结束时间": @""}]];
        if (showCategory == YES) {
            [_lotteryCategory addObject:categorys];
        }
        if (filterType == FTfilteraFromsearch) {
            [_lotteryCategory addObject:self.currentStates];
        }

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame rootview:(UIView *)rootView filterType:(FTfilterType)filterType states:(NSArray *)states {
    self = [super initWithFrame:frame];
    if (self) {
        self.rootView = rootView;
        [self initUI];
        self.filterType = filterType;
        
        // 初始化数据
        _openState = -1;
        _trueState = -1;
        _currentIndex = -1;
        _trueIndex = -1;
        self.trueEndDate = nil;
        self.trueStartDate = nil;
        self.endDate = nil;
        self.startDate = nil;
        
        NSMutableArray *categorys = [NSMutableArray array];
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
        documentPath = [documentPath stringByAppendingString:@"/allcategory.json"];
        
        NSData *jsondata = [NSData dataWithContentsOfFile:documentPath];
        if (jsondata) {
            NSArray *josnArray = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
            
            for (NSDictionary *dic in josnArray) {
                [categorys addObject:@{dic[@"name"]:dic[@"id"]}];
            }
        }
        [categorys insertObject:@{@"全部":@0} atIndex:0];
        _lotteryCategory = [NSMutableArray array];
        
        // 先添加时间数组
        [_lotteryCategory addObject:@[@{@"开始时间": @""},@{@"结束时间": @""}]];
        [_lotteryCategory addObject:states];
        [_lotteryCategory addObject:categorys];
        
    }
    return self;
}


- (void)setOrderStatesDatas:(NSArray *)orderStatesDatas {
    if (self.filterType == FTfilterTypeFromBetRecord) {
        _lotteryCategory[1] = orderStatesDatas;
        [self.collectionView reloadData];
    }
}

- (void)initUI
{
    UIButton *view = [[UIButton alloc]initWithFrame:_rootView.bounds];
    self.backGroundView = view;
    [view addTarget:self action:@selector(backGroundViewDidClick) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    self.backGroundView.alpha = 0;
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    flowlayout.minimumLineSpacing = 8;
    flowlayout.minimumInteritemSpacing = 8;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView registerClass:[FTFilterViewHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID];
    [collectionView registerClass:[FTFilterViewCell class] forCellWithReuseIdentifier:cellID];
    
    UIButton *resetButton = [[UIButton alloc]init];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    resetButton.backgroundColor = [UIColor whiteColor];
    [resetButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetButton];
    
    UIButton *confirmButton = [[UIButton alloc]init];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = kThemeColor;
    [confirmButton addTarget:self action:@selector(confirmButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    
    UIView *sparetor = [[UIView alloc]init];
    sparetor.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
    [self addSubview:sparetor];
    
    [sparetor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(resetButton);
        make.height.mas_equalTo(0.5);
    }];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(resetButton.mas_top);
    }];
    
    [resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.equalTo(confirmButton);
        make.right.equalTo(confirmButton.mas_left);
        make.height.mas_equalTo([[UIApplication sharedApplication] statusBarFrame].size.height == 44 ?80:45);
    }];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo([[UIApplication sharedApplication] statusBarFrame].size.height == 44 ?80:45);
    }];
}

#pragma mark - DataSource & Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        [UICustomDatePicker showCustomDatePickerAtView:self.rootView choosedDateBlock:^(NSDate *date) {
            
            if (indexPath.row == 0) {
                NSString *timeStr = [date stringWithFormat:@"YYYY-MM-dd"];
                NSDate *newDate = [NSDate dateWithString:timeStr format:@"YYYY-MM-dd"];
                
                NSDate *nowDate = [NSDate date];
                NSString *nowString = [nowDate stringWithFormat:@"YYYY-MM-dd"];
                nowDate = [NSDate dateWithString:nowString format:@"YYYY-MM-dd"];
                NSInteger timeInterval = [newDate timeIntervalSinceDate:nowDate];
                if(timeInterval > 0)
                {
                    NSLog(@"开始时间大于今天!");
                    return ;
                }
                else if (self.endDate != nil && [newDate timeIntervalSinceDate:self.endDate] > 0)
                {
                    
                    NSLog(@"结束时间小于开始时间!");
                    return ;
                }
                self.startDate = newDate;
                FTFilterViewCell * currentCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                [currentCell.button setTitle:[newDate stringWithFormat:@"YYYY-MM-dd"] forState:UIControlStateNormal];
            }
            else
            {
                NSString *timeStr = [date stringWithFormat:@"YYYY-MM-dd"];
                NSDate *newDate = [NSDate dateWithString:timeStr format:@"YYYY-MM-dd"];
                newDate = [NSDate dateWithTimeIntervalSince1970:([newDate timeIntervalSince1970] + 24 *60 *60 -1)];
                
                NSDate *nowDate = [NSDate date];
                NSString *nowString = [nowDate stringWithFormat:@"YYYY-MM-dd"];
                nowDate = [NSDate dateWithString:nowString format:@"YYYY-MM-dd"];
                NSInteger timeInterval = [newDate timeIntervalSinceDate:nowDate];
                
                if(timeInterval > 24*60*60-1)
                {
                    NSLog(@"结束时间大于今天!");
                    return ;
                }
                
                self.endDate = newDate;
                FTFilterViewCell * currentCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                [currentCell.button setTitle:[newDate stringWithFormat:@"YYYY-MM-dd"] forState:UIControlStateNormal];
            }
            
        } cancelBlock:^{
            
        }];
    }
    else if (indexPath.section == 1)
    {
        if (_filterType == FTfilteraFromsearch) {
            _currentIndex = 0;
            FTFilterViewCell * secletCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            
            if ([secletCell.button.titleLabel.text isEqualToString:self.datas[indexPath.row][@"name"]]) {
                
                NSMutableArray *cellArray = [NSMutableArray array];
                
                for (NSDictionary *dic in self.datas[indexPath.row][@"children"]) {
                    [cellArray addObject:@{dic[@"name"]:dic[@"id"]}];
                }
                if (indexPath.row != 0) {
                    [cellArray insertObject:@{@"全部":@0} atIndex:0];

                }
                self.currentStates = cellArray;
                
                [_lotteryCategory replaceObjectAtIndex:2 withObject:self.currentStates];
                [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
            }
            FTFilterViewCell *fastCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
            
//            if (indexPath.row == 0) {
                fastCell.button.selected = YES;
//            }else{
//                fastCell.button.selected = NO;
//            }
        }
     
        
        if (_openState > 0) {
            FTFilterViewCell *lastCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_openState-1 inSection:1]];
            lastCell.button.selected = NO;
        }
        
        FTFilterViewCell * currentCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        currentCell.button.selected = YES;
        
        FTFilterViewCell *lastCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        if (indexPath.row == 0) {
           lastCell.button.selected = YES;
        }else{
            lastCell.button.selected = NO;
        }
        
        _openState = indexPath.row + 1;
        _dealIndex = indexPath.row;

    }
    else if (indexPath.section == 2)
    {
        FTFilterViewCell *lastCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:2]];
        lastCell.button.selected = NO;
        
        FTFilterViewCell *currentCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        currentCell.button.selected = YES;
        
        FTFilterViewCell *fastCell = (FTFilterViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        
        if (indexPath.row == 0) {
            fastCell.button.selected = YES;
        }else{
            fastCell.button.selected = NO;
        }
        
        
        _currentIndex = indexPath.row;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Screen_Width, 45);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.width - 2*15 -8 -1)/2, 32);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FTFilterViewHeadView *head = (FTFilterViewHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headID forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            head.label.text = @"时间";
            break;
        case 1:
            head.label.text = (_filterType == FTfilteraFromsearch? @"交易类型":@"状态");
            break;
        case 2:
            head.label.text = (_filterType == FTfilteraFromsearch? @"交易类别":@"分类");
            break;
        default:
            break;
    }
    
    return head;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _lotteryCategory.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _lotteryCategory[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FTFilterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dict = _lotteryCategory[indexPath.section][indexPath.row];
    [cell.button setTitle:dict.allKeys.firstObject forState:UIControlStateNormal];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.button.selected = NO;
        if (self.trueStartDate) {
            [cell.button setTitle:self.trueStartDate forState:UIControlStateNormal];
            [cell.button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        }
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.button.selected = NO;
        if (self.trueEndDate) {
            [cell.button setTitle:self.trueEndDate forState:UIControlStateNormal];
            [cell.button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [cell.button setTitle:dict.allKeys.firstObject forState:UIControlStateSelected];
        cell.button.titleLabel.font = cell.button.titleLabel.text.length > 6?[UIFont systemFontOfSize:11]: [UIFont systemFontOfSize:13];

        if (indexPath.row == 0 ) {
            cell.button.selected = YES;
        }else{
            cell.button.selected = NO;
        }
    }
    return cell;
}

#pragma mark - Actions
- (void)show
{
   
    _isShow = YES;
    [self.rootView addSubview:self.backGroundView];
    [self.rootView addSubview:self];
    self.x = self.rootView.width;
    self.backGroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 1;
        self.x = self.rootView.width - self.width;
    }];
    
}

- (void)close
{
    
    _isShow = NO;
    self.x = self.rootView.width - self.width;
//    [self reloadCollectView];
    [UIView animateWithDuration:0.25 animations:^{
        self.x = self.rootView.width;
        self.backGroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backGroundView removeFromSuperview];
    }];
}

-(void)reloadCollectView {
    
    if (_trueIndex >= 0) {
        [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_trueIndex inSection:2]];
    } else {
        // 取消选择
        FTFilterViewCell *lastCell = (FTFilterViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:2]];
        lastCell.button.selected = NO;
        FTFilterViewCell *Cell = (FTFilterViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        Cell.button.selected = YES;
    }
    
    if (_trueState >= 0) {
        [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_trueState - 1 inSection:1]];
    } else {
        // 取消选择
        if (_openState > 0) {
            FTFilterViewCell *lastCell = (FTFilterViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_openState-1 inSection:1]];
            lastCell.button.selected = NO;
            
            FTFilterViewCell *Cell = (FTFilterViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            Cell.button.selected = YES;
        }
    }
    
   [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

- (void)backGroundViewDidClick
{
    self.startDate = nil;
    self.endDate = nil;
    [self close];
}

- (void)resetButtonDidClick
{
    self.startDate = nil;
    self.endDate = nil;
    self.trueStartDate = nil;
    self.trueEndDate = nil;
    self.currentIndex = -1;
    self.openState = -1;
    self.trueIndex = -1;
    self.trueState = -1;
    if (_filterType == FTfilteraFromsearch) {
        NSMutableArray *cellArray = [NSMutableArray array];
        for (NSDictionary *dic in self.datas[0][@"children"]) {
            [cellArray addObject:@{dic[@"name"]:dic[@"id"]}];
        }
        self.currentStates = cellArray;
        [_lotteryCategory replaceObjectAtIndex:2 withObject:self.currentStates];
    }
    [self.collectionView reloadData];
}

- (void)confirmButtonDidClick
{
    
    if ([self.delegate respondsToSelector:@selector(filterViewConfirmStarDate:endDate:openState:category:genre:)]) {
       
        _trueState = _openState;
        _trueIndex = _currentIndex;
        if (self.endDate) {
            _trueEndDate = [self.endDate stringWithFormat:@"YYYY-MM-dd"];
        }
        if (self.startDate) {
            _trueStartDate = [self.startDate stringWithFormat:@"YYYY-MM-dd"];
        }
        NSString *openState = @"";
        if (self.openState > 0) {
            openState = [_lotteryCategory[1][_openState - 1] allValues].firstObject;
        }
        
        NSString *category = @"";
//        if (_filterType == FTfilteraFromsearch) {
//            category = [NSString stringWithFormat:@"%ld", _openState-1];
//        } else {
            if (_currentIndex >= 0) {
                category = [_lotteryCategory[2][_currentIndex] allValues].firstObject;
            }
//        }
        [self.delegate filterViewConfirmStarDate:_trueStartDate endDate:_trueEndDate openState:self.openState category:category genre:openState];
    }
    [self close];
}

@end


@implementation FTFilterViewHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor colorWithHexString:@"666666"];
        _label.font = [UIFont systemFontOfSize:15];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.right.bottom.equalTo(self);
        }];
    }
    return self;
}

@end

@implementation FTFilterViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc]initWithFrame:self.bounds];
        [self addSubview:_button];
        _button.userInteractionEnabled = NO;
        _button.titleLabel.font = _button.titleLabel.text.length > 6?[UIFont systemFontOfSize:11]: [UIFont systemFontOfSize:13];
        [_button setTitleColor:[UIColor colorWithHexString:@"b2b2b2"] forState:UIControlStateNormal];
        BOOL FSMatchColors_ZI = YES;
        
        [_button setTitleColor:FSMatchColors_ZI ?[UIColor colorWithHexString:@"8841e0"]:[UIColor colorWithHexString:@"d6a23e"] forState:UIControlStateSelected];
        
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"beff2"] cornerRidus:6 rect:self.bounds boardColor:[UIColor colorWithHexString:@"beff2"]] forState:UIControlStateNormal];
        
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] cornerRidus:6 rect:self.bounds boardColor: FSMatchColors_ZI ?[UIColor colorWithHexString:@"8841e0"]:[UIColor colorWithHexString:@"d6a23e"]] forState:UIControlStateSelected];
    }
    return self;
}

@end
