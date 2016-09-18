

#import "FlickerAPI.h"

@implementation FlickerAPI
NSString * const BaseURLString = @"https://api.flickr.com/services/rest";
NSString * const RecentPhotosMethod = @"flickr.photos.getRecent";
NSString * const APIKey = @"a6d819499131071f158fd740860a5a88";

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

@end
