var React = require('react');

var OrderForm = React.createClass({
  getInitialState: function() {
    return {
      isComplete: false
    };
  },

  render: function() {
    return (
      <div>
        How many {this.props.name}s do you want?
        <a href="" onClick={this._cancel}>Cancel</a>
        </div>
    );
  },

  _cancel: function(e) {
    e.preventDefault();
    this.props.onCancel();
  }
});

module.exports = OrderForm;
