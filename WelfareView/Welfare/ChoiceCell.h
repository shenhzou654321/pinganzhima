//
//  ChoiceCell.h
//  G-live
//
//  Created by leo on 2018/2/6.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceCell : UITableViewCell

@property (nonatomic,strong) UIButton *selectBut;
//@property (nonatomic,strong) UIImageView *selectImage;
@property (nonatomic,strong) UIImageView *iconImage;
@property (nonatomic,strong) UILabel *topicLabel;
@property (nonatomic,assign) BOOL isVote;//是投票/查看投票
@property (nonatomic,strong) NSString *voteId;//投票选项id

- (void)setSelectedWith:(NSArray *)arr;
//根据投票还是查看已投票设置图片
- (void)setSelectedButStyle:(BOOL)isVote;
/*
{
 voteId：投票选项id
 voteTitle：投票标题
 voteImgUrl：投票图片
 }
*/
- (void)setContentWith:(NSDictionary *)dic;

@end
