export enum ZRInputType {
  TYPE_ORIGIN,
  TYPE_WITH_IMAGE,
  TYPE_WITH_BUTTON
}

@Component
export struct ZRInput {
  type: ZRInputType = ZRInputType.TYPE_ORIGIN
  @Prop hint: string = ""
  @Prop buttonHint?: string
  @Prop imageCodeUrl?: string | Resource
  @Prop isButtonEnable?: boolean = true
  inputType?: InputType = InputType.Normal
  isUnderLineShow?: boolean = true
  callback?: EditableTextOnChangeCallback = () => {
  }
  onButtonClick? = (event: ClickEvent) => {
  }

  build() {
    if (this.type == ZRInputType.TYPE_ORIGIN) {
      this.buildInput()
    } else if (this.type == ZRInputType.TYPE_WITH_IMAGE) {
      this.buildInputWithImageCode()
    } else if (this.type == ZRInputType.TYPE_WITH_BUTTON) {
      this.buildInputWithButton()
    }
  }

  @Builder
  buildInput() {
    TextInput({ placeholder: this.hint })
      .placeholderColor("#999999")
      .fontColor("#111111")
      .height($r("app.float.fp_50"))
      .showPasswordIcon(true)
      .showPassword(false)
      .cancelButton({ style: CancelButtonStyle.INPUT, icon: { src: $r("app.media.multi_city_clear_x") } })
      .flexShrink(1)
      .backgroundColor(Color.Transparent)
      .border({ width: { bottom: this.isUnderLineShow ? $r("app.float.fp_1") : 0 }, color: "#f6f6f6", radius: 0 })
      .padding({ left: 0, right: 0 })
      .maxLines(1)
      .type(this.inputType)
      .onChange(this.callback)
  }

  @Builder
  buildInputWithImageCode() {
    Row() {
      this.buildInput()
      Image(this.imageCodeUrl)
        .alt($r("app.media.icon_hotel_no_img"))
        .onError(() => {
          this.imageCodeUrl = $r("app.media.icon_hotel_no_img")
        })
        .width($r("app.float.fp_90"))
        .objectFit(ImageFit.Contain)
        .height($r("app.float.fp_50"))
        .onClick((event) => {
          if (this.onButtonClick != undefined) {
            this.onButtonClick(event)
          }
        })
    }.width("100%")
    .height($r("app.float.fp_50"))
    .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildInputWithButton() {
    Row() {
      this.buildInput()
      Button(this.buttonHint, { type: ButtonType.Normal })
        .fontColor("#1b86f7")
        .backgroundColor(this.buttonHint == "忘记密码?" ? Color.Transparent : "#F4F9FF")
        .borderRadius($r("app.float.fp_5"))
        .fontSize($r("app.float.fp_14"))
        .padding($r("app.float.fp_5"))
        .onClick((event) => {
          if (this.onButtonClick != undefined) {
            this.onButtonClick(event)
          }
        })
        .enabled(this.isButtonEnable)
    }.width("100%")
    .height($r("app.float.fp_50"))
    .border({ width: { bottom: $r("app.float.fp_1") }, color: "#f6f6f6", radius: 0 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

