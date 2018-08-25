//
//  ScrollChoiceView.m
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "ScrollChoiceView.h"
#import "WelfareDetailModel.h"
#import "ChoiceCell.h"

@interface ScrollChoiceView()<UITableViewDelegate,UITableViewDataSource> {
    
}
@property (nonatomic,copy) NSMutableArray *selectedArr;//选中的选项

@end

@implementation ScrollChoiceView
- (NSMutableArray *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = [[NSMutableArray alloc]init];
    }
    return _selectedArr;
}
- (void)setModel:(WelfareDetailModel *)model {
    _model = model;
    
    [self setContent];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addWelfareViews];
        
//        [self requestData];
    }
    
    return self;
}
- (void)requestData {
    self.model = [[WelfareDetailModel alloc]initWith:@{@"welfareTitle":@"投票标题的说法是否",@"welfareDesc":@"投票描述，多一点试试多排行多一点试试多排行多一点试试多排行多一点试试多排行多一点试试多排行多一点试试多排行多一点试试多排行多一点试试多排行多一点试试多排行威尔刚特",@"welfareCreatedDate":@"2018-02-03",@"welfareVoteEndDate":@"投票截止：2018-02-10 23:59",@"welfareVoteType":@"1",@"welfareVoteOrNo":@"0",@"welfareVoteSeleted":@[@{@"voteId":@"3-投票选项id",@"voteTitle":@"3-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"}],@"voteList":@[@{@"voteId":@"1voteid",@"voteTitle":@"1-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"},@{@"voteId":@"2voteid",@"voteTitle":@"2-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"},@{@"voteId":@"3voteid",@"voteTitle":@"3-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"},@{@"voteId":@"4voteid",@"voteTitle":@"4-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"},@{@"voteId":@"5voteid",@"voteTitle":@"5-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"},@{@"voteId":@"6voteid",@"voteTitle":@"6-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"},@{@"voteId":@"7voteid",@"voteTitle":@"7-投票选项标题",@"voteImgUrl":@"skyclass_7_商家"}]}];
    [self setContent];
    
    
    
}
- (void)addWelfareViews {
    self.welfareTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH-30, 15.f)];
    [self addSubview:_welfareTitleLabel];
    _welfareTitleLabel.font = [UIFont systemFontOfSize:15.f];
    _welfareTitleLabel.textColor = RGBFromHexadecimal(0x333333);
    [_welfareTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
//        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(SCREENWIDTH*0.75);
        make.height.mas_equalTo(15);
    }];
    
    self.welfareCreatedDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH-30, 15.f)];
    [self addSubview:_welfareCreatedDateLabel];
    _welfareCreatedDateLabel.font = [UIFont systemFontOfSize:12.f];
    _welfareCreatedDateLabel.textColor = RGBFromHexadecimal(0x999999);
    [_welfareCreatedDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_welfareTitleLabel);
        make.top.mas_equalTo(_welfareTitleLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(12);
    }];
    
    self.welfareDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH-30, 15.f)];
    [self addSubview:_welfareDescLabel];
    _welfareDescLabel.font = [UIFont systemFontOfSize:13.f];
    _welfareDescLabel.textColor = RGBFromHexadecimal(0x666666);
    _welfareDescLabel.numberOfLines = 0;
    [_welfareDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_welfareTitleLabel);
        make.top.mas_equalTo(_welfareCreatedDateLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREENWIDTH-30);
    }];
    
    self.voteListTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:_voteListTable];
    _voteListTable.delegate = self;
    _voteListTable.dataSource = self;
    _voteListTable.scrollEnabled = NO;
    _voteListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_voteListTable registerClass:[ChoiceCell class] forCellReuseIdentifier:@"cell"];
    [_voteListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_welfareDescLabel.mas_bottom).offset(15);
        
    }];
    
    self.welfareVoteEndDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREENWIDTH-30, 15.f)];
    [self addSubview:_welfareVoteEndDateLabel];
    _welfareVoteEndDateLabel.font = [UIFont systemFontOfSize:12.f];
    _welfareVoteEndDateLabel.textColor = RGBFromHexadecimal(0x999999);
    [_welfareVoteEndDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_welfareTitleLabel);
        make.top.mas_equalTo(_voteListTable.mas_bottom).offset(25);
        make.height.mas_equalTo(12);
    }];
    
    self.voteBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_voteBut];
