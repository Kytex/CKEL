@Entry
@Component
@Preview
struct FindBackPwdPage {
  @State message: string = 'Hello World';
  @State state: number = 0

  build() {
    Column() {
      this.buildTitleBar()
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  buildTitleBar() {
    Row() {
      Image($r("app.media.ic_title_right"))
        .height("100%")
        .padding({ left: $r("app.float.fp_5"), right: $r("app.float.fp_5") })
      Text("重置登录密码1/2")
    }.width("100%").height($r("app.float.fp_50"))
  }
}