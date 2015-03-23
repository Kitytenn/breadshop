var EventEmitter = require('events').EventEmitter;
var assign = require('object-assign');
var CHANGE_EVENT = 'change';

var _products = { rustic: { name: "Rustic" },
                  bagels: { name: "Bagels" },
                  baguette: { name: "Baguettes" },
                  pain: { name: "Pain a l'Ancienne" }
                };

function fetch(name) {
  _products[name] = {
    name: name,
    quantity: 4
  };
}

var ProductStore = assign({}, EventEmitter.prototype, {

  emitChange: function() {
    this.emit(CHANGE_EVENT);
  },

  /**
   * @param {function} callback
   */
  addChangeListener: function(callback) {
    this.on(CHANGE_EVENT, callback);
  },

  removeChangeListener: function(callback) {
    this.removeListener(CHANGE_EVENT, callback);
  },

  get: function(id) {
    return _products[id];
  },

  getAll: function() {
    return _products;
  },

});

module.exports = ProductStore;
