import { CommonConstants } from '../common/constant/CommonConstants'
import { StopWatchConstants } from '../common/constant/StopWatchConstants'
import DimensionUtil from '../common/util/DimensionUtils'
import HeaderContainer from '../view/HeaderContainer'
import FlagList from '../view/StopWatch/FlagList'

@Component
export default struct StopwatchPage {
  private textTimerController: TextTimerController = new TextTimerController()
  // 0 - 已重置 1 - 计时中 2 - 暂停中
  @State @Watch('onStateChange') state: number = 0
  private elapsedTime: number
  @State startOrPauseImage: Resource = $r('app.media.ic_play')
  @State resetOrFlagImage: Resource = $r('app.media.ic_flag')
  @State buttonScale: number = 1
  @State buttonScale2: number = 1
  @State flags: Array<number> = []
  private listScroller: Scroller = new Scroller();

  onStateChange() {
    switch (this.state) {
      case 0:
        this.textTimerController.reset();
        this.startOrPauseImage = $r('app.media.ic_play')
        break;
      case 1:
        this.textTimerController.start();
        this.startOrPauseImage = $r('app.media.ic_pause')
        this.resetOrFlagImage = $r('app.media.ic_flag')
        break;
      case 2:
        this.textTimerController.pause();
        this.startOrPauseImage = $r('app.media.ic_play')
        this.resetOrFlagImage = $r('app.media.ic_reset')
        break;
    }
  }

  addFlag() {
    this.flags.push(this.elapsedTime)
    this.listScroller.scrollToIndex(this.flags.length - 1)
  }

  reset() {
    this.state = 0;
    this.flags = []
  }

  build() {
    Column() {
      HeaderContainer({ title: StopWatchConstants.STOP_WATCH })

      Column() {
        TextTimer({ controller: this.textTimerController })
          .format(StopWatchConstants.TIMER_FORMAT)
          .fontColor(Color.Black)
          .fontSize($r('app.float.stop_watch_font_size'))
          .onTimer((_utc: number, elapsedTime: number) => {
            this.elapsedTime = elapsedTime
          })
          .padding({
            bottom: DimensionUtil.getVp($r('app.float.new_alarm_button_margin_vertical')),
            top: DimensionUtil.getVp($r('app.float.new_alarm_button_margin_vertical'))
          })
        if (this.flags && this.flags.length > 0) {
          FlagList({ flags: $flags, listScroller: this.listScroller })
            .height('80%')
            .transition({ type: TransitionType.Delete, opacity: 0, scale: { x: 0, y: 0 } })
        }
      }.width(CommonConstants.FULL_LENGTH)
      .height('60%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({
        left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
        right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
      })


      Row() {
        if (this.state != 0) {
          Button() {
            Image(this.resetOrFlagImage).objectFit(ImageFit.Fill)
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
            this.buttonScale2 = 0.95
            animateTo({
              duration: CommonConstants.ANIMATION_SHORT_DURATION,
              tempo: 1,
              playMode: PlayMode.Normal,
            }, () => {
              if (this.state === 1) {
                this.addFlag()
              } else {
                this.reset();
              }
            }
            )
          })
        }

        Button() {
          Image(this.startOrPauseImage).objectFit(ImageFit.Fill)
            .align(Alignment.Center)
        }
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
          this.buttonScale = 0.95
          animateTo({
            duration: CommonConstants.ANIMATION_SHORT_DURATION,
            tempo: 1,
            playMode: PlayMode.Normal,
          }, () => {
            if (this.state === 1) {
              this.state = 2
            } else {
              this.state = 1
            }
          }
          )
        })

      }.padding(DimensionUtil.getVp($r('app.float.title_horizon_margin')))
      .width(CommonConstants.FULL_LENGTH)
      .justifyContent(FlexAlign.SpaceAround)

    }.height(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}