//
//  ZWTabbar.m
//  ZWLiving
//
//  Created by limin on 17/3/25.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWTabbar.h"

@interface ZWTabbar ()

@property(nonatomic,strong) UIImageView *bgImageView;
@property(nonatomic,strong) NSArray *datalists;
@property(nonatomic,weak) UIButton *lastBtn;
@property(nonatomic,strong) UIButton *cameraButton;
@end

@implementation ZWTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImageView];
        // 装载item
        for (NSInteger i = 0; i<self.datalists.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.adjustsImageWhenHighlighted = NO;
            [btn setImage:[UIImage imageNamed:self.datalists[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",self.datalists[i]]] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = ZWItemType_Live + i;
            if (i == 0) {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            [self addSubview:btn];
        }
        //  相机
        [self addSubview:self.cameraButton];
        
        // UITabbar
        [[UITabBar appearance]setShadowImage:[UIImage new]];
        [[UITabBar appearance]setBackgroundImage:[UIImage new]];
    }
    return self;
}

#pragma mark - getter
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _bgImageView;
}

- (NSArray *)datalists{
    if (_datalists == nil) {
        _datalists = @[@"tab_live",@"tab_me"];
    }
    return _datalists;
}


- (UIButton *)cameraButton{
    if (_cameraButton == nil) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        _cameraButton.tag = ZWItemType_Launch;
        [_cameraButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}
#pragma mark - action
- (void)btnClick:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(tabbar:clickAtIndex:)]) {
        [self.delegate tabbar:self clickAtIndex:btn.tag];
    }
    
    if (self.block) {
        self.block(self,btn.tag);
    }
    
    if (btn.tag == ZWItemType_Launch) {
        return;
    }
    
    self.lastBtn.selected = NO;
    btn.selected = YES;
    self.lastBtn = btn;
    
    // 设置动画效果
    [UIView animateWithDuration:0.2 animations:^{
        // 放大图标
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        // 回复图标大小
        btn.transform = CGAffineTransformIdentity;
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageView.frame = self.bounds;
    CGFloat width = self.bounds.size.width / self.datalists.count;
    for (NSInteger i = 0; i<self.subviews.count; i++) {
        UIView * btnView = self.subviews[i];
        if ([btnView isKindOfClass:[UIButton class]]) {
            btnView.frame = CGRectMake((btnView.tag - ZWItemType_Live) * width, 0, width, self.frame.size.height);
        }
    }
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 50);
}

@end
