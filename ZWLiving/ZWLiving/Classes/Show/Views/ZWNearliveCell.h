//
//  ZLYNearliveCell.h
//  Live
//
//  Created by 朱梁瑜 on 2017/3/20.
//  Copyright © 2017年 朱梁瑜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWLive;
@interface ZWNearliveCell : UICollectionViewCell

- (void)showAnimation;

@property(nonatomic,strong)ZWLive *live;

@end