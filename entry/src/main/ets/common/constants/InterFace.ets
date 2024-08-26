export interface authSettingInterface {
  "livingType": number,
  "needVideo": boolean,
  "useStrictMode": number,
}

export interface configInterface extends authSettingInterface {
  "returnUrl"?: string;
  "cameraDeviceId"?: number;
}

