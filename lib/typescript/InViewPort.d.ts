import { PureComponent } from 'react';
export default class InViewPort extends PureComponent {
    constructor(props: any);
    componentDidMount(): void;
    componentWillUnmount(): void;
    UNSAFE_componentWillReceiveProps(nextProps: any): void;
    startWatching(): void;
    stopWatching(): void;
    isInViewPort(): void;
    render(): JSX.Element;
}
