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
    
    // Do any additional setup after loading the view.
}

//- (void)setSubeventImageURL:(NSURL *)subeventImageURL {
//    _subeventImageURL = subeventImageURL;
//    
//}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image{
    self.imageView.image = image;
}

- (NSString *)descriptionText
{
    return self.subeventDescription.text;
}

- (void)setDescriptionText:(NSString *)descriptionText{
    self.subeventDescription.text = descriptionText;
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

- (void)fetchDescription{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
