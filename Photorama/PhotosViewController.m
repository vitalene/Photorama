
#import "PhotosViewController.h"
#import "PhotoStore.h"


@interface PhotosViewController ()
@property (nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation PhotosViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.photoStore fetchRecentPhotosWithCompletion:^(NSArray *photos){
        NSLog(@"Found %lu photos", (unsigned long)photos.count);
    }];
}

@end
