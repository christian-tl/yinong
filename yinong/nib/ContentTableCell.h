//
//  ContentTableCell.h
//  yinong
//
//  Created by christian on 15/5/3.
//  Copyright (c) 2015年 coolsnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableCell : UITableViewCell

@property (copy,nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
