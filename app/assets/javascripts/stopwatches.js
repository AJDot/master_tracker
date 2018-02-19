App.Stopwatch = function($stopwatchElement) {
  this.$stopwatch = $stopwatchElement;
  // this.build();
  this.$timeDisplay = this.$stopwatch.find('.time-display');
  this.$startStopBtn = this.$stopwatch.find('.startstop');
  this.$resetBtn = this.$stopwatch.find('.reset');
  this.originalDisplay = this.$timeDisplay.text();
  this.running = false;
  this.time = 0;
  this.elapsed = 0;
  this.bindEvents();
}

App.Stopwatch.prototype = {
  constructor: App.Stopwatch,

  // build: function() {
  //   this.$timeDisplay = $('<td>');
  //   console.log(this.$stopwatch);
  //   this.$stopwatch.append(this.$timeDisplay);
  // },

  startStop: function() {
    if (this.running) {
      this.stop();
      this.resetStartStopBtn();
    } else {
      this.running = true;
      this.$startStopBtn.text("Stop");
      this.time = performance.now();
      requestAnimationFrame(this.step.bind(this));
    }
  },

  step: function(timestamp) {
    if (!this.running) { return; }
    this.elapsed += this.timePassed(timestamp);
    this.$timeDisplay.text(this.format(this.elapsed));
    requestAnimationFrame(this.step.bind(this));
  },

  timePassed: function(timestamp) {
    var diff = timestamp - this.time;
    this.time = timestamp;
    return diff;
  },

  stop: function() {
    this.running = false;
  },

  reset: function() {
    this.elapsed = 0;
    this.time = 0;
    this.running = false;
    this.resetStartStopBtn();
    this.$timeDisplay.text(this.originalDisplay);
  },

  resetStartStopBtn: function() {
    this.$startStopBtn.text("Start");
  },

  format: function(duration) {
    var date = new Date(duration);
    var hours = padStartZeroes(date.getUTCHours(), 2);
    var minutes = padStartZeroes(date.getUTCMinutes(), 2);
    var seconds = padStartZeroes(date.getUTCSeconds(), 2);

    return hours + ":" + minutes + ":" + seconds;
  },

  bindEvents: function() {
    this.$startStopBtn.on("click", this.startStop.bind(this));
    this.$resetBtn.on("click", this.reset.bind(this));
  },
}

$(document).on("turbolinks:load", function() {
  var $stopwatches = $('.stopwatch');
  $stopwatches.each(function() {
    new App.Stopwatch($(this));
  })
});
