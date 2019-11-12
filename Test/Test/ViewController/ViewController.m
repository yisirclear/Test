//
//  ViewController.m
//  Test
//
//  Created by yzq on 17/8/31.
//  Copyright © 2017年 tango. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK.h>
#import <JsenNetworkingManager.h>
#import <YYModel.h>

@interface ViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, copy) NSURL *url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WXAppConfiguration setAppGroup:@"Test"];
    [WXAppConfiguration setAppName:@"Test"];
    [WXAppConfiguration setAppVersion:@"1.0"];
    [WXSDKEngine initSDKEnvironment];
    
    [WXLog setLogLevel:WXLogLevelWarning];
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
    
    [self downloadTask];
    
//file:///var/containers/Bundle/Application/8169ADF7-8443-4817-B93D-61C02B4C0FEC/Test.app/index2.js

    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"index5" withExtension:@"js"];
    
    
    NSLog(@"%@",url1.absoluteString);
    [_instance renderWithURL:url1 options:@{@"bundleUrl":[url1 absoluteString]} data:nil];
}

- (void)downloadTask {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSLog(@"%@",docPath);
    
//    NSString *relPath = [NSString stringWithFormat:@"%@/weex/",docPath];
    NSURL *docurl = [[NSURL alloc] initFileURLWithPath:docPath];
    NSLog(@"relpath - %@",docurl);
    
    NSString *picString = @"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png";

    NSString *urlString = @"http://10.255.4.92:8081/dist/components/ApplyDissent.js";
    [[JsenNetworkingManager manager] downloadWithUrl:urlString filePath:docurl fileName:@"test.js" progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"1.-----------%@",uploadProgress);
        
    } success:^(JsenNetworkingSuccessResponse * _Nonnull response) {
        
        NSLog(@"2.-----------%@",[response yy_modelDescription]);
        
    } failed:^(JsenNetworkingFailedResponse * _Nonnull response) {
        
        NSLog(@"3.-----------%@",response);
        
    } finished:nil];
    
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
