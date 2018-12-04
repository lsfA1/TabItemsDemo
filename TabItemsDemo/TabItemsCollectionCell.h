//
//  TabItemsCollectionCell.h
//  TabItemsDemo
//
//  Created by 李少锋 on 2018/12/4.
//  Copyright © 2018年 李少锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChoseDeleteItemDelegate <NSObject>

-(void)choseDeleteItem:(NSIndexPath *)indexPath;

@end

@interface TabItemsCollectionCell : UICollectionViewCell

@property (nonatomic,strong)UILabel *mytitleLabel;

@property (nonatomic,assign)id <ChoseDeleteItemDelegate>delegate;

-(void)initView:(NSIndexPath *)indexPath andIsShowDelete:(BOOL)isShowDelete;

@end

NS_ASSUME_NONNULL_END
