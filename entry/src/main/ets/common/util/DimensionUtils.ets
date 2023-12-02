import display from '@ohos.display';
import { GlobalContext } from './GlobalContext';

let context = getContext(this);

/**
 * 设计绘制宽度。
 */
const DESIGN_WIDTH = 360;

/**
 * 设计绘制高度。
 */
const DESIGN_HEIGHT = 780;

/**
 * 适配不同大小和长度的工具类。
 */
export default class DimensionUtil {
  /**
   * 获取屏幕水平适配值。
   *
   * @param value 需要适配的值
   * @return 适配后的值
   */
  static adaptDimension(value: number): number {
    let deviceDisplay = GlobalContext.getContext().getObject('globalDisplay') as display.Display;
    let widthScale = deviceDisplay.width / DESIGN_WIDTH;
    let virtualHeight = widthScale * DESIGN_HEIGHT;
    let designDim = Math.sqrt(DESIGN_WIDTH * DESIGN_WIDTH + DESIGN_HEIGHT * DESIGN_HEIGHT);
    let virtualDim = Math.sqrt(deviceDisplay.width * deviceDisplay.width + virtualHeight * virtualHeight);
    return virtualDim * value / designDim; // 放缩后长度
  }

  /**
   * 获取屏幕水平适配 px 值。
   *
   * @param value 资源值
   * @return 适配后的 px 值
   */
  static getPx(value: Resource): number {
    let beforeVp = context.resourceManager.getNumber(value.id);
    return DimensionUtil.adaptDimension(beforeVp);
  }

  /**
   * 获取屏幕水平适配 vp 值。
   *
   * @param value 资源值
   * @return 适配后的 vp 值
   */
  static getVp(value: Resource): number {
    let beforeVp = context.resourceManager.getNumber(value.id);
    return px2vp(DimensionUtil.adaptDimension(beforeVp));
  }

  /**
   * 获取屏幕水平适配 fp 值。
   *
   * @param value 资源值
   * @return 适配后的 fp 值
   */
  static getFp(value: Resource): number {
    let beforeFp = context.resourceManager.getNumber(value.id);
    return px2fp(DimensionUtil.adaptDimension(beforeFp));
  }
}
