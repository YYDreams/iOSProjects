//
//  BaseCell.h
//  iOSProjects
//
//  Created by flowerflower on 2018/8/22.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellID:(NSString *)cellID style:(UITableViewCellStyle)style;

@end
