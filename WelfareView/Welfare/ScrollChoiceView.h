//
//  ScrollChoiceView.h
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareDetailModel.h"

@interface ScrollChoiceView : UIView

@property (nonatomic,strong) WelfareDetailModel *model;

@property (nonatomic,strong) UILabel *welfareTitleLabel;//福利title
@property (nonatomic,strong) UILabel *welfareCreatedDateLabel;//福利发布时间
@property (nonatomic,strong) UILabel *welfareDescLabel;//福利描述
@property (nonatomic,strong) UILabel *welfareVoteEndDateLabel;//福利投票截止日期
@property (nonatomic,strong) UIButton *voteBut;//投票

@property (nonatomic,strong) UITableView *voteListTable;//选项表
@end
