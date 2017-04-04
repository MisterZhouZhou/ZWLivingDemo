//
//  ZLYAdvertiseView.m
//  Live
//
//  Created by 朱梁瑜 on 2017/3/20.
//  Copyright © 2017年 朱梁瑜. All rights reserved.
//

#import "ZWAdvertiseView.h"
#import "ZWLiveHandler.h"
#import "ZWAdvertise.h"
#import "SDWebImageManager.h"
#import "ZWCacheHelper.h"
#import "ZWTimerManager.h"

static NSInteger showTime = 3;

@interface ZWAdvertiseView ()
//@property (nonatomic,strong) dispatch_source_t timer;
@end

@implementation ZWAdvertiseView

+(instancetype)loadAdvertiseView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZWAdvertiseView" owner:nil options:nil] lastObject];
}


//广告页初始化
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.timeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skipAction)];
    [self.timeLabel addGestureRecognizer:tap];
    
    //展示广告
    [self showAd];
    
    //下载广告
    [self downAd];
    
    //倒计时
    [self startTimer];
}

-(void)showAd
{
   NSString *filePath = [ZWCacheHelper getAdvertise];
   UIImage *lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:filePath];
    if (lastCacheImage) {
        self.backView.image = lastCacheImage;
    }
    else{
        self.hidden = YES;
    }
}

-(void)downAd
{
    [ZWLiveHandler executeGet_AdvertiseTaskWithSuccess:^(id obj) {
        ZWAdvertise *ad = obj;

        // SDWebImageAvoidAutoSetImage 下载完不给imageview赋值
        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:ad.image] options:SDWebImageAvoidAutoSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [ZWCacheHelper setAdvertise:ad.image];
        }];
    } failed:^(id obj) {
        
    }];
}

-(void)startTimer
{
//    __block NSInteger timeout = showTime;
//    
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        if (timeout <= 0) {
//            dispatch_source_cancel(timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self dismiss];
//            });
//        }
//        else{
//            timeout --;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.timeLabel.text = [NSString stringWithFormat:@"跳过%zd",timeout];
//            });
//        }
//    });
//    dispatch_resume(timer);
    [ZWTimerManager timerWithAnimationTime:5 timeEvent:^(NSInteger time){
        self.timeLabel.text = [NSString stringWithFormat:@"跳过%zd",time];
    } timeoutEvent:^{
        [self dismiss];
    }];
}

#pragma mark - skip action
-(void)dismiss{
    // 设置广告消失动画 ，动画消失后移除
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - skip action
- (void)skipAction{
    [self dismiss];
}

@end
