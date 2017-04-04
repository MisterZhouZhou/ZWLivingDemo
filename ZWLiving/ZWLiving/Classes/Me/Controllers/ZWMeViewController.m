//
//  ZWMeViewController.m
//  ZWLiving
//
//  Created by limin on 17/3/25.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWMeViewController.h"
#import "ZWMeinfoView.h"
#import "ZWSetting.h"

@interface ZWMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datalists;
@property(nonatomic,strong)ZWMeinfoView *infoView;

@end

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self loadData];
}

-(ZWMeinfoView *)infoView
{
    if (!_infoView) {
        _infoView = [ZWMeinfoView loadInfoView];
        _infoView.height = KScreen_Height * 0.5;
        [_infoView showInfo];
    }
    return _infoView;
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
    self.tableView.tableHeaderView = self.infoView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 60;
    self.tableView.sectionFooterHeight = 15;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}

-(void)loadData
{
    ZWSetting * set1 = [[ZWSetting alloc] init];
    set1.title = @"映客贡献榜";
    set1.subTitle = @"";
    set1.vcName = @"";
    
    ZWSetting * set2 = [[ZWSetting alloc] init];
    set2.title = @"收益";
    set2.subTitle = @"0映票";
    set2.vcName = @"";
    
    ZWSetting * set3 = [[ZWSetting alloc] init];
    set3.title = @"账户";
    set3.subTitle = @"0钻石";
    set3.vcName = @"";
    
    ZWSetting * set4 = [[ZWSetting alloc] init];
    set4.title = @"等级";
    set4.subTitle = @"3级";
    set4.vcName = @"";
    
    ZWSetting * set5 = [[ZWSetting alloc] init];
    set5.title = @"实名认证";
    set5.subTitle = @"";
    set5.vcName = @"";
    
    ZWSetting * set6 = [[ZWSetting alloc] init];
    set6.title = @"设置";
    set6.subTitle = @"";
    set6.vcName = @"";
    
    
    NSArray * arr1 = @[set1,set2,set3];
    NSArray * arr2 = @[set4,set5];
    NSArray * arr3 = @[set6];
    self.datalists = [@[arr1,arr2,arr3] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.datalists.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray * arr = self.datalists[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    ZWSetting * set = self.datalists[indexPath.section][indexPath.row];
    cell.textLabel.text = set.title;
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = set.subTitle;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSMutableArray *)dataLists {
    
    if (!_datalists) {
        _datalists = [NSMutableArray array];
    }
    return _datalists;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
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
