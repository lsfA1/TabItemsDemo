//
//  ViewController.m
//  TabItemsDemo
//
//  Created by 李少锋 on 2018/12/4.
//  Copyright © 2018年 李少锋. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "TabItemsCollectionCell.h"
#import "AppDelegate.h"

#define CellIdentifierName @"CellIdentifier"

#define ReusableHeaderView @"ReusableHeaderView"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ChoseDeleteItemDelegate>

@property(nonatomic,strong)UICollectionView *collectView;

@property(nonatomic,copy)NSMutableArray *selectArray;

@property(nonatomic,copy)NSMutableArray *unselectArray;

@property(nonatomic,assign)BOOL showDeleteBtn;

@end

@implementation ViewController

-(void)initData{
    _showDeleteBtn=NO;
    _selectArray=[[NSMutableArray alloc]initWithObjects:@"本地",@"综合",@"视频",@"娱乐",@"体育",@"定制",@"数码", nil];
    _unselectArray=[[NSMutableArray alloc]initWithObjects:@"+热点",@"+图片",@"+科技",@"+财经",@"+军事",@"+健康",@"+特卖",@"+房产",@"+电影",@"+动漫",@"+星座",@"+手机",@"+美食",@"+搞笑",@"+彩票", nil];
}

-(void)initCollectionView{
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=0;
    layout.minimumInteritemSpacing=0;
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectView registerClass:[TabItemsCollectionCell class]forCellWithReuseIdentifier:CellIdentifierName];
    [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReusableHeaderView];
    [self.view addSubview:_collectView];
    _collectView.delegate=self;
    _collectView.dataSource=self;
    _collectView.backgroundColor=RGB(240, 240, 240, 1);
    _collectView.backgroundColor=[UIColor whiteColor];
    [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _collectView.pagingEnabled = NO;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressed:)];
    [_collectView addGestureRecognizer:longPress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"栏目管理";
    [self initData];
    [self initCollectionView];
}

- (void)onLongPressed:(UILongPressGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSIndexPath *indexPath = [_collectView indexPathForItemAtPoint:point];
    if(indexPath.section == 0&&indexPath.item!=0){
        switch (sender.state) {
            case UIGestureRecognizerStateBegan: {
                _showDeleteBtn=YES;
                [_collectView reloadSections:[NSIndexSet indexSetWithIndex:0]];
                if (indexPath) {
                    if (@available(iOS 9.0, *)) {
                        [_collectView beginInteractiveMovementForItemAtIndexPath:indexPath];
                    } else {
                        // Fallback on earlier versions
                    }
                }
                break;
            }
            case UIGestureRecognizerStateChanged: {
                if (@available(iOS 9.0, *)) {
                    [_collectView updateInteractiveMovementTargetPosition:point];
                } else {
                    // Fallback on earlier versions
                }
                break;
            }
            case UIGestureRecognizerStateEnded: {
                if (@available(iOS 9.0, *)) {
                    [_collectView endInteractiveMovement];
                } else {
                    // Fallback on earlier versions
                }
                break;
            }
            default: {
                if (@available(iOS 9.0, *)) {
                    [_collectView cancelInteractiveMovement];
                } else {
                    // Fallback on earlier versions
                }
                break;
            }
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0&&indexPath.item!=0) {
        return YES;
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 0) {
        [_selectArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    if (section==0) {
        return _selectArray.count;
    }
    return _unselectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = CellIdentifierName;
    TabItemsCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    [cell initView:indexPath andIsShowDelete:_showDeleteBtn];
    NSString *titleStr=nil;
    if (indexPath.section==0) {
        titleStr=_selectArray[indexPath.item];
    }else{
        titleStr=_unselectArray[indexPath.item];
    }
    cell.mytitleLabel.text=titleStr;
    return cell;
}

//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView=  [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:ReusableHeaderView forIndexPath:indexPath];
    headerView.backgroundColor=RGB(246, 246, 246, 1);
    for (UIView * view in headerView.subviews) {
        [view removeFromSuperview];
    }
    if (headerView) {
        UIView  * lineView =[UIView new];
        [headerView addSubview:lineView];
        lineView.backgroundColor=RGB(218, 218, 218, 1);
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(.5);
        }];
        UILabel * lae =[UILabel new];
        lae.font=[UIFont systemFontOfSize:14];
        lae.textColor=RGB(100, 100, 100, 1);
        [headerView addSubview:lae];
        [lae mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.bottom.mas_equalTo(0);
        }];
        if (indexPath.section==0) {
            UIButton *editButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            editButton.backgroundColor=RGB(213, 19, 48 , 1);
            if(_showDeleteBtn){
                [editButton setTitle:@"完成" forState:UIControlStateNormal];
            }
            else{
                [editButton setTitle:@"编辑" forState:UIControlStateNormal];
            }
            editButton.titleLabel.font=[UIFont systemFontOfSize:13.0f];
            editButton.layer.cornerRadius=10;
            [headerView addSubview:editButton];
            [editButton addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
            [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(headerView).offset(-15);
                make.width.equalTo(@50);
                make.height.equalTo(@20);
                make.centerY.equalTo(headerView);
            }];
            lae.text=@"已添加栏目";
        }else{
            lae.text=@"添加栏目";
        }
    }
    return headerView;
}

-(void)editClick:(UIButton *)button{
    _showDeleteBtn=!_showDeleteBtn;
    [_collectView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/4-1, 45);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;{
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.item!=0) {
        /*删除已经添加的栏目*/
        NSString *titleStr =_selectArray[indexPath.item];
        [_unselectArray addObject:[NSString stringWithFormat:@"+%@",titleStr]];
        [_selectArray removeObjectAtIndex:indexPath.item];
        NSInteger index = _unselectArray.count - 1;
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:index inSection:1]];
        [_collectView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    }else if (indexPath.section==1){
        /*添加栏目*/
        NSString *titleStr =_unselectArray[indexPath.item];
        [_selectArray addObject:[titleStr substringFromIndex:1]];
        [_unselectArray removeObjectAtIndex:indexPath.item];
        NSInteger index = _selectArray.count - 1;
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [_collectView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    }
    NSLog(@"选择--%ld组--第%ld个",indexPath.section,indexPath.item);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - ChoseItemDelegate
-(void)choseDeleteItem:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.item!=0) {
        /*删除已经添加的栏目*/
        NSString *titleStr =_selectArray[indexPath.item];
        [_unselectArray addObject:[NSString stringWithFormat:@"+%@",titleStr]];
        [_selectArray removeObjectAtIndex:indexPath.item];
        [_collectView reloadData];
    }
}


@end
