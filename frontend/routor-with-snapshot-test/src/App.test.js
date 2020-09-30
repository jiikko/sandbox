import React from 'react';
import App from './App';
import { mount } from 'enzyme'
import { MemoryRouter, Router } from "react-router-dom"
import { render, fireEvent } from '@testing-library/react'
import '@testing-library/jest-dom/extend-expect'
import { createMemoryHistory } from 'history'

// test('renders learn react link', () => {
//   const { getByText } = render(<App />);
//   const linkElement = getByText(/learn react/i);
//   expect(linkElement).toBeInTheDocument();
// });

it('with routing', () => {
  const body = render(
  // const o = mount(
    <MemoryRouter initialEntries={['/a']}>
      <App/>
    </MemoryRouter>
  )
  console.log(body.debug())
  // expect(o.find(".testTarget").length).toBe(1)
});

it('a', () => {
  const history = createMemoryHistory()
  history.push('/a');
  const body = render(
    <Router history={history}>
      <App/>
    </Router>
  )
  console.log(body.debug())
})
