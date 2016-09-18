

#import <UIKit/UIKit.h>
@class PhotoStore;
@interface PhotosViewController : UIViewController <UICollectionViewDelegate>
@property (nonatomic) PhotoStore *photoStore;

@end

