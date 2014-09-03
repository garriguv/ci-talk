#import "Environment.h"

#import "PlistReader.h"
#import "APIConfig.h"

@interface Environment ()
@property (nonatomic, readonly) NSDictionary *environmentValues;
@end

static NSString * const kEnvironmentPlist = @"Environment";

@implementation Environment

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithPlistReader:[[PlistReader alloc] initWithPlistNamed:kEnvironmentPlist]];
}

- (instancetype)initWithPlistReader:(PlistReader *)plistReader
{
    self = [super init];
    if (self) {
        NSParameterAssert(plistReader);
        _environmentValues = [plistReader allValues];
    }
    return self;
}

#pragma mark - Public static

+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    static Environment *_sharedEnvironment;
    dispatch_once(&token, ^{
        _sharedEnvironment = [[Environment alloc] init];
    });
    return _sharedEnvironment;
}

#pragma mark - Public

- (APIConfig *)apiConfig
{
    return [[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:[self environmentValues][@"api"][@"base_url"]]
                                     clientId:[self environmentValues][@"api"][@"client_id"]];
}

@end
