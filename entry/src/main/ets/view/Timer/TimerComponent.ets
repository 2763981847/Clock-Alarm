import { TimerConstants } from '../../common/constant/TimerConstants'
import DimensionUtil from '../../common/util/DimensionUtils'
import reminderAgent from '@ohos.reminderAgentManager';
import { CommonConstants } from '../../common/constant/CommonConstants';

@Component
export default struct TimerComponent {
  private textTimerController: TextTimerController
  private count: number = 0
  private onCountOver: () => void
  private reminderRequestTimer: reminderAgent.ReminderRequestTimer = {
    reminderType: 0,
    title: "计时已到时",
    ringDuration: 10,
    snoozeTimes: 1,
    actionButton: [
      {
        title: '关闭',
        type: reminderAgent.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
      },
    ],
    wantAgent: {
      pkgName: CommonConstants.BUNDLE_NAME,
      abilityName: CommonConstants.ABILITY_NAME
    },
    triggerTimeInSeconds: 1
  }
  @State restTimeContainer: Array<number> = [this.count]

  build() {
    Stack({ alignContent: Alignment.Center }) {
      TextTimer({ isCountDown: true, count: this.count, controller: this.textTimerController })
        .format(TimerConstants.TIMER_FORMAT)
        .fontSize($r('app.float.stop_watch_font_size'))
        .onTimer((_utc: number, elapsedTime: number) => {
          let restTime = this.count - elapsedTime
          if (restTime <= 0) {
            reminderAgent.publishReminder(this.reminderRequestTimer)
            this.onCountOver();
          }
          this.restTimeContainer = [restTime]

        })
        .padding({
          bottom: DimensionUtil.getVp($r('app.float.new_alarm_button_margin_vertical')),
          top: DimensionUtil.getVp($r('app.float.new_alarm_button_margin_vertical'))
        })

      DataPanel({ values: this.restTimeContainer, max: this.count, type: DataPanelType.Circle })
        .closeEffect(true).width(400).height(400)
    }
    .onAppear(() => this.textTimerController.start())
  }
}