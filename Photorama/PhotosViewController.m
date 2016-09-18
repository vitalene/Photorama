
#import "PhotosViewController.h"
#import "PhotoStore.h"


@interface PhotosViewController ()
@property (nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation PhotosViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.photoStore fetchRecentPhotos];
}

@end
