
#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)updateWithImage:(UIImage *)image {
    if (image != nil) {
        [self.spinner stopAnimating];
    } else {
        [self.spinner startAnimating];
    }
    self.imageView.image = image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateWithImage:nil];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    [self updateWithImage:nil];
}

@end
