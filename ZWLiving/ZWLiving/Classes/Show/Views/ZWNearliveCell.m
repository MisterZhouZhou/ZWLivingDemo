//
//  ZLYNearliveCell.m
//  Live
//
//  Created by 朱梁瑜 on 2017/3/20.
//  Copyright © 2017年 朱梁瑜. All rights reserved.
//

#import "ZWNearliveCell.h"
#import "ZWLive.h"
@interface ZWNearliveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation ZWNearliveCell

- (void)showAnimation {
    //x和y的最终值为1
    if (self.live.isShow) {
        return;
    }
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.live.show = YES;
    }];
}

-(void)setLive:(ZWLive *)live
{
    _live = live;
    
    [self.headImageView downloadImage:live.creator.portrait placeholder:@"default_room"];
    self.distanceLabel.text = live.distance;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
