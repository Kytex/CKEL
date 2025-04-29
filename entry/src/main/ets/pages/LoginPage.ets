import { InputWithClearParams } from '../interfaces/CustomeInterfaces'
import { promptAction, router } from '@kit.ArkUI'
import { requestLogin } from '../requests/ApiService'

@Entry
@Component
struct Login {
  @State loginType: number = 0 //0：手机号，密码登录 1：图形验证码登录；2：工号登录
  @State pwdHint: string = "输入密码"
  @State inputPhone: string = ""
  @State inputImageCode: string = ""
  @State inputPwd: string = ""
  @State isPrivacyChecked: boolean = false

  build() {
    Column() {
      Text("差客e旅登录").fontSize($r("app.float.fp_25"))
      this.InputWithClear({
        index: 0,
        hint: (this.loginType != 2) ? "输入手机号码/邮箱" : "输入工号",
        marginTop: $r("app.float.fp_100"),
        isShowBoarder: true,
        inputType: InputType.Normal
      }, (value) => {
        this.inputPhone = value
      })
      if (this.loginType == 1) {
        Row() {
          this.InputWithClear({
            index: 1,
            hint: "输入图片验证码",
            marginTop: 0,
            isShowBoarder: false,
            inputType: InputType.Number
          }, (value) => {
            this.inputImageCode = value
          })
          Image("").width($r("app.float.fp_90"))
        }.height($r("app.float.fp_50")).border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
      }
      Row() {
        this.InputWithClear({
          index: 2,
          hint: this.pwdHint,
          marginTop: 0,
          isShowBoarder: false,
          inputType: (this.loginType == 1) ? InputType.Number : InputType.Password
        }, (value) => {
          this.inputPwd = value
        })
        if (this.loginType == 0) {
          Text("忘记密码？").fontColor("#1b86f7").fontSize($r("app.float.fp_14"))
            .onClick(() => {
              router.pushUrl({ url: "pages/FindBackPwdPage" })
            })
        }
        if (this.loginType == 1) {
          Button("获取验证码", { type: ButtonType.Normal })
            .fontColor("#1b86f7")
            .backgroundColor("#F4F9FF")
            .borderRadius($r("app.float.fp_5"))
            .fontSize($r("app.float.fp_14"))
            .padding($r("app.float.fp_5"))
        }
      }
      .width("100%")
      .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
      .height($r("app.float.fp_50"))

      Button("登录", { type: ButtonType.Normal })
        .margin({ top: $r("app.float.fp_40") })
        .width("100%")
        .borderRadius($r("app.float.fp_5"))
        .enabled((this.loginType == 0 || this.loginType == 2) && (this.inputPhone != "" && this.inputPwd != "") ||
          (this.loginType == 1 && this.inputImageCode != "" && this.inputPhone != "" && this.inputPwd != ""))
        .onClick(() => {
          if (this.isPrivacyChecked) {
            this.login()
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
        Text("工号登录")
          .fontColor("#1b86f7")
          .fontSize($r("app.float.fp_14"))
          .visibility((this.loginType != 0) ? Visibility.Visible : Visibility.Hidden)
          .onClick(() => {
            this.loginType = 2
            this.pwdHint = "输入登录密码"
          })
        Text((this.loginType == 0) ? "其他登录方式" : "账号密码登录")
          .fontColor("#1b86f7")
          .fontSize($r("app.float.fp_14"))
          .onClick(() => {
            if (this.loginType == 0) {
              this.loginType = 1
              this.pwdHint = "输入短信验证码"
            } else {
              this.loginType = 0
              this.pwdHint = "输入密码"
            }
          })
      }.margin({ top: $r("app.float.fp_20") }).justifyContent(FlexAlign.SpaceBetween).width("100%")
    }.padding({ left: $r("app.float.fp_20"), right: $r("app.float.fp_20") })
    .width("100%")
    .height("100%")
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  InputWithClear(params: InputWithClearParams, callback: EditableTextOnChangeCallback) {
    TextInput({ placeholder: this.getTextHint(params) })
      .placeholderColor("#999999")
      .fontColor("#111111")
      .height($r("app.float.fp_50"))
      .cancelButton({ style: CancelButtonStyle.INPUT, icon: { src: $r("app.media.multi_city_clear_x") } })
      .flexShrink(1)
      .backgroundColor(Color.Transparent)
      .border({ width: { bottom: params.isShowBoarder ? $r("app.float.fp_1") : 0 }, color: "#f6f6f6", radius: 0 })
      .margin({ top: params.marginTop })
      .padding({ left: 0, right: 0 })
      .maxLines(1)
      .type(params.inputType)
      .onChange(callback)
  }

  getTextHint(params: InputWithClearParams) {
    if (params.index == 0) {
      if (this.loginType == 2) {
        params.hint = "输入工号"
      } else {
        params.hint = "输入手机号码 / 邮箱"
      }
    } else if (params.index == 2) {
      params.hint = this.pwdHint
    }
    return params.hint
  }

  login() {
    requestLogin({
      account: this.inputPhone,
      pwd: this.inputPwd,
      code: this.loginType == 1 ? this.inputPwd : "",
      pictureAnswer: this.inputImageCode,
      pictureKeyID: this.inputPwd,
      outAccount: this.inputPhone
    }).then(() => {

    })
  }
}

