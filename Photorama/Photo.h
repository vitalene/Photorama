
#import <UIKit/UIKit.h>
@interface Photo : NSObject
@property(nonatomic, readonly, copy) NSString *title;
@property(nonatomic, readonly) NSURL *remoteURL;
@property(nonatomic, readonly, copy) NSString *photoID;
@property(nonatomic, readonly) NSDate *dateTaken;
@property(nonatomic) UIImage *image;


- (instancetype)initWithTitle:(NSString *)title
                      photoID:(NSString *)photoID
                    remoteURL:(NSURL *)URL
                    dateTaken:(NSDate *)dateTaken NS_DESIGNATED_INITIALIZER;

@end