//    [_voteBut setBackgroundColor:RGBFromHexadecimal(0xcccccc)];
    [_voteBut setBackgroundImage:LoadIMG(@"确认投票按钮") forState:UIControlStateNormal];
    [_voteBut setBackgroundImage:LoadIMG(@"确认投票按钮不可点") forState:UIControlStateSelected];
    
    [_voteBut setTitle:@"确认投票" forState:UIControlStateNormal];
//    [_voteBut setTitleColor:RGBFromHexadecimal(0x000000) forState:UIControlStateNormal];
    [_voteBut setTitleColor:RGBFromHexadecimal(0xffffff) forState:UIControlStateNormal];

//    [_voteBut setTitleColor:RGBFromHexadecimal(0xff894c) forState:UIControlStateSelected];
    [_voteBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_welfareVoteEndDateLabel.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(230, 40));
    }];
    _voteBut.selected = YES;
    
//    [self setNeedsLayout];
}

- (void)setContent {
    _welfareTitleLabel.text = _model.welfareTitle;
    
    _welfareCreatedDateLabel.text = _model.welfareCreatedDate;
    _welfareVoteEndDateLabel.text = _model.welfareVoteEndDate;
    
    if ([_model.welfareVoteOrNo isEqualToString:@"0"]) {
        _voteBut.enabled = YES;
        
        _voteListTable.allowsSelection = YES;
        
        if ([_model.welfareVoteType isEqualToString:@"0"]) {
            _voteListTable.allowsMultipleSelection = NO;
        }else {
            _voteListTable.allowsMultipleSelection = YES;
        }
    }else {
        [_voteBut setTitle:@"您已投票" forState:UIControlStateNormal];
        [_voteBut setBackgroundImage:LoadIMG(@"确认投票按钮-已点") forState:UIControlStateNormal];
        _voteBut.enabled = NO;
        
        _voteListTable.allowsSelection = NO;
    }
    
    NSString *finalDesc = [NSString stringWithFormat:@"%@%@",[_model.welfareVoteType isEqualToString:@"0"]? @"【单选】":@"【多选】",_model.welfareDesc];
    CGRect rect = [finalDesc boundingRectWithSize:CGSizeMake(SCREENWIDTH-30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} context:nil];
    self.frame = CGRectMake(0, 0, SCREENWIDTH, 155+55*_model.voteList.count+25+rect.size.height);//两行35
    _welfareDescLabel.text = finalDesc;
    [_voteListTable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_welfareDescLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(55*_model.voteList.count);
    }];
    [_voteListTable reloadData];
    
    NSInteger count = _model.voteList.count;
    LeoLog(@">>>>%ld",count);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.voteList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell) {
        
        NSDictionary *dic = self.model.voteList[indexPath.row];
        [cell setContentWith:dic];
        
        BOOL isVote = [_model.welfareVoteOrNo isEqualToString:@"0"];
        [cell setSelectedButStyle:isVote];
        
        if (isVote) {//投票

        }else {//查看已投票
            tableView.allowsSelection = NO;
            [cell setSelectedWith:_model.welfareVoteSeleted];
        }
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView indexPathsForSelectedRows];
    
    _voteBut.selected = YES;
    if ([_model.welfareVoteType isEqualToString:@"0"]) {//单选
        NSIndexPath *index = [tableView indexPathForSelectedRow];
        if (index) {
            _voteBut.selected = NO;
        }
    }else {
        NSArray *arr = [tableView indexPathsForSelectedRows];
        if (arr.count>0) {
            _voteBut.selected = NO;
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    _voteBut.selected = YES;
    if ([_model.welfareVoteType isEqualToString:@"0"]) {//单选
        NSIndexPath *index = [tableView indexPathForSelectedRow];
        if (index) {
            _voteBut.selected = NO;
        }
    }else {
        NSArray *arr = [tableView indexPathsForSelectedRows];
        if (arr.count>0) {
            _voteBut.selected = NO;
        }
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
