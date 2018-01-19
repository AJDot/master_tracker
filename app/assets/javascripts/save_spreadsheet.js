App.SaveSpreadsheet = function($table, url) {
  this.$table = $table;
  this.url = url;

  this.save = debounce(this.save.bind(this), 5000);
  this.bindEvents();
};

App.SaveSpreadsheet.prototype = {
  constructor: App.SaveSpreadsheet,

  gatherData: function() {
    var data = [];
    this.$table.find('tbody tr').each(function() {
      var $tr = $(this);
      var $category = $tr.find('.category');
      var $skill = $tr.find('.skill');
      var $description = $tr.find('.description');
      var rowId = $tr.attr('data-id');
      data.push({
        id: rowId,
        category_id: $category.attr('data-id'),
        skill_id: $skill.attr('data-id'),
        description_id: $description.attr('data-id')
      });
    })
    return data;
  },

  save: function(e) {
    e.preventDefault();
    $tr = $(e.currentTarget);
    var data = this.gatherData();

    $.ajax({
      url: this.url,
      type: "PATCH",
      data: { data: data },
      dataType: "json",
      success: function(rows) {
      }.bind(this),
      error: function(json) {
        console.log("Error saving spreadsheet");
      }.bind(this)
    });
  },

  bindEvents: function() {
    this.$table.on("blur.saveSpreadsheet", "tbody tr", this.save.bind(this));
  },
}

$(document).on("turbolinks:load", function() {
  var $table = $('#picker');
  new App.SaveSpreadsheet($table, "/users/" + $table.attr('data-user_id') + "/sheets/" + $table.attr('data-id'));
})
