import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
// import {GlobalContext} from '../../../../../fldtsdk/src/main/ets/utils/GLobalContext'
import { AbilityConstant, Want } from '@kit.AbilityKit';
import { GlobalContext } from '../common/utils/GlobalContext';
import CommonConstants from '../common/constants/CommonConstants';
import PreferencesUtil from "../common/database/PreferencesUtil"
import {authSettingInterface} from "../common/constants/InterFace"
import { BusinessError } from '@ohos.base';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    // GlobalContext.getContext().setValue('cameraContext',this.context)
    GlobalContext.getContext().setObject('abilityWant', want);
    PreferencesUtil.createLdtConfigPreferences(this.context);
    let authSetting: authSettingInterface = {
      "livingType": 2,
      "useStrictMode": 0,
      "needVideo": false
    }
    PreferencesUtil.saveDefaultLdtConfig(JSON.stringify(authSetting));
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
        hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
      // Main window is destroyed, release UI related resources
      hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
      // Ability has brought to foreground
      hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
      // Ability has back to background
      hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
