import React from 'react';
import styles from '../css/heading.css';

type Props = {
  name: string
};

const Heading = (props: Props) => {
  const { name } = props;
  return <h1 className={styles.text}>{`Hello ${name} World!`}</h1>;
};

export default Heading;
