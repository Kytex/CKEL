@Entry
@Component
struct Splash {
  @State message: string = 'Hello World';
  swiperController: SwiperController = new SwiperController()

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

  }

}