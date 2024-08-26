import http from '@ohos.net.http';
import {BusinessError} from '@ohos.base';
import HttpResponse from '../constants/HttpResponse'
import { MyLog } from '@esand/esldtSDK'
export class LdtHttpRequest {

  /**
   * 替换为你自己的阿里云 APPCODE, APPCODE 获取方式可参考 ： https://esandinfo.yuque.com/yv6e1k/ulp2ub/fs2mm48opwox3xc4
   */
  MY_APPCODE: string = 'TODO 替换为你自己的APPCODE'

  private constructor() { }

  public static ldtHttpRequest(): LdtHttpRequest {
     let ldtHttpRequest  = new LdtHttpRequest();
    return ldtHttpRequest;
  }

  /**
   * 获取认证TOKEN （为了保护密钥，次逻辑建议写在服务器端）, 可参考：https://esandinfo.yuque.com/yv6e1k/aa4qsg/chz53t
   * @param initMsg
   * @returns
   */
  async getToken(initMsg:string) : Promise<HttpResponse>{
    let getTokenResult = new HttpResponse();
    const httpRequest = http.createHttp();
    MyLog.info("request token: 请求服务端获取token");
    let url = "https://eface.market.alicloudapi.com/init";
    let formData = "initMsg=" + initMsg
    await httpRequest.request(
      // 请求url地址
      url,
      {
        // 请求方式
        method: http.RequestMethod.POST,
        // 请求的额外数据。
        extraData: formData,
        // 可选，默认为60s
        connectTimeout: 60000,
        // 可选，默认为60s
        readTimeout: 60000,
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/x-www-form-urlencoded;chart-set:utf-8',
          "Authorization": "APPCODE " + this.MY_APPCODE,
          "X-Ca-Nonce": Math.round(Math.random() * 100000000).toString()
        }
      })
      .then((data) => {
        MyLog.info("request token:" + JSON.stringify(data))
        getTokenResult.code = data.responseCode
        if (data.responseCode === http.ResponseCode.OK) {
          // 处理响应结果
          // data.result为服务器返回的业务数据
          MyLog.info('request token Result:' + JSON.stringify(data.result));
          if(typeof(data.result) == "string"){
            getTokenResult.data = data.result
          }else{
            getTokenResult.data = JSON.stringify(data.result);
          }
        }
      }).catch((err: BusinessError) => {
        MyLog.error('request token error:' + JSON.stringify(err));
    });

    httpRequest.destroy();
    return getTokenResult;
  }

  /**
   * 查询认证结果（为了保护密钥，次逻辑建议写在服务器端）, 可参考：https://esandinfo.yuque.com/yv6e1k/aa4qsg/rp6dws
   * @param token
   * @param verifyMsg
   * @returns
   */
  async verify(token:string, verifyMsg:string) : Promise<HttpResponse>{
    let verifyResult = new HttpResponse();
    const httpRequest = http.createHttp();
    MyLog.info("request verify: 传给服务器进行服务器端认证");
    let url = "https://eface.market.alicloudapi.com/verify";
    let formData = "token=" + token + "&verifyMsg=" + verifyMsg
    await httpRequest.request(
      // 请求url地址
      url,
      {
        // 请求方式
        method: http.RequestMethod.POST,
        // 请求的额外数据。
        extraData: formData,
        // 可选，默认为60s
        connectTimeout: 60000,
        // 可选，默认为60s
        readTimeout: 60000,
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/x-www-form-urlencoded;chart-set:utf-8',
          "Authorization": "APPCODE " + this.MY_APPCODE,
          "X-Ca-Nonce": Math.round(Math.random() * 100000000).toString()
        }
      })
      .then((data) => {
        MyLog.info("request verify:" + JSON.stringify(data))
        verifyResult.code = data.responseCode
        if (data.responseCode === http.ResponseCode.OK) {
          // 处理响应结果
          // data.result为服务器返回的业务数据
          MyLog.info('request verify Result:' + JSON.stringify(data.result));
          if(typeof(data.result) == "string"){
            verifyResult.data = data.result
          }else{
            verifyResult.data = JSON.stringify(data.result);
          }
        }
      }).catch((err: BusinessError) => {
        MyLog.error('request verify error:' + JSON.stringify(err));
      });

    httpRequest.destroy();
    return verifyResult;
  }
}