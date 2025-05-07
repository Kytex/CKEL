import { TitleBar } from '../common/builders';

@Entry
@Component
@Preview
struct FindBackPwdPage {
  @State message: string = 'Hello World';
  @State state: number = 0

  build() {
    Column() {
      TitleBar()
    }
    .height('100%')
    .width('100%')
  }
}