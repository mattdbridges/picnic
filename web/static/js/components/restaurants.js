export default class Restaurants extends React.Component {
  constructor(props) {
    super(props)
    this.state = { list: [] }
  }

  componentDidMount() {
    $.get(this.props.source, (data) => {
      this.setState({
        list: data["data"]
      })
    })
  }

  render() {
    let restaurants = this.state.list.map((r) => {
      return <li key={r.id}>{r.name}</li>
    })
    return <ul>{restaurants}</ul>
  }
}
