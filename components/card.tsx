import { ReactNode } from 'react';

export const Card = (props: { children: ReactNode }) => (
  <div className="card">{props.children}</div>
);

export const CardContent = (props: { children: ReactNode }) => (
  <div className="card-content gap-2">{props.children}</div>
);
