//
//  HollowLabel.m
//  Demo-跑马灯文字
//
//  Created by Suning on 16/10/11.
//  Copyright © 2016年 Suning. All rights reserved.
//

#import "HollowLabel.h"

@interface HollowLabel(){
    NSString *_labelText;
    UIFont *_labelFont;
    UIColor *_labelBackgroundColor;
    CGRect _labelRect;
}

@end

@implementation HollowLabel

-(void)setText:(NSString *)text{
    _labelText = text;
}

-(void)setFont:(UIFont *)font{
    _labelFont = font;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _labelBackgroundColor = backgroundColor;
}

//重写该方法，否则该方法会出问题
-(void)sizeToFit{
    
}

//禁止使用该方法初始化
-(instancetype)init{
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _labelRect = frame;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawHallowLabel:_labelText inRect:_labelRect inContext:ctx];
}

-(void)drawHallowLabel:(NSString *)labText inRect:(CGRect )labrect inContext:(CGContextRef )context{
    //记录上下文的当前状态
    CGContextSaveGState(context);
    //设置混合色
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    //lable上边添加label
    UILabel *lab = [[UILabel alloc]initWithFrame:labrect];
    lab.text = labText;
    lab.backgroundColor = _labelBackgroundColor;
    lab.font = _labelFont;
    lab.textAlignment = NSTextAlignmentCenter;
    
    [lab.layer drawInContext:context];
    //去除堆栈顶部的状态，返回到之前的上下文状态
    CGContextRestoreGState(context);
    
}

@end
