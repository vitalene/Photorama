
#import <Foundation/Foundation.h>

@interface FlickrAPI : NSObject
+ (NSURL *)recentPhotosURL;
+ (NSArray *)photosFromJSONData:(NSData *)jsonData;
@end
