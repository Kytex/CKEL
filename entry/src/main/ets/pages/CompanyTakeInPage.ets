@Entry
@Component
struct CompanyTakeInPage {
  @State isNewCpy: boolean = false

  build() {
    Column() {
      if (this.isNewCpy) {
        Text("尚未开通主动加入企业的功能，请联系您的企业向您发送邀请链接完成加入企业。")
          .fontColor("#353c42")
          .margin({ top: $r("app.float.fp_60") })
          .textAlign(TextAlign.Start)
          .padding({ left: $r("app.float.fp_20"), right: $r("app.float.fp_20") })
          .width("100%")
      } else {
        Text("您必须加入企业才能使用差客")
          .fontColor("#353c42")
          .margin({ top: $r("app.float.fp_60") })
          .textAlign(TextAlign.Start)
          .padding({ left: $r("app.float.fp_20"), right: $r("app.float.fp_20") })
          .width("100%")

        Button("新建企业")
          .type(ButtonType.Normal)
          .fontColor(Color.White)
          .fontSize($r("app.float.fp_18"))
          .border({ radius: $r("app.float.fp_5") })
          .width("80%")
          .margin({ top: $r("app.float.fp_80") })
          .onClick(() => {
            
          })

        Button("加入企业")
          .type(ButtonType.Normal)
          .fontColor(Color.White)
          .fontSize($r("app.float.fp_18"))
          .border({ radius: $r("app.float.fp_5") })
          .width("80%")
          .margin({ top: $r("app.float.fp_30") })
          .onClick(() => {
            this.isNewCpy = true
          })
      }
    }
    .height('100%')
    .width('100%')
  }

  onBackPress(): boolean | void {
    if (this.isNewCpy) {
      this.isNewCpy = false
      return true
    }
  }
}