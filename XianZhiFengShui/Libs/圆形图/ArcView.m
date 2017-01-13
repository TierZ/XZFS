//
//  ArcView.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 16/5/9.
//  Copyright © 2016年 傻瓜理财. All rights reserved.
//

#import "ArcView.h"

@implementation ArcView

static float arcWidth; //圆弧的宽度
static double pieCapacity;  //角度增量值

static inline float radians(double degrees) {
    return degrees * M_PI/ 180;
}


- (id)initWithFrame:(CGRect)frame arcWidth:(double)width current:(double)current total:(double)total
{
    self = [super initWithFrame:frame];
    if (self) {
        arcWidth=width;
        pieCapacity=360*current/total;
        NSLog(@"pieCapacity->>%f",pieCapacity);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();//获得当前view的图形上下文(context)
    //设置填充颜色
    CGContextSetRGBFillColor(context, 200,200, 0, 1);
    //设置画笔颜色
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    //设置画笔线条粗细
        CGContextSetLineWidth(context, 0);
    
    //扇形参数
    double radius; //半径
    if(self.frame.size.width>self.frame.size.height){
        radius=self.frame.size.height/2-self.frame.size.height/10;
    }else{
        radius=self.frame.size.width/2-self.frame.size.width/10;
    }
    int startX=self.frame.size.width/2;//圆心x坐标
    int startY=self.frame.size.height/2;//圆心y坐标
    double pieStart=270;//起始的角度
    int clockwise=1;//0=逆时针,1=顺时针
//    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
//    CGContextSetRGBFillColor(context, 255, 153, 0, 1);
    //顺时针画扇形
//    CGContextMoveToPoint(context, startX, startY);
//    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+(360-pieCapacity)), clockwise);
//    CGContextClosePath(context);
//        CGContextDrawPath(context, kCGPathEOFillStroke);
//    CGContextFillPath(context);
    
    clockwise=1;//0=逆时针,1=顺时针
    CGContextSetRGBStrokeColor(context, 255, 153, 0, 1);
    CGContextSetRGBFillColor(context, 1.00, 0.30, 0.00, 1.00);//完成的颜色
    //顺时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextFillPath(context);
    
    clockwise=0;//0=逆时针,1=顺时针
    CGContextSetRGBStrokeColor(context, 255, 153, 0, 1);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);//未完成颜色
    //逆时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
    CGContextFillPath(context);
    
    //    画圆
    CGContextBeginPath(context);
    CGContextSetRGBFillColor(context,1.00, 0.56, 0.00, 1.00);//背景颜色
    CGRect circle = CGRectInset(self.bounds, arcWidth, arcWidth);
    CGContextAddEllipseInRect(context, circle);
    CGContextFillPath(context);
}

@end
