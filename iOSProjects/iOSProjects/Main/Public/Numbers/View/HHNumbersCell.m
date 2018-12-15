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
#import "FSPlayAlertView.h"
NSString * const kResetNotification = @"kResetNotification" ;

@interface HHNumbersCell()<UIScrollViewDelegate>

@property(nonatomic,strong)HHOptionSwithView *optionView; //选项卡切换

@property(nonatomic, strong)UIScrollView *scrollView;;

@property(nonatomic,copy)NSArray  *letterArr; // ABCDE选项卡

@property(nonatomic,strong)UIView *selectedView; //随机选号 我的预设号码

@property(nonatomic,strong)FSNumbersPlayView *playView; //玩法

@property(nonatomic,strong)UIView *chaseNumbersView;  //追号View

@end
 
@implementation HHNumbersCell
#pragma mark - init Methods
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self setupSubView];
        [self loadDefalutData];
    }
    return self;
    
}

#pragma mark - setupSubView
- (void)setupSubView{
    
    [self.contentView addSubview:self.optionView];
    
    [self.contentView addSubview:self.scrollView];
    
    [self.contentView addSubview:self.selectedView];
    
    [self addRandomNumbersBtns];

    [self.contentView addSubview:self.playView];
    
    [self addSelectNumbersView];
    
    [self addChaseNumbersView];
    
}

#pragma mark - loadDefalutData
- (void)loadDefalutData{
    
    self.optionView.itemsArr = self.letterArr;
    WeakSelf;
    self.playView.handlerPlayTypeBtnCallBack = ^(BOOL select) {
        
        weakSelf.select = select;
    };
 
    
    
}

- (void)setModel:(FSNumbersModel *)model{
    
    _model = model;
    
    
    
    
}
#pragma mark - SEL Methods
- (void)resetOnClick{
    
    if (_handlerResetBtnCallBack) {
        _handlerResetBtnCallBack();
    }
    
}

- (void)selectOnClick:(UIButton *)btn{
    
    
    btn.tag == 0 ? [self randomOnClick] : [self presetNumbersOnClick];
}

- (void)randomOnClick{
    
    NSLog(@"%s",__func__);
    
}
- (void)presetNumbersOnClick{
    
#warning 是否登录判断
    BOOL isLogin = NO;
    
    if (isLogin) {
        
        
    }
    
    NSLog(@"%s",__func__);
    
}


#pragma mark - setupUI
- (void)addSelectNumbersView{
    HHSelectNumbersView *view;
    for (NSInteger i = 0; i < self.letterArr.count ; i++) {
        
        view = [[HHSelectNumbersView alloc]initWithFrame:CGRectMake(i * Screen_Width, 0, Screen_Width, _scrollView.height)];
        view.index = i;
        view.backgroundColor =[UIColor hh_redomColor];
        [_scrollView addSubview:view];
    }
    self.playView.handlerPlayMiniBtnCallBack = ^(NSInteger index) {
      
        [view reloadIndex:index];
    };
    
    
}
- (void)addRandomNumbersBtns{
    NSArray *titleArr = @[@"随机选号",@"我的预设号码"];
    CGFloat btnWidth = Screen_Width / titleArr.count;
    CGFloat btnHeight = 45;
    for (NSInteger i = 0; i< titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnWidth * i, (self.selectedView.height - btnHeight)/2, btnWidth, btnHeight)];
        btn.tag =  i;
        [btn addTarget:self action:@selector(selectOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [btn setTitleColor:kThemeColor forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self.selectedView addSubview:btn];
        
    }
}

- (void)addChaseNumbersView{
    
    UIView *chaseView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_playView.frame), Screen_Width, 45)];
    
    chaseView.backgroundColor = [UIColor grayColor];
    
    [self addSubview:chaseView];
    
    UILabel * singleStakesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(chaseView.frame) + (45-30)/2, Screen_Width - 100, 30)];
    singleStakesLabel.text = @" 单注：200日元";
    singleStakesLabel.font = [UIFont systemFontOfSize:15];
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 100, CGRectGetMaxY(chaseView.frame), 80, 45)];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [resetBtn addTarget:self action:@selector(resetOnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:singleStakesLabel];
    [self addSubview:resetBtn];
 
}

#pragma mark - Custom Methods
-(void)adjustScrollView:(NSInteger)index{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.bounds.size.width, 0);
    }];
}
#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_optionView setSelectAtIndex:index];
    
}
#pragma mark - Setter && Getter Methods
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

