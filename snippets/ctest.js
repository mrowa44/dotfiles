import React from 'react';
import toJson from 'enzyme-to-json';
import { shallow } from 'enzyme';

import X from './X';

describe('X', () => {
  test('renders correctly', () => {
    const component = shallow((
      <X />
    ));
    expect(toJson(component)).toMatchSnapshot();
  });
});
