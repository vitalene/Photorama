

#import <UIKit/UIKit.h>
@interface PhotoDataSource : NSObject <UICollectionViewDataSource>
@property(nonatomic, copy) NSArray *photos;
- (instancetype)initWithPhotos:(NSArray *)photos NS_DESIGNATED_INITIALIZER;

@end
