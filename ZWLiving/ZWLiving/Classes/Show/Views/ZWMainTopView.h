//
//  ZWMainTopView.h
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZWMainTopBlock)(NSInteger tag);

@interface ZWMainTopView : UIView

@property(nonatomic,copy) ZWMainTopBlock block;

- (instancetype)initWithFrame:(CGRect)frame titlse:(NSArray*)titles;

- (void)scrolling:(NSInteger)tag;

@end
