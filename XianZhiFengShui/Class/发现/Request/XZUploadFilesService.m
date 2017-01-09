//
//  XZUploadFilesService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/9.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZUploadFilesService.h"

static NSString * UploadFilesService = @"/file/upload";
@implementation XZUploadFilesService


-(void)uploadFilesWithFiles:(NSArray*)fileArray fileNames:(NSArray*)fileNames view:(id)view{
    NSDictionary * dic = [NSDictionary dictionary];
    [self postAddFiles:UploadFilesService parameters:dic fileName:fileNames[0] fileDatas:fileArray view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"上传文件 = %@",data);
    } failBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
@end
