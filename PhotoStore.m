

#import "PhotoStore.h"
#import "FlickrAPI.h"
@interface PhotoStore ()
@property (nonatomic) NSURLSession *session;
@end
@implementation PhotoStore
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}



- (void)fetchRecentPhotos {
    NSURL *url = [FlickrAPI recentPhotosURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *response,
                                                                     NSError *error) {
                                                     if (data != nil) {
                                                         NSString *jsonString =
                                                         [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                         NSLog(@"%@", jsonString);
                                                     } else {
                                                         NSLog(@"Failed to fetch data. Error: %@", error);
                                                     }
                                                 }];
    [task resume];
}



@end
