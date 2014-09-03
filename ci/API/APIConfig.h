@interface APIConfig : NSObject
- (instancetype)initWithBaseURL:(NSURL *)baseURL clientId:(NSString *)clientId;

@property (nonatomic, readonly) NSURL *baseURL;
@property (nonatomic, readonly) NSString *clientId;
@end
