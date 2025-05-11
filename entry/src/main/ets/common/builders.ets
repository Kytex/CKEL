@Builder
export function buildInput(hint: string, inputType: InputType, marginTop: number | Resource,
  isShowBoarder: boolean,
  callback: EditableTextOnChangeCallback
) {
  TextInput({ placeholder: hint })
    .placeholderColor("#999999")
    .fontColor("#111111")
    .height($r("app.float.fp_50"))
    .cancelButton({ style: CancelButtonStyle.INPUT, icon: { src: $r("app.media.multi_city_clear_x") } })
    .flexShrink(1)
    .backgroundColor(Color.Transparent)
    .border({ width: { bottom: isShowBoarder ? $r("app.float.fp_1") : 0 }, color: "#f6f6f6", radius: 0 })
    .margin({ top: marginTop })
    .padding({ left: 0, right: 0 })
    .maxLines(1)
    .type(inputType)
    .onChange(callback)
}

@Builder
export function buildInputWithImageCode(hint: string, imageCodeUrl: string | Resource,
  callback: EditableTextOnChangeCallback) {
  Row() {
    buildInput(hint, InputType.Number, 0, false, callback)
    Image(imageCodeUrl)
      .alt($r("app.media.icon_hotel_no_img"))
      .onError(() => {
        imageCodeUrl = $r("app.media.icon_hotel_no_img")
      })
      .width($r("app.float.fp_90"))
      .objectFit(ImageFit.Contain)
      .height($r("app.float.fp_50"))
  }.width("100%")
  .height($r("app.float.fp_50"))
  .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
  .justifyContent(FlexAlign.SpaceBetween)
}

@Builder
export function buildInputWithButton(inputHint: string, buttonHint: string, callback: EditableTextOnChangeCallback,
  onButtonClick: (event?: ClickEvent) => void) {
  Row() {
    buildInput(inputHint, InputType.Number, 0, false, callback)
    Button(buttonHint, { type: ButtonType.Normal })
      .fontColor("#1b86f7")
      .backgroundColor(buttonHint == "忘记密码?" ? Color.Transparent : "#F4F9FF")
      .borderRadius($r("app.float.fp_5"))
      .fontSize($r("app.float.fp_14"))
      .padding($r("app.float.fp_5"))
      .onClick((event) => {
        onButtonClick(event)
      })
  }.width("100%")
  .height($r("app.float.fp_50"))
  .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
  .justifyContent(FlexAlign.SpaceBetween)
}