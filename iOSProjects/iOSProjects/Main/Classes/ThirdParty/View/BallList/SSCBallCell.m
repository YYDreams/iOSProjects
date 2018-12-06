//
//  SSCBallCell.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCBallCell.h"
#import "SSCCellContentView1.h"
#import "SSCCellContentView2.h"
#import "SSCCellContentView3.h"
@interface SSCBallCell()

@property (nonatomic,strong)SSCCellContentView1 *view1;
@property (nonatomic,strong)SSCCellContentView2 *view2;
@property (nonatomic,strong)SSCCellContentView3 *view3;

@end


@implementation SSCBallCell

+ (NSString *)getCellIdentifier:(UITableViewCellType )cellType{
    
    if (cellType == UITableViewCell_Type1) {
        return @"UITableViewCell_Type1";
    }
    else if (cellType == UITableViewCell_Type2) {
        return @"UITableViewCell_Type2";
    }
    else if (cellType == UITableViewCell_Type3) {
        return @"UITableViewCell_Type3";
    }
    return @"";
}



+ (CGFloat)getHight:(SSCBallCellModel *)model cellType:(UITableViewCellType)cellType{
    
    if (cellType == UITableViewCell_Type1) {
        return [SSCCellContentView1 getHeight:model];
    }
    else if (cellType == UITableViewCell_Type2) {
        return [SSCCellContentView2 getHeight:model];
    }
    else if (cellType == UITableViewCell_Type3) {
        return [SSCCellContentView3 getHeight:model];
    }
    return 0;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(UITableViewCellType)cellType{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _cellType = cellType;
        
        [self setupSubView];
        
    }
    return self;
    
}


- (void)setModel:(SSCBallCellModel *)model{
    
    _model = model;
    if (self.cellType == UITableViewCell_Type1) {
        self.view1.model = model;
    } else if (self.cellType == UITableViewCell_Type2) {
        self.view2.model = model;
    } else if (self.cellType == UITableViewCell_Type3) {
        
        self.view3.model = model;
    }
}
- (void)setDidChangeSelectBall:(void (^)(NSArray *))didChangeSelectBall{
//    if (self.cellType == UITableViewCell_Type1) {
//        self.view1.didChangeSelectBall = didChangeSelectBall;
//    }
//    else if (self.cellType == UITableViewCell_Type2) {
//        self.view2.didChangeSelectBall = didChangeSelectBall;
//    }
//    else
        if (self.cellType == UITableViewCell_Type3) {
            
            self.view3.didChangeSelectBall = didChangeSelectBall;
            
    }
    
    
    
    
    
}

- (void)setupSubView{
    
    
    if (_cellType == UITableViewCell_Type1) {
        SSCCellContentView1 *view1 = [[SSCCellContentView1 alloc] initWithFrame:CGRectZero];
        view1.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:view1];
        self.view1 = view1;
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    else if (_cellType == UITableViewCell_Type2) {
        SSCCellContentView2 *view2 = [[SSCCellContentView2 alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:view2];
        view2.backgroundColor = [UIColor orangeColor];
        self.view2 = view2;
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    } else if (_cellType == UITableViewCell_Type3) {
        SSCCellContentView3 *view3 = [[SSCCellContentView3 alloc] initWithFrame:CGRectZero];
            view3.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:view3];
        self.view3 = view3;
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
}



@end
