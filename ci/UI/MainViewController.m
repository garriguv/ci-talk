#import "MainViewController.h"

#import "Environment.h"
#import "APIConfig.h"

@interface MainViewController ()
@property (nonatomic, readonly) Environment *environment;

@property (weak, nonatomic) IBOutlet UILabel *bundleIdentifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *baseUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *clientIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@end

@implementation MainViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _environment = [Environment sharedInstance];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupLabels];
}

#pragma mark - Private

- (void)setupLabels
{
    self.bundleIdentifierLabel.text = [[NSBundle mainBundle] bundleIdentifier];
    self.versionLabel.text = [self versionString];
    self.baseUrlLabel.text = [[[self.environment apiConfig] baseURL] absoluteString];
    self.clientIdLabel.text = [[self.environment apiConfig] clientId];
}

- (NSString *)versionString
{
    return [NSString stringWithFormat:@"%@-%@-%@",
            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
}

@end
