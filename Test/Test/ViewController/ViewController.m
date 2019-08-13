//
//  ViewController.m
//  Test
//
//  Created by yzq on 17/8/31.
//  Copyright © 2017年 tango. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK.h>

@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, copy) NSURL *url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.bounds;
    
     __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        NSLog(@"开始加载");
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:view];
    };
    
    _instance.onFailed = ^(NSError *error) {
        //process failure
        NSLog(@"处理失败:%@",error);
    };
    
    _instance.renderFinish = ^ (UIView *view) {
        //process renderFinish
        NSLog(@"渲染完成");
    };
    
//file:///var/containers/Bundle/Application/8169ADF7-8443-4817-B93D-61C02B4C0FEC/Test.app/index2.js

    
    NSLog(@"%@",self.url.absoluteString);
    [_instance renderWithURL:self.url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
}

- (NSURL *)url {
    if (!_url) {
        _url =  [[NSBundle mainBundle] URLForResource:@"index5" withExtension:@"js"];
    }
    return _url;
}

- (void)dealloc {
    [_instance destroyInstance];
}

@end
