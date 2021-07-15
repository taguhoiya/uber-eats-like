import axios from 'axios';
import { restaurantsIndex } from '../urls/index'

// axios.getして、URL文字列にHTTPリクエストを投げた結果成功した場合はthen(...)にいき、失敗・例外が帰ってきた場合はcatch(...)へと入ります。

export const fetchRestaurants =() => {
  return axios.get(restaurantsIndex)
  .then(res => {
    return res.data
  })
  .catch((e) => console.error(e))
}