/**
 * TimerPage 页面组件。
 */
import { CommonConstants } from '../common/constant/CommonConstants';
import { TimerConstants } from '../common/constant/TimerConstants';
import DimensionUtil from '../common/util/DimensionUtils';
import HeaderContainer from '../view/HeaderContainer';
import MyTimePicker from '../view/Timer/MyTimePicker';
import TimerComponent from '../view/Timer/TimerComponent';

@Component
export default struct TimerPage {
  //  startOrPauseImage 按钮图标
  @State startOrPauseImage: Resource = $r('app.media.ic_play');

  // 表示计时器状态，0 - 已重置 1 - 计时中 2 - 暂停中
  @State @Watch('onStateChange') state: number = 0;

  // buttonScale 和 buttonScale2 用于按钮动画
  @State buttonScale: number = 1;
  @State buttonScale2: number = 1;

  // 状态变量 count 表示倒计时的时间（毫秒）
  @State count: number = CommonConstants.MILLISECONDS_PER_MINUTE;

  // 创建 TextTimerController 对象，用于控制计时器
  private textTimerController: TextTimerController = new TextTimerController();

  // 监听计时器状态变化
  onStateChange() {
    switch (this.state) {
      case 0:
        this.textTimerController.reset();
        this.startOrPauseImage = $r('app.media.ic_play');
        break;
      case 1:
        this.textTimerController.start();
        this.startOrPauseImage = $r('app.media.ic_pause');
        break;
      case 2:
        this.textTimerController.pause();
        this.startOrPauseImage = $r('app.media.ic_play');
        break;
    }
  }

  // 计时结束回调函数
  private onCountOver = () => {
    animateTo({
      duration: CommonConstants.ANIMATION_SHORT_DURATION,
      tempo: 1,
      playMode: PlayMode.Normal,
    }, () => {
      this.state = 0;
    });
  }

  // 构建页面内容
  build() {
    Column() {
      HeaderContainer({ title: TimerConstants.TIMER });

      if (this.state === 0) {
        MyTimePicker({ count: $count })
          .transition({ type: TransitionType.All, opacity: 0, scale: { x: 0, y: 0 } });
      } else {
        TimerComponent({
          textTimerController: this.textTimerController,
          count: this.count,
          onCountOver: this.onCountOver
        }).transition({ type: TransitionType.All, opacity: 0, scale: { x: 0, y: 0 } });
      }

      Row() {
        if (this.state != 0) {
          Button() {
            Image($r('app.media.ic_reset')).objectFit(ImageFit.Fill);
          }
          .backgroundColor($r('app.color.trans_parent'))
          .height(DimensionUtil.getVp($r('app.float.play_button_size')))
          .width(DimensionUtil.getVp($r('app.float.play_button_size')))
          .stateEffect(false)
          .type(ButtonType.Circle)
          .scale({ x: this.buttonScale2, y: this.buttonScale2 })
          .padding(DimensionUtil.getVp($r('app.float.play_button_size')) / 4)
          .border({ width: 2, color: $r('app.color.grey_light') })
          .animation({ duration: CommonConstants.ANIMATION_SHORT_DURATION,
            tempo: 2,
            playMode: PlayMode.Normal,
            onFinish: () => this.buttonScale2 = 1 })
          .transition({ type: TransitionType.All, translate: { x: 50 }, opacity: 0 })
          .onClick(() => {
            // 缩放按钮动画
            this.buttonScale2 = 0.95;
            animateTo({
              duration: CommonConstants.ANIMATION_SHORT_DURATION,
              tempo: 1,
              playMode: PlayMode.Normal,
            }, () => {
              this.state = 0;
            });
          });
        }

        Button() {
          Image(this.startOrPauseImage).objectFit(ImageFit.Fill)
            .align(Alignment.Center);
        }
        .enabled(this.state != 0 || this.count > 0)
        .backgroundColor($r('app.color.red_light'))
        .height(DimensionUtil.getVp($r('app.float.play_button_size')))
        .width(DimensionUtil.getVp($r('app.float.play_button_size')))
        .scale({ x: this.buttonScale, y: this.buttonScale })
        .padding(DimensionUtil.getVp($r('app.float.play_button_size')) / 4)
        .animation({ duration: CommonConstants.ANIMATION_SHORT_DURATION,
          tempo: 2,
          playMode: PlayMode.Normal,
          onFinish: () => this.buttonScale = 1 })
        .stateEffect(false)
        .type(ButtonType.Circle)
        .onClick(() => {
          // 缩放按钮动画
          this.buttonScale = 0.95;
          animateTo({
            duration: CommonConstants.ANIMATION_SHORT_DURATION,
            tempo: 1,
            playMode: PlayMode.Normal,
          }, () => {
            if (this.state === 1) {
              this.state = 2;
            } else {
              this.state = 1;
            }
          });
        });
      }.padding(DimensionUtil.getVp($r('app.float.title_horizon_margin')))
      .width(CommonConstants.FULL_LENGTH)
      .justifyContent(FlexAlign.SpaceAround);
    }.justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH);
  }
}
