//
//  WelfareCollectionView.m
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//
#define CellIdentifier  @"cellId"

#import "WelfareCollectionView.h"
#import "WelfareCollectionCell.h"
#import "PAWelfareModel.h"

@interface WelfareCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation WelfareCollectionView
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = RGBFromHexadecimal(0xf4f5f9);
        self.userInteractionEnabled = YES;
        [self setCollectionView];
    }
    
    return self;
}
- (void)setCollectionView {
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    // [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    //    layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);
    //该方法也可以设置itemSize layout.itemSize =CGSizeMake(110, 150);
    //2.初始化collectionView
    _collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [self addSubview:_collection];
    _collection.backgroundColor = RGBFromHexadecimal(0xf4f5f9);
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_collection registerClass:[WelfareCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
    //注册headerView 此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为reusableView
    
    //4.设置代理
    _collection.delegate = self;
    _collection.dataSource = self;
    
    
}

#pragma mark 代理实现

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 0.01);
}
//定义每个Section  间的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 0, 0);//分别为上、左、下、右
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(self.frame.size.width, 5);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WelfareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    PAWelfareModel *model = _dataArr[indexPath.row];
    [cell setContentWith:model];
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    PAWelfareModel *model = self.dataArr[indexPath.row];
    return CGSizeMake(self.frame.size.width, model.cellHeight);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"QuestionListNotification" object:@(indexPath.row) userInfo:@{@"isSearch":_isSearch?@"YES":@"NO"}];
    
    PAWelfareModel *model = self.dataArr[indexPath.row];
   
    if ([model.startDate longLongValue]/1000 > [[NSDate date] timeIntervalSince1970]) {
      [PublicTool showAlertWith:NSLocalizedString(@"活动未开始", @"活动未开始")];
        return;
    }
    else if([model.endDate longLongValue]/1000 < [[NSDate date] timeIntervalSince1970])
    {
        [PublicTool showAlertWith:NSLocalizedString(@"活动已结束", @"活动已结束")];
        return;
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WelfareListNoti" object:model userInfo:nil];
    LeoLog(@"didselectWelfare");
}

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
