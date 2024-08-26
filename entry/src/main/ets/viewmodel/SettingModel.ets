import ldtSettingData from './LdtSettingData'

export class SettingModel {
  /**
   * Get data of the setting list.
   *
   * @return {Array<PageResource>} settingListData.
   */
  getLivingTypeListData(): Array<String> {
    let livingTypeListData: string[] = [
      "远近",
      "眨眼",
      "摇头",
      "点头",
      "张嘴",
      "炫彩",
    ]
    return livingTypeListData;
  }
}

export default new SettingModel();