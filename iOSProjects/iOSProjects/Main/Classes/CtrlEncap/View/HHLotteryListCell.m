//
//  HHLotteryListCell.m
//  iOSProjects
//
//  Created by flowerflower on 2018/11/9.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHLotteryListCell.h"
#import <UIImageView+WebCache.h>
@implementation HHLotteryListCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.resultWidthConst.constant = Screen_Width  - ( 50 + 45 + 15 * 3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HHLotteryListModel *)model{
    
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.open_img] placeholderImage:defaultPlaceholderImage];
    self.nameLabel.text = model.name;
    self.lottery_numberLabel.text = [NSString stringWithFormat:@"第%zd期",model.lottery_number];
    
    
    NSArray *numers = nil;
    NSString *result = nil;
    int number = 0;
    
   numers =  [model.period_code componentsSeparatedByString:@","];

    for (NSString *code in numers) {
        number += code.integerValue;
        
    }
    result = [NSString stringWithFormat:@"%d",number];
    
    [_resultView addNumbers:numers result:result type:HHResultViewTypeSymbol];
    
    
    
    
}


@end
