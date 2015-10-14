var React = require('react');
var Relay = require('react-relay');

Relay.injectNetworkLayer(
  new Relay.DefaultNetworkLayer(window.location.origin + '/graphql', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
    credentials: 'same-origin',
  })
);

var FairiesDemo = React.createClass({
  displayName: 'FairiesDemo',
  propTypes: {
    viewer: React.PropTypes.shape({
      fairies: React.PropTypes.shape({
        edges: React.PropTypes.arrayOf(React.PropTypes.shape({
          node: React.PropTypes.shape({
            name: React.PropTypes.string
          })
        })),
        pageInfo: React.PropTypes.shape({
          hasNextPage: React.PropTypes.bool
        })
      }),
    }),
    relay: React.PropTypes.shape({
      setVariables: React.PropTypes.func,
      variables: React.PropTypes.shape({
        count: React.PropTypes.number
      })
    })
  },
  onClick: function(e) {
    e.preventDefault();
    this.props.relay.setVariables({
      count: this.props.relay.variables.count + 4
    });
  },
  render: function() {
    if(!this.props.viewer || !this.props.viewer.fairies) { return <div>No Fairies Available Today</div>; }
    return (
      <div>
        {'Fairies'}
        <ul>
        {
          this.props.viewer.fairies.edges.map((fairyEdge) =>
            <li>{fairyEdge.node.name}</li>
          )
        }
        </ul>
        {
          this.props.viewer.fairies.pageInfo.hasNextPage &&
          <button onClick={this.onClick}>Load More</button>
        }
      </div>
    );
  }
});

var FairyContainer = Relay.createContainer(FairiesDemo, {
  initialVariables: {count: 2},
  fragments: {
    viewer: () => Relay.QL`fragment on Viewer {
      fairies(first: $count) {
        edges {
          node {
            ... on Fairy {
              name
            }
          }
        }
        pageInfo { hasNextPage }
      }
    }`,
  },
});

class FairiesHomeRoute extends Relay.Route {
  static routeName = 'FairiesHomeRoute';
  static queries = {
    viewer: () => Relay.QL`query { viewer }`,
  };
};


var FairyRelay = React.createClass({
  displayName: 'FairyRelay',
  render: function() {
    return (
      <Relay.RootContainer
        Component={FairyContainer}
        route={new FairiesHomeRoute() }
      />
    );
  }
});

module.exports = FairyRelay;