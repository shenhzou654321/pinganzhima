//
//  CycleTopicView.h
//  G-live
//
//  Created by leo on 2018/2/8.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WelfareCycleModel;

@interface CycleTopicView : UIView

@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *lineLabel;
@property (nonatomic,strong) UILabel *topicLabel;
@property (nonatomic,strong) UIImageView *typeImageView;

- (void)setContentWith:(WelfareCycleModel *)model;

@end
