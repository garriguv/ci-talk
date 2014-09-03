#import "Environment.h"

#import "APIConfig.h"
#import "PlistReader.h"

@interface Environment (Spec)
- (instancetype)initWithPlistReader:(PlistReader *)plistReader;
@end

SpecBegin(Environment)
    __block Environment *subject;

    __block PlistReader *plistReader;

    before(^{
        plistReader = mock([PlistReader class]);
    });

    describe(@"+sharedInstance", ^{
        it(@"is a singleton", ^{
            expect([Environment sharedInstance]).to.beIdenticalTo([Environment sharedInstance]);
        });
    });

    context(@"when the plist is valid", ^{
        __block NSDictionary *plistDictionary;

        before(^{
            plistDictionary = @{
                @"api" : @{
                    @"base_url" : @"https://api.soundcloud.com",
                    @"client_id" : @"client_id"
                }
            };

            [given([plistReader allValues]) willReturn:plistDictionary];

            subject = [[Environment alloc] initWithPlistReader:plistReader];
        });

        describe(@"-apiConfig", ^{
            it(@"returns a valid APIConfig", ^{
                expect([subject apiConfig]).to.equal([[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.soundcloud.com"]
                                                                               clientId:@"client_id"]);
            });
        });
    });

    context(@"when the plist is NOT valid", ^{
        before(^{
            subject = [[Environment alloc] initWithPlistReader:plistReader];
        });

        describe(@"-apiConfig", ^{
            it(@"raises an assertion", ^{
                expect(^{ [subject apiConfig]; }).to.raiseAny();
            });
        });
    });
SpecEnd
