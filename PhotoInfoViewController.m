
#import "PhotoInfoViewController.h"
#import "Photo.h"
#import "PhotoStore.h"
@interface PhotoInfoViewController ()
@property(nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.photoStore fetchImageForPhoto:self.photo
                             completion:^(UIImage *image) {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     self.imageView.image = image;
                                 }];
                             }]; }

- (void)setPhoto:(Photo *)photo {
    _photo = photo;
    self.navigationItem.title = self.photo.title;
}

@end
