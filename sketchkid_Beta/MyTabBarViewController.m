//
//  MyTabBarViewController.m
//  tabbaTest
//
//  Created by Andrea Terzani on 07/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTabBarViewController.h"


#define TABBAR_HEIGHT 99
@interface MyTabBarViewController (){
 
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;

    UIImageView *imgView1;
    UIImageView *imgView2;
    UIImageView *imgView3;
}

-(void)hideExistingTabBar;
-(void)addCustomElement;
-(void)selectTab:(int)tabID;

@end

@implementation MyTabBarViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self hideExistingTabBar];
    [self addCustomElements];

    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    
    [am setSelectedAlbum:[am defaultAlbum]];
    
    [am.istanceOfHomeViewController reloadAlbumData];
    
    [self setSelectedIndex:1];

}

-(void)hideExistingTabBar{

    
    for (UIView * view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]]){
            view.hidden=YES;
            view.frame=CGRectMake(0,480,320,TABBAR_HEIGHT);
        }else {
            view.frame=CGRectMake(0,0,320,440);
        }
    
    }
}

-(void)addCustomElements
{


    //Aggiunge un immagine di sfondo
    CGRect imageRect = CGRectMake(0,480-TABBAR_HEIGHT,320,TABBAR_HEIGHT);
    UIImageView * backView = [[UIImageView alloc]initWithFrame:imageRect];
    UIImage * backImage =[UIImage imageNamed:@"toolBackHome.png"];
    [backView setImage:backImage];
    [self.view addSubview:backView];
    
    
    UIImage *btnImage = [UIImage imageNamed:@"kidsIcon.png"];
    UIImage *btnImageSelected = [UIImage imageNamed:@"kidsIcon.png"];

    imgView1=[[UIImageView alloc]initWithImage:btnImage];
    imgView1.frame=CGRectMake(15, 420, 80, 55);

    btn1 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    btn1.frame = CGRectMake(8, 415, 90, 70);
    [btn1 setTag:0]; 
    [btn1 setSelected:true]; 

    btnImage = [UIImage imageNamed:@"cameraIcon.png"];
    btnImageSelected = [UIImage imageNamed:@"cameraIcon.png"];
    
    imgView2=[[UIImageView alloc]initWithImage:btnImage];
    imgView2.frame=CGRectMake(133, 415, 57, 42);
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(115, 410, 90, 70);
    [btn2 setTag:1];
    
    btnImage = [UIImage imageNamed:@"albumIcon.png"];
    btnImageSelected = [UIImage imageNamed:@"albumIcon.png"];
    
    imgView3=[[UIImageView alloc]initWithImage:btnImage];
    imgView3.frame=CGRectMake(225, 422, 80 , 55);
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(220, 415, 90, 70);
    [btn3 setTag:2];

    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:imgView1];
    [self.view addSubview:imgView2];
    [self.view addSubview:imgView3];

    
    [btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];

    


}

- (void)selectTab:(int)tabID
{
   
    switch(tabID)
    {
        case 0:
            [btn1 setSelected:true];
            [btn2 setSelected:false];
            [btn3 setSelected:false];
            break;
        case 1:
            [btn1 setSelected:false];
            [btn2 setSelected:true];
            [btn3 setSelected:false];
            break;
        case 2:
            [btn1 setSelected:false];
            [btn2 setSelected:false];
            [btn3 setSelected:true];
            break;
        case 3:
            [btn1 setSelected:false];
            [btn2 setSelected:false];
            [btn3 setSelected:false];
            break;
    }
    
    self.selectedIndex = tabID;
    
    if (tabID==1) {

        [self performSegueWithIdentifier:@"takePicture" sender:self];
    }
    
        
}
- (void)buttonClicked:(id)sender
{
    int tagNum = [sender tag];
    [self selectTab:tagNum];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"takePicture"])
    {
        TakePictureViewController * takePictureView=(TakePictureViewController*) [segue destinationViewController];
        [takePictureView setDelegate:self];
    }
}


#pragma mark TakePictureViewControllerDelegate

-(void)TakePictureViewControllerDidCancel:(TakePictureViewController *)controller{

    [self dismissModalViewControllerAnimated:NO];
    
}


-(void)TakePictureViewControllerDidAddSomePhoto:(TakePictureViewController *)controller{
    
    [self dismissModalViewControllerAnimated:NO];
    
   
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    
    [am setSelectedAlbum:[am defaultAlbum]];
    
    [am.istanceOfHomeViewController reloadAlbumData];
    [am.istanceOfAlbumViewController reloadData];
    
    [self setSelectedIndex:1];
    


}







@end
