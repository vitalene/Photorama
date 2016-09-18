
#import <Foundation/Foundation.h>

@interface PhotoStore : NSObject
- (void)fetchRecentPhotosWithCompletion:(void(^)(NSArray *))completion;
@end
