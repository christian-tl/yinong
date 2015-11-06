

#import "ContentTableCell.h"

@interface ContentTableCell ()




@end

@implementation ContentTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setName:(NSString *)n
{
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.contentLabel.text = self.name;
        
    }
}


@end
