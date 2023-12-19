import display from '@ohos.display'
import { GlobalContext } from './GlobalContext'

let context = getContext(this)

const DESIGN_WIDTH = 360
const DESIGN_HEIGHT = 780

export default class DimensionUtil {
  /**
   * 安装屏幕宽度适配尺寸
   * @param value
   * @returns
   */
  static adaptDimension(value: number): number {
    let deviceDisplay = GlobalContext.getContext().getObject('globalDisplay') as display.Display
    let widthScale = deviceDisplay.width / DESIGN_WIDTH
    let virtualHeight = widthScale * DESIGN_WIDTH
    let designDim = Math.sqrt(DESIGN_WIDTH * DESIGN_WIDTH + DESIGN_HEIGHT * DESIGN_HEIGHT)
    let virtualDim = Math.sqrt(deviceDisplay.width * deviceDisplay.width + virtualHeight * virtualHeight)
    return virtualDim * value / designDim //缩放后长度
  }

  /**
   * 获取按照屏幕宽度适配后的像素值
   * @param value
   * @returns
   */
  static getPx(value: Resource): number {
    let beforePx = context.resourceManager.getNumber(value.id)
    return DimensionUtil.adaptDimension(beforePx)
  }

  /**
   * 获取按照屏幕宽度适配后的vp值
   * @param value
   * @returns
   */
  static getVp(value: Resource): number {
    let beforePx = context.resourceManager.getNumber(value.id)
    return px2vp(DimensionUtil.adaptDimension(beforePx))
  }

  /**
   * 获取按照屏幕宽度适配后的fp值
   * @param value
   * @returns
   */
  static getFp(value: Resource): number {
    let beforePx = context.resourceManager.getNumber(value.id)
    return px2fp(DimensionUtil.adaptDimension(beforePx))
  }
}