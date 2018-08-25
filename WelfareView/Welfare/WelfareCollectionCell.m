//
//  WelfareCollectionCell.m
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "WelfareCollectionCell.h"
#import "PAWelfareModel.h"

@implementation WelfareCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUp];
    }
    
    return self;
}
- (void)setUp {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH*0.75, 15)];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:15.f];
    _titleLabel.textColor = RGBFromHexadecimal(0x333333);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(15);
    }];
    self.mainIcon = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_mainIcon];
    [_mainIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleLabel);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo((SCREENWIDTH-30)*0.6);
    }];
    
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH*0.75, 15)];
    [self.contentView addSubview:_contentLabel];
    _contentLabel.font = [UIFont systemFontOfSize:15.f];
    _contentLabel.numberOfLines = 2;
    _contentLabel.textColor = RGBFromHexadecimal(0x333333);

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mainIcon.mas_bottom).offset(10);
        make.left.right.equalTo(_titleLabel);
//        make.bottom.mas_equalTo(-15);
    }];
    
    self.typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (SCREENWIDTH-30)*0.6-35, 60, 20)];
    [self.mainIcon addSubview:self.typeImageView];
    self.typeImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.typeImageView.hidden = YES;
    
    
}
- (void)setContentWith:(PAWelfareModel *)model {
    if([model.welfareType intValue] == 1)
    {
        self.titleLabel.text = [NSString stringWithFormat:@"%@%@",@"「福利选择」",model.welfareTitle];
    }
    else
    {
        self.titleLabel.text = [NSString stringWithFormat:@"%@%@",@"「员工关怀」",model.welfareTitle];
    }
    
    self.contentLabel.text = model.welfareDesc;
    self.mainIcon.image = model.iconImage;
    self.typeImageView.hidden = YES;
//    if([model.welfareType intValue] == 1)
//    {
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
//    }
    
    
}
@end
