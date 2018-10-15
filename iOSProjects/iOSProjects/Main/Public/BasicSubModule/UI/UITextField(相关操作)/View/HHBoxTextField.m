//
//  HHBoxTextField.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/23.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHBoxTextField.h"

@interface HHBoxTextField()<UITextFieldDelegate>


@property(nonatomic,assign) NSInteger  maxTextCount;  // 最多输入位数

@property(nonatomic,strong) NSMutableArray *labelArr;  // <#注释#>

@property(nonatomic,strong) NSMutableArray *textArr;  // <#注释#>


@property(nonatomic,copy) void (^editFinish)(NSString *text);
@end

static NSString *const  secureTextEntry = @"●";
static CGFloat const orginXY = 0.0;
@implementation HHBoxTextField

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count textEntry:(BOOL)textEntry editDone:(void (^)(NSString *))done{
    
    if (self  = [super initWithFrame:frame]) {
        
        self.limitStr = @"0123456789";
        [self boxInput:count textEntry:textEntry editDone:done];
    }
    return self;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.limitStr = @"0123456789";
    }
    return self;
}
- (instancetype)init{
    if (self = [super init] ) {
        
        self.limitStr = @"0123456789";
    }
    return self;
    
}


- (void)boxInput:(NSInteger)count textEntry:(BOOL)textEntry editDone:(void (^)(NSString *))done{
    
    if (0 < count) {
        
        self.delegate = self;
        
        _maxTextCount = count;
        self.secureTextEntry = textEntry;
        self.editFinish = [done copy];
        //        self.handlerConfirmTextCallBack = [done copy];
        self.tintColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor clearColor];
        [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        
        self.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.textAlignment = NSTextAlignmentCenter;
        
        CGFloat heightSelf = CGRectGetHeight(self.bounds);
        
        
        CGFloat originXItem = orginXY;
        CGFloat originYItem = orginXY;
        CGFloat sizeItem = (heightSelf - 2 * originYItem);
        CGFloat widthTotal = sizeItem * _maxTextCount + (_maxTextCount -1) * originXItem;
        
        if (widthTotal > CGRectGetWidth(self.bounds)) {
            
            // 大于自身宽度时
            sizeItem = (CGRectGetWidth(self.bounds) - (_maxTextCount * (originXItem + 1))) / _maxTextCount;
            originYItem = (heightSelf - sizeItem) / 2;
        }else if (widthTotal < CGRectGetWidth(self.bounds)){
            
            // 小于自身宽度时
            originXItem = (CGRectGetWidth(self.bounds) - sizeItem * _maxTextCount) / (_maxTextCount - 1);
        }
        
        self.labelArr = [[NSMutableArray alloc]initWithCapacity:_maxTextCount];
        
        for (int i = 0; i < _maxTextCount; i++) {
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i * (sizeItem + originXItem)), originYItem, sizeItem, sizeItem)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            label.layer.masksToBounds = YES;
            label.layer.borderWidth = 0.5;
            label.layer.borderColor = [UIColor colorWithHexString:@"D0D0D0"].CGColor;
            label.font = [UIFont systemFontOfSize:(sizeItem * 0.5)];
            [self addSubview:label];
            
            [self.labelArr addObject:label];
        }
        
        self.textBordColor = [UIColor blackColor];
        self.textBackgroundColor = [UIColor whiteColor];
        self.textCornRadius = 3.0;
        
        
        self.textArr = [[NSMutableArray alloc]initWithCapacity:_maxTextCount];
    }
    
    
    
    
}
- (void)setTextBackgroundColor:(UIColor *)textBackgroundColor{
    
    _textBackgroundColor = textBackgroundColor;
    
    
    for (int i = 0; i< _maxTextCount; i++) {
        
        UILabel *label = self.labelArr[i];
        label.backgroundColor = _textBackgroundColor;
    }
    
}
- (void)setTextBordColor:(UIColor *)textBordColor{
    _textBordColor = textBordColor;
    
    for (int i = 0; i< _maxTextCount; i++) {
        
        UILabel *label = self.labelArr[i];
        label.layer.borderColor = _textBordColor.CGColor;
    }
    
}
- (void)setTextCornRadius:(CGFloat)textCornRadius{
    _textCornRadius  = textCornRadius;
    
    for (int i = 0; i<_maxTextCount; i++) {
        
        UILabel *label = self.labelArr[i];
        label.layer.cornerRadius = _textCornRadius;
        
    }
}
- (void)setFontSize:(CGFloat)fontSize{
    
    _fontSize = fontSize;
    
    for (int i = 0; i < _maxTextCount; i++) {
        UILabel *label = self.labelArr[i];
        label.font  = kFont(fontSize);
    }
}
- (void)setColor:(UIColor *)color{
    _color = color;
    
    for (int i = 0; i< _maxTextCount; i++) {
        
        UILabel *label = self.labelArr[i];
        label.textColor = _color;
    }
    
}
- (BOOL)limitTextChareacter:(NSString *)limitCharecter limitNumber:(NSInteger)limitNumber string:(NSString *)string{
    
    NSInteger length = self.textArr.count;
    
    if (length > limitNumber) {
        
        return NO;
    }else{
        
        
        if (limitCharecter && 0 < limitCharecter.length) {
            
            if ([limitCharecter containsString:string]) {
                return YES;
            }else{
                return NO;
            }
            
        }
        
    }
    
    
    
    return YES;
}
- (void)showLabelText{
    
    
    for (int i = 0; i < _maxTextCount; i++) {
        
        
        UILabel *label = self.labelArr[i];
        
        NSString *text  = (i < self.textArr.count ? self.textArr[i]: @"");
        label.text = ((self.secureTextEntry && 0 != text.length)? secureTextEntry: text);
        
        NSLog("-----------%@",label.text);
    }
    
    if (self.editFinish && self.textArr.count >0) {
        
        NSMutableString *textStr = [[NSMutableString alloc]initWithCapacity:self.textArr.count];
        
        for (NSString *string in self.textArr) {
            [textStr appendString:string];
        }
        if (_handlerConfirmTextCallBack) {
            _handlerConfirmTextCallBack(textStr);
        }
    }
    if (self.editFinish && self.textArr.count == _maxTextCount) {
        
        NSMutableString *textStr = [[NSMutableString alloc]initWithCapacity:_maxTextCount];
        
        for (NSString *string in self.textArr) {
            [textStr appendString:string];
        }
        self.editFinish(textStr);
        
    }
    
    
    
}
- (void)textFieldEditChanged:(UITextField *)textField{
    
    //    self.editFinish(textField.text);
    //    if (_handlerConfirmTextCallBack) {
    //        _handlerConfirmTextCallBack(textField.text);
    //    }
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController)
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    
    
    
    if ([string isEqualToString:@"\n"]){
        
        [textField resignFirstResponder];
        
        return NO;
    }
    
    if ([textField isFirstResponder]) {
        
        
        BOOL isReuslt = [self limitTextChareacter:self.limitStr limitNumber:_maxTextCount string:string];
        
        if ([string isEqualToString:@""]) {
            
            [self.textArr removeLastObject];
        }else{
            
            if (self.textArr.count < _maxTextCount &&  isReuslt) {
                
                [self.textArr addObject:string];
            }
        }
        [self performSelector:@selector(showLabelText) withObject:nil afterDelay:0.1];
        
        return isReuslt;
    }
    
    
    return YES;
}

- (void)clearInput{
    
    [self.labelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        label.text = nil;
    }];
    
    [self.textArr removeAllObjects];
}

@end
