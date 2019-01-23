//
//  JYTextField.m
//  JYFarm
//
//  Created by LOVE on 2017/12/7.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HHTextField.h"


@interface HHTextField ()<UITextFieldDelegate>

@end

@implementation HHTextField

BOOL isHaveDian;

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self commonInit];
    }
    return self;
}

#pragma mark - commonInit
- (void)commonInit{
    
    _placeHolderFontSize = 15;
    _placeHolderColor = k9Color;
}
- (void)setLimitStr:(NSString *)limitStr{
    
    _limitStr = limitStr;
    if (!kStringIsEmpty(limitStr)) {
        self.delegate = self;
        
    }
    
}
#pragma mark - setter && getter

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    _placeHolderColor = placeHolderColor;
    
    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    
}
- (void)setPlaceHolderFontSize:(CGFloat)placeHolderFontSize{
    
    _placeHolderFontSize = placeHolderFontSize;
    [self setValue:[UIFont systemFontOfSize:placeHolderFontSize] forKeyPath:@"_placeholderLabel.font"];
    
}


- (void)setMaxLength:(NSInteger)maxLength{
    _maxLength = maxLength;
    
    if (_maxLength != 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange) name:UITextFieldTextDidChangeNotification object:self];
    }
}
- (void)textFieldTextDidChange{
    
    if(self.text.length >_maxLength){
        self.text = [self.text substringToIndex:_maxLength];
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return [self validateLimitStr:string];
}

- (BOOL)validateLimitStr:(NSString*)limitStr {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:_limitStr];
    int i = 0;
    while (i < limitStr.length) {
        NSString * string = [limitStr substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
#pragma mark - dealloc
- (void)dealloc{
    
   if (_maxLength != 0) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
    
}

@end
