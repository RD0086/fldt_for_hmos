@Component
export struct MainIcon {

  build() {
      Column() {
        Image($r('app.media.auth_icon'))
          .objectFit(ImageFit.Cover)
          .width('65%')
          .height('auto')
          .margin({ top: $r("app.float.auth_icon_margin_top"), bottom: $r("app.float.auth_icon_margin_bottom") })
        Text('请根据屏幕指示完成识别')
          .fontSize($r("app.float.auth_prompt_text_size"))
          .fontColor($r('app.color.auth_prompt_text_color'))
        Row() {
          Column() {
            Image($r('app.media.zdpm_icon')).height($r('app.float.auth_prompt_icon_height'))
            Text("正对屏幕")
              .fontSize($r('app.float.auth_prompt_label_text_size'))
              .fontColor($r('app.color.auth_prompt_label_text_color'))
          }

          Column() {
            Image($r('app.media.gxcz_icon')).height($r('app.float.auth_prompt_icon_height'))
            Text("光线充足")
              .fontSize($r('app.float.auth_prompt_label_text_size'))
              .fontColor($r('app.color.auth_prompt_label_text_color'))
          }

          Column() {
            Image($r('app.media.lwzd_icon')).height($r('app.float.auth_prompt_icon_height'))
            Text("脸无遮挡")
              .fontSize($r('app.float.auth_prompt_label_text_size'))
              .fontColor($r('app.color.auth_prompt_label_text_color'))
          }
        }
        .width('65%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: $r('app.float.auth_prompt_margin_bottom') })
      }
  }
}