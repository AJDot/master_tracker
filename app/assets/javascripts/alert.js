$(function() {
  var Alert = {
    removeAlert: function(e) {
      e.preventDefault();
      var $target = $(e.currentTarget);
      var className = $target.attr('data-dismiss')
      var $toClose = $target.closest('.' + className);
      $toClose.remove();
    },

    bindEvents: function() {
      $('[data-dismiss]').on('click', this.removeAlert.bind(this));
    },

    init: function() {
      this.bindEvents();
    },
  }

  Alert.init();
});
