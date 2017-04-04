//
//  SXTHotLiveCell.m
//  尚学堂映客
//
//  Created by 大欢 on 16/8/22.
//  Copyright © 2016年 大欢. All rights reserved.
//

#import "ZWHotLiveCell.h"
#import "UIImageView+SDWebImage.h"

@interface ZWHotLiveCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLineUserLabel;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@end

@implementation ZWHotLiveCell

- (void)setLive:(ZWLive *)live {
    
    _live = live;
    
    self.nameLabel.text = live.creator.nick;
    self.cityLabel.text = live.city;
    self.onLineUserLabel.text = [@(live.onlineUsers) stringValue];
    
    [self.portraitImageView downloadImage:live.creator.portrait placeholder:@"default_room"];
    [self.bigImageView downloadImage:live.creator.portrait placeholder:@"default_room"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.portraitImageView.layer.cornerRadius = CGRectGetWidth(self.portraitImageView.frame) / 2;
    self.portraitImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

