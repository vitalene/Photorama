

#import "PhotoDataSource.h"

@implementation PhotoDataSource


- (instancetype)initWithPhotos:(NSArray *)photos {
    self = [super init];
    if (self) {
        _photos = [photos copy];
    }
    return self;
}
- (instancetype)init {
    return [self initWithPhotos:nil];
}

// MARK: Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell"
                                              forIndexPath:indexPath];
    return cell;
}

@end
