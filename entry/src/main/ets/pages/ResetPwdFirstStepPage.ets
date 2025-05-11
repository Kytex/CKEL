import { buildInput, buildInputWithButton, buildInputWithImageCode } from '../common/builders';
import { TitleBar } from '../views/TitleBar';
import { LengthMetrics, promptAction } from '@kit.ArkUI';
import { util } from '@kit.ArkTS';
import { UrlConstants } from '../constants/UrlConstants';
import { getResetPwdSmsCode } from '../requests/ApiService';

@Entry
@Component
@Preview
struct FindBackPwdPage {
  @State message: string = 'Hello World';
  @State state: number = 0
  @State currentIndex: number = 0
  @State inputPhone: string = ""
  @State inputImageCode: string = ""
  @State inputSmsCode: string = ""
  @State inputSmsCode1: string = ""
  @State inputEmail: string = ""
  @State imageCodeUrl: string | Resource = ""
  @State successCount: number = 0
  @State remainMills: number = 0
  answerKeyID: string = ""

  build() {
    Column() {
      TitleBar({ title: "重置登录密码1/2", isShowBack: Visibility.Visible })
      Column() {
        Flex({ direction: FlexDirection.Row, space: { main: LengthMetrics.fp(20) } }) {
          this.buildTabBar(0, "手机号找回")
          this.buildTabBar(1, "邮箱找回")
        }.margin({ top: $r("app.float.fp_41") })

        if (this.currentIndex == 0) {
          this.buildPhoneFindBack()
        } else {
          this.buildEmailFindBack()
        }
        Button("下一步")
          .padding({ top: $r("app.float.fp_12"), bottom: $r("app.float.fp_12") })
          .fontSize($r("app.float.fp_16"))
          .type(ButtonType.Normal)
          .width("100%")
          .borderRadius($r("app.float.fp_5"))
          .margin({ top: $r("app.float.fp_35") })
          .onClick(() => {

          })
      }
      .padding({ left: $r("app.float.fp_20"), right: $r("app.float.fp_20") })
    }
    .height('100%')
    .width('100%')
  }

  aboutToAppear(): void {
    this.loadImageCode()
  }

  @Builder
  buildTabBar(index: number, name: string) {
    RelativeContainer() {
      Text(name).fontSize($r("app.float.fp_18")).fontColor("#111111").id("id_title")
      Divider()
        .strokeWidth(2)
        .color("#1b86f7")
        .opacity(this.currentIndex === index ? 1 : 0)
        .alignRules({
          left: { anchor: "id_title", align: HorizontalAlign.Start },
          right: { anchor: "id_title", align: HorizontalAlign.End },
          top: { anchor: "id_title", align: VerticalAlign.Bottom }
        })
    }.height($r("app.float.fp_30")).width($r("app.float.fp_90"))
    .onClick(() => {
      this.currentIndex = index
    })
  }

  @Builder
  buildPhoneFindBack() {
    Column() {
      buildInput("输入手机号码", InputType.PhoneNumber, $r("app.float.fp_86"), true, (value) => {
        this.inputPhone = value
      })
      buildInputWithImageCode("输入图片验证码", this.imageCodeUrl, (value) => {
        this.inputImageCode = value
      })
      buildInputWithButton("输入验证码", this.remainMills == 0 ? "获取验证码" : this.remainMills + "s后重新获取",
        (value) => {
          this.inputSmsCode = value
        }, (event) => {
          this.getSmsCode()
        })
    }.width("100%")
  }

  @Builder
  buildEmailFindBack() {
    Column() {
      buildInput("输入邮箱", InputType.PhoneNumber, $r("app.float.fp_86"), true, (value) => {
        this.inputEmail = value
      })
      buildInputWithButton("输入验证码", "获取验证码", (value) => {
        this.inputSmsCode1 = value
      }, (event) => {
        this.getSmsCode()
      })
    }.width("100%")
  }

  getSmsButtonText() {
    if (this.successCount > 0) {
      setInterval(() => {
      }, 1000)
    }
  }

  loadImageCode() {
    this.answerKeyID = util.generateRandomUUID().toString().replace("-", "")
    this.imageCodeUrl = UrlConstants.API_JAVA + UrlConstants.VERIFY_CODE_URL + "?id=" + this.answerKeyID;
  }

  getSmsCode() {
    getResetPwdSmsCode({
      answer: this.inputImageCode,
      answerKeyID: this.answerKeyID,
      phoneNumber: this.inputPhone
    }).then((result) => {
      promptAction.showToast({ message: result.message })
      if (result.code != 1) {
        this.loadImageCode()
      } else {
        this.startCountDown()
      }
    }).catch((reason: string) => {
      promptAction.showToast({ message: reason })
      this.loadImageCode()
    })
  }

  startCountDown() {
    this.remainMills = 60
    let timerId = setInterval(() => {
      if (this.remainMills > 0) {
        this.remainMills--
      } else {
        clearInterval(timerId)
      }
    }, 1000)
  }
}