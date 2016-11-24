//
//  ViewController.m
//  Demo-跑马灯文字
//
//  Created by Suning on 16/10/11.
//  Copyright © 2016年 Suning. All rights reserved.
//

#import "ViewController.h"
#import "HollowLabel.h"
#import "UIView+Frame.h"

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController (){
    HollowLabel *_hollowOutLabel;
    UIView *_scrollView;
    NSTimer *_timer;
    UIView *_backView;
    BOOL _isStop;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIView alloc]initWithFrame:CGRectMake(90, 100, kScreenWidth/2, 40)];
    _scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollView];
    
    [self setHollowLabByDrawRect];
    
    [self setUpBtn];
    
    
}

-(void)setHollowLabByDrawRect{
    _hollowOutLabel = [[HollowLabel alloc] initWithFrame:CGRectMake(90, 100, _scrollView.width, _scrollView.height)];
    _hollowOutLabel.text = @"这是一行镂空文字";
    _hollowOutLabel.backgroundColor = [UIColor grayColor];
    _hollowOutLabel.font = [UIFont boldSystemFontOfSize:20];
    _hollowOutLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_hollowOutLabel];
    
    UIView *backView = [[UIView alloc]initWithFrame:_hollowOutLabel.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    _backView = backView;
    [_scrollView insertSubview:backView belowSubview:_hollowOutLabel];
}
     
-(void)setUpBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, _scrollView.bottom+80, 100, 50);
    [btn setTitle:@"播放" forState:UIControlStateNormal];
    [btn setTitle:@"停止" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(timerTheScrollview:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)timerTheScrollview:(UIButton *)btn {
    if (!btn.selected) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(playTheText) userInfo:nil repeats:YES];
    } else {
        [_timer invalidate];
        _timer = nil;
    }
    btn.selected = !btn.selected;

}

-(void)playTheText{
    if (!_isStop) {
        _backView.width--;
        if (_backView.width == 0.5) {
            _isStop = YES;
        }
    } else {
        _backView.width++;
        if (_backView.width == _scrollView.width) {
            _isStop = NO;
        }
    }
}

@end
