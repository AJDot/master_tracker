App.AutoLister = function($input, url) {
  this.$input = $input;
  this.url = url;

  this.$listUI = null;
  this.selectedIndex = null;
  this.valueChanged = debounce(this.valueChanged.bind(this), 300);
  this.wrapInput();
  this.createUI();
  this.bindEvents();
  this.reset();
};

App.AutoLister.prototype = {
  constructor: App.AutoLister,

  wrapInput: function() {
    var $wrapper = $('<div class="input-wrapper"></div>');

    this.$input.wrap($wrapper);
  },

  createUI: function() {
    var $listUI = $('<ul class="autocomplete-ui"></ui>')
    this.$input.after($listUI);
    $listUI.hide();
    this.$listUI = $listUI;
  },

  draw: function() {
    this.$listUI.show().children().remove();
    this.matches.forEach(function(match) {
      var $li = $('<li class="autocomplete-ui-choice"></li>');
      $li.text(match);
      this.$listUI.append($li)
    }.bind(this));
  },

  valueChanged: function() {
    var value = this.$input.val();
    if (value.length > 0) {
      this.fetchMatches(value, 3, function(matches) {
        this.matches = matches;
        this.selectedIndex = null;
        this.draw();
      }.bind(this))
    } else {
      this.reset();
    }
  },

  keydown: function(e) {
    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        if (this.matches.length > 0) {
          if (this.selectedIndex === null) {
            this.selectedIndex = -1;
          }
          this.select(this.selectedIndex + 1);
          this.scrollToSelected();
        }
        break;
      case 'ArrowUp':
        e.preventDefault();
        if (this.matches.length > 0) {
          if (this.selectedIndex === null) {
            this.selectedIndex = this.matches.length;
          }
          this.select(this.selectedIndex - 1);
          this.scrollToSelected();
        }
        break;
      case 'Enter':
        e.preventDefault();
        e.stopPropagation();
        if (this.$selected) {
          this.$input.val(this.$selected.text());
          this.$input.trigger("blur.selectTrait")
          this.reset();
        // } else {
        //   this.reset();
        //   this.fetchMatches("", null, function(matches) {
        //     this.matches = matches;
        //     this.draw();
        //   }.bind(this))
        }
        break;
      case 'Tab':
        if (this.$selected) {
          this.$input.val(this.$selected.text());
        }
        break;
      case 'Escape':
        e.preventDefault();
        this.$input.blur();
        this.reset();
    }
  },

  gainFocus: function(e) {
    e.preventDefault();
    this.reset();
    this.fetchMatches("", null, function(matches) {
      this.matches = matches;
      this.draw();
    }.bind(this))
  },

  loseFocus: function(e) {
    e.preventDefault();
    if (this.$listUI.is(":hover")) {
      return;
    } else {
      this.reset();
    }
  },

  fetchMatches: function(query, limit, callback) {
    $.ajax({
      url: this.url,
      type: "GET",
      data: {
        query: query,
        limit: limit
      },
      success: function(json) {
        callback(json);
      },
      error: function(json) {
        console.log("This didn't work");
      }
    });
  },

  select: function(newIndex) {
    var $items = this.$listUI.children();

    this.selectedIndex = wrapNumber(newIndex, this.matches.length);

    $items.each(function(itemIndex, item) {
      if (itemIndex === this.selectedIndex) {
        $(item).addClass('selected');
        this.$selected = $(item);
      } else {
        $(item).removeClass('selected');
      }
    }.bind(this));
  },

  clickMatch: function(e) {
    e.preventDefault();
    this.select($(e.target).index());
    this.$input.trigger({
      type: 'keydown',
      which: 13,
      key: 'Enter',
    });
    // this.reset();
  },

  scrollToSelected: function() {
    var $selected = this.$listUI.find('.selected');
    var top = this.$listUI.scrollTop();
    this.$listUI.scrollTop(top + $selected.position().top);
  },

  reset: function() {
    this.matches = [];
    this.selectedIndex = null;
    this.$selected = null;
    this.$listUI.hide();
  },

  bindEvents: function() {
    this.$input.on('input', this.valueChanged.bind(this));
    this.$input.on('keydown', this.keydown.bind(this));
    this.$input.on('focusin.selectTrait', this.gainFocus.bind(this));
    this.$input.on('focusout.selectTrait', this.loseFocus.bind(this));
    this.$listUI.on('click.selectTrait', 'li', this.clickMatch.bind(this));
  }
};

$(document).on("turbolinks:load", function() {
  var $categoryInputs = $('input[name*="category-"]');
  $categoryInputs.each(function(index, input) {
    new App.AutoLister($(input), "/categories.json");
  });

  var $skillInputs = $('input[name*="skill-"]');
  $skillInputs.each(function(index, input) {
    new App.AutoLister($(input), "/skills.json");
  });

  var $descriptionInputs = $('input[name*="description-"]');
  $descriptionInputs.each(function(index, input) {
    new App.AutoLister($(input), "/descriptions.json");
  });
});
