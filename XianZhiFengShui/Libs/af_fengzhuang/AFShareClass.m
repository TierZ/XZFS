//
//  AFShareClass.m

//

#import "AFShareClass.h"

static NSString * const AFBaseURLString = XZBASEURL;

@implementation AFShareClass

+ (instancetype)sharedClient {
    static AFShareClass *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFShareClass alloc] initWithBaseURL:[NSURL URLWithString:AFBaseURLString]];
//        _sharedClient = [AFShareClass manager];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
  
        AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [serializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = 30.0f;
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
                
        [_sharedClient.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"application/x-javascript",@"application/text",@"text/plain" ,nil]];

//        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    return _sharedClient;
}

@end
