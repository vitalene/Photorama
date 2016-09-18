
#import "PhotosViewController.h"
#import "PhotoStore.h"
#import "PhotoDataSource.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoInfoViewController.h"
@interface PhotosViewController ()
@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) PhotoDataSource *photoDataSource;@end
@implementation PhotosViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.photoDataSource = [PhotoDataSource new];
    self.collectionView.dataSource = self.photoDataSource;
    self.collectionView.delegate = self;
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


- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = self.photoDataSource.photos[indexPath.row];
    // Download the image data, which could take some time
    [self.photoStore fetchImageForPhoto:photo
                             completion:^(UIImage *image) {
                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                     // The index path for the photo might have changed between the
                                     // time the request started and finished, so find the most
                                     // recent index path
                                     NSUInteger photoIndex = [self.photoDataSource.photos indexOfObject:photo];
                                     NSIndexPath *photoIndexPath = [NSIndexPath indexPathForItem:photoIndex
                                                                                       inSection:0];
                                     // When the request finishes, update the cell
                                     PhotoCollectionViewCell *photoCell =
                                     (PhotoCollectionViewCell *)[self.collectionView
                                                                 cellForItemAtIndexPath:photoIndexPath];
                                     [photoCell updateWithImage:image];
                                 }];
                             }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPhoto"]) {
        NSIndexPath *selectedIndexPath =
        [self.collectionView indexPathsForSelectedItems].firstObject;
        Photo *photo = self.photoDataSource.photos[selectedIndexPath.row];
        PhotoInfoViewController *destinationVC = segue.destinationViewController;
        destinationVC.photoStore = self.photoStore;
        destinationVC.photo = photo;
    }
}



@end
