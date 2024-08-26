import { EsLivingDetectionManager } from '@esand/esldtSDK/Index';
import CommonConstants from '../common/constants/CommonConstants';

@CustomDialog
export default struct CameraPermissionDialog {
  @State subtaskName: string = '';
  private controller?: CustomDialogController;
  onClickOk?: (value: string) => void;

  build() {
    Column() {
      Text("相机权限获取失败")
        .width('100%')
        .fontSize(CommonConstants.SET_SIZE_EXTRA_LARGE)
        .fontWeight(CommonConstants.SET_FONT_WEIGHT_LARGE)
        .fontColor("#182431")
        .textAlign(TextAlign.Start)
      Text("手动设置权限: 设置 -> 应用与元服务 -> demo -> 相机 -> 允许")
        .fontSize(CommonConstants.SET_SIZE_NORMAL)
        .lineHeight($r('app.float.dialog_text_height'))
        .padding({top: '10vp'})
      Blank()
      Row() {
        Button('取消')
          .dialogButtonStyle()
          .onClick(() => {
            this.controller?.close();
          })
        Divider()
          .vertical(true)
        // Button('去设置')
        //   .dialogButtonStyle()
        //   .onClick(() => {
        //     let esLivingDetectionManager = new EsLivingDetectionManager();
        //     esLivingDetectionManager.openPermissionsInSystemSettings();
        //     if (this.onClickOk !== undefined) {
        //       this.onClickOk(this.subtaskName);
        //     }
        //   })
      }
      .width('70%')
      .height('10%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding('24vp')
    .height($r('app.float.dialog_content_height'))
    .width('90.3%')
    .borderRadius($r('app.float.dialog_content_border_radius'))
    .backgroundColor(Color.White)
  }
}

/**
 * Custom button style.
 */
@Extend(Button) function dialogButtonStyle() {
  .fontSize(CommonConstants.SET_SIZE_NORMAL)
  .height($r('app.float.dialog_btn_height'))
  .width($r('app.float.dialog_btn_width'))
  .backgroundColor(Color.White)
  .fontColor("#007DFF")
}