var MainSection = require('./MainSection.react');
var React = require('react');
var ProductStore = require('../stores/ProductStore');

function getProductState() {
  return {
    allProducts: ProductStore.getAll()
  };
}

var BreadApp = React.createClass({
  getInitialState: function() {
    return getProductState();
  },

  render: function() {
    return (
        <MainSection
      allProducts={this.state.allProducts}
        />
    );
  }
});

module.exports = BreadApp;
