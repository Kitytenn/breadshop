var React = require('react');
var ReactPropTypes = React.PropTypes;
var ProductItem = require('./ProductItem.react');

var MainSection = React.createClass({
  propTypes: {
    allProducts: ReactPropTypes.object.isRequired
  },

  render: function() {
    if (Object.keys(this.props.allProducts).length < 1) {
      return null;
    }

    var allProducts = this.props.allProducts;
    var products = [];

    for (var key in allProducts) {
      products.push(<ProductItem key={key} product={allProducts[key]} name={key} />);
    }

    return (
      <section id="main">
        <div id="product-list">{products}</div>
      </section>
    );
  },
});

module.exports = MainSection;
