

#import "FlickrAPI.h"
#import "Photo.h"
#import "PhotoStore.h"
@implementation FlickrAPI
NSString * const BaseURLString = @"https://api.flickr.com/services/rest";
NSString * const RecentPhotosMethod = @"flickr.photos.getRecent";
NSString * const APIKey = @"a6d819499131071f158fd740860a5a88";

+ (Photo *)photoFromJSON:(NSDictionary *)jsonDict {
    NSString *photoID = jsonDict[@"id"];
    NSString *title = jsonDict[@"title"];
    NSURL *URL = [NSURL URLWithString:jsonDict[@"url_h"]];
    NSDate *dateTaken = [[FlickrAPI dateFormatter] dateFromString:jsonDict[@"datetaken"]];
    if (!photoID || !title || !URL || !dateTaken) {
        return nil; }
    Photo *photo = [[Photo alloc] initWithTitle:title
                                        photoID:photoID
                                      remoteURL:URL
                                      dateTaken:dateTaken];
    return photo;
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return formatter;
}
+ (NSURL *)flickrURLForMethod:(NSString *)method
                   parameters:(NSDictionary *)params {
    NSURLComponents *components = [NSURLComponents componentsWithString:BaseURLString];
    NSMutableArray *queryItems = [NSMutableArray array];
    NSMutableDictionary *allParams = [@{ @"method" : method,
                                         @"format" : @"json",
                                         @"nojsoncallback" : @"1",
                                         @"api_key" : APIKey } mutableCopy];
    [allParams addEntriesFromDictionary:params];
    for (NSString *queryKey in allParams.allKeys) {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:queryKey
                                                                value:allParams[queryKey]];
        [queryItems addObject:queryItem];
    }
    components.queryItems = queryItems;
    return components.URL;
}

+ (NSURL *)recentPhotosURL {
    NSDictionary *parameters = @{@"extras":@"url_h,date_taken"};
    NSURL *url = [self flickrURLForMethod:RecentPhotosMethod
                               parameters:parameters];
    return url;
}

+ (NSArray *)photosFromJSONData:(NSData *)jsonData {
    NSMutableArray *photos = [NSMutableArray array];
    NSError *parseError = nil;
    NSDictionary *jsonObject =
    [NSJSONSerialization JSONObjectWithData:jsonData
                                    options:0
                                      error:&parseError];
    if (jsonObject != nil) {
        NSDictionary *jsonPhotosDict = jsonObject[@"photos"];
        NSArray *jsonPhotosArray = jsonPhotosDict[@"photo"];
        for (NSDictionary *jsonSinglePhotoDict in jsonPhotosArray) {
            Photo *photo = [FlickrAPI photoFromJSON:jsonSinglePhotoDict];
            if (photo) {
                [photos addObject:photo];
            }
        }
    } else {
        NSLog(@"Failed to parse JSON data. Error: %@", parseError);
    }
    return photos; // returning empty array for now
}






@end
