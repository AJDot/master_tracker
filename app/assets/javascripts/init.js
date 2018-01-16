if (window.App === undefined) {
  window.App = {};
}

App.init = function() { };

$(document).on('turbolinks:load', App.init);
