App.SaveRow = function($table, url) {
  this.$table = $table;
  this.url = url;

  this.save = debounce(this.save.bind(this), 5000);
  this.bindEvents();
};

App.SaveRow.prototype = {
  constructor: App.SaveRow,

  // gatherData: function($tr) {
  gatherData: function() {
    // var $category = $tr.find('[name*="category-"]');
    // var $skill = $tr.find('[name*="skill-"]');
    // var $description = $tr.find('[name*="description-"]');
    // return {
    //   category: $category.val(),
    //   skill: $skill.val(),
    //   description: $description.val()
    // };
    var data = [];
    this.$table.find('tbody tr').each(function() {
      var $tr = $(this);
      var $category = $tr.find('[name*="category-"]');
      var $skill = $tr.find('[name*="skill-"]');
      var $description = $tr.find('[name*="description-"]');
      var id = $tr.attr('data-id');
      data.push({
        id: id,
        category: $category.val(),
        skill: $skill.val(),
        description: $description.val()
      });
    })
    return data;
  },

  save: function(e) {
    e.preventDefault();
    $tr = $(e.currentTarget);
    // var data = this.gatherData($tr);
    var data = this.gatherData();

    $.ajax({
      // url: this.url + "/rows/" + $tr.attr('data-id'),
      url: this.url,
      type: "PATCH",
      data: { data: data },
      dataType: "json",
      success: function(rows) {
        // this.notifySuccessfulSave();
      }.bind(this),
      error: function(json) {
        // this.notifyUnsuccessfulSave();
        // console.log("Error saving row");
        console.log("Error saving spreadsheet");
      }.bind(this)
    });
  },

  bindEvents: function() {
    // this.$table.on("blur.saveRow", "tbody tr", this.save.bind(this));
    this.$table.on("blur.saveSpreadsheet", "tbody tr", this.save.bind(this));
  },
}

$(document).on("turbolinks:load", function() {
  var $table = $('#picker');
  new App.SaveRow($table, "/spreadsheets/" + $table.attr('data-id'));
})
