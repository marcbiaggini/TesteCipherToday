//
//  AppDelegate.m
//  TesteCipher
//
//  Created by TVTiOS-01 on 22/06/15.
//  Copyright (c) 2015 TVTiOS-01. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)getImage
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
             
             // Exibe mensagem de erro (problemas na chamada)
             
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
                 
                 [[NSUserDefaults standardUserDefaults] setObject:values forKey:@"Information"];
                 
                 
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

@end
