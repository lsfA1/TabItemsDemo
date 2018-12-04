//
//  TabItemsCollectionCell.m
//  TabItemsDemo
//
//  Created by 李少锋 on 2018/12/4.
//  Copyright © 2018年 李少锋. All rights reserved.
//

#import "TabItemsCollectionCell.h"
#import <Masonry.h>
#import "AppDelegate.h"

#define DeleteButtonHeight 16

@interface TabItemsCollectionCell ()

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,assign)NSIndexPath *indexPath;

@end

@implementation TabItemsCollectionCell

-(void)initView:(NSIndexPath *)indexPath andIsShowDelete:(BOOL)isShowDelete{
    self.contentView.backgroundColor=[UIColor clearColor];
    _indexPath=indexPath;
    if(!self.mytitleLabel){
        self.mytitleLabel=[[UILabel alloc]init];
        self.mytitleLabel.layer.borderWidth=1;
        self.mytitleLabel.textAlignment=NSTextAlignmentCenter;
        self.mytitleLabel.font=[UIFont systemFontOfSize:14.0f];
        self.mytitleLabel.layer.borderColor=RGB(218, 218, 218, 1).CGColor;
        self.mytitleLabel.backgroundColor=[UIColor whiteColor];
        self.mytitleLabel.layer.cornerRadius=5;
        self.mytitleLabel.clipsToBounds=YES;
        [self.contentView addSubview:self.mytitleLabel];
        [self.mytitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
            make.center.equalTo(self);
        }];
    }
    if(indexPath.section==0&&indexPath.item==0){
        self.mytitleLabel.layer.borderWidth=0;
        self.mytitleLabel.layer.borderColor=[UIColor clearColor].CGColor;
        self.mytitleLabel.backgroundColor=RGB(246, 246, 246, 1);
    }
    else{
        self.mytitleLabel.layer.borderWidth=1;
        self.mytitleLabel.layer.borderColor=RGB(218, 218, 218, 1).CGColor;
        self.mytitleLabel.backgroundColor=[UIColor whiteColor];
    }
    if(indexPath.section==0&&isShowDelete&&indexPath.item!=0){
        [self.contentView addSubview:self.deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mytitleLabel).offset(-(DeleteButtonHeight/2));
            make.right.equalTo(self.mytitleLabel).offset((DeleteButtonHeight/2));
            make.width.height.equalTo(@DeleteButtonHeight);
        }];
    }
    else{
        [_deleteButton removeFromSuperview];
    }
}

-(UIButton *)deleteButton{
    if(!_deleteButton){
        _deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font=[UIFont systemFontOfSize:10];
        _deleteButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        _deleteButton.backgroundColor=RGB(241, 88, 92 , 1);
        _deleteButton.layer.cornerRadius=DeleteButtonHeight/2;
        [_deleteButton setTitle:@"X" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(void)deleteClick:(UIButton *)button{
    if(_delegate){
        [_delegate choseDeleteItem:_indexPath];
    }
}

@end
