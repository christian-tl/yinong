

#import <Foundation/Foundation.h>

@interface YNHttpService : NSObject

-(NSMutableArray *) listOfficalContents : (NSString * ) page upDate: (NSString *) up_date downDate : (NSString *) down_date;

-(void) saveContent : (NSString * ) content;
@end
