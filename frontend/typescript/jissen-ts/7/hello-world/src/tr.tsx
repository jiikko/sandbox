import * as React from 'react'
import { Row } from './data'

const Component: React.FC<Row> = props => (
  <tr>
    <th>{props.age}</th>
    {props.answers.map((answer, i) => {
      if(answer) {
        return <td key={i}>{`${answer * 100}%`}</td>
      } else {
        return <td key={i}>-</td>
      }
    })}
  </tr>
)

export default Component
