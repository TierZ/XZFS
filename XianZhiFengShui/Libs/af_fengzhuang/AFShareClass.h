//
//  AFShareClass.h

//

#import <Foundation/Foundation.h>
//#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

@interface AFShareClass : AFHTTPSessionManager

+ (instancetype)sharedClient;


@end
