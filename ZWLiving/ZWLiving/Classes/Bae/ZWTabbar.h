//
//  ZWTabbar.h
//  ZWLiving
//
//  Created by limin on 17/3/25.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ZWItemType){
    ZWItemType_Launch = 10, //  直播
    ZWItemType_Live = 100 , // 展示直播
    ZWItemType_Me           // 我的
};

@class ZWTabbar;
@protocol ZWTabbarDelegate <NSObject>

- (void)tabbar:(ZWTabbar *)tabbar clickAtIndex:(ZWItemType)idx;

@end


typedef void(^TabbarBlock) (ZWTabbar *tabbar,ZWItemType idx);

@interface ZWTabbar : UIView

@property(nonatomic,weak) id <ZWTabbarDelegate> delegate;

@property(nonatomic,copy) TabbarBlock block;

@end
