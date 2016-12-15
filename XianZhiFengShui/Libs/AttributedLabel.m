//
//  AttributedLabel.m
//  AttributedStringTest
//
//  Created by sun huayu on 13-2-19.
//  Copyright (c) 2013年 sun huayu. All rights reserved.
//

#import "AttributedLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface AttributedLabel(){

}
@property (nonatomic,retain)NSMutableAttributedString          *attString;
@end

@implementation AttributedLabel
@synthesize attString = _attString;

- (void)dealloc{
    [_attString release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = 2;
    textLayer.string = _attString;
    textLayer.wrapped = YES;
    // textLayer.transform = CATransform3DMakeScale(1.5,1.5,1);
    textLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.layer addSublayer:textLayer];
    
  //段洛样式有要求的需要用到下面
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attString);
//    
//    CGMutablePathRef Path = CGPathCreateMutable();
//    
//    //坐标点在左下角
//    CGPathAddRect(Path, NULL ,CGRectMake(10 , 10 ,self.bounds.size.width-20 , self.bounds.size.height-20));
//    
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
//
//    //获取当前(View)上下文以便于之后的绘画，这个是一个离屏。
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
//    
//    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
//    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
//    CGContextSaveGState(context);
//    
//    //x，y轴方向移动
//    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
//    
//    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
//    CGContextScaleCTM(context, 1.0 ,-1.0);
//    
//    CTFrameDraw(frame,context);
//    
//    CGPathRelease(Path);
//    CFRelease(framesetter);
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (text == nil) {
        self.attString = nil;
    }else{
        self.attString = [[[NSMutableAttributedString alloc] initWithString:text] autorelease];
        
    }
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)color.CGColor
                        range:NSMakeRange(location, length)];
}

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CTFontCreateWithName((CFStringRef)font.fontName,
                                                       font.pointSize,
                                                       NULL)
                        range:NSMakeRange(location, length)];
    [self setStyleNumber];
}

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length{
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    [_attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                        value:(id)[NSNumber numberWithInt:style]
                        range:NSMakeRange(location, length)];
}
- (void)setStyleNumber
{
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping; //换行模式
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    //行间距
    CTParagraphStyleSetting LineSpacing;
    CGFloat spacing = 11.0;  //指定间距
    LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacing;
    LineSpacing.value = &spacing;
    LineSpacing.valueSize = sizeof(CGFloat);
    
    CTParagraphStyleSetting settings[] = {lineBreakMode,LineSpacing};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);   //第二个参数为settings的长度
    [_attString addAttribute:(NSString *)kCTParagraphStyleAttributeName
                             value:(id)paragraphStyle
                             range:NSMakeRange(0, _attString.length)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
