//
//  EditUserInfoViewController.m
//  JWChat
//
//  Created by jerry on 2017/4/19.
//  Copyright © 2017年 JerryWang. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "BaseTableViewCell.h"
#import "ProfileCellModel.h"
#import <TZPhotoPickerController.h>
#import <TZPhotoPreviewController.h>
#import <TZImagePickerController.h>
#import <QBAssetsViewController.h>
#import <QBImagePickerController.h>

@interface EditUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic,strong) NIMUser * user;

@end

@implementation EditUserInfoViewController

#pragma mark - getter

-(NSArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

#pragma mark - init

- (instancetype)initWithUser:(NIMUser *)user{

    if (self = [super initWithNibName:nil bundle:nil]) {
        _user = user;
        [self configData];
    }
    return self;
}

-(void)loadView {
    
    [super loadView];
    
    [self setupSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)configData{
    
    _dataSource = @[
                    @{
                        HeaderTitle : @"",
                        RowContent  : @[
                                @{
                                    ImageUrl : _user.userInfo.avatarUrl ? _user.userInfo.avatarUrl : @"",
                                    Title : _user.userInfo.nickName,
                                    SubTitle : _user.userId,
                                    
                                    },
                                ],
                        FooterTitle :@"",
                        
                        },
                    @{
                        HeaderTitle : @"",
                        RowContent : @[
                                        @{
                                    
                                            Title : @"昵称",
                                            SubTitle : _user.userInfo.nickName,
                                    
                                        },
                                        @{
                                            
                                            Title : @"性别",
                                            SubTitle : [self userGender:_user.userInfo.gender],
                                            
                                            },
                                        @{
                                            
                                            Title : @"生日",
                                            SubTitle : _user.userInfo.birth ? _user.userInfo.birth : @"",
                                            
                                            },
                                        @{
                                            
                                            Title : @"手机",
                                            SubTitle : _user.userInfo.mobile ? _user.userInfo.mobile : @"",
                                            
                                            },
                                        @{
                                            
                                            Title : @"邮箱",
                                            SubTitle : _user.userInfo.email ? _user.userInfo.email : @"",
                                            
                                            },
                                        @{
                                            
                                            Title : @"签名",
                                            SubTitle : _user.userInfo.sign ? _user.userInfo.sign : @"",
                                            
                                            },
                                        
                                ],
                        FooterTitle : @"",
                        
                        },
                    
                ];
    
}


- (void)setupSubviews{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = IMBgColor;
    [self.view addSubview:_tableView];
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * rowsArr = self.dataSource[section][RowContent];
    
    return rowsArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.dataSource[section][HeaderTitle];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    return self.dataSource[section][FooterTitle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoTableViewCell * userInfoCell = [UserInfoTableViewCell userInfoCellWithTableView:tableView];
    BaseTableViewCell * baseCell = [BaseTableViewCell baseCellWithTableView:tableView];
    
    NSArray * dataArr = self.dataSource[indexPath.section][RowContent];
    
    if (indexPath.section == 0) {
        
        ProfileCellModel * model = [ProfileCellModel cellModelWithDic:dataArr.firstObject];
        userInfoCell.model = model;
        return userInfoCell;
    }
    
    if (indexPath.section == 1) {
        baseCell.model = [ProfileCellModel cellModelWithDic:dataArr[indexPath.row]];
        return baseCell;
    }
    
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        // 修改用户头像
        [self changeAvatar];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // 修改昵称
        }
        if (indexPath.row == 1) {
            // 修改性别
        }
        if (indexPath.row == 2) {
            // 修改昵称
        }
        if (indexPath.row == 3) {
            // 修改性别
        }
        if (indexPath.row == 4) {
            // 修改昵称
        }
        if (indexPath.row == 5) {
            // 修改性别
        }
    }
    
}



#pragma mark - private 

- (NSString *)userGender:(NIMUserGender)gender{
    
    switch (gender) {
        case NIMUserGenderMale:
            return @"男";
            break;
        case NIMUserGenderFemale:
            return @"女";
            break;
        case NIMUserGenderUnknown:
            return @"未知";
            break;
        default:
            return @"未知";
            break;
    }
}

- (void)changeAvatar{

    TZImagePickerController * photoPicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    photoPicker.autoDismiss = NO;
    __weak typeof(self) weakSelf = self;
    __weak typeof(photoPicker) weakPicker = photoPicker;
    
    [photoPicker setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> * photos, NSArray * assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> * infos) {
        [weakPicker dismissViewControllerAnimated:NO completion:nil];
        
        TZImagePickerController * cropVc = [[TZImagePickerController alloc] initCropTypeWithAsset:assets.firstObject photo:photos.firstObject completion:^(UIImage *cropImage, id asset) {
            NSLog(@"裁剪完成");
            
            // 上传图片到服务器，成功后刷新表格
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [weakSelf presentViewController:cropVc animated:NO completion:nil];
    }];
    
    [photoPicker setImagePickerControllerDidCancelHandle:^{
        [weakPicker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self presentViewController:photoPicker animated:YES completion:nil];
    
}

- (void)refreshTableView{

    
}
@end