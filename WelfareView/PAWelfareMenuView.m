//
//  PAWelfareMenuView.m
//  G-live
//
//  Created by leo on 2018/2/1.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "PAWelfareMenuView.h"

@implementation PAWelfareMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBFromHexadecimal(0xffffff);
        self.imageArr = [[NSMutableArray alloc]initWithObjects:LoadIMG(@"skyclass_7_福利选择"),LoadIMG(@"Skyclass_10_员工关怀"),LoadIMG(@"skyclass_7_商家"),LoadIMG(@"skyclass_7_积分"), nil];
        self.titleArr = [[NSMutableArray alloc]initWithObjects:@"福利选择",@"员工关怀",@"优惠商家",@"积分兑换", nil];
        self.enTitleArr = [[NSMutableArray alloc]initWithObjects:@"Welfare choic",@"Employee care",@"Preferential merchants",@"Integral exchange", nil];
        [self setSubviews];
    }
    
    return self;
}

- (void)setSubviews {
    
    for (NSInteger i =0; i<self.imageArr.count;i++) {
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:but];
        but.center = CGPointMake(SCREENWIDTH/4.0*((i%2)*2+1), self.bounds.size.height/4.0*((i/2)*2+1)-5);
        but.bounds = CGRectMake(0, 0, 70, 65);
//        but.titleLabel.text = self.titleArr[i];
        [but setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [but setImage:self.imageArr[i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [but setTitleColor:RGBFromHexadecimal(0x333333) forState:UIControlStateNormal];
//        but.backgroundColor = [UIColor cyanColor];
        but.tag = 100+i;
        [but setImageEdgeInsets:UIEdgeInsetsMake(-10, 10, 0, 0)];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(45, -42, 0, 0)];
        [but addTarget: self action:@selector(choiceClick:) forControlEvents:UIControlEventTouchUpInside];
        switch (i) {
            case 0:
                _welfareBut = but;
                break;
            case 1:
                _topicBut = but;
                break;
            case 2:
                _preferentialBut = but;
                break;
            case 3:
                _integralBut = but;
                break;
            
            default:
                break;
        }
        
        UILabel *textLabel = [[UILabel alloc]init];
        [self addSubview:textLabel];
        textLabel.text = self.enTitleArr[i];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = RGBFromHexadecimal(0x999999);
        textLabel.font = [UIFont systemFontOfSize:6.f];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(but);
            make.top.mas_equalTo(but.mas_bottom);
            make.height.mas_equalTo(6);
        }];
    }
}

- (void)choiceClick:(UIButton *)sender {
    NSLog(@">>>>>>menu:%@",[sender currentTitle]);

    if (self.choiceBlock) {
        self.choiceBlock(sender.tag-100);
    }
//    if (sender.tag==100) {//福利选择
//        
//    }else if (sender.tag==101) {//优惠商家
//        
//    }else if (sender.tag==102) {//积分兑换
//        
//    }else {//话题调研
//        
//    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor colorFromHexString:@"#e6e6e6"].CGColor);
    CGContextMoveToPoint(context, 15, self.bounds.size.height/2.0);
    CGContextAddLineToPoint(context, SCREENWIDTH-15, self.bounds.size.height/2.0);
    
    CGContextMoveToPoint(context, SCREENWIDTH/2.0, 15);
    CGContextAddLineToPoint(context, SCREENWIDTH/2.0, self.bounds.size.height-15);
    
    CGContextStrokePath(context);
}


@end
