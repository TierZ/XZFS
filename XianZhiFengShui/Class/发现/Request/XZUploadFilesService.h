//
//  XZUploadFilesService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/9.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

/**
 上传文件
 */
@interface XZUploadFilesService : BasicService

/**
 上传文件

 @param fileArray 文件数组
 @param fileNames 文件名
 @param view      。。
 */
-(void)uploadFilesWithFiles:(NSArray*)fileArray fileNames:(NSArray*)fileNames view:(id)view;
@end
