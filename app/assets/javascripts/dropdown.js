App.Dropdown = function(element) {
  this.$toggle = $(element);
  this.$parent = this.$toggle.parent();
  this.$parent.removeClass('open');

  this.bindEvents();
};

App.Dropdown.prototype = {
  constructor: App.Dropdown,

  toggle: function(e) {
    e.preventDefault();
    this.$parent.toggleClass('open');
  },

  bindEvents: function() {
    this.$toggle.on('click.dropdown', this.toggle.bind(this));
  },
};

$(document).on("turbolinks:load", function() {
  var toggle = '[data-toggle=dropdown]';
  $(toggle).each(function() {
    new App.Dropdown(this);
  });
});