- (UIView *)selectedView{
    if (!_selectedView) {
        _selectedView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollView.frame), Screen_Width, 45)];
    }
    return _selectedView;
    
}
- (FSNumbersPlayView *)playView{
    
    if (!_playView) {
        _playView = [[FSNumbersPlayView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_selectedView.frame), Screen_Width, 45 * 3)];
    }
    return _playView;
}
- (NSArray *)letterArr{
    if (!_letterArr) {
        _letterArr = @[@"A",@"B",@"C",@"D",@"E"];
    }
    
    return _letterArr;
}
@end


@interface FSNumbersPlayView()

@property(nonatomic,strong)UILabel *selectPlayLabel; //选择参加的玩法

@property(nonatomic,strong)UIButton *playIntroduceBtn; //玩法介绍

@property(nonatomic,strong)UIView *selectPlayBgView; //玩法View

@property(nonatomic,strong)NSMutableArray *allBtns;

@property(nonatomic,assign)BOOL select; //

@end

@implementation FSNumbersPlayView

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kBgColor;
        [self setupSubView];
        
    }
    return self;
}



#pragma mark - setupSubView
- (void)setupSubView{
    
    _select = NO;
    [self addSubview:self.selectPlayBgView];
    
    [self.selectPlayBgView addSubview:self.playIntroduceBtn];
    
    [self.selectPlayBgView addSubview:self.selectPlayLabel];
    
    [self addPlayBtns];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetNotification) name:kResetNotification object:nil];
}


#warning
#pragma mark - SEL Method
- (void)resetNotification{
    
    NSLog(@"%s",__func__);

    
    for (UIButton *btn in self.allBtns) {
        btn.selected = NO;
        
    }
    
    
    
}

- (void)btnOnClick:(UIButton *)btn{
    
    for (UIButton *button in self.allBtns) {
        button.selected = (button == btn)? YES : NO;
        
    }
    _select = YES;
    if (_handlerPlayTypeBtnCallBack) {
        _handlerPlayTypeBtnCallBack(_select);
    }

        if (_select) {
            
            if (_handlerPlayMiniBtnCallBack) {
                _handlerPlayMiniBtnCallBack(btn.tag);
            }
            
    }
    
    
}
- (void)playIntroduceBtnOnClick{
    
    NSLog(@"%s",__func__);
    
    [FSPlayAlertView showPlayType:FSPlayTypeLoTo];
    
    if (_handlerPlayIntroduceBtnCallBack) {
        _handlerPlayIntroduceBtnCallBack();
    }
}

#pragma mark - setupUI
- (void)addPlayBtns{
    int totalloc = 2;//一行的列数
    CGFloat btnW = Screen_Width/2;
    CGFloat btnH = 45;
    CGFloat margin = 0;
    NSArray *titles = @[@"直选",@"组选",@"直选/组选",@"迷你"];
    
    for(int i = 0 ; i<titles.count;i++){
        int row = i/totalloc;//行号
        int loc = i%totalloc;//列号
        CGFloat btnX =   (margin + btnW) * loc; //x值由列号决定
        CGFloat btnY = CGRectGetMaxY(_selectPlayBgView.frame) + (btnH + 1 )* row;  //y值由行号决定
        
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.backgroundColor =  [UIColor whiteColor];
        [btn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:k3Color forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(btnW, btnH)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kThemeColor size:CGSizeMake(btnW, btnH)] forState:UIControlStateSelected];
        [self.allBtns addObject:btn];
        [self addSubview:btn];
    }
    
    
    if (_handlerPlayTypeBtnCallBack) {
        _handlerPlayTypeBtnCallBack(_select);
    }

}


#pragma mark - Setter && Getter Methods
- (UIView *)selectPlayBgView{
    
    if (!_selectPlayBgView) {
        _selectPlayBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width, 45)];
    }
    return _selectPlayBgView;
    
}
- (UILabel *)selectPlayLabel{
    if (!_selectPlayLabel) {
        _selectPlayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width - self.playIntroduceBtn.width, _selectPlayBgView.height)];
        _selectPlayLabel.text = @" 选择参加的玩法";
        _selectPlayLabel.font = [UIFont systemFontOfSize:15];
        
        
    }
    return _selectPlayLabel;

}
- (UIButton *)playIntroduceBtn{
    
    if (!_playIntroduceBtn) {
        
        _playIntroduceBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 80,0, 80, _selectPlayBgView.height)];
        _playIntroduceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_playIntroduceBtn setTitle:@"玩法介绍" forState:UIControlStateNormal];
#warning 缺少图片
        [_playIntroduceBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_playIntroduceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_playIntroduceBtn addTarget:self action:@selector(playIntroduceBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playIntroduceBtn;
}
- (NSMutableArray *)allBtns{
    
    if (!_allBtns) {
        _allBtns = [NSMutableArray array];
    }
    return _allBtns;
}

#pragma mark - dealloc
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
@end




