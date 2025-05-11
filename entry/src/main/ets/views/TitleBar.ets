import { router } from "@kit.ArkUI"

@Component
export struct TitleBar {
  @Prop title?: string
  @Prop textRight?: string
  @Prop isShowBack: Visibility
  @Prop onBackClick: (event: ClickEvent) => void
  @Prop onRightClick: (event: ClickEvent) => void

  build() {
    RelativeContainer() {
      Image($r("app.media.ic_title_right"))
        .height($r("app.float.fp_20"))
        .padding({ left: $r("app.float.fp_5"), right: $r("app.float.fp_5") })
        .visibility(this.isShowBack)
        .objectFit(ImageFit.Contain)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
        })
        .onClick((event) => {
          if (typeof this.onBackClick == undefined) {
            router.back()
          } else {
            this.onBackClick(event)
          }
        })
      Text(this.title).textAlign(TextAlign.Center).alignRules({
        left: { anchor: "__container__", align: HorizontalAlign.Start },
        right: { anchor: "__container__", align: HorizontalAlign.End },
        top: { anchor: "__container__", align: VerticalAlign.Top },
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
      }).fontColor("#050505").fontSize($r("app.float.fp_16"))

      Text(this.textRight)
        .textAlign(TextAlign.Center)
        .alignRules({
          right: { anchor: "__container__", align: HorizontalAlign.End },
          top: { anchor: "__container__", align: VerticalAlign.Top },
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
        })
        .fontColor("#050505")
        .fontSize($r("app.float.fp_16"))
        .onClick((event) => {
          this.onRightClick(event)
        })
    }
    .padding({ left: $r("app.float.fp_10"), right: $r("app.float.fp_10") })
    .width("100%")
    .height($r("app.float.fp_30"))
  }
}