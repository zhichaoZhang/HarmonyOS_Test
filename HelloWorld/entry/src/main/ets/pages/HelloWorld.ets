import router from '@ohos.router'
import url from '@ohos.url'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State secondPageSrcParam: string = '' //从SecondPage返回的参数

  onPageShow() {
    let secondPageParams = router.getParams()
    if (secondPageParams != null) {
      this.secondPageSrcParam = (secondPageParams as Record<string, string>)['src']
    }
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Text(this.secondPageSrcParam)
          .fontSize(20)
          .fontWeight(FontWeight.Normal)

        Button() {
          Text('Next')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin(20)
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          router.pushUrl({ url: 'pages/Second', params: {
            src: 'Index页面传来的参数'
          } }, router.RouterMode.Single).then(() => {
            console.info('jump to second page.')
          }).catch((err) => {
            console.error(err)
          })
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}