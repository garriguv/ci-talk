#import "PlistReader.h"

SpecBegin(PlistReader)
    __block PlistReader *subject;

    __block NSString *plistName;

    before(^{
        plistName = @"TestPlist";

        subject = [[PlistReader alloc] initWithPlistNamed:plistName];
    });

    describe(@"-allValues", ^{
        context(@"when the plist does NOT exist", ^{
            it(@"raises an assertion", ^{
                expect(^{ [subject allValues]; }).to.raiseAny();
            });
        });

        context(@"when the plist exists", ^{
            __block NSDictionary *values;
            __block NSURL *plistURL;

            before(^{
                values = @{
                    @"attribute1" : @"value1",
                    @"attribute2" : @"value2"
                };
                plistURL = [[[NSBundle mainBundle] resourceURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", plistName]];
                NSAssert([values writeToURL:plistURL atomically:YES], @"failed to create test plist file");
            });

            after(^{
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSError *error;
                NSAssert([fileManager removeItemAtURL:plistURL error:&error], @"failed to remove test plist file: %@", error);
            });

            it(@"returns a dictionary containing the values", ^{
                expect([subject allValues]).to.equal(values);
            });
        });
    });
SpecEnd
