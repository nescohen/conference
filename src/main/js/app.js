'use strict';

// tag::vars[]
const React = require('react');
const ReactDOM = require('react-dom');
const client = require('./client');
// end::vars[]

// tag::app[]
class App extends React.Component {

    constructor(props) {
        super(props);
        this.state = {events: []};
    }

    componentDidMount() {
        client({method: 'GET', path: '/api/events'}).done(response => {
            this.setState({events: response.entity._embedded.events});
        });
    }

    render() {
        return (
            <EventList events={this.state.events}/>
        )
    }
}
// end::app[]

// tag::event-list[]
class EventList extends React.Component{
    render() {
        const events = this.props.events.map(event =>
            <Event key={event._links.self.href} event={event}/>
        );
        return (
            <table>
                <tbody>
                <tr>
                    <th>Event</th>
                    <th>Location</th>
                    <th>Start</th>
                    <th>End</th>
                </tr>
                {events}
                </tbody>
            </table>
        )
    }
}
// end::event-list[]

// tag::event[]
class Event extends React.Component{
    render() {
        return (
            <tr>
                <td>{this.props.event.name}</td>
                <td>{this.props.event.location.name}</td>
                <td>{this.props.event.startDate}</td>
                <td>{this.props.event.endDate}</td>

            </tr>
        )
    }
}
// end::event[]

// tag::render[]
ReactDOM.render(
    <App />,
    document.getElementById('react')
)
// end::render[]
