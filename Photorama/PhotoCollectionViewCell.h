#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property(nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic) IBOutlet UIActivityIndicatorView *spinner;


- (void)updateWithImage:(UIImage *)image;
@end
