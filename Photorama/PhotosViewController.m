
#import "PhotosViewController.h"
#import "PhotoStore.h"
#import "PhotoDataSource.h"

@interface PhotosViewController ()
@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource *photoDataSource;@end
@implementation PhotosViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.photoDataSource = [PhotoDataSource new];
    self.collectionView.dataSource = self.photoDataSource;
    [self.photoStore fetchRecentPhotosWithCompletion:^(NSArray *photos){
        NSLog(@"Found %lu photos", (unsigned long)photos.count);
        
        if (photos.count == 0) {
            NSLog(@"Zero photos! Sad times.");
            return; }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.photoDataSource.photos = photos;
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }];
        
        
    }];
}

@end
