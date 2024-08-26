import hilog from '@ohos.hilog';
import { EsLDTInitConfig } from '@esand/esldtSDK'
import '@esand/esldtSDK'
import settingModel from '../viewmodel/SettingModel'
import router from '@ohos.router';
import LdtSettingData from '../viewmodel/LdtSettingData'
import PreferencesUtil from '../common/database/PreferencesUtil';
import {authSettingInterface} from "../common/constants/InterFace";
import CommonConstants from '../common/constants/CommonConstants';
@Entry
@Component
struct Setting {
  @State livingType: string = "2";
  @State useStrictMode: number = 0;
  @State needVideo: boolean = false;
  @State toggleList: Array<boolean> = [];
  onPageShow() {
    //查询已保存的设置
    PreferencesUtil.getSavedLdtConfig().then((value) => {
      let config:authSettingInterface = JSON.parse(value);
      console.info("config livingType",config.livingType.toString())
      this.livingType = config.livingType.toString();
      this.useStrictMode = config.useStrictMode;
      this.needVideo = config.needVideo;
    })
  }

  build() {
    Column() {
      Row(){
        Text("活体检测方式")
          .fontSize($r('app.float.setting_title_font_size'))
          .fontColor($r('app.color.setting_title_font_color'))
          .fontWeight(CommonConstants.SET_FONT_WEIGHT_NORMAL)
      }.width('100%').height($r('app.float.setting_title_height'))
      List() {
        ForEach(settingModel.getLivingTypeListData(), (item: String, index) => {
          ListItem() {
            Column(){
              if(index != 0){
                Row(){
                }.width('100%').height('1vp').backgroundColor($r('app.color.setting_line_background_color'))
              }
              Row() {
                Text(`${item}`).fontSize($r('app.float.setting_label_font_size'))
                Toggle({ type: ToggleType.Switch, isOn: this.livingType.indexOf((index + 1).toString()) >= 0 ? true : false })
                  .enabled((this.livingType.length >= 4 && this.livingType.indexOf((index + 1).toString()) < 0) || (this.livingType.length <= 1 && this.livingType.indexOf((index + 1).toString()) >= 0) ? false : true)
                  .onChange((isOn: boolean) => {
                  let value = (index + 1).toString()
                  if (isOn) {
                    if(this.livingType.length < 4 && this.livingType.indexOf(value) < 0){
                      //增加活体检测类型
                      this.livingType  = this.livingType + value;
                    }
                  }else{
                    if(this.livingType.length > 1){
                      //减少活体检测类型
                      let livingTypeList = this.livingType.split('')
                      let changeLivingType = "";
                      for(let i = 0; i < livingTypeList.length; i++){
                        if(livingTypeList[i] != value){
                          changeLivingType += livingTypeList[i];
                        }
                      }
                      this.livingType = changeLivingType;
                    }
                  }
                }).selectedColor($r('app.color.button_background')).hoverEffect(HoverEffect.None)
              }
              .height($r('app.float.setting_item_content_height'))
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }.width('100%')
          }
        }, (item:String) => JSON.stringify(item))
      }
      .width('100%')
      .backgroundColor($r('app.color.setting_item_content_background_color'))
      .borderRadius($r('app.float.setting_item_content_border_radius'))
      .padding({left: '5%', right: '5%'})
      Row(){
        Text("是否开启严格模式")
          .fontSize($r('app.float.setting_title_font_size'))
          .fontColor($r('app.color.setting_title_font_color'))
          .fontWeight(CommonConstants.SET_FONT_WEIGHT_NORMAL)
      }.width('100%').height($r('app.float.setting_title_height'))
      Row(){
        Text('严格模式').fontSize($r('app.float.setting_label_font_size'))
        Toggle({ type: ToggleType.Switch, isOn: this.useStrictMode == 0 ? false : true }).onChange((isOn: boolean) => {
          if(isOn){
            this.useStrictMode = 1;
          }else{
            this.useStrictMode = 0;
          }
        }).selectedColor($r('app.color.button_background')).hoverEffect(HoverEffect.None)
      }
      .width('100%').height($r('app.float.setting_item_content_height'))
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor($r('app.color.setting_item_content_background_color'))
      .borderRadius($r('app.float.setting_item_content_border_radius'))
      .padding({left: '5%', right: '5%'})
      Row(){
        Text("是否需要录制视频")
          .fontSize($r('app.float.setting_title_font_size'))
          .fontColor($r('app.color.setting_title_font_color'))
          .fontWeight(CommonConstants.SET_FONT_WEIGHT_NORMAL)
      }.width('100%').height($r('app.float.setting_title_height'))
      List() {
        ListItem() {
          Row(){
            Text("录制视频").fontSize($r('app.float.setting_label_font_size'))
            Toggle({ type: ToggleType.Switch, isOn: this.needVideo }).onChange((isOn: boolean) => {
              this.needVideo = isOn;
            }).selectedColor($r('app.color.button_background')).hoverEffect(HoverEffect.None)
          }.width('100%').justifyContent(FlexAlign.SpaceBetween)
        }.width('100%').height($r('app.float.setting_item_content_height'))
        // ListItem() {
        //   Row(){
        //     Text('返回照片数量')
        //     Row(){
        //       TextInput().textAlign(TextAlign.End).backgroundColor('#ffffff').width('50vp')
        //       Image($r('app.media.right_icon')).width('16vp').height('16vp')
        //     }.justifyContent(FlexAlign.End)
        //   }.width('100%').justifyContent(FlexAlign.SpaceBetween)
        // }.width('100%').height('50vp')

      }
      .width('100%')
      .backgroundColor($r('app.color.setting_item_content_background_color'))
      .padding({left: '5%', right: '5%'})
      .borderRadius($r('app.float.setting_item_content_border_radius'))
      Button("完成").onClick(() => {
        let changeSetting:authSettingInterface = {
          "livingType": parseInt(this.livingType),
          "useStrictMode": this.useStrictMode,
          "needVideo": this.needVideo
        }
        console.info("config livingType change: ", parseInt(this.livingType))
        //保存设置
        PreferencesUtil.saveChangeLdtConfig(JSON.stringify(changeSetting))
        router.back()
      })
        .width(CommonConstants.SET_BUTTON_HEIGHT_NORMAL)
        .height($r('app.float.auth_btn_height'))
        .backgroundColor($r('app.color.button_background'))
        .margin({top: '100vp'})
    }
    .width(CommonConstants.SET_PAGE_WIDTH)
    .height(CommonConstants.SET_PAGE_HEIGHT)
    .backgroundColor($r('app.color.setting_page_background'))
    .padding({left: "5%",right: "5%",top: '10vp'})
  }
}