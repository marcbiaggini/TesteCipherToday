//
//  ViewController.m
//  TesteCipher
//
//  Created by TVTiOS-01 on 22/06/15.
//  Copyright (c) 2015 TVTiOS-01. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *listImage;
@property (nonatomic, strong) NSArray *listImageNoRepeat;

@property (strong,nonatomic)  NSMutableArray *dataList;
@property (strong,nonatomic)  NSArray *dataListNoRepeat;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listImageNoRepeat = [[NSArray alloc] init];
    self.listImage = [[NSMutableArray alloc] init];
    self.dataList = [[NSMutableArray alloc] init];
    self.dataListNoRepeat = [[NSArray alloc] init];


    if([[NSUserDefaults standardUserDefaults] objectForKey:@"CacheImage"]!=nil)
    {
        self.dataList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Information"]];
       
        [self sortImageList:[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"CacheImage"]] withData:self.dataList];
       // self.listImage = ;
        NSDictionary *itemImage = [self.listImage objectAtIndex:0];

        UIImage *image = [[UIImage alloc] initWithData:[itemImage objectForKey:@"image"]];
        [self.imageProperty setImage:image];
        NSDictionary *item = [self.dataList objectAtIndex:0];
        self.titleProperty.text = [item objectForKey:@"title"];
        self.descriptionProperty.text = [item objectForKey:@"description"];
        double valor = [[item objectForKey:@"valor"] doubleValue];
        self.valueProperty.text = [NSString stringWithFormat:@"%g", valor];
        
        self.pageControl.numberOfPages = self.dataList.count;
        
    }
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sortImageList:(NSMutableArray *)imageList withData:(NSMutableArray *)listData
{
    for(int i=0;i<listData.count;i++)
    {
        NSMutableDictionary *dataItem = [listData objectAtIndex:i];
        NSString *urlListData = [dataItem objectForKey:@"image"];

        for(int j=0;j<imageList.count;j++)
        {
            NSDictionary *imageDataContext = [imageList objectAtIndex:j];
            NSString *urlImageData = [imageDataContext objectForKey:@"url"];
            if([urlImageData isEqualToString:urlListData])
            {
                [self.listImage addObject:imageDataContext];
            }
        }
        
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)swipeRecogniser
{
    if ([swipeRecogniser direction] == UISwipeGestureRecognizerDirectionLeft)
    {
        
       
        self.pageControl.currentPage +=1;
        
    }
    else if ([swipeRecogniser direction] == UISwipeGestureRecognizerDirectionRight)
    {
       
        self.pageControl.currentPage -=1;
        
        
    }
    
    [UIView transitionWithView:self.view
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        NSDictionary *itemImage = [self.listImage objectAtIndex:self.pageControl.currentPage];
                        
                        UIImage *image = [[UIImage alloc] initWithData:[itemImage objectForKey:@"image"]];
                        
                        [self.imageProperty setImage:image];
                        NSDictionary *item = [self.dataList objectAtIndex:self.pageControl.currentPage];
                        self.titleProperty.text = [item objectForKey:@"title"];
                        self.descriptionProperty.text = [item objectForKey:@"description"];
                        double valor = [[item objectForKey:@"valor"] doubleValue];
                        self.valueProperty.text = [NSString stringWithFormat:@"%g", valor];
                    } completion:^(BOOL finished){
                        
                        
                        
                    }];
    
    
    
    
    
}


-(void)swapFirstIndex:(NSUInteger)firstIndex withSecondIndex:(NSUInteger)secondIndex inMutableArray:(NSMutableArray*)array{
    
    NSDictionary* valueAtFirstIndex = array[firstIndex];
    NSDictionary* valueAtSecondIndex = array[secondIndex];
    
    [array replaceObjectAtIndex:firstIndex withObject:valueAtSecondIndex];
    [array replaceObjectAtIndex:secondIndex withObject:valueAtFirstIndex];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
