//
//  Define.h
//  ArtExhibition
//
//  Created by qianfeng on 15/10/26.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#ifndef ArtExhibition_Define_h
#define ArtExhibition_Define_h


#define  kScreenSize [UIScreen mainScreen].bounds.size

//分类页面
#define kNewUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibits_new?pageIndex=%ld&sortType=1&token=df68e038-143e-41cb-b554-456f78f184fc"
#define kBeijingUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibits_new?pageIndex=%ld&sortType=100002&token=df68e038-143e-41cb-b554-456f78f184fc"
#define kShanghaiUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibits_new?pageIndex=%ld&sortType=100001&token=df68e038-143e-41cb-b554-456f78f184fc"
#define kHangzhouUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibits_new?pageIndex=%ld&sortType=100000&token=df68e038-143e-41cb-b554-456f78f184fc"
#define kHaiwaiUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibits_new?pageIndex=%ld&sortType=100004&token=df68e038-143e-41cb-b554-456f78f184fc"
#define kOtherUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibits_new?pageIndex=%ld&sortType=100005&token=df68e038-143e-41cb-b554-456f78f184fc"

//详情接口
#define kDetailUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/exhibit/%ld?token=df68e038-143e-41cb-b554-456f78f184fc"
//滚动视图接口
#define kScrollUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/topics?token=df68e038-143e-41cb-b554-456f78f184fc"
//滚动视图详情接口
#define kScrollDetailUrl @"http://120.26.62.107:8084/artgoer/api/v1/user/0/topic/%ld/exhibits?pageIndex=1&token=df68e038-143e-41cb-b554-456f78f184fc"


#endif
