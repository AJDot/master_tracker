$(function() {
  var toggle = '[data-toggle=dropdown]'

  var Dropdown = function(element) {
    this.$toggle = $(element);
    this.$parent = this.$toggle.parent();
    this.$parent.removeClass('open');

    this.bindEvents();
  }

  Dropdown.prototype = {
    constructor: Dropdown,

    toggle: function(e) {
      e.preventDefault();
      this.$parent.toggleClass('open');
    },

    bindEvents: function() {
      this.$toggle.on('click.dropdown', this.toggle.bind(this));
    },
  }

  $(toggle).each(function() {
    console.log(this);
    new Dropdown(this);
  });
});
