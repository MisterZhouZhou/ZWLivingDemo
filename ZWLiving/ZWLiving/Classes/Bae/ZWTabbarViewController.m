//
//  ZWTabbarViewController.m
//  ZWLiving
//
//  Created by limin on 17/3/25.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWTabbarViewController.h"
#import "ZWBaseNavController.h"
#import "ZWLaunchViewController.h"
#import "ZWTabbar.h"

@interface ZWTabbarViewController ()<ZWTabbarDelegate>
@property(nonatomic,strong) ZWTabbar * zwtabbar;
@end

@implementation ZWTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载控制器
    [self setupChildVC];
    // 加载tabbar
    [self.tabBar addSubview:self.zwtabbar];
}

- (void)setupChildVC{
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:@[@"ZWMainViewController",@"ZWMeViewController"]];
    for (NSInteger i = 0; i<vcArray.count; i++) {
        NSString *name = vcArray[i];
        UIViewController *vc  = [[NSClassFromString(name) alloc]init];
        ZWBaseNavController  *nav = [[ZWBaseNavController alloc]initWithRootViewController:vc];
        [vcArray replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = vcArray;
}


#pragma mark - getter {
- (ZWTabbar *)zwtabbar{
    if (!_zwtabbar) {
        _zwtabbar = [[ZWTabbar alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 49)];
        _zwtabbar.delegate = self;
    }
    return _zwtabbar;
}

#pragma mark - tabbar delegate
- (void)tabbar:(ZWTabbar *)tabbar clickAtIndex:(ZWItemType)idx{
    if (idx != ZWItemType_Launch) {
        self.selectedIndex = idx - ZWItemType_Live;
        return;
    }
    
    // 模态视图
    [self presentViewController:[ZWLaunchViewController new] animated:YES completion:nil];
    
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
