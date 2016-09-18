
#import <UIKit/UIKit.h>
@class Photo;
@interface PhotoStore : NSObject
- (void)fetchRecentPhotosWithCompletion:(void(^)(NSArray *))completion;
- (void)fetchImageForPhoto:(Photo *)photo completion:(void(^)(UIImage *))completion;
@end
