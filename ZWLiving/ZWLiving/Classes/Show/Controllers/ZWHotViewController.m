//
//  ZWHotViewController.m
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWHotViewController.h"
#import "ZWLiveHandler.h"
#import "ZWHotLiveCell.h"
#import "ZWPlayerViewController.h"

static NSString * identifier = @"ZWHotLiveCell";
@interface ZWHotViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataList;


@end

@implementation ZWHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initUI];
    [self loadData];
}

- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZWHotLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}

- (void)loadData{
    [ZWLiveHandler executeGetHotLiveTaskWithPage:0 success:^(id obj) {
        [self.dataList addObjectsFromArray:obj];
        [self.tableView reloadData];
    } failed:^(id obj) {
        NSLog(@"%@",obj);
    }];
}

- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZWHotLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.dataList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + self.view.bounds.size.width + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZWPlayerViewController * playerVC = [[ZWPlayerViewController alloc] init];
    
    playerVC.live = self.dataList[indexPath.row];
    
    [self.navigationController pushViewController:playerVC animated:YES];
    
    
    /*
     
     系统自带的播放器解码能力不够，播放不了直播
     
     SXTLive * live = self.dataList[indexPath.row];
     
     MPMoviePlayerViewController * mp = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:live.streamAddr]];
     
     [self.tabBarController presentViewController:mp animated:YES completion:nil];
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
