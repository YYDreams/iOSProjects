//
//  FSPlayAlertView.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/14.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "FSPlayAlertView.h"
#import "FSFontTool.h"



CGFloat  lineSpac = 5;
CGFloat contentViewWidth;
CGFloat contentViewHeight;

@interface FSPlayAlertView()

@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *messageLabel;

@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,copy)NSString *message;


@property(nonatomic,assign)FSPlayType type; //

@end



@implementation FSPlayAlertView


+ (instancetype)showPlayType:(FSPlayType)type{
    
    FSPlayAlertView * alerView =[[FSPlayAlertView alloc]initPlayType:type];
    
    return alerView;
    
}
- (instancetype)initPlayType:(FSPlayType)type{
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        _type = type;
        [self commonInit];
        
        [self setupSubView];
        
        [self show];
    }
    return self;
}

- (void)commonInit{
    
    
    if (_type == FSPlayTypeLoTo) {
        
        _message = @"● 组合选号：\nLOTO 7 选择7个号码为选号条件。\n MINI LOTO 选择5个号码为选号条件。\n● 组合(子注单)：\n 每个注单从A到E位5个子注单。\n● 注单：\n1个注单包含5个组合，最多可以添加10个注单\n● 手动选号：\n手动添加注单选号。\n ● 快捷选号：\n快捷机选，号码需要购买后可见\n● 随机选号：\n 分为所有机选和其余机选选号界面可\n以进行可见性机选。\n● 追号/倍投：\n可根据每个子注单添加需要追加期号及倍投增加";
        }else{
        _message = @"直选:\n3个号码和开奖相同顺序相同\n组选:\n3个号码和开奖相同顺序不同\n直选/组选：\n同时进行2个开奖校验(直选、盒子)赔率减半\n迷你：\n2个号码和开奖相同顺序相同";
        
    }
    
}


- (void)setupSubView{
    
    self.backgroundColor = [UIColor clearColor];
    
    _backgroundView = [[UIView alloc] initWithFrame:self.frame];
    _backgroundView.backgroundColor = [UIColor blackColor];
    [self addSubview:_backgroundView];

    
    contentViewWidth = Screen_Width - 50;
    contentViewHeight = 20;
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, contentViewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;


    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, contentViewWidth, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_contentView addSubview:_titleLabel];
    
    _titleLabel.text = (_type == FSPlayTypeLoTo) ? @"LOTO 彩种功能说明": @"NUMBERS 3 玩法介绍";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame), contentViewWidth- 2* 10, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_contentView addSubview:lineView];
    

    _messageLabel = [[UILabel alloc]init];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray *numbers;
    
    if (_type == FSPlayTypeLoTo) {
        _messageLabel.font = kFont(15);
        
    }else{
          numbers = @[@"直选:",@"组选:",@"",@"直选/组选：",@"迷你："];
        _messageLabel.font = [UIFont boldSystemFontOfSize:15];

    }
 
    _messageLabel.text = _message;
    _messageLabel.numberOfLines = 0;
    _messageLabel.attributedText = [FSFontTool fs_changeCorlorWithColor:[UIColor blackColor] changeFontAndColor:[UIFont boldSystemFontOfSize:20] TotalString:_message SubStringArray:numbers LineSpace:lineSpac];
    CGSize messageSize = [self getMessageSize];
    _messageLabel.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame), messageSize.width -2 * 10, messageSize.height);
    
    [_contentView addSubview:_messageLabel];
    
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake((contentViewWidth -100)/2, CGRectGetMaxY(_messageLabel.frame), 100, 45)];
    [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeOnClick) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_closeBtn];
    
    CGFloat sizeH = MIN((Screen_Height - kNavHeight),CGRectGetMaxY(_closeBtn.frame));
    _contentView.height = sizeH;
    _contentView.center = self.center;
    [self addSubview:_contentView];

    
    
    
}
- (CGSize )getMessageSize{
    
    UIFont *font = kFont(15);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpac;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};

    CGSize size = [_message boundingRectWithSize:CGSizeMake(contentViewWidth, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (void)closeOnClick{
    
    [self hide];
    
}
- (void)showBackground{
    _backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.6;
    [UIView commitAnimations];
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}

- (void)hideAlertAnimation {
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)show {
    contentViewHeight += CGRectGetMaxY(_closeBtn.frame);

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
}
- (void)hide{
    
    _contentView.hidden = YES;
    
    [self hideAlertAnimation];

    [self removeFromSuperview];
    
    
}


@end
