//
//  SettingsVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "SettingsVC.h"
#import "PersonalVC.h"
@interface SettingsVC ()
{
    GlobalDataManager * dataCenter;
}
@end

@implementation SettingsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tableView.delegate=self;
    dataCenter=[GlobalDataManager sharedDataManager];
    
    nameLabel.text=dataCenter.userRealName;
    acountID.text=dataCenter.userMobile;
    
    
    
    // Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            UIActionSheet * sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
            [sheet showInView:self.view];
            [sheet release];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    NSLog(@"indexpath:%d",indexPath.row);
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index:%d",buttonIndex);
     UIImagePickerController* picker=[[UIImagePickerController alloc] init];
     picker.delegate=self;
   
    if(buttonIndex==0)//拍照
    {
        picker.sourceType= UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls=YES;
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"presented");
        }];
    }
    else if(buttonIndex==1)//相册
    {
        picker.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"presented");
        }];
    }
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismissed");
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    headerImageView.image=image;
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismissed");
        //[self updateHeadImage:image];
    }];
}
-(void)updateHeadImage:(UIImage*)aImage
{
    //URL
    NSURL* url7_1=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_updateUserHeadPic]];
    //参数
    NSMutableDictionary* dict7_1=[[NSMutableDictionary alloc] init];
    [dict7_1 setObject:@"1" forKey:@"userId"];
    [dict7_1 setObject:@"" forKey:@"headPic"];//文件
    
    //请求
    [WBHTTPRequest sendRequestWithURL:url7_1 parameterDict:dict7_1 type:kWBHTTPRequestPOSTType  queue:[dataCenter globalTaskQueue] completeHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
