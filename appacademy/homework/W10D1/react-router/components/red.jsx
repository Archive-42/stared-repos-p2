import React from 'react'
import { NavLink, Route } from 'react-router-dom'
import Orange from './orange'
import Yellow from './yellow'

class Red extends React.Component {
  render() {
    return (
      <div>
        <h2 className="red" />
        <NavLink to="/red" exact>
          Red only
        </NavLink>
        <NavLink to="/red/yellow">Add Yellow</NavLink>
        <NavLink to="/red/orange">Add Orange</NavLink>

        <Route path="/red/orange" component={Orange} />
        <Route path="/red/yellow" component={Yellow} />
      </div>
    )
  }
}

export default Red
