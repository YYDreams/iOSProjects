//
//  SSCBallCell.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCBallCellModel.h"
typedef NS_ENUM(NSInteger,UITableViewCellType) {
    UITableViewCell_Type1 = 1,//圆圈(带“全大小单双清”)
    UITableViewCell_Type2,//方块
    UITableViewCell_Type3,//六合彩圆圈
};
@interface SSCBallCell : UITableViewCell


@property(nonatomic,strong)SSCBallCellModel *model;


@property (nonatomic,strong)NSIndexPath *indexPath;//所在的索引


@property (nonatomic,assign)UITableViewCellType cellType;//cell的类型

@property (nonatomic,copy)void (^didChangeSelectBall)(NSArray *selectBalls);//选球改变



+ (NSString *)getCellIdentifier:(UITableViewCellType )cellType;


+ (CGFloat)getHight:(SSCBallCellModel *)model cellType:(UITableViewCellType)cellType;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(UITableViewCellType)cellType;

@end
