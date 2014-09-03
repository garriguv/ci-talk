#import "PlistReader.h"

@interface PlistReader ()
@property (nonatomic, readonly) NSString *plistName;
@end

@implementation PlistReader

#pragma mark - Initialization

- (instancetype)initWithPlistNamed:(NSString *)plistName
{
    self = [super init];
    if (self) {
        NSParameterAssert(plistName);
        _plistName = plistName;
    }
    return self;
}

#pragma mark - Public

- (NSDictionary *)allValues
{
    NSURL *plistURL = [self plistURL];
    NSAssert(plistURL, @"plist URL is nil");
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    NSAssert(plist, @"plist file returned nil dictionary %@", plistURL);
    return plist;
}

#pragma mark - Private

- (NSURL *)plistURL
{
    return [[self resourcesURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", self.plistName]];
}

- (NSURL *)resourcesURL
{
    return [[NSBundle mainBundle] resourceURL];
}

@end
