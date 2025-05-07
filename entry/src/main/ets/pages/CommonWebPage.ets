import { router } from '@kit.ArkUI';

export class JumpParams {
  title: string = ""
  url: string = ""

  constructor(title: string, url: string) {
    this.title = title
    this.url = url
  }
}

@Entry
@Component
struct CommonWebPage {
  @State message: string = 'Hello World';
  title: string = ""
  url: string = ""

  aboutToAppear(): void {
    let params = router.getParams() as JumpParams
    this.title = params.title
    this.url = params.url
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('CommonWebPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}

