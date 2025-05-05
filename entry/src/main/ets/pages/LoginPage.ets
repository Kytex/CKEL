import { InputWithClearParams, LoginPostBody, LoginUIConfig } from '../interfaces/CustomeInterfaces'
import { promptAction, router } from '@kit.ArkUI'
import { requestLogin } from '../requests/ApiService'
import CryptoJS from '@ohos/crypto-js';
import { PrefUtils } from '../utils/PrefUtils';
import { AppConst } from '../utils/AppConst';
import { util } from '@kit.ArkTS';
import { UrlConstants } from '../constants/UrlConstants';

const LOGIN_TYPE_PWD = 1000; //登录类型：账号密码登录
const LOGIN_TYPE_SMS = 1001; //登录类型：短信验证码登录
const LOGIN_TYPE_JOB = 1004; //登录类型：工号登录
const LOGIN_TYPE_OTHER = 1005; //登录类型：其他登录方式

@Entry
@Component
struct Login {
  @State loginType: number = LOGIN_TYPE_PWD //0：手机号，1其他登录，2：工号登录 3：图形验证码登录
  @State inputPhone: string = ""
  @State inputImageCode: string = ""
  @State inputPwd: string = ""
  @State inputSmsCode: string = ""
  @State isPrivacyChecked: boolean = false
  @State imageCodeUrl: string | Resource = ""
  loginResponseBusCode: number = 0
  verifyCode: string = ""
  bindPhone: string = ""

  getLoginUiConfig(): LoginUIConfig {
    let loginConfig: LoginUIConfig = { loginType: this.loginType }
    switch (this.loginType) {
      case LOGIN_TYPE_PWD:
        loginConfig.textRight = "其他登录方式"
        break
      case LOGIN_TYPE_SMS:
        loginConfig.textLeft = "工号登录"
        loginConfig.textRight = "账号密码登录"
        break
      case LOGIN_TYPE_JOB:
        loginConfig.textLeft = "手机验证码登录"
        loginConfig.textRight = "账号密码登录"
        break
      case LOGIN_TYPE_OTHER:
        loginConfig.textLeft = "工号登录"
        loginConfig.textRight = "账号密码登录"
        break
    }
    return loginConfig;
  }

