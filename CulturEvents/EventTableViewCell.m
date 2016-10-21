//
//  EventTableViewCell.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 21.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell()
@property (nonatomic, strong) UIImage *image;
@end

@implementation EventTableViewCell

- (void)setEventImageURL:(NSURL *)eventImageURL {
    _eventImageURL = eventImageURL;
    [self startDownloadEventImage];
}


- (void)startDownloadEventImage {
    self.image = nil;
    
    if (self.eventImageURL)
    {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:self.eventImageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                            if (!error) {
                                                                if ([request.URL isEqual:self.eventImageURL]) {
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                                    dispatch_async(dispatch_get_main_queue(), ^{ self.image = image; });
                                                                }
                                                            }
                                                        }];
        [task resume];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
