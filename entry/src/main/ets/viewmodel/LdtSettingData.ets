export default class LdtSettingData {
  livingType: String = "6";

  keepTime: String = "200";

  takePhotoNumber: String = "1";

  isUseStrictMode: String = "false";

  needVideo: String = "false";

  constructor(livingType: String, keepTime: String, takePhotoNumber: String, isUseStrictMode: String, needVideo: String) {
    this.livingType = livingType;
    this.keepTime = keepTime;
    this.takePhotoNumber = takePhotoNumber;
    this.isUseStrictMode = isUseStrictMode;
    this.needVideo = needVideo;
  }
}