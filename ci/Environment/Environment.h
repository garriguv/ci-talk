@class PlistReader;
@class APIConfig;

@interface Environment : NSObject
+ (instancetype)sharedInstance;

- (APIConfig *)apiConfig;
@end
