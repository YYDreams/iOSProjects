//
//  UILabel+HHAddition.m
//  LYYGame
//
//  Created by 花花 on 2017/5/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "UILabel+HHAddition.h"

@implementation UILabel (HHAddition)
+ (instancetype)labelText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment{

    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = kFont(fontSize);
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}


- (UILabel *)autoSizeVertical {
    return [self autoSizeVertical:0];
}
- (UILabel *)autoSizeHorizontal {
    return [self autoSizeHorizontal:0];
}
- (UILabel *)autoSizeHorizontal:(CGFloat)minWidth {
    
    CGRect newFrame = self.frame;
    
    CGSize autoSize = CGSizeMake(CGFLOAT_MAX, self.frame.size.height);
    
    NSString *string = self.text;
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.lineBreakMode = NSLineBreakByCharWrapping;
        
        NSDictionary *dic = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:style.copy};
        
        CGSize size = [string boundingRectWithSize:autoSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:dic context:nil].size;
        
        newFrame.size.width = ceil(size.width)+0.5;
    }
    if (minWidth > 0) {
        newFrame.size.width = (minWidth > newFrame.size.width)?minWidth:newFrame.size.width;
    }
    self.frame = newFrame;
    return self;
}
- (UILabel *)autoSizeVertical:(CGFloat)minHeigh {
    CGRect newFrame = self.frame;
    
    CGSize autoSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    
    NSString *string = self.text;
    
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        
        style.lineBreakMode = NSLineBreakByCharWrapping;
        
        NSDictionary *dic = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:style.copy};
        
        CGSize size = [string boundingRectWithSize:autoSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:dic context:nil].size;
        
        newFrame.size.height = ceil(size.height)+0.5;
    }
    if (minHeigh > 0) {
        newFrame.size.height = (minHeigh > newFrame.size.height)?minHeigh:newFrame.size.height;
    }
    self.frame = newFrame;
    return self;
}
#pragma mark - 改变行间距
- (void)hh_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:textLineSpace];
    [self hh_changeParagraphStyleWithTextParagraphStyle:paragraphStyle];
}
#pragma mark - 段落样式
- (void)hh_changeParagraphStyleWithTextParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [self setAttributedText:attributedString];
}
@end
