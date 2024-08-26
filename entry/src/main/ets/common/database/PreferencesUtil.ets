import dataPreferences from '@ohos.data.preferences';
import { GlobalContext } from '../utils/GlobalContext';

const TAG = '[PreferencesUtil]';
const PREFERENCES_NAME = 'myPreferences';
const KEY_LDT_CONFIG = 'ldtConfig';

export class PreferencesUtil {
  createLdtConfigPreferences(context: Context) {
    let ldtConfigPreferences: Function = (() => {
      let preferences: Promise<dataPreferences.Preferences> = dataPreferences.getPreferences(context,
        PREFERENCES_NAME);
      return preferences;
    });
    GlobalContext.getContext().setObject('getLdtConfigPreferences', ldtConfigPreferences);
  }

  saveDefaultLdtConfig(ldtConfig: string){
    let getLdtConfigPreferences: Function = GlobalContext.getContext().getObject('getLdtConfigPreferences') as Function;
    getLdtConfigPreferences().then((preferences: dataPreferences.Preferences) => {
      preferences.has(KEY_LDT_CONFIG).then(async (isExist: boolean) => {
        console.info(TAG, 'preferences has changeFontSize is ' + isExist);
        if (!isExist) {
          await preferences.put(KEY_LDT_CONFIG, ldtConfig);
          preferences.flush();
        }
      }).catch((err: Error) => {
        console.error(TAG, 'Has the value failed with err: ' + err);
      });
    }).catch((err: Error) => {
      console.error(TAG, 'Get the preferences failed, err: ' + err);
    });
  }
  saveChangeLdtConfig(ldtConfig: string){
    let getLdtConfigPreferences: Function = GlobalContext.getContext().getObject('getLdtConfigPreferences') as Function;
    getLdtConfigPreferences().then(async (preferences: dataPreferences.Preferences) => {
      await preferences.put(KEY_LDT_CONFIG, ldtConfig);
      preferences.flush();
    }).catch((err: Error) => {
      console.error(TAG, 'put the preferences failed, err: ' + err);
    });
  }

  async getSavedLdtConfig(){
    let ldtConfig : string = "";
    let getLdtConfigPreferences: Function = GlobalContext.getContext().getObject('getLdtConfigPreferences') as Function;
    ldtConfig = await (await getLdtConfigPreferences()).get(KEY_LDT_CONFIG, ldtConfig);
    return ldtConfig;
  }

  async deleteChangeLdtConfig(){
    let getLdtConfigPreferences: Function = GlobalContext.getContext().getObject('getLdtConfigPreferences') as Function;
    const preferences: dataPreferences.Preferences = await getLdtConfigPreferences();
    let deleteValue = preferences.delete(KEY_LDT_CONFIG);
    deleteValue.then(() => {
      console.info(TAG, 'Succeeded in deleting the key appFontSize.');
    }).catch((err: Error) => {
      console.error(TAG, 'Failed to delete the key appFontSize. Cause: ' + err);
    });
  }
}

export default new PreferencesUtil();