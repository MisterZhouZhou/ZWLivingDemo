//
//  ZLYAdvertiseView.h
//  Live
//
//  Created by 朱梁瑜 on 2017/3/20.
//  Copyright © 2017年 朱梁瑜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWAdvertiseView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+(instancetype)loadAdvertiseView;

@end
