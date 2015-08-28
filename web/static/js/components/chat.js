export default class Chat extends React.Component {
  constructor(props) {
    super(props)
    this.state = { count: this.props.count }
  }

  handleClick() {
    this.setState({count: this.state.count + 1})
  }

  render() {
    return (
      <h1 onClick={this.handleClick.bind(this)}>It's working! {this.state.count}</h1>
    )
  }
}
