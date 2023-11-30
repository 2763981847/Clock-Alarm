import { CommonConstants } from '../common/constant/CommonConstants'
import WorldClockConstants from '../common/constant/WorldClockConstants'
import ClockArea from '../view/WorldClock/ClockArea'
import HeaderContainer from '../view/HeaderContainer'

@Component
export default struct WorldClockPage {
  build() {
    Column() {
      HeaderContainer({ title: WorldClockConstants.WORLD_CLOCK }) {

      }

      ClockArea()
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}