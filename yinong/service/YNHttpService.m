

#import "YNHttpService.h"

@implementation YNHttpService

-(NSMutableArray *) listOfficalContents : (NSString * ) page upDate: (NSString *) up_date downDate : (NSString *) down_date
{
    NSError *error = nil;
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://101.200.233.90:8080/cs2/webservice/public/list.do?page=%@&update=%@&downdate=%@" ,page,up_date,down_date];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
   
    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dateStr,@"date",@"1",@"page", nil];
//    NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted
//                                                     error:&error];
      NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url ];
//
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:json];
    
    NSHTTPURLResponse *response;
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error != nil){
        NSLog(@"Error on load = %@" ,[error localizedDescription]);
    }
    
    if([response isKindOfClass:[NSHTTPURLResponse class]]){
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *) response;
        NSLog(@"response code is %ld",[httpresponse statusCode]);
    }
    
    NSDictionary *list = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSArray *results = [list objectForKey:@"objects"];
    return [results mutableCopy];
}

-(void) saveContent : (NSString * ) content {
    NSError *error = nil;
    NSString *urlString = @"http://101.200.233.90:8080/cs2/webservice/public/save.do";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5.0];
    
    NSString *str = [[NSString alloc] initWithFormat:@"content=%@",content];//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSHTTPURLResponse *response;
    
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error != nil){
        NSLog(@"Error on load = %@" ,[error localizedDescription]);
    }
    
    if([response isKindOfClass:[NSHTTPURLResponse class]]){
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *) response;
        NSLog(@"response code is %ld",[httpresponse statusCode]);
    }
    
 
}

@end
