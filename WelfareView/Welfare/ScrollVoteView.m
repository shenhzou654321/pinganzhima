//
//  ScrollVoteView.m
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "ScrollVoteView.h"
#import "VoteRateView.h"
#import "WelfareVoteModel.h"

@implementation ScrollVoteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.titleArr = @[@"选项1：",@"选项2：",@"选项3："];
//        self.rateArr = @[@"70%",@"20%",@"10%"];
//        self.valueArr = @[@(0.7),@(0.2),@(0.1)];
        [self addSubViews];
    }
    
    return self;
}

- (void)addSubViews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 200, 20)];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    titleLabel.textColor = RGBFromHexadecimal(0x333333);
    titleLabel.text = @"当前投票统计:";
    
    CGRect rectItem = [self.titleArr[0] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} context:nil];
    CGFloat width = 0.0;
    for (NSInteger i =0; i<self.rateArr.count; i++) {
        CGRect rectRate = [self.rateArr[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} context:nil];
        width = MAX(width, rectRate.size.width);
    }
    
    for (NSInteger i=0; i<self.titleArr.count; i++) {
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+(15+20)*i+10, rectItem.size.width+5, 15)];
        [self addSubview:itemLabel];
        itemLabel.font = [UIFont systemFontOfSize:13.f];
        itemLabel.textColor = RGBFromHexadecimal(0x666666);
        itemLabel.text = self.titleArr[i];
        
        UILabel *rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-width-15, CGRectGetMinY(itemLabel.frame), width+5, 15)];
        [self addSubview:rateLabel];
        rateLabel.font = [UIFont systemFontOfSize:13.f];
        rateLabel.textColor = RGBFromHexadecimal(0x666666);
        rateLabel.text = self.rateArr[i];
        
        
        
        VoteRateView *progressView = [VoteRateView initCommenProgressView];
        NSUInteger cHeight = 10; //高度
        progressView.frame = CGRectMake(CGRectGetMaxX(itemLabel.frame), CGRectGetMinY(itemLabel.frame)+3,CGRectGetMinX(rateLabel.frame)-CGRectGetMaxX(itemLabel.frame)-15 , cHeight);

        CGFloat value = [self.valueArr[i] floatValue]; //进度条的值

        progressView.progressValue = value;
        progressView.progressBackGroundColor = RGBFromHexadecimal(0xe8e9f0);
        progressView.progressTintColor = RGBFromHexadecimal(0xff894c);
        [self addSubview:progressView];
    }
}
- (void)setContent {
    if (_modelArr.count>0) {
        NSMutableArray *titleArray = [[NSMutableArray alloc]init];
        NSMutableArray *rateArray = [[NSMutableArray alloc]init];
        NSMutableArray *valueArray = [[NSMutableArray alloc]init];
        for (NSInteger i=0; i<_modelArr.count; i++) {
            WelfareVoteModel *model = _modelArr[i];
            [titleArray addObject:[NSString stringWithFormat:@"选项%ld",i+1]];
            [rateArray addObject:[NSString stringWithFormat:@"%.2f%@",[model.votePercentge floatValue]*100,@"%"]];
            [valueArray addObject:model.votePercentge];
        }
        self.titleArr = titleArray;
        self.valueArr = valueArray;
        self.rateArr = rateArray;
        
        [self addSubViews];
    }
    
}
- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    
    [self setContent];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
