import { PrefUtils } from '../common/PrefUtils';
import router from '@ohos.router';
import application from '@ohos.app.ability.application';

@Entry
@Component
struct Splash {
  @State message: string = 'Hello World';
  @State isPrivacyAgree: boolean = false
  @State isFirst:boolean = true
  swiperController: SwiperController = new SwiperController()

  build() {
    RelativeContainer() {
      if (this.isPrivacyAgree) {
        if (this.isFirst) {
          Swiper(this.swiperController) {
            Image($r('app.media.icon_guide1')).width("100%").height("100%")
            Image($r('app.media.icon_guide2')).width("100%").height("100%")
            Image($r('app.media.icon_guide3')).width("100%").height("100%").onClick(() => {
              router.pushUrl({url:"pages/"})
            })
          }
          .displayCount(1)
          .indicator(false)
          .width("100%")
          .height("100%")
          .loop(false)
        }else {

        }
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
        Text() {
          Span($r("app.string.privacy_message"))
          Span("《隐私政策》").fontColor(Color.Blue).onClick(() => {

          })
          Span("的所有条款，包括：")
        }.fontColor("#000000").margin({ top: $r("app.float.fp_10") })

        Text("1、适用范围，在您使用差客e族应用时我们可能会基于具体业务场景收集您的个人信息；").fontColor("#000000")
        Text("2、信息使用，基于您的授权，我们可能会收集包括地理位置，设备信息，您有权拒绝或取消授权；").fontColor("#000000")
        Text("3、信息披露共享和使用，未经你同意差客e族应用不会向任何第三方共享您的个人信息。").fontColor("#000000")

        Button("同意", { type: ButtonType.Normal }).borderRadius(5).margin({ top: $r("app.float.fp_20") }).width("100%").onClick(() => {
          this.isPrivacyAgree = true
          PrefUtils.setPrivacyAgree(getContext(this))
        })
        Text("不同意退出").fontColor("#000000").margin({ top: $r("app.float.fp_10") }).onClick(()=>{
          getContext(this).getApplicationContext().killAllProcesses()
        })
      }
      .borderRadius($r("app.float.fp_12"))
      .backgroundColor($r('app.color.privacy_dialog_background'))
      .margin({ left: $r("app.float.fp_10"), right: $r("app.float.fp_10") })
      .width($r("app.float.fp_500"))
      .padding($r("app.float.fp_15"))
    }
    .backgroundColor($r('app.color.privacy_container_background'))
    .width('100%')
    .height('100%')
  }
}