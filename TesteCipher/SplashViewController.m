//
//  ViewController.m
//  TesteCipher
//
//  Created by TVTiOS-01 on 22/06/15.
//  Copyright (c) 2015 TVTiOS-01. All rights reserved.
//

#import "SplashViewController.h"
#import "ViewController.h"

@interface SplashViewController ()
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) NSMutableArray *conteudoList;

@end

@implementation SplashViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = [[NSMutableArray alloc] init];
    self.networkMonitor = [[NetworkConnectionMonitor alloc] init];
    self.busyView = [BusyIndicatorController getActivityIndicator:self.view];
    [BusyIndicatorController startBusyIndicator:self.busyView];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Information"]==nil)
    {
        if([self.networkMonitor getWifiStatus])
        {
            
            [self getWebServiceValues];
            [self transitionObserver];
            
        }else{
            [BusyIndicatorController stopBusyIndicator:self.busyView];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"                                                                   message:@"You must Have a good internet Connection!...Restart again, Your Application!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            alert.tag = 1;
            [alert show];
        }
        
        
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated
{

    // Dispose of any resources that can be recreated.
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Information"]!=nil)
    {
        [self gotoViewController];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)transitionObserver
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setTransition:)
                                                 name:nil object:nil];
    
    
}

- (void)setTransition:(NSNotification*)aNotification
{
    if(self.listData.count == 5)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];

        [self gotoViewController];
    }
    
}

- (void)getWebServiceValues
{
    
    NSString * ws=[NSString stringWithFormat:@"%@",@"http://tmp.eidoscode.com/cipher/ws.json"];
    // Inicializa o objeto de URL
    NSURL *url = [[NSURL alloc] initWithString:[ws stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // Faz a request ao webservice
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         // Verifica se a chamada foi realizada com erros
         if (error)
         {
             [BusyIndicatorController stopBusyIndicator:self.busyView];

             // Exibe mensagem de erro (problemas na chamada)
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"                                                                   message:@"You must Have a good internet Connection!...Restart again, Your Application!"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             alert.tag = 1;
             [alert show];

             
         }
         else
         {
             
             NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSDictionary *conteudoList = [parsedObject objectForKey:@"conteudo"];
             
             if([conteudoList isKindOfClass:[NSArray class]]){
                 
                 NSMutableArray *values = [[NSMutableArray alloc] init];
                 values = [conteudoList mutableCopy];
                 bool swapped = YES;
                 while (swapped){
                     swapped = NO;
                     for (int i=0; i<values.count;i++)
                     {
                         if (i < values.count-1){
                             
                             NSDictionary *currentIndexValue = [values objectAtIndex:i];
                             NSDictionary *nextIndexValue    = [values objectAtIndex:i+1];
                             
                             if ([[currentIndexValue objectForKey:@"valor"] doubleValue]  > [[nextIndexValue objectForKey:@"valor"] doubleValue]){
                                 swapped = YES;
                                 [self swapFirstIndex:i withSecondIndex:i+1 inMutableArray:values];
                             }
                         }
                         
                     }
                 }
                 NSOrderedSet *dataOrderedSet = [NSOrderedSet orderedSetWithArray:values];
                 
                 [[NSUserDefaults standardUserDefaults] setObject:[dataOrderedSet array] forKey:@"Information"];
                
                
                 
                 if([[NSUserDefaults standardUserDefaults] objectForKey:@"Information"]!=nil)
                 {
                     self.dataList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Information"]];
                     
                     self.listData = [[NSMutableArray alloc] initWithCapacity:self.dataList.count];

                             [self downloadImageWithURL:self.dataList
                                        completionBlock:^(BOOL succeeded, NSMutableArray *bannerArray) {
                                            if (succeeded) {
                                                
                                                
                                                // cache the image for use later
                                                [[NSUserDefaults standardUserDefaults] setObject:self.listData forKey:@"CacheImage"];
                                                

                                                
                                            }else{
                                                [BusyIndicatorController stopBusyIndicator:self.busyView];

                                                // Exibe mensagem de erro (problemas na chamada)
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!"                                                                   message:@"You must Have a good internet Connection!...Restart again, Your Application!"
                                                                                               delegate:self
                                                                                      cancelButtonTitle:@"OK"
                                                                                      otherButtonTitles:nil];
                                                alert.tag = 1;
                                                [alert show];
                                            }
                                            
                                        }];
                         
                     
                    
                     
                 }
                 
             }
         }
         
     }];
   

    
}

-(void)swapFirstIndex:(NSUInteger)firstIndex withSecondIndex:(NSUInteger)secondIndex inMutableArray:(NSMutableArray*)array{
    
    NSDictionary* valueAtFirstIndex = array[firstIndex];
    NSDictionary* valueAtSecondIndex = array[secondIndex];
    
    [array replaceObjectAtIndex:firstIndex withObject:valueAtSecondIndex];
    [array replaceObjectAtIndex:secondIndex withObject:valueAtFirstIndex];
}




- (void)downloadImageWithURL:(NSMutableArray *)dataArray completionBlock:(void (^)(BOOL succeeded, NSMutableArray *imageArray))completionBlock
{
    for (int i =0; i<=dataArray.count-1; i++)
    {
        NSMutableDictionary *fruits = [[NSMutableDictionary alloc]init];
         NSDictionary *item = [dataArray objectAtIndex:i];
        NSURL *urlImage = [[NSURL alloc]initWithString:[item objectForKey:@"image"]];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlImage];
       
        [NSURLConnection sendAsynchronousRequest:request
                                                              queue:[NSOperationQueue mainQueue]
                                                  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                            {
                                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                if ( !error && [httpResponse statusCode]!=404)
                                {
                                    [fruits setValue:[response.URL absoluteString] forKey:@"url"];
                                    [fruits setValue:data forKey:@"image"];
                                    [self.listData addObject:fruits];
                                    
                                    completionBlock(YES,self.listData);
                                    
                                    
                                    
                                } else{
                                    completionBlock(NO,nil);
                                }
                            }];
                           
        
        
    }
   
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [BusyIndicatorController stopBusyIndicator:self.busyView];
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    if (alertView.tag == 1) {
        exit(0);
    }
    
    
}

- (void)gotoViewController {

    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [BusyIndicatorController stopBusyIndicator:self.busyView];

    // Load the initial view controller from the storyboard.
    // Set this by selecting 'Is Initial View Controller' on the appropriate view controller in the storyboard.
    //
    // Load the view controller with the identifier string
    // Change UIViewController to the appropriate class
    UIViewController *viewController = (ViewController *)[secondStoryBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    // Then present the new view controller in the usual way:
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
