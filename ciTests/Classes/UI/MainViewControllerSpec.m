#import "MainViewController.h"

#import "Environment.h"
#import "APIConfig.h"

@interface MainViewController (Spec)
@property (weak, nonatomic) IBOutlet UILabel *bundleIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *clientIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

SpecBegin(MainViewController)
    __block MainViewController *subject;

    __block Environment *environment;

    before(^{
        environment = mock([Environment class]);

        subject = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];

        [given([environment apiConfig]) willReturn:[[APIConfig alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.soundcloud.com"]
                                                                             clientId:@"client_id"]];

        [subject setValue:environment forKey:@"environment"];
    });

    context(@"when view is loaded", ^{
        before(^{
            subject.view;
        });

        it(@"sets the bundle identifier", ^{
            expect(subject.bundleIdentifierLabel.text).to.equal(@"com.company.ci-test-dev");
        });

        it(@"sets the version label", ^{
            expect(subject.versionLabel.text).to.equal(@"dev-not-set-not-set");
        });

        it(@"sets the API url", ^{
            expect(subject.baseUrlLabel.text).to.equal(@"https://api.soundcloud.com");
        });

        it(@"sets the client id", ^{
            expect(subject.clientIdLabel.text).to.equal(@"client_id");
        });
    });
SpecEnd
