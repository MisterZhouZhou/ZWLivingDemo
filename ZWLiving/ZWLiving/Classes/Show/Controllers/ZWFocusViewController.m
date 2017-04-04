//
//  ZWFocusViewController.m
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWFocusViewController.h"
#import "ZWLive.h"
#import "ZWHotLiveCell.h"
#import "ZWPlayerViewController.h"
#import "ZWCreator.h"

static NSString *identifier = @"ZWHotLiveCell";
@interface ZWFocusViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *datalists;

@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ZWFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self loadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZWHotLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
}

-(void)loadData
{
    ZWLive *live = [[ZWLive alloc] init];
    live.city = @"北京";
    live.onlineUsers = 1200;
    live.streamAddr = Live_Luotuo;
    
    ZWCreator *creator = [[ZWCreator alloc] init];
    live.creator = creator;
    creator.nick = @"骆驼";
    creator.portrait = @"http://img3.duitang.com/uploads/item/201503/15/20150315213756_CsKt5.jpeg";
    [self.datalists addObject:live];
    
}

-(NSMutableArray *)datalists
{
    if (!_datalists) {
        _datalists = [NSMutableArray array];
    }
    return _datalists;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.live = self.datalists[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70 + KScreen_Width;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZWLive *live = self.datalists[indexPath.row];
    
    ZWPlayerViewController *playerVC = [[ZWPlayerViewController alloc] init];
    playerVC.live = live;
    //    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
    
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
