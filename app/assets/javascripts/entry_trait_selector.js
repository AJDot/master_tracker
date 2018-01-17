App.EntryTraitSelector = function($tr, url) {
  this.$tr = $tr;
  this.url = url;
  this.$category = this.$tr.find('input[name*="category-"]');
  this.$skill = this.$tr.find('input[name*="skill-"]');
  this.$description = this.$tr.find('input[name*="description-"]');
  this.$durationTd = this.$tr.find('td.duration-total');

  this.handleFocusout = debounce(this.handleFocusout.bind(this), 500);
  this.bindEvents();
};

App.EntryTraitSelector.prototype = {
  constructor: App.EntryTraitSelector,

  handleFocusout: function(e) {
    e.preventDefault();
    this.getInputValues();
    this.fetchEntries(this.inputValues, function(entries) {
      this.totalDuration = sumProps(entries, "duration");
      this.displayTotalDuration();
    }.bind(this));
  },

  getInputValues: function() {
    this.inputValues = {
      category: this.$category.val(),
      skill: this.$skill.val(),
      description: this.$description.val(),
    };
  },

  hasJQueryValue: function(props) {
    var allExist, allHaveLength, allHaveValue;
    var allPropNames = Object.getOwnPropertyNames(this);
    allExist = props.every(function(prop) {
      return allPropNames.includes(prop);
    });

    if (allExist) {
      allHaveLength = props.every(function(prop) {
        return this[prop].length > 0;
      }.bind(this));
    } else {
      return false;
    }

    if (allHaveLength) {
      allHaveValue = props.every(function(prop) {
        return this.hasValue(this[prop]);
      }.bind(this));
    } else {
      return false;
    }

    return allHaveValue;
  },

  hasValue: function($el) {
    return $el.val() !== "";
  },

  displayTotalDuration: function() {
    this.$durationTd.text(this.totalDuration || "No Match");
  },

  fetchEntries: function(query, callback) {
    $.ajax({
      url: this.url,
      type: "GET",
      data: query,
      success: function(json) {
        callback(json);
      },
      error: function(json) {
        console.log("There was a problem processing the request.");
      }
    });
  },

  bindEvents: function() {
    this.$tr.on("blur.totalDuration", "input", this.handleFocusout.bind(this));
  },
}

$(document).on("turbolinks:load", function() {
  $("#picker tbody tr").each(function() {
    new App.EntryTraitSelector($(this), "/api/v1/entries.json");
  });
});