  build() {
    Column() {
      Text("差客e旅登录").fontSize($r("app.float.fp_25"))
      if (this.loginType == LOGIN_TYPE_PWD) {
        this.buildPwd()
      } else if (this.loginType == LOGIN_TYPE_OTHER) {
        this.buildOther()
      } else if (this.loginType == LOGIN_TYPE_JOB) {
        this.buildJob()
      } else if (this.loginType == LOGIN_TYPE_SMS) {
        this.buildPhoneSms()
      }
      Button("登录", { type: ButtonType.Normal })
        .margin({ top: $r("app.float.fp_40") })
        .width("100%")
        .borderRadius($r("app.float.fp_5"))
        .enabled((this.loginType == LOGIN_TYPE_PWD || this.loginType == LOGIN_TYPE_JOB) &&
          (this.inputPhone != "" && this.inputPwd != "") ||
          (this.loginType == LOGIN_TYPE_OTHER && this.inputImageCode != "" && this.inputPhone != "" &&
            this.inputPwd != ""))
        .onClick(() => {
          if (this.isPrivacyChecked) {
            this.handleLogin()
          } else {
            promptAction.showToast({ message: "请仔细阅读并同意隐私政策" })
          }
        })

      Row() {
        Checkbox().shape(CheckBoxShape.ROUNDED_SQUARE).onChange((value) => {
          this.isPrivacyChecked = value
        })
        Text() {
          Span("已仔细阅读并同意我们的").fontColor("#666666").fontSize($r("app.float.fp_13"))
          Span("<<隐私政策>>").fontColor(Color.Blue).fontSize($r("app.float.fp_13")).onClick((event) => {

          })
        }
      }
      .margin({ top: $r("app.float.fp_20") })

      Row() {
        Text(this.getLoginUiConfig().textLeft)
          .fontColor("#1b86f7")
          .fontSize($r("app.float.fp_14"))
          .visibility((this.loginType != 0) ? Visibility.Visible : Visibility.Hidden)
          .onClick(() => {
            if (this.loginType == LOGIN_TYPE_JOB) {
              this.loginType = LOGIN_TYPE_SMS
            } else {
              this.loginType = LOGIN_TYPE_JOB
            }
          })
        Text(this.getLoginUiConfig().textRight)
          .fontColor("#1b86f7")
          .fontSize($r("app.float.fp_14"))
          .onClick(() => {
            if (this.loginType == LOGIN_TYPE_PWD) {
              this.loginType = LOGIN_TYPE_OTHER
              this.loadImageValidCode()
            } else {
              this.loginType = LOGIN_TYPE_PWD
            }
          })
      }.margin({ top: $r("app.float.fp_20") }).justifyContent(FlexAlign.SpaceBetween).width("100%")
    }.padding({ left: $r("app.float.fp_20"), right: $r("app.float.fp_20") })
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  buildInput(hint: string, isShowBoarder: boolean, marginTop: number | Resource, inputType: InputType,
    callback: EditableTextOnChangeCallback) {
    TextInput({ placeholder: hint })
      .placeholderColor("#999999")
      .fontColor("#111111")
      .height($r("app.float.fp_50"))
      .cancelButton({ style: CancelButtonStyle.INPUT, icon: { src: $r("app.media.multi_city_clear_x") } })
      .flexShrink(1)
      .backgroundColor(Color.Transparent)
      .border({ width: { bottom: isShowBoarder ? $r("app.float.fp_1") : 0 }, color: "#f6f6f6", radius: 0 })
      .margin({ top: marginTop })
      .padding({ left: 0, right: 0 })
      .maxLines(1)
      .type(inputType)
      .onChange(callback)
  }

  @Builder
  buildInputWithImageCode(hint: string, callback: EditableTextOnChangeCallback) {
    Row() {
      this.buildInput(hint, false, 0, InputType.Number, callback)
      Image(this.imageCodeUrl)
        .alt($r("app.media.icon_hotel_no_img"))
        .onError(() => {
          this.imageCodeUrl = $r("app.media.icon_hotel_no_img")
        })
        .width($r("app.float.fp_90"))
        .objectFit(ImageFit.Contain)
        .height($r("app.float.fp_50"))
    }.width("100%")
    .height($r("app.float.fp_50"))
    .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildInputWithButton(inputHint: string, buttonHint: string, callback: EditableTextOnChangeCallback) {
    Row() {
      this.buildInput(inputHint, false, 0, InputType.Number, callback)
      Button(buttonHint, { type: ButtonType.Normal })
        .fontColor("#1b86f7")
        .backgroundColor(buttonHint == "忘记密码?" ? Color.Transparent : "#F4F9FF")
        .borderRadius($r("app.float.fp_5"))
        .fontSize($r("app.float.fp_14"))
        .padding($r("app.float.fp_5"))
        .onClick(() => {
          if (buttonHint == "忘记密码?") {
            router.pushUrl({ url: "pages/FindBackPwdPage" })
          } else {
            this.getSmsCode()
          }
        })
    }.width("100%")
    .height($r("app.float.fp_50"))
    .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildPwd() {
    this.buildInput("输入手机号码/邮箱", true, $r("app.float.fp_100"), InputType.Normal, (value) => {
      this.inputPhone = value
    })
    this.buildInputWithButton("输入密码", "忘记密码?", (value) => {
      this.inputPwd = value
    })
  }

  @Builder
  buildOther() {
    this.buildInput("输入手机号码/邮箱", true, $r("app.float.fp_100"), InputType.Normal, (value) => {
      this.inputPhone = value
    })
    this.buildInputWithImageCode("输入图片验证码", (value) => {
      this.inputImageCode = value
    })
    this.buildInputWithButton("输入短信验证码", "获取验证码", (value) => {
      this.inputSmsCode = value
    })
  }

  @Builder
  buildJob() {
    this.buildInput("输入工号", true, $r("app.float.fp_100"), InputType.Normal, (value) => {
      this.inputPhone = value
    })
    this.buildInput("输入登录密码", true, 0, InputType.Normal, (value) => {
      this.inputPhone = value
    })
  }

  @Builder
  buildPhoneSms() {
    this.buildInput("输入手机号", true, $r("app.float.fp_100"), InputType.PhoneNumber, (value) => {
      this.inputPhone = value
    })
    this.buildInputWithImageCode("输入图片验证码", (value) => {
      this.inputImageCode = value
    })
    this.buildInputWithButton("输入短信验证码", "获取验证码", (value) => {
      this.inputSmsCode = value
    })
  }

  handleLogin() {
    let loginParams: LoginPostBody = {}
    loginParams.source = "app"
    loginParams.version = 657
    loginParams.type = this.loginType
    loginParams.account = this.inputPhone
    loginParams.pwd = CryptoJS.MD5(this.inputPwd).toString().toUpperCase()
    if (this.loginType == LOGIN_TYPE_OTHER) {
      loginParams.pictureAnswer = this.inputImageCode
      loginParams.pictureKeyID = this.verifyCode
    } else if (this.loginType == LOGIN_TYPE_SMS) {
      loginParams.code = this.inputSmsCode
    } else if (this.loginType == LOGIN_TYPE_JOB && this.loginResponseBusCode == 2002 ||
      this.loginType == LOGIN_TYPE_JOB && this.loginResponseBusCode == 2004) {
      loginParams.userPhone = "bindPhone"
      loginParams.code = "smsCode"
    } else if (this.loginType != LOGIN_TYPE_JOB && this.loginResponseBusCode == 2011) {
      loginParams.outAccount = "jobNumber"
    }
    requestLogin(loginParams).then((result) => {
      if (result.code == 1 && result.data != null) {
        promptAction.showToast({ message: result.message })
        this.loginSuccess(result.data)
      } else if (result.code == 2) {
        this.loginFailNotIn()
      } else if (result.code == 3) { //首次登录，修改密码
        this.loginChangeDefaultPwd()
      } else {
        this.loginFailed(result.busCode, result.message)
      }
    }).catch((reason: string) => {
      this.loginFailed(-2, reason)
    })
  }

  loginSuccess(data: object) {
    let accessToken: string = data["accessToken"]
    let refreshToken: string = data["refreshToken"]
    PrefUtils.putBoolean(PrefUtils.KEY_IS_LOGIN, true)
    PrefUtils.putString(PrefUtils.KEY_ACCESS_TOKEN, accessToken)
    PrefUtils.putString(PrefUtils.KEY_REFRESH_TOKEN, refreshToken)
    AppConst.accessToken = accessToken
    AppConst.refreshToken = refreshToken
    router.replaceUrl({ url: "pages/CommonWebPage" })
  }

  loginFailed(busCode: number, message: string) {
    this.loginResponseBusCode = busCode
    if (busCode == 2002) { //工号登录-请绑定手机号（跳转输入手机号及短信验证码页面）

    } else if (busCode == 2004) { //工号登录-账号需要绑定手机号

    } else if (busCode == 2011) { //账号和验证码登录-需绑定工号

    } else {
      this.loadImageValidCode()
      promptAction.showDialog({ message: message })
    }
  }

  loginFailNotIn() {

  }

  loginChangeDefaultPwd() {

  }

  loadImageValidCode() {
    this.verifyCode = util.generateRandomUUID().toString().replace("-", "")
    this.imageCodeUrl = UrlConstants.API_JAVA + UrlConstants.VERIFY_CODE_URL + "?id=" + this.verifyCode;
  }

  getSmsCode() {

  }
}

