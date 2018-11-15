//
//  HHResultView.m
//  iOSProjects
//
//  Created by flowerflower on 2018/11/15.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHResultView.h"


#define NUMBER_WIDTH (Screen_Width==320?16:18)

@interface HHResultView(){
    
    NSArray *_numbers;
    NSString *_result;
}
@end

@implementation HHResultView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxNumber = 26;
    }
    return self;
}

- (void)addNumbers:(NSArray *)numbers result:(NSString *)result type:(HHResultViewType)type{
    
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
    _numbers = numbers;
    _result = result;
    
    if (numbers.count == 0) {
        return;
    }
    
    if (type == HHResultViewTypeSymbol) {
    [self addSymbolResult];
    }
    
    
}


- (void)addSymbolResult{
    CGFloat currentX = 0;
    
    UILabel *lastL;
    for (int i = 0;i < _numbers.count;i++) {
        currentX = NUMBER_WIDTH * 2 * i;
        UILabel *numLabel = [self numLabel];
        numLabel.frame = CGRectMake(currentX, 0, NUMBER_WIDTH, NUMBER_WIDTH);
        numLabel.text = _numbers[i];
        
        [self addSubview:numLabel];
        
        if (i != _numbers.count - 1) {
            UILabel *symbolLabel = [self symbolLabel];
            symbolLabel.frame = CGRectMake(currentX+NUMBER_WIDTH, 0, 1*NUMBER_WIDTH, NUMBER_WIDTH);
            symbolLabel.text = @"+";
            
            [self addSubview:symbolLabel];
        }
        if (i == _numbers.count-1) {
            lastL = numLabel;
        }
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastL.mas_bottom);
    }];
    [self layoutIfNeeded];
    
    UILabel *symbolLabel = [self symbolLabel];
    symbolLabel.frame = CGRectMake(currentX+NUMBER_WIDTH, 0, 1*NUMBER_WIDTH, NUMBER_WIDTH);
    symbolLabel.text = @"=";
    
    [self addSubview:symbolLabel];
    
    UILabel *numLabel = [self numLabel];
    numLabel.frame = CGRectMake(currentX + NUMBER_WIDTH*2, 0, NUMBER_WIDTH, NUMBER_WIDTH);
    numLabel.text = _result;
    numLabel.backgroundColor = [self resultLableColorWithResult:[_result integerValue]];
    [self addSubview:numLabel];
    
    if (![_result isEqualToString:@"?"]) {
        
        UILabel *resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(currentX + NUMBER_WIDTH *3.2, 0, 100, NUMBER_WIDTH)];
        resultLabel.textAlignment = NSTextAlignmentLeft;
        resultLabel.textColor = [UIColor lightGrayColor];//[UIColor colorWithHex:0xd6a23e];
        resultLabel.text = [self resultStringWithResult:[_result integerValue]];
        resultLabel.font = [UIFont systemFontOfSize:Screen_Width == 320 ? 11:12];
        [self addSubview:resultLabel];
    }
    
}

- (UIColor *)resultLableColorWithResult:(NSInteger)integer
{
    if (integer == 0 ||integer == 27 || integer == 13 || integer == 14 ) {
        return [UIColor colorWithHexString:@"666666"];
    }else if (integer%3 ==0){
        return [UIColor colorWithHexString:@"d85e54"];
        
    }else if (integer%3 ==1){
        return [UIColor colorWithHexString:@"4ee864"];
        
        
    }else if (integer%3 ==2){
        return [UIColor colorWithHexString:@"5b9bea"];
    }
 return [UIColor colorWithHexString:@"d6a23e"];

}
- (NSString *)resultStringWithResult:(NSInteger)integer
{
    if (integer>_maxNumber/2)
    {
        if (integer%2==0)
        {
            return [NSString stringWithFormat:@"(大,双)"];
        }
        else
        {
            return [NSString stringWithFormat:@"(大,单)"];
        }
    }
    else
    {
        if (integer%2==0)
        {
            return [NSString stringWithFormat:@"(小,双)"];
        }
        else
        {
            return [NSString stringWithFormat:@"(小,单)"];
        }
        
    }
}


- (UILabel *)symbolLabel
{
    UILabel *symbolLabel = [[UILabel alloc]init];
    symbolLabel.textColor = [UIColor grayColor];//[UIColor colorWithHex:0xd6a23e];
    symbolLabel.font = [UIFont systemFontOfSize:Screen_Width == 320 ? 13:14];
    symbolLabel.textAlignment = NSTextAlignmentCenter;
    return symbolLabel;
}

- (UILabel *)numLabel
{
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.backgroundColor = [UIColor colorWithHexString:@"d6a23e"];
    numLabel.font = [UIFont systemFontOfSize:Screen_Width == 320 ? 11:12];
    numLabel.layer.cornerRadius = 9;
    numLabel.layer.masksToBounds = YES;
    numLabel.textAlignment = NSTextAlignmentCenter;
    return numLabel;
}

@end
