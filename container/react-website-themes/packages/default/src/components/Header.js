import React from 'react';
import PropTypes from 'prop-types';
import { cx } from 'emotion';

import style from '../styles/header';

const Header = props => {
  const { children, themeStyle = style, customStyle = '' } = props;

  return <header className={cx(themeStyle, customStyle)}>{children}</header>;
};

Header.propTypes = {
  children: PropTypes.node,
  themeStyle: PropTypes.string,
  customStyle: PropTypes.string,
};

export default Header;
