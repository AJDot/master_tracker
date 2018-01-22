App.EntryTraitSelector = function($tr, url) {
  this.$tr = $tr;
  this.url = url;
  this.$category = this.$tr.find('input.category');
  this.$skill = this.$tr.find('input.skill');
  this.$description = this.$tr.find('input.description');
  this.$durationTd = this.$tr.find('.duration-total');

  this.handleFocusout = debounce(this.handleFocusout.bind(this), 500);
  this.bindEvents();
  this.fetchAndDisplayTotalDuration();
};

App.EntryTraitSelector.prototype = {
  constructor: App.EntryTraitSelector,

  handleFocusout: function(e) {
    e.preventDefault();
    this.fetchAndDisplayTotalDuration();
  },

  fetchAndDisplayTotalDuration: function() {
    this.getInputValues();
    this.fetchEntries(this.inputValues, function(entries) {
      this.totalDuration = sumProps(entries, "duration");
      this.displayTotalDuration();
    }.bind(this));
  },

  getInputValues: function() {
    this.inputValues = {
      category: {
        id: this.$category.attr('data-id'),
        value: this.$category.val()
      },
      skill: {
        id: this.$skill.attr('data-id'),
        value: this.$skill.val()
      },
      description: {
        id: this.$description.attr('data-id'),
        value: this.$description.val()
      }
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
    if (this.totalDuration === 0 && !this.hasJQueryValue(["$category", "$skill", "$description"])) {
      this.$durationTd.text("");
    } else {
      this.$durationTd.text(mmToHHMM(this.totalDuration));
    }
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

App.CreateEntryTraitSelectors = function() {
  var path = window.location.pathname;
  var userId = path.split("/")[2];
  $("#picker .row.body").each(function() {
    new App.EntryTraitSelector($(this), "/api/v1/users/" + userId + "/entries.json");
  });
}

$(document).on("turbolinks:load", function() {
  App.CreateEntryTraitSelectors();
});
