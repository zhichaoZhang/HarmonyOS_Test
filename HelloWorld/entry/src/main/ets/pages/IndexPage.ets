import router from '@ohos.router'
import UIAbility from '@ohos.app.ability.UIAbility'
import common from '@ohos.app.ability.common'
import featureAbility from '@ohos.ability.featureAbility'

@Entry
@Component
struct IndexPage {
  build() {
    Scroll() {
      Column({ space: 10 }) {
        Button('HelloWorld')
          .onClick(() => {
            router.pushUrl({ url: 'pages/HelloWorld' })
          })

        Button('长列表LazyList')
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/LazyList' })
          })

        Button('Tab组件')
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/TabComponent' })
          })

        Button('评分Demo')
          .onClick(() => {
            router.pushUrl({ url: 'pages/RankPage' })
          })

        Button('登录+首页Demo')
          .onClick(() => {
            this.startFirstDemo()
          })

        Button('状态管理')
          .onClick(() => {
            router.pushUrl({ url: 'pages/TargetManagement' })
          })
      }.alignItems(HorizontalAlign.Start)
    }.height('100%').width('100%').edgeEffect(EdgeEffect.Spring)
  }

  private context = getContext(this) as common.UIAbilityContext

  startFirstDemo() {
    //启动Ability
    let want = {
      deviceId: '', //deviceId为空代表本设备
      bundleName: 'com.zzc.helloworld', //
      abilityName: 'First_demoAbility', //Ability名称
      moduleName: 'first_demo', //模块名称，可选
      // parameters: { //自定义参数，可选
      //
      // }
    }
    this.context.startAbility(want).then(() => {
      //可以在这里获取
    }).catch((err) => {
      console.error('start ability failed: ' + err)
    })
  }
}