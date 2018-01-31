App.EntryTraitSelector = function($tr, url) {
  this.$tr = $tr;
  this.url = url;
  this.$category = this.$tr.find('input.category');
  this.$skill = this.$tr.find('input.skill');
  this.$description = this.$tr.find('input.description');
  this.$durationTd = this.$tr.find('.duration-total');
  this.$durationTodayTd = this.$tr.find('.duration-today');
  this.$durationYesterdayTd = this.$tr.find('.duration-yesterday');
  this.$durationMonthTd = this.$tr.find('.duration-month');

  this.handleFocusout = debounce(this.handleFocusout.bind(this), 500);
  this.bindEvents();
  this.fetchAndDisplayDurations();
};

App.EntryTraitSelector.prototype = {
  constructor: App.EntryTraitSelector,

  handleFocusout: function(e) {
    e.preventDefault();
    this.fetchAndDisplayDurations();
  },

  fetchAndDisplayDurations: function() {
    this.getInputValues();
    this.fetchEntries(this.inputValues, function(entries) {
      this.entries = entries;
      this.setAllDurations();
      this.displayAllDurations();
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

  setAllDurations: function() {
    this.totalDuration = sumProps(this.entries["all_time"], "duration");
    this.durationToday = sumProps(this.entries["today"], "duration");
    this.durationYesterday = sumProps(this.entries["yesterday"], "duration");
    this.durationMonth = sumProps(this.entries["this_month"], "duration");
  },

  displayAllDurations: function() {
    if (this.totalDuration === 0 && !this.hasJQueryValue(["$category", "$skill", "$description"])) {
      this.$durationTd.text("");
      this.$durationTodayTd.text("");
      this.$durationYesterdayTd.text("");
      this.$durationMonthTd.text("");
    } else {
      this.$durationTd.text(mmToHHMM(this.totalDuration));
      this.$durationTodayTd.text(mmToHHMM(this.durationToday));
      this.$durationYesterdayTd.text(mmToHHMM(this.durationYesterday));
      this.$durationMonthTd.text(mmToHHMM(this.durationMonth));
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
