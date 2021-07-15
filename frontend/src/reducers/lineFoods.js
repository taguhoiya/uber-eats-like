import { REQUEST_STATE } from '../constants';

export const initialState = {
  fetchState: REQUEST_STATE.INITIAL, // 取得状況
  postState: REQUEST_STATE.INITIAL,  // 登録状況
  lineFoodsSummary: null,            // 仮注文データ
};

export const lineFoodsActionTypes = {
  FETCHING: 'FETCHING',
  FETCH_SUCCESS: 'FETCH_SUCCESS',
  POSTING: 'POSTING',
  POST_SUCCESS: 'POST_SUCCESS',
}

export const lineFoodsReducer = (state, action) => {
  switch (action.type) {
    case lineFoodsActionTypes.FETCHING:  // 仮注文取得中
      return {
        ...state,
        fetchState: REQUEST_STATE.LOADING, 
      };
    case lineFoodsActionTypes.FETCH_SUCCESS: // 仮注文取得完了
      return {
        fetchState: REQUEST_STATE.OK,
        lineFoodsSummary: action.payload.lineFoodsSummary, 
      };
    case lineFoodsActionTypes.POSTING: // 仮注文登録中
      return {
        ...state,
        postState: REQUEST_STATE.LOADING, 
      };
    case lineFoodsActionTypes.POST_SUCCESS: // 仮注文登録完了 
      return {
        ...state,
        postState: REQUEST_STATE.OK,
      };
    default:
      throw new Error();
  }
}