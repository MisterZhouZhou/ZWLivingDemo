//
//  ZWLaunchViewController.m
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWLaunchViewController.h"
#import "LFLivePreview.h"

@interface ZWLaunchViewController ()
@property(nonatomic,weak) UITextField *titleTfd;
@end

@implementation ZWLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}


#pragma mark - initUI
- (void)initUI{
    
    // bgImageView
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_zbfx"]];
    bgImageView.backgroundColor = [UIColor redColor];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    
    // close button
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"launch_close"] forState:UIControlStateNormal];
    [closeButton sizeToFit];
    [closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
    }];
    
    // 定位
    UIButton *addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressButton setImage:[UIImage imageNamed:@"launch_map_on"] forState:UIControlStateNormal];
    addressButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [addressButton setTitle:@"北京市" forState:UIControlStateNormal];
    [addressButton addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressButton];
    [addressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.centerY.mas_equalTo(closeButton.mas_centerY).offset(-5);
    }];
    
    // 开始直播
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setBackgroundImage:[UIImage imageNamed:@"room_button"] forState:UIControlStateNormal];
    [playButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(50);
    }];
    
    // 直播标题
    UITextField *titleTfd = [UITextField new];
    titleTfd.placeholder = @"给直播写个标题吧";
    titleTfd.layer.borderWidth   = 1;
    titleTfd.layer.borderColor   = [UIColor grayColor].CGColor;
    titleTfd.layer.cornerRadius  = 15;
    titleTfd.layer.masksToBounds = YES;
    titleTfd.textColor = [UIColor whiteColor];
    titleTfd.textAlignment =  NSTextAlignmentCenter;
    titleTfd.font = [UIFont systemFontOfSize:15.0];
    [titleTfd setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
    self.titleTfd = titleTfd;
    [self.view addSubview:titleTfd];
    [titleTfd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(playButton.mas_centerX);
        make.bottom.mas_equalTo(playButton.mas_top).offset(-10);
        make.width.mas_equalTo(playButton.mas_width);
        make.height.mas_equalTo(30);
    }];
}

- (void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addressClick{
    
}

- (void)playClick{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    LFLivePreview *preview = [[LFLivePreview alloc]initWithFrame:self.view.bounds];
    preview.vc = self;
    [self.view addSubview:preview];
    //开启直播
    [preview startLive];
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
