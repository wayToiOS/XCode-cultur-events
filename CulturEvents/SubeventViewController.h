//
//  SubeventViewController.h
//  CulturEvents
//
//  Created by Vladimir Bolotov on 21.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubeventViewController : UIViewController

@property (nonatomic, strong) NSString *subeventDateAndTime;
@property (nonatomic, strong) NSURL *subeventImageURL;
@property (nonatomic, strong) NSURL *subeventURL;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *subeventDescription;



@end
