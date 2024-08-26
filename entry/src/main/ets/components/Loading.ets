import { StartOptions } from '@kit.AbilityKit'

@Component
export struct Loading {
  @State offsetY: string = "-10vp";
  aboutToAppear(){
    setTimeout(() => {
      this.offsetY = "5vp"
    },200)

  }
  build() {
    Column() {
      Row(){
        Text("正在查询认证结果").fontSize('24fp').fontColor('#40afee')
      }
      Row(){
        Row().width("24vp").height('24vp').borderRadius('15vp').backgroundColor('#40afee')
          .offset({y : this.offsetY, x: 0})
          .animation({
              duration: 1600,
              tempo: 3.0,
              delay: 0,
              curve: Curve.EaseInOut,
              playMode: PlayMode.Alternate,
              iterations: -1
           })
        Row().width("24vp").height('24vp').borderRadius('15vp').backgroundColor('#40afee').margin({left: '20vp'})
          .offset({y : this.offsetY, x: 0})
          .animation({
            duration: 1600,
            tempo: 3.0,
            delay: -500,
            curve: Curve.EaseInOut,
            playMode: PlayMode.Alternate,
            iterations: -1
          })
        Row().width("24vp").height('24vp').borderRadius('15vp').backgroundColor('#40afee').margin({left: '20vp'})
          .offset({y : this.offsetY, x: 0})
          .animation({
            duration: 1600,
            tempo: 3.0,
            delay: -1000,
            curve: Curve.EaseInOut,
            playMode: PlayMode.Alternate,
            iterations: -1
          })
        Row().width("24vp").height('24vp').borderRadius('15vp').backgroundColor('#40afee').margin({left: '20vp'})
          .offset({y : this.offsetY, x: 0})
          .animation({
            duration: 1600,
            tempo: 3.0,
            delay: -1500,
            curve: Curve.EaseInOut,
            playMode: PlayMode.Alternate,
            iterations: -1
          })
      }.margin({bottom: '100vp', top: '30vp'})
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }
}