import React from 'react';

type Props = {
  name: string;
}

const Heading = (props: Props) => {
  const { name } = props;
  return <h1>{`Hello ${name} World!`}</h1>;
};


export default Heading;
