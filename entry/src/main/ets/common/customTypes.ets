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

export interface TitleBarOptions {
  title?: string
  isShowBack?: boolean
  onBackClick?: (event: ClickEvent) => void
}

export interface ForgetPwdRequestBody {
  answer: string
  answerKeyID: string
  phoneNumber: string
  smsCode?: string
  password?: string
}