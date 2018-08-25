//
//  ChoiceCell.m
//  G-live
//
//  Created by leo on 2018/2/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "ChoiceCell.h"

@implementation ChoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    self.selectBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_selectBut];
    [_selectBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(7);
        make.bottom.mas_equalTo(-8);
        make.width.mas_equalTo(40);
    }];
    _selectBut.userInteractionEnabled = NO;//触摸事件交给superview

//    self.selectImage = [[UIImageView alloc]initWithFrame:CGRectZero];
//    [self.contentView addSubview:_selectImage];
//    _selectImage.contentMode = UIViewContentModeCenter;
//    [_selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(5);
//        make.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(40);
//
//    }];
    
    
    self.iconImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selectBut.mas_right).offset(5);
        make.top.bottom.width.equalTo(_selectBut);
        
    }];
    
    self.topicLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_topicLabel];
    _topicLabel.textColor = RGBFromHexadecimal(0x666666);
    _topicLabel.font = [UIFont systemFontOfSize:13.f];
    [_topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImage.mas_right).offset(10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
}
//根据投票还是查看已投票设置图片
- (void)setSelectedButStyle:(BOOL)isVote {
    self.isVote = isVote;
    if (isVote) {
        [_selectBut setImage:LoadIMG(@"skyclass_7_投票单选") forState:UIControlStateNormal];
        [_selectBut setImage:LoadIMG(@"skyclass_7_投票选中") forState:UIControlStateSelected];

    }else {
        [_selectBut setImage:LoadIMG(@"skyclass_7_已投票默认") forState:UIControlStateNormal];
        [_selectBut setImage:LoadIMG(@"skyclass_7_已投票选中") forState:UIControlStateSelected];

    }
}
/*
 {
 voteId：投票选项id
 voteTitle：投票标题
 voteImgUrl：投票图片
 }
 */
- (void)setContentWith:(NSDictionary *)dic {
    self.voteId = dic[@"voteId"];
//    self.iconImage.image = LoadIMG(dic[@"voteImgUrl"]);
    self.topicLabel.text = dic[@"voteTitle"];
    [self loadImage:dic[@"voteImgUrl"]];
}
- (void)loadImage:(NSString *)url {
//    if ([key isEqualToString:@"voteList"]) {
                NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:url];
        #ifdef PATest
                NSRange range = [url rangeOfString:@"api.pingan.com.cn"];
                if (range.length>0) {
                    [mutableStr insertString:@":20080" atIndex:NSMaxRange(range)];
                    if (![mutableStr containsString:@"test-"]) {
                        [mutableStr insertString:@"test-" atIndex:range.location];
                    }
                }else {
                    self.iconImage.image = LoadIMG(@"SkyClass_默认无图-大图");
//                    if (self.backImageBlock) {
//                        self.backImageBlock(self.iconImage);
//                    }
                    return;
                }
        
        #else
        
        #endif
        
//                self.welfareImgUrl = mutableStr;
    
    [self requestImage:mutableStr];
        
//            }
}
- (void)requestImage:(NSString *)imageUrl {
    NSRange rangeTest = [imageUrl rangeOfString:@"getImage?imageUrl="];
    if (rangeTest.length>0) {
        NSString *subStrTest = [imageUrl substringFromIndex:NSMaxRange(rangeTest)];
        if (subStrTest.length<=0) {
            //            self.iconImage = LoadIMG(@"SkyClass_默认无图-大图");
            return;
        }
        
        if ([imageUrl containsString:@"getImage?imageUrl="]) {
            
        }else {
            //            self.iconImage = LoadIMG(@"SkyClass_默认无图-大图");
            return;
        }
        
        NSRange range1 = [imageUrl rangeOfString:@"getImage?imageUrl="];
        NSString *subStr1 = [imageUrl substringFromIndex:NSMaxRange(range1)];
        if (subStr1.length>4) {
            NSString *subStr2 = [subStr1 substringToIndex:subStr1.length-4];
            NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:subStr2];
            if (imageData) {
                self.iconImage.image = [UIImage imageWithData:imageData];
                
                LeoLog(@">>>>已有缓存图片数据>>>>return");
                return;
            }
        }else {
            //            self.iconImage = LoadIMG(@"SkyClass_默认无图-大图");
        }
        
        
        
        [[PublicTool sharedInstance] requestImageWithDomain:imageUrl returnBlock:^(NSDictionary * _Nullable responseDic) {
            if ([responseDic[@"code"] longValue]==10000) {
                NSDictionary *subDic = responseDic[@"data"];
                NSData* imageData = [[NSData alloc] initWithBase64EncodedString:subDic[@"imageCode"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                
                NSRange range1 = [imageUrl rangeOfString:@"getImage?imageUrl="];
                NSString *subStr1 = [imageUrl substringFromIndex:NSMaxRange(range1)];
                NSString *subStr2 = [subStr1 substringToIndex:subStr1.length-4];
                LeoLog(@">>>>缓存图片数据>>>>请求");
                [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:subStr2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.iconImage.image = [UIImage imageWithData:imageData];
                });
                
               
            }else {

            }
            
        }];
    }else {

        
    }
}
//已投票设置选中
- (void)setSelectedWith:(NSArray *)arr {
    _selectBut.selected = NO;
    for (NSString *voteId in arr) {
        if ([voteId isEqualToString:self.voteId]) {
            _selectBut.selected = YES;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (_isVote) {
        if (selected) {
            self.selectBut.selected = YES;
        }else {
            self.selectBut.selected = NO;
        }
    }
    


    // Configure the view for the selected state
}
//- (void)click:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    [self setSelected:sender.selected animated:NO];
//}
@end
