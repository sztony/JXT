//
//  URL.h
//  WBHTTPRequest
//
//  Created by 伍 兵 on 14-7-31.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//
//#define HOST_URL @"http://223.71.208.118:8180/jxt/"
#define HOST_URL @"http://192.168.20.216:8180/jxt/" //内网

//接口1
//登录接口
#define URL_Login @"api/user/login"
//获取验证码
#define URL_GetVertifyCode @"api/user/getVerifyCode"
//获取地区列表
#define URL_GetAreaList   @"api/common/getAreaList"
//找回密码
#define URL_FindPwd  @"api/user/findPwd"
//获取学校列表
#define URL_GetSchoolList   @"api/common/getSchoolList"
//获取学段列表
#define URL_GetPhaseList   @"api/common/getPhaseList"
//获取年级列表
#define URL_GetGradeList   @"api/common/getGradeList"
//获取分享用户协议接口
#define URL_Agreement      @"api/common/getAgreement"
//相关推荐接口
#define URL_Recommed    @"api/common/getRecommendation"
//注册完成接口
#define URL_Register    @"api/user/register"

//接口2

//学校课堂
//今日课堂导航接口 2.1.1
#define URL_School_SubjectList @"api/common/getSubjectList"
//今日课堂列表信息接口2.1.2
#define URL_CourseByDate    @"api/course/getUserCourseByDate"
//今日作业详细接口  2.1.3
#define URL_HomeWorkByDate   @"api/course/getUserHomeWorkByDate"
//我的课表接口 2.1.4
#define URL_Schedule  @"api/course/getUserSchedule"
//我的课程信息列表接口 2.2.1
#define URL_MyCourseList @"api/course/getUserCourseList"
//删除课程接口2.2.2
#define URL_DelUserCourse  @"api/course/delUserCourse"
//视频播放页接口2.2.3  课程播放详细页，获取课程介绍和学生评论
#define URL_UserPlayInfo   @"api/course/getUserPlayInfo"

//接口5
//5.1获取用户的消息列表
#define URL_GetUserMessageList @"api/user/getUserMessageList"
//5.2获取指定好友的消息详细页
#define URL_getUserMessageInfo @"api/user/getUserMessageInfo"
//5.3删除用户自己的消息
#define URL_delUserMessage @"api/user/delUserMessage"
//5.4获取用户好友联系人列表
#define URL_getUserFriendList @"api/user/getUserFriendList"
//5.5发送消息给用户
#define URL_sendMessage @"api/user/sendMessage"

//接口6
//6.1 根据搜索词对课程进行搜索
#define URL_searchCourse @"api/common/searchCourse"
//6.2 根据搜索词对教师进行搜索
#define URL_searchTeacher @"api/common/searchTeacher"

//接口7 （个人设置)
//7.1 返回用户信息（登录时返回)
//7.2 修改个人密码
#define URL_updateUserPwd @"api/user/updateUserPwd"
//7.3上传用户头像
#define URL_updateUserHeadPic @"api/user/updateUserHeadPic"
//7.4修改用户昵称
#define URL_updateUserNickName @"api/user/updateUserNickName"
//7.5.1获取用户所有的班级列表
#define URL_getUserClassList @"api/class/getUserClassList"
//7.5.2获取用户所在班级的公告信息列表
#define URL_getUserClassNotice @"api/class/getUserClassNotice"
//7.5.3获取用户所在班级的成员信息列表，包括老师和同学列表
#define URL_getUserClassMemberList @"api/class/getUserClassMemberList"
//7.5.4班级成员教师详细介绍接口
#define URL_getClassTeacherInfo @"api/class/getClassTeacherInfo"
//7.5.5获取班级成员中同学的详细介绍
#define URL_getStudentInfo @"api/class/getStudentInfo"

//接口8 (关注)
//8.1获取关注的学科和关注的教师列表
#define URL_getUserFollowInfo @"api/user/getUserFollowInfo"
//8.2取消用户对学科的关注
#define URL_delUserFollowSubject @"api/user/delUserFollowSubject"
//8.3取消用户对某个教师的关注
#define URL_delUserFollowTeacher @"api/user/delUserFollowTeacher"
//8.4根据学段和学校来查询教师的列表，排除已经关注的老师
#define URL_searchFollowTeacher @"api/user/searchFollowTeacher"
//8.5用户添加对学科的关注
#define URL_addUserFollowSubject @"api/user/addUserFollowSubject"
//8.6用户添加对某个老师的关注
#define URL_addUserFollowTeacher @"api/user/addUserFollowTeacher"


//接口9 (交易)
//9.1根据时间查询交易记录
#define URL_getUserOrderList @"api/user/getUserOrderList"
//9.2续费（待定)  对过期的课程进行续费 ,再次购买
#define URL_rePayProduct @"api/user/rePayProduct"

//接口10（设置)
//10.1设置客户端是否接受推送
#define URL_updateUserPushStatus @"api/user/updateUserPushStatus"

//接口11 （关于我们)
//11.1帮助与反馈（静态文件)
//11.2检查更新
#define URL_getVesion @"api/common/getVesion"

//接口12 （购物车)
//12.1将商品添加到购物车
#define URL_addProductToCart @"api/user/addProductToCart"
//12.2将商品从购物车删除
#define URL_delProductToCart @"api/user/delProductToCart"
//12.3清空购物车
#define URL_delUserAllCart @"api/user/delUserAllCart"
//12.4获取购物车列表
#define URL_getUserShooppingCart @"api/user/getUserShooppingCart"

//12.5通过购物车去支付时需要生成订单
#define URL_addUserOrder @"api/user/addUserOrder"






