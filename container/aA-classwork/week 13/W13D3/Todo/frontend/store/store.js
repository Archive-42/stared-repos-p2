import { createStore } from 'redux'
import rootReducer from '../reducers/root_reducer'

const configureStore = createStore(rootReducer)

export default configureStore
