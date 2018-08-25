//
//  VoteRateView.h
//  G-live
//
//  Created by leo on 2018/2/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoteRateView : UIView

//你还可以根据自己的需要创建其他的属性
@property (strong,nonatomic) UIColor *progressBackGroundColor;       //背景色
@property (strong,nonatomic) UIColor *progressTintColor;             //进度条颜色
@property (assign,nonatomic) CGFloat progressValue;                  //进度条进度的值
@property (assign,nonatomic) NSInteger progressCornerRadius;         //进度条圆角
@property (assign,nonatomic) NSInteger progressBorderWidth;          //进度条边宽度


+ (instancetype)initCommenProgressView;  //初始化构造方法

@end
