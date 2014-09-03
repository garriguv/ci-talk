@interface PlistReader : NSObject
- (instancetype)initWithPlistNamed:(NSString *)plistName;

- (NSDictionary *)allValues;
@end
