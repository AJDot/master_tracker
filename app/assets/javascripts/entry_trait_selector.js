App.EntryTraitSelector = function(tr) {
  this.$tr = $(tr);
  this.$category = this.$tr.find('input[name*="category-"]')
  this.$skill = this.$tr.find('input[name*="skill-"]')
  this.$description = this.$tr.find('input[name*="description-"]')

  this.handleFocusout = debounce(this.handleFocusout.bind(this), 500);
  this.bindEvents();
};

App.EntryTraitSelector.prototype = {
  constructor: App.EntryTraitSelector,

  handleFocusout: function(e) {
    e.preventDefault();
    console.log("Category: ", this.$category.val(), this.$skill.val(), this.$description.val());
  },



  bindEvents: function() {
    this.$tr.on("blur.totalDuration", "input", this.handleFocusout.bind(this));
  },
}

$(document).on("turbolinks:load", function() {
  $("#picker tbody tr").each(function() {
    new App.EntryTraitSelector(this);
  });
});
