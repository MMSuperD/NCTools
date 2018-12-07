//
//  NCTool.h
//  NCTools
//
//  Created by sh-lx on 2018/12/7.
//  Copyright © 2018年 sh-lx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NetworkStatus_NO,
    NetworkStatus_WIFI,
    NetworkStatus_3G4G,
} WD_NetworkStatus;
NS_ASSUME_NONNULL_BEGIN


/**
 you might monitor NetworkingStatusChangedNotification in order to networking change notification
 */
#define NetworkingStatusChangedNotification (@"NetworkingStatusChangedNotification")

@protocol NCToolDelegate <NSObject>

@optional

-(void)ncToolDelegateCurrentNewStatus:(WD_NetworkStatus)currentStaus;

@end

@interface NCTool : NSObject

+ (instancetype)shareInstance;

@property(nonatomic,assign)WD_NetworkStatus currentReachabilityStatus;

@property(nonatomic,weak) id<NCToolDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
