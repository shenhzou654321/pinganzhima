//
//  WelfareCollectionView.h
//  G-live
//
//  Created by leo on 2018/2/5.
//  Copyright © 2018年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelfareCollectionView : UIView

@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,copy) NSMutableArray *dataArr;


- (void)reloadData;

@end
