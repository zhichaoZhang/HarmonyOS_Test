import router from '@ohos.router'

@Entry
@Component
struct Second {
  @State message: string = '第二个页面'
  @State srcParams: string = (router.getParams() as Record<string, string>)['src'] //页面参数解析

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Text(this.srcParams)
          .fontSize(20)
          .fontWeight(FontWeight.Normal)

        Button() {
          Text('Back')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin(20)
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          try {
            router.showAlertBeforeBackPage({
              message: "Back page alert"
            })
            router.back({
              url: 'pages/Index',
              params: {
                src: 'Second页面传来的参数'
              }
            })
            console.info('return to the first page')
          } catch (err) {
            console.error(err)
          }
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}