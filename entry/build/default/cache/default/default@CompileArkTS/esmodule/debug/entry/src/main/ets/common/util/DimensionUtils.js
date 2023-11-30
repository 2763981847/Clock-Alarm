import { GlobalContext } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/GlobalContext';
let context = getContext(this);
/**
 * Design drawing width.
 */
const DESIGN_WIDTH = 360;
/**
 * Design drawing height.
 */
const DESIGN_HEIGHT = 780;
/**
 * Fits tools with different sizes and lengths.
 */
export default class DimensionUtil {
    /**
     * Obtains the screen horizontal adaptation value.
     *
     * @return number
     */
    static adaptDimension(value) {
        let deviceDisplay = GlobalContext.getContext().getObject('globalDisplay');
        let widthScale = deviceDisplay.width / DESIGN_WIDTH;
        let virtualHeight = widthScale * DESIGN_HEIGHT;
        let designDim = Math.sqrt(DESIGN_WIDTH * DESIGN_WIDTH + DESIGN_HEIGHT * DESIGN_HEIGHT);
        let virtualDim = Math.sqrt(deviceDisplay.width * deviceDisplay.width + virtualHeight * virtualHeight);
        return virtualDim * value / designDim; // 放缩后长度
    }
    /**
     * Obtains the screen horizontal adaptation px.
     *
     * @return number
     */
    static getPx(value) {
        let beforeVp = context.resourceManager.getNumber(value.id);
        return DimensionUtil.adaptDimension(beforeVp);
    }
    /**
     * Obtains the screen horizontal adaptation vp.
     *
     * @return number
     */
    static getVp(value) {
        let beforeVp = context.resourceManager.getNumber(value.id);
        return px2vp(DimensionUtil.adaptDimension(beforeVp));
    }
    /**
     * Obtains the screen horizontal adaptation fp.
     *
     * @return number
     */
    static getFp(value) {
        let beforeFp = context.resourceManager.getNumber(value.id);
        return px2fp(DimensionUtil.adaptDimension(beforeFp));
    }
}
//# sourceMappingURL=DimensionUtils.js.map