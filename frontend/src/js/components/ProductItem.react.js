var React = require('react');
var ReactPropTypes = React.PropTypes;
var OrderForm = require('./OrderForm.react');

var cx = require('classnames');

var ProductItem = React.createClass({
  propTypes: {
    product: ReactPropTypes.object.isRequired
  },

  getInitialState: function() {
    return {
      quantity: 0,
      isOrdering: false
    };
  },

  render: function() {
    var product = this.props.product;
    var name = this.props.name;
    var divClasses = cx('bread', name);
    var linkClasses = cx({ order: !this.state.isOrdering },
                         { ordering: this.state.isOrdering });

    var content;
    if (this.state.isOrdering) {
      content =
        <OrderForm
      onCancel={this._onCancel}
      name={name}
        />;
    } else {
      content = "Order now";
    }

    return (
      <div className={divClasses}>
        <h1>{product.name}</h1>
        <div className={linkClasses} onClick={this._onClick}>{content}</div>
      </div>
    );
  },

  _onClick: function() {
    if (!this.state.isOrdering) {
      this.setState({isOrdering: true});
    }
  },

  _onCancel: function() {
    this.setState({isOrdering: false});
  }
});

module.exports = ProductItem;
