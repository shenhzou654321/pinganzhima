//
//  PAWelfareMenuView.h
//  G-live
//
//  Created by leo on 2018/2/1.
//  Copyright © 2018年 Leo. All rights reserved.
//
typedef void(^BackChoiceBlock)(NSInteger index);

#import <UIKit/UIKit.h>

@interface PAWelfareMenuView : UIView

@property (nonatomic,strong) UIButton *welfareBut;//福利选择
@property (nonatomic,strong) UIButton *preferentialBut;//优惠商家
@property (nonatomic,strong) UIButton *integralBut;//积分兑换
@property (nonatomic,strong) UIButton *topicBut;//员工关怀

@property (nonatomic,copy) BackChoiceBlock choiceBlock;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSMutableArray *enTitleArr;
@end
