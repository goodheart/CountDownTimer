//
//  ViewController.m
//  timeDemo
//
//  Created by goodheart on 15/9/6.
//  Copyright (c) 2015年 HSC. All rights reserved.
//

#import "ViewController.h"
#import "PMTimerManager.h"
#define kGetVerifyCodeStr @"获取验证码"

@interface ViewController ()
@property (nonatomic,strong) UIButton * verifyCodeButton;
@property (nonatomic,strong) PMTimerManager * timerManager;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.verifyCodeButton];
}

#pragma mark - Private Action
- (void)verfiyCodeButtonAction:(id)sender {
    self.verifyCodeButton.enabled = NO;
    
    __block int timeout = 10;
    [self.timerManager addCountDownWithSecDuration:1.0
                                   eventHandler:^(dispatch_source_t timer) {
        if (timeout <= 0) {//倒计时结束，关闭
            dispatch_source_cancel(timer);
        } else {
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString * strTime = [NSString stringWithFormat:@"%@(%d分%.2d秒)",kGetVerifyCodeStr,minutes,seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:strTime
                                       forState:UIControlStateDisabled];
            });
            timeout--;
        }
    } cancelBlock:^(dispatch_source_t timer) {
        dispatch_async(dispatch_get_main_queue(), ^{
            /*
             warning:((UIButton *)sender).enabled = YES;一定要写在该括号内，因为更新UI只能在主线程中做，否则会出现：当button点击两次的时候，会有延时
             */
            ((UIButton *)sender).enabled = YES;
        });
    }];
}

#pragma mark - Property Getter
- (UIButton *)verifyCodeButton{
    if (_verifyCodeButton) {
        return _verifyCodeButton;
    }
    
    _verifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _verifyCodeButton.frame = CGRectMake(10, 100, 300, 44);
    _verifyCodeButton.backgroundColor = [UIColor grayColor];
    [_verifyCodeButton setTitle:@"获取验证码"
                       forState:UIControlStateNormal];
    _verifyCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_verifyCodeButton addTarget:self
                          action:@selector(verfiyCodeButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
    
    
    return _verifyCodeButton;
}

- (PMTimerManager *)timerManager{
    if (_timerManager) {
        return _timerManager;
    }
    
    _timerManager = [[PMTimerManager alloc] init];
    
    return _timerManager;
}

@end









