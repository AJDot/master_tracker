App.SaveSpreadsheet = function($table, url) {
  this.$table = $table;
  this.url = url;

  this.$saveStatus = $('#save_status');
  this.saveInterval = null;
  this.successTimout = null;
  this.emptySuccessTimeout = null;

  this.gatherData();
  this.previous = this.current;

  this.createInterval();
};

App.SaveSpreadsheet.prototype = {
  constructor: App.SaveSpreadsheet,

  gatherData: function() {
    var data = [];
    this.current = [];
    this.$table.find('.row.body').each(function(index, tr) {
      var $tr = $(tr);
      var categoryId = $tr.find('.category').attr('data-id');
      var skillId = $tr.find('.skill').attr('data-id');
      var descriptionId = $tr.find('.description').attr('data-id');
      var rowId = $tr.attr('data-id');
      data.push({
        id: rowId,
        category_id: categoryId,
        skill_id: skillId,
        description_id: descriptionId
      });
      // this.current.push(rowId, categoryId, skillId, descriptionId);
      this.pushToCurrent(rowId, categoryId, skillId, descriptionId);
    }.bind(this));
    return data;
  },

  pushToCurrent: function() {
    data = [].slice.call(arguments);
    [].push.apply(this.current, data);
  },

  save: function() {
    this.data = this.gatherData();

    if (!equalArrays(this.current, this.previous)) {
      $.ajax({
        url: this.url,
        type: "PATCH",
        data: { data: this.data },
        dataType: "json",
        beforeSend: function() {
          this.$saveStatus.text("Saving spreadsheet...");
        }.bind(this),
        success: function(rows) {
          this.previous = this.current;
          this.current = [];

          if (this.successTimout) {
            clearTimeout(this.successTimout);
          }
          this.successTimout = setTimeout(function() {
            this.$saveStatus.text("Changes were saved.");
          }.bind(this), 1000);

          if (this.emptySuccessTimeout) {
            clearTimeout(this.emptySuccessTimeout);
          }
          this.emptySuccessTimeout = setTimeout(function() {
            this.$saveStatus.text("");
          }.bind(this), 6000);
        }.bind(this),
        error: function(json) {
          this.$saveStatus.text("Error saving changes.");
        }.bind(this)
      });
    }
  },
  createInterval: function() {
    this.saveInterval = setInterval(this.save.bind(this), 5000);
  },

  removeInterval: function() {
    if (this.saveInterval) {
      clearInterval(this.saveInterval);
    }
  }
}

var saver;
$(document).on("turbolinks:load", function() {
  var path = window.location.pathname;
  var userId = path.split("/")[2];
  var spreadsheetId = path.split("/")[4];

  var $table = $('#picker');
  if ($table.length > 0) {
    saver = new App.SaveSpreadsheet($table, "/users/" + userId + "/sheets/" + spreadsheetId);
  }
});

$(document).on("turbolinks:before-cache", function() {
  if (saver) {
    saver.removeInterval();
    saver = null;
  }
});

$(document).on("turbolinks:before-render", function() {
  if (saver) {
    saver.removeInterval();
    saver = null;
  }
});
