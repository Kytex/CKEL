import { TitleBar } from '../views/TitleBar';
import { ZRInput, ZRInputType } from '../views/ZRInput';
import { promptAction, router } from '@kit.ArkUI';
import { forgetPwdRequest } from '../requests/ApiService';
import CryptoJS from '@ohos/crypto-js';
import { PrefUtils } from '../utils/PrefUtils';

@Entry
@Component
struct SetupPwdPage {
  @State message: string = 'Hello World';
  @State inputNewPwd: string = ""
  @State inputConfirmPwd: string = ""
  account: string = ""
  verifyCode: string = ""
  answer: string = ""
  answerKeyID: string = ""

  build() {
    Column() {
      TitleBar({ title: "重置登录密码2/2" })
      Column() {
        Text("设置登录密码").fontSize($r("app.float.fp_25")).fontColor("#111111")

        ZRInput({
          hint: "设置新密码",
          type: ZRInputType.TYPE_ORIGIN,
          inputType: InputType.Password,
          callback: (value) => {
            this.inputNewPwd = value
          }
        })

        ZRInput({
          hint: "确认密码",
          type: ZRInputType.TYPE_ORIGIN,
          inputType: InputType.Password,
          callback: (value) => {
            this.inputConfirmPwd = value
          }
        })

        Text("密码为6-20个字符，且同时包含字母和数字")
          .fontSize($r("app.float.fp_15"))
          .fontColor("#999999")
          .margin({ top: $r("app.float.fp_15") })

        Button("完成")
          .type(ButtonType.Normal)
          .padding($r("app.float.fp_10"))
          .fontSize("app.float.fp_16")
          .fontColor("#FFFFFF")
          .width("100%")
          .margin({ top: $r("app.float.fp_28") })
          .enabled(this.inputNewPwd != "" && this.inputConfirmPwd != "")
          .onClick(() => {
            this.handleSetupPwd()
          })
      }.width("100%").height("100%").margin({ top: $r("app.float.fp_64") })
      .padding($r("app.float.fp_22"))
    }.width("100%").height("100%")
  }

  aboutToAppear(): void {
    let data = router.getParams() as Record<string, string>
    this.account = data["account"]
    this.answer = data["answer"]
    this.answerKeyID = data["answerKeyID"]
    this.verifyCode = data["verifyCode"]
  }

  handleSetupPwd() {
    forgetPwdRequest({
      answer: this.answer,
      answerKeyID: this.answerKeyID,
      phoneNumber: this.account,
      smsCode: this.verifyCode,
      password: CryptoJS.MD5(this.inputConfirmPwd).toString().toUpperCase()
    }).then((result) => {
      if (result.code == 1) {
        PrefUtils.putString(PrefUtils.KEY_ACCOUNT, this.account)
        router.pushUrl({ url: "pages/LoginPage" })
      }
      promptAction.showToast({ message: result.message })
    }).catch((reason: string) => {
      promptAction.showToast({ message: reason })
    })
  }
}