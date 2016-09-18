

#import "PhotoStore.h"
#import "FlickrAPI.h"
#import "Photo.h"
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



- (void)fetchRecentPhotosWithCompletion:(void(^)(NSArray *))completion {
    NSParameterAssert(completion);
    NSURL *url = [FlickrAPI recentPhotosURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data,
                                                                     NSURLResponse *response,
                                                                     NSError *error) {
                                                     NSArray *photos = [self processRecentPhotosRequestWithData:data
                                                                                                          error:error];
                                                     completion(photos);
                                                 }];
    [task resume];
}


- (NSArray *)processRecentPhotosRequestWithData:(NSData *)data error:(NSError *)error {
    if (data != nil) {
        return [FlickrAPI photosFromJSONData:data];
    }
    else {
        return nil; }
}

@end
