//
//  CycleTopicView.m
//  G-live
//
//  Created by leo on 2018/2/8.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "CycleTopicView.h"
#import "WelfareCycleModel.h"

@implementation CycleTopicView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
//        self.backgroundColor = [UIColor colorWithPatternImage:LoadIMG(@"banner遮罩")];
        [self setSubViews];
    }
    
    return self;
}

- (void)setSubViews {
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, [self getHeight]-100, self.bounds.size.width, 100)];
    [self addSubview:bgview];
    bgview.backgroundColor = [UIColor colorWithPatternImage:LoadIMG(@"banner遮罩")];
    self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, [self getHeight]-70, self.bounds.size.width, 20)];
    [self addSubview:_typeLabel];
    _typeLabel.font = [UIFont systemFontOfSize:12.f];
    _typeLabel.textColor = RGBFromHexadecimal(0xffffff);
    
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, [self.typeLabel getBottom], 100, 5)];
    [self addSubview:_lineLabel];
    _lineLabel.text = @"//////////";
    _lineLabel.font = [UIFont systemFontOfSize:12.f];
    _lineLabel.textColor = RGBFromHexadecimal(0xffffff);
    
    self.topicLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, [self.lineLabel getBottom], self.bounds.size.width, 25)];
    [self addSubview:_topicLabel];
    _topicLabel.font = [UIFont systemFontOfSize:15.f weight:UIFontWeightBlack];
    _topicLabel.textColor = RGBFromHexadecimal(0xffffff);
    
    self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,15, 60, 20)];
    [self addSubview:self.typeImageView];
    self.typeImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.typeImageView.hidden = YES;
    
}

- (void)setContentWith:(WelfareCycleModel *)model {
    _typeLabel.text = model.welfareType;
    _topicLabel.text = model.welfareTitle;
    self.typeImageView.hidden = YES;
    if ([model.startDate longLongValue]/1000 > [[NSDate date] timeIntervalSince1970]) {
        self.typeImageView.image = [UIImage imageNamed:@"Skyclass_10_未开始"];
        self.typeImageView.hidden = NO;
    }
    else if([model.endDate longLongValue]/1000 < [[NSDate date] timeIntervalSince1970])
    {
        self.typeImageView.image = [UIImage imageNamed:@"Skyclass_10_已结束"];
        self.typeImageView.hidden = NO;
    }
    else
    {
        self.typeImageView.image = [UIImage imageNamed:@"Skyclass_10_进行中"];
        self.typeImageView.hidden = NO;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
