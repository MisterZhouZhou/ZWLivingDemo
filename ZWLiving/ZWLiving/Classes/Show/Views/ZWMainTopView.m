//
//  ZWMainTopView.m
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWMainTopView.h"

@interface ZWMainTopView ()

@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) NSMutableArray *buttons;
@end

@implementation ZWMainTopView

- (instancetype)initWithFrame:(CGRect)frame titlse:(NSArray*)titles{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = self.width / titles.count;
        CGFloat height = self.height;
        
        for (NSInteger i=0; i<titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            btn.frame = CGRectMake(i*width, 0, width, height);
            [self addSubview:btn];
            [self.buttons addObject:btn];
            
            if (i == 0) {
                [btn sizeToFit];
                CGFloat h = 2;
                CGFloat y = self.height - h;
                CGFloat w = CGRectGetWidth(btn.frame);
                self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, y, w, h)];
                self.lineView.backgroundColor = [UIColor whiteColor];
                [self addSubview:self.lineView];
            }
        }
    }
    return self;
}

#pragma mark - getter
- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
    }
    [self scrolling:btn.tag];
}

- (void)scrolling:(NSInteger)tag{
    UIButton *btn = self.buttons[tag];
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.lineView.centerX = btn.centerX;
    }];
}

@end
