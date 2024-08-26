import { List } from '@kit.ArkTS';

export default class VerifyDataResponse{
  public code: string = "9999";

  public msg: string = "";

  public bestImg?: string = "";

  public bestImgArray?: List<string>;

  public bestImgBase64Array?: List<string>;

  public appid?: string = "";

  public isCharge?: string = "";

  public logID?: string = "";

  public requestId: string = "";

  public resultCode: string = "";
}