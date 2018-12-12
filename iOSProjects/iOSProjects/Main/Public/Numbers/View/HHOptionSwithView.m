//
//  HHOptionSwithView.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHOptionSwithView.h"
#define Button_Origin_Tag 78
@interface HHOptionSwithView()

@property(nonatomic,strong)UIView *lineView;
@end
@implementation HHOptionSwithView
- (void)setItemsArr:(NSArray *)itemsArr{
    
    _itemsArr = itemsArr;
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    
    [self setupSubView];
    
}

- (void)setupSubView{
    
    CGFloat itemWidth = self.width / _itemsArr.count;
    CGFloat itemHeight = self.height-2;
   for (int i = 0; i< _itemsArr.count;i++ ) {
        UIButton * buton = [[UIButton alloc]init];
        buton.frame = CGRectMake(i*itemWidth , (self.height - itemHeight )/2 , itemWidth, itemHeight);
        [buton setTitle:_itemsArr[i] forState:UIControlStateNormal];
        [buton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [buton setTitleColor:kThemeColor forState:UIControlStateSelected];
        buton.titleLabel.font =kFont(14);

//       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:buton.bounds byRoundingCorners:UIRectCornerTopLeft| UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
//
//       CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//       maskLayer.frame = buton.bounds;
//       maskLayer.path = maskPath.CGPath;
//       buton.layer.mask = maskLayer;
       
       buton.layer.borderWidth = 1;
       buton.layer.borderColor = kSeparatedLineColor.CGColor;
       buton.layer.masksToBounds = true;
        [buton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
       
       
        buton.tag = Button_Origin_Tag+i;
        [self addSubview:buton];
        
        if (i == 0) {
            buton.selected = YES;
        }
    }
        
        //加红线
        _lineView = [[UIView alloc]init];
        _lineView.frame = CGRectMake(0, self.frame.size.height-2, itemWidth, 2);
        _lineView.backgroundColor = kThemeColor;
        [self addSubview:_lineView];
    
    
    
    
    
}

- (void)buttonClick:(UIButton *)sender{
    
    NSInteger index = sender.tag - Button_Origin_Tag;
    
    [self setSelectAtIndex:index];
    
    if (_itemHandlerOnClick) {
        _itemHandlerOnClick(index);
    }
    
    
}
-(void)setSelectAtIndex:(NSInteger)index{
    
    
    for (int i = 0; i<self.itemsArr.count; i++) {
        
        UIButton *btn = [self viewWithTag:i+ Button_Origin_Tag];
        
        if (btn.tag-Button_Origin_Tag == index) {
            
            btn.selected = YES;
            
            
        }else{
            
            btn.selected = NO;
        }
    }
    
    
    //调整红线的位置
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _lineView.frame;
        frame.origin.x = index*frame.size.width;
        _lineView.frame = frame;
    }];
    
    
}
@end
