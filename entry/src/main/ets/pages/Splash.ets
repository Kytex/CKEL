import { PrefUtils } from '../common/PrefUtils';
import App from '@system.app';

@Entry
@Component
struct Splash {
  @State message: string = 'Hello World';
  @State isPrivacyAgree: boolean = false
  swiperController: SwiperController = new SwiperController()

  build() {
    RelativeContainer() {
      if (this.isPrivacyAgree) {
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
      } else {
        this.showPrivacyDialog()
      }
    }
    .visibility(Visibility.Visible)
    .backgroundImage($r('app.media.icon_guid_main'))
    .backgroundImageSize(ImageSize.FILL)
    .width("100%")
    .height("100%")
  }

  aboutToAppear(): void {
    this.isPrivacyAgree = PrefUtils.isPrivacyAgree(getContext(this))
  }

  @Builder
  showPrivacyDialog() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Column() {
        Text($r('app.string.privacy_title')).fontColor("#000000").fontWeight(FontWeight.Bold)
        Text($r('app.string.privacy_message')).fontColor("#000000").margin({top:15})
      }
      .backgroundColor($r('app.color.privacy_dialog_background'))
      .margin({left:20,right:20})
      .padding(15)
    }
    .backgroundColor($r('app.color.privacy_container_background'))
    .width('100%')
    .height('100%')
  }
}