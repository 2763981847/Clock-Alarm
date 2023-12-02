import { CommonConstants } from '../../common/constant/CommonConstants';
import { AlarmClockConstants } from '../../common/constant/AlarmClockConstants';
import DimensionUtil from '../../common/util/DimensionUtils';

@Component
export default struct ClockArea {
  private canvasSize: number = DimensionUtil.getVp($r('app.float.clock_size'));
  private clockRadius: number = this.canvasSize / CommonConstants.DEFAULT_DOUBLE - CommonConstants.DEFAULT_DOUBLE;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private renderContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  @Link @Watch('drawClockArea') now: number
  private isReady: boolean = false

  build() {
    Canvas(this.renderContext)
      .width(this.canvasSize)
      .height(this.canvasSize)
      .onReady(() => {
        this.startDrawTask();
        this.isReady = true;
      })
  }

  // 启动绘画任务
  private startDrawTask() {
    this.renderContext.translate(
      this.canvasSize / CommonConstants.DEFAULT_DOUBLE,
      this.canvasSize / CommonConstants.DEFAULT_DOUBLE);
  }

  // 开始绘制时钟区域
  private drawClockArea(): void {
    if (!this.isReady) {
      return;
    }
    this.renderContext.clearRect(
      -this.canvasSize,
      -this.canvasSize / CommonConstants.DEFAULT_DOUBLE,
      this.canvasSize * CommonConstants.DEFAULT_DOUBLE,
      this.canvasSize);
    let date = new Date(this.now);
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    this.drawPan();
    this.drawPointer(
      CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX * (hours > CommonConstants.DEFAULT_TOTAL_HOUR
        ? hours - CommonConstants.DEFAULT_TOTAL_HOUR
        : hours)
      + minutes / CommonConstants.DEFAULT_TOTAL_HOUR * CommonConstants.DEFAULT_COMMON_DEGREE,
      AlarmClockConstants.HOUR_POINTER_IMAGE_URL);
    this.drawPointer(CommonConstants.DEFAULT_COMMON_DEGREE * minutes, AlarmClockConstants.MINUTE_POINTER_IMAGE_URL);
    this.drawPointer(CommonConstants.DEFAULT_COMMON_DEGREE * seconds, AlarmClockConstants.SECOND_POINTER_IMAGE_URL);
  }

  // 绘制表盘
  private drawPan(): void {
    this.renderContext.beginPath();
    let secondImg = new ImageBitmap(AlarmClockConstants.CLOCK_PAN_IMAGE_URL);
    let imgWidth = this.clockRadius * 2;
    this.renderContext.drawImage(secondImg, -this.clockRadius, -this.clockRadius, imgWidth, imgWidth);
    this.renderContext.restore();
  }

  // 绘制时针、分针、秒针
  private drawPointer(degree: number, pointerImgRes: string) {
    this.renderContext.save();
    let theta = (degree + AlarmClockConstants.DEFAULT_HORIZONTAL_ANGLE) * Math.PI / AlarmClockConstants.DEFAULT_HORIZONTAL_ANGLE;
    this.renderContext.rotate(theta);
    this.renderContext.beginPath();
    let secondImg = new ImageBitmap(pointerImgRes);
    let imgWidth = CommonConstants.DEFAULT_POINTER_WIDTH;
    this.renderContext.drawImage(
      secondImg,
      -imgWidth / CommonConstants.DEFAULT_DOUBLE,
      -this.clockRadius,
      imgWidth,
      this.clockRadius * CommonConstants.DEFAULT_DOUBLE);
    this.renderContext.restore();
  }
}
