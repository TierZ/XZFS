//
//  XZAboutXianZhiVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/23.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAboutXianZhiVC.h"

@interface XZAboutXianZhiVC ()

@end

@implementation XZAboutXianZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}
-(void)setupView{
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 7, SCREENWIDTH, XZFS_MainView_H-7)];
    scroll.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:scroll];
    
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(scroll.width/2-68/2, 23, 68, 68)];
    iv.image = XZFS_IMAGE_NAMED(@"guanyuxianzhi");
    [scroll addSubview:iv];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, iv.bottom+32, SCREENWIDTH, 20)];
    title.text = @"找大师，上先知";
    title.font = XZFS_S_FONT(20);
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = XZFS_TEXTBLACKCOLOR;
    [scroll addSubview:title];
    
    UILabel * content = [[UILabel alloc]initWithFrame:CGRectMake(20, title.bottom+22, scroll.width-40, 200)];
    content.numberOfLines = 0;
    content.font = XZFS_S_FONT(13);
    content.textColor = XZFS_HEX_RGB(@"#252323");
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@" GPU 资源消耗原因和解决方案\n相对于 CPU 来说，GPU 能干的事情比较单一：接收提交的纹理（Texture）和顶点描述（三角形），应用变换（transform）、混合并渲染，然后输出到屏幕上。通常你所能看到的内容，主要也就是纹理（图片）和形状（三角模拟的矢量图形）两类。\n纹理的渲染\n所有的 Bitmap，包括图片、文本、栅格化的内容，最终都要由内存提交到显存，绑定为 GPU Texture。不论是提交到显存的过程，还是 GPU 调整和渲染 Texture 的过程，都要消耗不少 GPU 资源。当在较短时间显示大量图片时（比如 TableView 存在非常多的图片并且快速滑动时），CPU 占用率很低，GPU 占用非常高，界面仍然会掉帧。避免这种情况的方法只能是尽量减少在短时间内大量图片的显示，尽可能将多张图片合成为一张进行显示。\n当图片过大，超过 GPU 的最大纹理尺寸时，图片需要先由 CPU 进行预处理，这对 CPU 和 GPU 都会带来额外的资源消耗。目前来说，iPhone 4S 以上机型，纹理尺寸上限都是 4096x4096，更详细的资料可以看这里：iosres.com。所以，尽量不要让图片和视图的大小超过这个值。\n视图的混合 (Composing)\n当多个视图（或者说 CALayer）重叠在一起显示时，GPU 会首先把他们混合到一起。如果视图结构过于复杂，混合的过程也会消耗很多 GPU 资源。为了减轻这种情况的 GPU 消耗，应用应当尽量减少视图数量和层次，并在不透明的视图里标明 opaque 属性以避免无用的 Alpha 通道合成。当然，这也可以用上面的方法，把多个视图预先渲染为一张图片来显示。"];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(13) range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#252323") range:NSMakeRange(0, att.length)];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5;
    [att addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, att.length)];
    float height = [Tool labelHeightWithText:att fontSize:13 width:scroll.width-40 lineNum:0];
    content.attributedText = att;
    CGRect frame = content.frame;
    frame.size.height = height;
    content.frame = frame;
    [scroll addSubview:content];
    scroll.contentSize = CGSizeMake(SCREENWIDTH, content.bottom+20);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
