//
//  ViewController.m
//  天气预报
//
//  Created by chengchao on 15/8/11.
//  Copyright (c) 2015年 chengchao. All rights reserved.
//

#import "ViewController.h"
#import "SBJson4.h"
#define  APP_KEY     @"deea78a9824533b47985c2747fadae38"
#define  BAIDUAPIURL @"http://apis.baidu.com/apistore/weatherservice/citylist"
@interface ViewController ()
{
    
    UITextView *textView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    textView=[[UITextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:textView];
    
    
    NSString *httpUrl = @"http://apis.baidu.com/apistore/weatherservice/citylist";

    NSString *str=@"南京";
    NSString *httpArg =  [NSString stringWithFormat:@"cityname=%@",[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
    
    
    [self request: httpUrl withHttpArg: httpArg];
    
    
}

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: APP_KEY forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                   NSString *str=    [responseString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                   textView.text=str;
                                   
                                   
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                               }
                           }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
