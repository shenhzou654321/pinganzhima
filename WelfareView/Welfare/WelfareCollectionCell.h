//
//  WelfareCollectionCell.h
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PAWelfareModel;

@interface WelfareCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *mainIcon;//主图片
@property (nonatomic,strong) UILabel *titleLabel;//帖子title
@property (nonatomic,strong) UILabel *contentLabel;//内容
@property (nonatomic,strong) UIImageView *typeImageView;//

- (void)setContentWith:(PAWelfareModel *)model;

@end
