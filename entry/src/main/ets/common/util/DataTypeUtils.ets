/**
 * 数据类型工具类。
 */
export default class DataTypeUtils {
  /**
   * 判断对象是否为 null。
   *
   * @param obj 要检查的对象
   * @return 是否为 null 的布尔值
   */
  static isNull(obj: Object): boolean {
    return (typeof obj === 'undefined' || obj == null || obj === '');
  }

  /**
   * 从对象 obj 创建一个深拷贝的新对象。
   *
   * @param obj 要深拷贝的对象
   * @return 与 obj 类型相同的新对象
   */
  static deepCopy(obj: number[]) {
    let newObj: number[] = [];
    for (let i = 0; i < obj.length; i++) {
      newObj[i] = JSON.parse(JSON.stringify(obj[i]));
    }
    return newObj;
  }
}
