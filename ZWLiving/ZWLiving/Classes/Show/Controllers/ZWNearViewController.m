//
//  ZLYNearViewController.m
//  Live
//
//  Created by 朱梁瑜 on 2017/3/17.
//  Copyright © 2017年 朱梁瑜. All rights reserved.
//

#import "ZWNearViewController.h"
#import "ZWLiveHandler.h"
#import "ZWNearliveCell.h"
#import "ZWLive.h"
#import "ZWPlayerViewController.h"
static NSString *identifer = @"ZWNearliveCell";

#define kMargin 5

#define kItemWidth  100

@interface ZWNearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSArray *datalist;

@end

@implementation ZWNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self loadData];
}

-(void)initUI
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZWNearliveCell" bundle:nil] forCellWithReuseIdentifier:identifer];
}

-(void)loadData
{
    [ZWLiveHandler executeNearLiveTaskWithSuccess:^(id obj) {
        self.datalist = [ZWLive mj_objectArrayWithKeyValuesArray:obj];
        [self.collectionView reloadData];
    } failed:^(id obj) {
        
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datalist.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZWNearliveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    cell.live = self.datalist[indexPath.item];
    
    return cell;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
   sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = self.collectionView.width / kItemWidth;
    
    CGFloat  etraWidth  = (self.collectionView.width - kMargin * (count+1)) / count;
    
    return CGSizeMake(etraWidth , etraWidth + 20);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWNearliveCell * c = (ZWNearliveCell *)cell;
    [c showAnimation];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ZWLive *live = self.datalist[indexPath.row];
    
    ZWPlayerViewController *playerVC = [[ZWPlayerViewController alloc] init];
    
    playerVC.live = live;
    
    //    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
