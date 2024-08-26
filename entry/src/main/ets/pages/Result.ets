import CommonConstants from '../common/constants/CommonConstants';
import router from '@ohos.router';
import { LdtHttpRequest } from "../common/utils/LdtHttpRequest";
import VerifyDataResponse from "../common/constants/VerifyDataResponse";
import { Loading } from "../components/Loading"

@Entry
@Component
struct Index {
  @State verifyRes: object = router.getParams();
  @State authResultStatus: Boolean = false;
  @State authResultTitle: string = "";
  @State verifyMsg: string = this.verifyRes['verifyMsg'];
  @State code: string = this.verifyRes['code'];
  @State token: string = this.verifyRes['token'];
  @State msg: string = "";
  @State requestId: string = "";
  @State resultCode: string = "";
  @State getResStatus: Boolean = false;
  aboutToAppear(){
    LdtHttpRequest.ldtHttpRequest().verify(this.token, this.verifyMsg).then((res) => {
      console.info("verifyRes: ", JSON.stringify(res))
      let resultData:VerifyDataResponse = JSON.parse(res.data);
      this.code = resultData.code;
      this.msg = resultData.msg;
      this.requestId = resultData.requestId;
      this.resultCode = resultData.resultCode;
      this.authResultTitle = resultData.resultCode == "LDT_LIVING_SUCCESS" ? '活体检测成功' : '活体检测失败';
      this.authResultStatus = resultData.resultCode == "LDT_LIVING_SUCCESS" ? true : false;
      this.getResStatus = true
    }).catch(() => {
      this.getResStatus = true
    })
  }
  build() {
    Column(){
      if(this.getResStatus){
        Text(this.authResultTitle).fontSize('24fp')
        Image(this.authResultStatus ? $r('app.media.verify_success') : $r('app.media.verify_failed'))
          .width('50%')
          .padding({top: '30vp', bottom: '50vp'})
        Column(){
          Row(){
            Text('code').fontSize('18fp').fontColor('#888888').lineHeight('40vp').width('35%')
            Text(this.code).lineHeight('40vp').textAlign(TextAlign.End).width('65%').lineHeight('40vp')
          }.width('100%').height('40vp').justifyContent(FlexAlign.SpaceBetween)
          if(this.msg){
            Row(){
              Text('msg').fontSize('18fp').fontColor('#888888').lineHeight('40vp').width('35%')
              Text(this.msg).lineHeight('40vp').textAlign(TextAlign.End).width('65%').lineHeight('40vp')
            }.width('100%').height('40vp').justifyContent(FlexAlign.SpaceBetween)
          }
          Row(){
            Text('resultCode').fontSize('18fp').fontColor('#888888').lineHeight('40vp').width('35%')
            Text(this.resultCode).lineHeight('40vp').textAlign(TextAlign.End).width('65%').lineHeight('40vp')
          }.width('100%').height('40vp').justifyContent(FlexAlign.SpaceBetween)
          Row(){
            Text('requestId').fontSize('18fp').fontColor('#888888').lineHeight('40vp')
            Text(this.requestId).lineHeight('40vp').textAlign(TextAlign.End).width('65%').lineHeight('40vp')
          }.width('100%').height('40vp').justifyContent(FlexAlign.SpaceBetween)
        }.width('90%').padding({bottom: '50vp'})
        Button('返回').backgroundColor($r('app.color.button_background'))
          .width('90%').onClick(() => {
            router.pushUrl({
              url : 'pages/Index'
            })
        })
      }else{
        Loading()
      }
    }
    .width(CommonConstants.SET_PAGE_WIDTH)
    .height(CommonConstants.SET_PAGE_HEIGHT)
    .backgroundColor($r('app.color.result_page_background_color'))
    .padding({top: '50vp', left: '5%', right: '5%'})
  }
}