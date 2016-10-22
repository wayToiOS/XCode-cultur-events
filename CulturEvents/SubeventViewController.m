//
//  SubeventViewController.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 21.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "SubeventViewController.h"

@interface SubeventViewController ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *descriptionText;
@end

@implementation SubeventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startDownloadEventImage];
    [self fetchDescription];
}

# pragma mark - date and time formatting

- (void)setSubeventDateAndTime:(NSString *)subeventDateAndTime{
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:subeventDateAndTime];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"dd MMMM HH:mm"];
    subeventDateAndTime = [dateFormat stringFromDate:date];
    self.title = subeventDateAndTime;
}

# pragma mark - image

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)startDownloadEventImage {
    self.image = nil;
    if (self.subeventImageURL)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.subeventImageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.subeventImageURL]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{ self.image = image; });
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}


# pragma mark - description

- (void)setDescriptionText:(NSString *)descriptionText {
    UIFont *systemFont =[UIFont systemFontOfSize:16.0f];
    NSAttributedString *attrStr  = [[NSAttributedString alloc] initWithData:[descriptionText dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.subeventDescription.attributedText = attrStr;
    self.subeventDescription.font = systemFont;
}

- (void)fetchDescription {
    dispatch_queue_t fetchQDescription = dispatch_queue_create("description fetcher", NULL);
    dispatch_async(fetchQDescription, ^{
        NSError *error = nil;
        
        NSData *jsonResults = [NSData dataWithContentsOfURL:self.subeventURL options:0 error: &error];
        
        
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                            options:0
                                                                              error:NULL];
        
        NSString *descriptionText = [propertyListResults valueForKeyPath:@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.descriptionText = descriptionText;
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
