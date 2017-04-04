//
//  ZWMainViewController.m
//  ZWLiving
//
//  Created by limin on 17/3/25.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWMainViewController.h"
#import "ZWMainTopView.h"

@interface ZWMainViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) ZWMainTopView *mainTopView;
@end

@implementation ZWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    // initUI
    [self initUI];
}

#pragma mark initUI
- (void)initUI{
    [self setupNav];
    // setup ScrollView
    [self.view addSubview:self.scrollView];
    [self setupChilds];
}

- (void)setupNav{
     self.navigationItem.titleView = self.mainTopView ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
   
}

- (void)setupChilds{
    
    NSArray *vcArray = @[@"ZWFocusViewController",@"ZWHotViewController",@"ZWNearViewController"];
    for (NSInteger i=0; i<vcArray.count; i++) {
        UIViewController *vc = [[NSClassFromString(vcArray[i]) alloc]init];
        vc.title = self.titles[i];
        [self addChildViewController:vc];
    }
    self.scrollView.contentOffset = CGPointMake(KScreen_Width, 0);
    // 设置默认控制器
    [self scrollViewDidEndDecelerating:self.scrollView];
}


#pragma mark - getter
- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"关注",@"热门",@"附近"];
    }
    return _titles;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreen_Width, self.view.height-64-49)];
        _scrollView.contentSize = CGSizeMake(KScreen_Width * self.titles.count,0);
        _scrollView.delegate = self;
        
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (ZWMainTopView *)mainTopView{
    if (!_mainTopView) {
        _mainTopView = [[ZWMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 35) titlse:self.titles];
        @weakify(self);
        _mainTopView.block = ^(NSInteger tag){
            @strongify(self);
            [self.scrollView setContentOffset:CGPointMake(tag * kScreenWidth, self.scrollView.contentOffset.y) animated:YES];
        };
    }
    return _mainTopView;
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = KScreen_Width;
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger idx = offset / width;
    // 
    [self.mainTopView scrolling:idx];
    // 根据索引取视图控制器
    UIViewController *vc = self.childViewControllers[idx];
    if ([vc isViewLoaded]) {
        return;
    }
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    [self.scrollView addSubview:vc.view];

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
