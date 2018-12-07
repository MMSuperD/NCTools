//
//  NCTool.m
//  NCTools
//
//  Created by sh-lx on 2018/12/7.
//  Copyright © 2018年 sh-lx. All rights reserved.
//

#import "NCTool.h"
#import "Reachability.h"

@interface NCTool()
/**
 monitor
 */
@property(nonatomic,strong)Reachability * reachabilityManager;

@end

@implementation NCTool

+ (instancetype)shareInstance {
    static NCTool *_tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tools = [[self alloc] init];
    });
    return _tools;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCode];
    }
    return self;
}

- (void)initCode {
    
    //create reachability
    self.reachabilityManager = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    //register notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkStatus:) name:kReachabilityChangedNotification object:nil];
    
    // start monitor networking
    [self.reachabilityManager startNotifier];
}

- (void)checkStatus:(NSNotification *)object {

    // get networking status
    NetworkStatus statu = self.reachabilityManager.currentReachabilityStatus;
    
    if (self.currentReachabilityStatus == statu) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(ncToolDelegateCurrentNewStatus:)]) {
            [self.delegate ncToolDelegateCurrentNewStatus:(WD_NetworkStatus)statu];
    }
    switch (statu) {
        case NotReachable:              //no networking
            NSLog(@"current networking:NO");
            self.currentReachabilityStatus = NotReachable;
            break;
        case ReachableViaWiFi:          //wifi
            NSLog(@"current networking:WIFI");
            self.currentReachabilityStatus = ReachableViaWiFi;
            break;
        case ReachableViaWWAN:          //flow 3g/4g
            NSLog(@"current networking:3g/4g");
            self.currentReachabilityStatus = ReachableViaWWAN;
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    [self.reachabilityManager stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
