#import "APIConfig.h"

SpecBegin(APIConfig)
    __block APIConfig *subject;

    before(^{
        subject = [[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.soundcloud.com"]
                                            clientId:@"client_id"];
    });

    describe(@"data value object", ^{
        it(@"has an baseURL", ^{
            expect(subject.baseURL).to.equal([NSURL URLWithString:@"https://api.soundcloud.com"]);
        });

        it(@"has a clientId", ^{
            expect(subject.clientId).to.equal(@"client_id");
        });
    });

    describe(@"-equal:", ^{
        it(@"just works", ^{
            expect(subject).to.equal([[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.soundcloud.com"]
                                                               clientId:@"client_id"]);
            expect(subject).notTo.equal([[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:@"https://apiv2.soundcloud.com"]
                                                               clientId:@"client_id"]);
            expect(subject).notTo.equal([[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.soundcloud.com"]
                                                               clientId:@"other_client_id"]);
        });
    });
SpecEnd
