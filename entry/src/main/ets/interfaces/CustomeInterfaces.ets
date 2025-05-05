export interface LoginUIConfig {
  loginType: number,
  hint1?: string,
  hint2?: string,
  hint3?: string,
  textLeft?: string,
  textRight?: string
}

export interface InputWithClearParams {
  index: number
  hint?: string
  marginTop: number | Resource
  isShowBoarder: boolean
  inputType: InputType
}

export interface LoginPostBody {
  account?: string
  appid?: string
  code?: string
  pictureAnswer?: string
  pictureKeyID?: string
  pwd?: string
  sign?: string
  source?: string
  type?: number
  version?: number
  bindingPhone?: string
  userPhone?: string
  outAccount?: string
}