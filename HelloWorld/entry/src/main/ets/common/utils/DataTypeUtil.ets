/**
 * 数据类型工具类
 */
export default class DataTypeUtils {
  /**
   * 判断对象是否为空
   * @param obj
   * @returns
   */
  static isNull(obj: Object): boolean {
    return (typeof obj === 'undefined' || obj === null || obj === '')
  }

  /**
   * 深拷贝
   * @param obj
   * @returns
   */
  static deepCopy(obj: number[]) {
    let newObj: number[] = []
    for (let i = 0; i < obj.length; i++) {
      newObj[i] = JSON.parse(JSON.stringify(obj[i]))
    }
    return newObj
  }
}