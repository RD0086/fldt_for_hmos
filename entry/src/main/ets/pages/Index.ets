import hilog from '@ohos.hilog';
import { EsLDTInitConfig, EsLivingDetectionManager, MyLog } from '@esand/esldtSDK'
import '@esand/esldtSDK'
import router from '@ohos.router';
import CameraPermissionDialog from '../components/CameraPermissionDialog'
import { MainIcon } from "../components/MainIcon"
import { LdtHttpRequest } from "../common/utils/LdtHttpRequest"
import TokenResponse from "../common/constants/TokenResponse";
import PreferencesUtil from '../common/database/PreferencesUtil';
import CommonConstants from '../common/constants/CommonConstants';
import { BusinessError } from '@ohos.base';
import { configInterface } from "../common/constants/InterFace";
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State @Watch("handleAuth") ldtStatus: Boolean = false;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CameraPermissionDialog({
      // onClickOk: (value: string): void => this.saveTask(value)
    }),
    alignment: DialogAlignment.Bottom,
    offset: {
      dx: 0,
      dy: '-16vp'
    },
    customStyle: true,
    autoCancel: false
  });
  onPageShow(): void {
    this.ldtStatus = false
    router.clear();
  }
  handleAuth(){
    if(this.ldtStatus){
    }
  }
  build() {
    Column(){
        Column() {
          Column() {
            MainIcon()
            Button("开始活体检测").onClick((event) => {
              let esLivingDetectionManager = new EsLivingDetectionManager();
              //查询已保存的设置
              PreferencesUtil.getSavedLdtConfig().then((value) => {
                let esLDTInitConfig = new EsLDTInitConfig();
                let authSettingConfig:configInterface = JSON.parse(value);
                //设置returnUrl
                authSettingConfig.returnUrl = "pages/Result";
                esLDTInitConfig.initConfig(JSON.stringify(authSettingConfig));
                //0:后置摄像头，1:前置摄像头
                esLDTInitConfig.cameraDeviceId = 1;
                //活体检测初始化
                esLivingDetectionManager.verifyInit(esLDTInitConfig).then(initRes => {
                  if(initRes.code == "ELD_SUCCESS"){
                    let initMsg = initRes.data;
                    //从服务端获取token
                    LdtHttpRequest.ldtHttpRequest().getToken(initMsg).then(getTokenRes => {
                      if(getTokenRes.data){
                        let getTokenData:TokenResponse = JSON.parse(getTokenRes.data);
                        let token = getTokenData.token;
                        if(token){
                          //开始活体检测
                          esLivingDetectionManager.startLivingDetect(token).then(res => {
                            console.info("活体检测结果：", res.code)
                          });
                          //显示刷脸页面
                          this.ldtStatus = true;
                        }
                      }else{
                        promptAction.showToast({
                          message: "获取token失败:" + getTokenRes.code,
                          duration: 3000,
                          bottom: 300
                        });
                      }
                    })
                  }else{
                    promptAction.showToast({
                      message: "认证初始化失败:" + initRes.msg,
                      duration: 3000,
                      bottom: 300
                    });
                    MyLog.error("认证初始化失败 code:" + initRes.code + " msg:" + initRes.msg)
                  }
                }).catch((err:BusinessError) => {
                  MyLog.error("认证初始化异常 code:" + err.code + " msg:" + err.message)
                })
              })
            })
              .backgroundColor($r('app.color.button_background'))
              .width('65%')
          }
          Button('设置',{stateEffect: false}).onClick(() => {
            router.pushUrl({
              url : 'pages/Setting'
            })
          })
            .backgroundColor($r('app.color.setting_button_background'))
            .fontColor($r('app.color.setting_button_font_color'))

        }.width('100%').height('96%').justifyContent(FlexAlign.SpaceBetween).backgroundColor($r('app.color.index_page_background'))
    }.width(CommonConstants.SET_PAGE_WIDTH).height(CommonConstants.SET_PAGE_HEIGHT)

  }
}