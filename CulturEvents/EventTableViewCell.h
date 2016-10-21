//
//  EventTableViewCell.h
//  CulturEvents
//
//  Created by Vladimir Bolotov on 21.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface EventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDateLabel;

@end
