//
//  ViewController.m
//  Interface
//
//  Created by Michael Kane on 6/7/18.
//  Copyright © 2018 Michael Kane. All rights reserved.
//

#import "ViewController.h"
#include <ifaddrs.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *isConnectedLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    self.isConnectedLabel.text =  [self isVPNConnected] ? @"Yes" : @"No";
}

- (BOOL)isVPNConnected
{
    NSDictionary *dict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *keys = [dict[@"__SCOPED__"]allKeys];
    for (NSString *key in keys) {
        if ([key rangeOfString:@"tap"].location != NSNotFound ||
            [key rangeOfString:@"tun"].location != NSNotFound ||
            [key rangeOfString:@"ipsec"].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}
@end
