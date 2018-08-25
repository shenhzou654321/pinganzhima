//
//  PAWelfareCycleView.m
//  G-live
//
//  Created by leo on 2018/2/1.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import "PAWelfareCycleView.h"
#import "JLAdvertisingScrollView.h"

#import "CycleTopicView.h"

@interface PAWelfareCycleView ()<HJCActionSheetDelegate>
{
   WelfareCycleModel *birdthModel;
}
@property (nonatomic,strong) JLAdvertisingScrollView *topScrollView;
@property (nonatomic,strong) CycleTopicView *topView;

@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,copy) NSMutableArray *dataArr;
@end;

@implementation PAWelfareCycleView
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self requestData];
    }
    
    return self;
}
- (void)requestData {

    __block PAWelfareCycleView *weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[PublicTool getUserInfo]];
    [dic removeObjectForKey:PApasswordKeY];
    [dic setObject:@(1) forKey:@"pageNum"];
//    [dic setObject:@(20) forKey:@"pageSize"];
    [[PublicTool sharedInstance] requestWithDomain:[NSString stringWithFormat:@"welfareHomeConfig?access_token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PATokenKey]] parama:dic returnBlock:^(NSDictionary *responseDic) {
        
        if ([responseDic[@"code"] longValue]==10000) {
            NSDictionary *subDic = responseDic[@"data"];
            birdthModel = [[WelfareCycleModel alloc] initWith:subDic];
            NSArray *subArr = subDic[@"configList"];
            //            NSMutableArray *listArray = [[NSMutableArray alloc]initWithCapacity:20];
            if (subArr.count>0) {
                [weakSelf.dataArr removeAllObjects];
                for (NSDictionary *subDic in subArr) {
                    WelfareCycleModel *model = [[WelfareCycleModel alloc]initWith:subDic];
                    model.backImageBlock = ^(UIImage *image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf setCycleScroll];
                        });
                        
                    };
                    [weakSelf.dataArr addObject:model];
                }
                [weakSelf setCycleScroll];
                
            }else {

                LeoLog(@">>>>>请求成功——我上传的--无数据");
            }
 
            
        }else {
            LeoLog(@">>>>>请求失败——我上传的");
        }
        
    }];
    
    
}
- (void)setCycleScroll {
    JCJLog(@"");
    if (!_topScrollView) {
        
        _topScrollView = [[JLAdvertisingScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH*0.6)];//280
        
  
//        NSMutableArray *imageArr = [[NSMutableArray alloc]init];
//        for (WelfareCycleModel *model in self.dataArr) {
//            [imageArr addObject:model.iconImage?model.iconImage:LoadIMG(@"SkyClass_默认无图-大图")];
//        }
//        [_topScrollView setImages:imageArr];
        
        [_topScrollView setDelegate:self];
        [_topScrollView setAutoLoopInterval:3];
        [self addSubview:_topScrollView];
        [_topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(SCREENWIDTH*0.6);
        }];
        
    }
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    for (WelfareCycleModel *model in self.dataArr) {
        [imageArr addObject:model.iconImage?model.iconImage:LoadIMG(@"SkyClass_默认无图-大图")];
    }
    [_topScrollView setImages:imageArr];
    
    
    if (!_topView) {
        _topView = [[CycleTopicView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [_topScrollView getHeight])];
        [self addSubview:_topView];
//        [_topView setBackgroundColor:[UIColor redColor]];
        [_topView setContentWith:self.dataArr[0]];
    }
    [self bringSubviewToFront:_topView];
    
}
- (void)reloadView {
    [_imageArr removeAllObjects];
    for (WelfareCycleModel *model in self.dataArr) {
        [_imageArr addObject:model.iconImage];
    }
    [_topScrollView setImages:_imageArr];
}
/**
 点击事件代理
 
 @param scrollView JLAdvertisingScrollView
 @param index 点击的图片的序号
 */
- (void)advertisingScrollView:(JLAdvertisingScrollView *)scrollView  clickEventAtIndex:(NSInteger)index{

    LeoLog(@">>>福吧cycle点击：%ld>>>",index);
     WelfareCycleModel *model = self.dataArr[index];
    if ([model.startDate longLongValue]/1000 > [[NSDate date] timeIntervalSince1970]) {
        [PublicTool showAlertWith:NSLocalizedString(@"活动未开始", @"活动未开始")];
        return;
    }
    else if([model.endDate longLongValue]/1000 < [[NSDate date] timeIntervalSince1970])
    {
        [PublicTool showAlertWith:NSLocalizedString(@"活动已结束", @"活动已结束")];
        return;
    }
    
   
    if ([model.careType intValue] == 2) {
        model.birthdayStatus = birdthModel.birthdayStatus;
        model.giftId = birdthModel.giftId;
        model.welfareId = birdthModel.welfareId;
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"WelfareCycleClickNotification" object:model userInfo:nil];
    
    
    
}
- (void)scrollDidScrollAt:(NSInteger)index {
//    LeoLog(@"福吧-cycleIndex:%ld",index);
    if (index<self.dataArr.count) {
        [_topView setContentWith:self.dataArr[index]];
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
