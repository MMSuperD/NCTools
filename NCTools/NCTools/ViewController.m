//
//  ViewController.m
//  NCTools
//
//  Created by sh-lx on 2018/12/7.
//  Copyright © 2018年 sh-lx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NCTool shareInstance].delegate = self;
}

#pragma NCToolDelegate

- (void)ncToolDelegateCurrentNewStatus:(WD_NetworkStatus)currentStaus {
    
    NSLog(@"++++++++++++WD_NetworkStatus:%zd",currentStaus);
}


@end
