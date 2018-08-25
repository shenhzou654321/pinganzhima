//
//  VoteRateView.m
//  G-live
//
//  Created by leo on 2018/2/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "VoteRateView.h"

@interface VoteRateView ()

@property (strong,nonatomic) UIView *firstView;
@property (strong,nonatomic) UIView *secondView;
//@property (strong,nonatomic) UILabel *progressLabel;

@end

@implementation VoteRateView

+ (instancetype)initCommenProgressView{
    return [[self alloc]init];
}

- (UIView *)firstView{
    if (_firstView == nil){
        UIView *fView = [[UIView alloc]init];
        fView.backgroundColor = _progressBackGroundColor;
        fView.layer.masksToBounds = YES;
        fView.layer.cornerRadius = _progressCornerRadius;
        [self addSubview:fView];
        _firstView = fView;
    }
    return _firstView;
}

- (UIView *)secondView{
    if (_secondView == nil){
        UIView *sView = [[UIView alloc]init];
        sView.backgroundColor = _progressTintColor;
//        sView.layer.masksToBounds = YES;
//        sView.layer.cornerRadius = _progressCornerRadius;
        [self.firstView addSubview:sView];
        _secondView = sView;
    }
    return _secondView;
}
/*
- (UILabel *)progressLabel{
    if (_progressLabel == nil){
        UILabel *lb = [[UILabel alloc]init];
        lb.textAlignment = NSTextAlignmentRight;
        CGFloat value = _progressValue * 100;
        NSString *valueStr = [[NSString stringWithFormat:@"%.1f",value]stringByAppendingString:@"%"];
        lb.text = valueStr;
        lb.textColor = [UIColor whiteColor];
        _progressLabel = lb;
        [self insertSubview:lb aboveSubview:_secondView];
    }
    return _progressLabel;
}
*/


- (void)layoutSubviews{
    [super layoutSubviews];
    self.secondView.frame = CGRectMake(0, 0, self.frame.size.width * _progressValue, self.frame.size.height);
    self.firstView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    self.progressLabel.frame = CGRectMake(-10, 0, self.frame.size.width, self.frame.size.height);
    
}

#pragma mark - set&&get
- (void)setProgressBackGroundColor:(UIColor *)progressBackGroundColor{
    
    _progressBackGroundColor = progressBackGroundColor;
}

- (void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor{
    self.layer.borderColor = progressTintColor.CGColor;
    
    _progressTintColor = progressTintColor;
}


- (void)setProgressCornerRadius:(NSInteger)progressCornerRadius{
    
    _progressCornerRadius = progressCornerRadius;
}

- (void)setProgressBorderWidth:(NSInteger)progressBorderWidth{
    self.layer.borderWidth = progressBorderWidth;
    _progressBorderWidth = progressBorderWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
