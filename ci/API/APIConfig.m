#import "APIConfig.h"

@implementation APIConfig

#pragma mark - Initialization

- (instancetype)initWithBaseURL:(NSURL *)baseURL clientId:(NSString *)clientId
{
    self = [super init];
    if (self) {
        NSParameterAssert(baseURL);
        NSParameterAssert(clientId);
        _baseURL = baseURL;
        _clientId = clientId;
    }
    return self;
}

#pragma mark - Description

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.baseURL=%@", self.baseURL];
    [description appendFormat:@", self.clientId=%@", self.clientId];
    [description appendString:@">"];
    return description;
}

#pragma mark - Equality

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    }
    if (!other || ![[other class] isEqual:[self class]]) {
        return NO;
    }

    return [self isEqualToConfig:other];
}

- (BOOL)isEqualToConfig:(APIConfig *)config
{
    return [self.baseURL isEqual:config.baseURL] && [self.clientId isEqualToString:config.clientId];
}

- (NSUInteger)hash
{
    return [[self description] hash];
}

@end
