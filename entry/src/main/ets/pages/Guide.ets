import { CustomContentDialog } from '@ohos.arkui.advanced.Dialog'

@Entry
@Component
struct Guide {
  @State currentIndex: number = 0

  swiperController:SwiperController = new SwiperController()

  build() {
    Swiper(this.swiperController) {
      Image($r('app.media.icon_guide1')).width("100%").height("100%")
      Image($r('app.media.icon_guide2')).width("100%").height("100%")
      Image($r('app.media.icon_guide3')).width("100%").height("100%")
    }
    .displayCount(1)
    .indicator(false)
    .width("100%")
    .height("100%")
    .loop(false)
  }

  aboutToAppear(): void {
    setInterval(() => {
      this.currentIndex++
      this.swiperController.changeIndex(this.currentIndex)
    }, 1000)
  }
}