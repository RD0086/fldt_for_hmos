import VerifyDataResponse from './VerifyDataResponse'
export default class HttpResponse{
  /**
   * 响应码
   */
  public code: number = 400;
  /**
   * 相应消息
   */
  public msg: string = "";
  /**
   * 相应数据
   */
  public data: string = "";
}