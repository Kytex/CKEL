import { TitleBarOptions } from "./customTypes"
import { router } from "@kit.ArkUI"

//顶部标题栏
@Builder
export function TitleBar(title?: string, isShowBack?: Visibility, onBackClick?: (event: ClickEvent) => void) {
  Row() {
    Image($r("app.media.ic_title_right"))
      .height("100%")
      .padding({ left: $r("app.float.fp_5"), right: $r("app.float.fp_5") })
      .visibility(isShowBack)
      .onClick(typeof onBackClick == undefined ? onBackClick : () => {
        router.back()
      })
    Text(title)
  }.width("100%").height($r("app.float.fp_50"))
}