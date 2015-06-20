//
//  ViewController.m
//  lab2
//
//  Created by Kalluri, Venkatesh Prasad (UMKC-Student) on 6/19/15.
//  Copyright (c) 2015 edu.umkc. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"

#define BASE_URL "https://api.twilio.com/2010-04-01/Accounts/AC3d32dbfc8c14af0c3513ca06b796a65a/SMS/Messages"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;


@property (weak, nonatomic) IBOutlet UITextView *messageBody;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)send:(id)sender {
    NSLog(@" Sending Request....");
    
    NSString *twilioSID = @"AC3d32dbfc8c14af0c3513ca06b796a65a";
    NSString *twilioAuthKey = @"a6f88ec75cf8a5d0f89b521d5085a6ba";
    NSString *fromNumber = @"+13145941038";
    NSString *ToNumber = self.phoneNumber.text;
    NSString *bodyMessage = self.messageBody.text;
    
    
    // NSString *messageBody = self.messageBody.text;
    
    //Building Http request to send the data
    
    NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", twilioSID, twilioAuthKey, twilioSID];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    
    //Set up the body the request
    
    NSString *bodyString = [NSString stringWithFormat:@"From=%@&To=%@&Body=%@", fromNumber,ToNumber,bodyMessage];
    
    NSData *data =[bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    NSError *error;
    
    NSURLResponse *response;
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //Handle the received data
    
    if(error){
        NSLog(@"Error:%@", error);
    }else{
        NSString *receivedString = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"Request sent.%@",receivedString);
    }
    
}



@end
