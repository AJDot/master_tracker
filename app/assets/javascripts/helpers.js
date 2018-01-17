function wrapNumber(number, end) {
  // 0 to end (exclusive)
  var number;
  number = number % end;

  if (number < 0) { number = end + number; }
  return number;
}

function sumProps() {
  var args = [].slice.call(arguments);
  var data = args.shift();
  var props = args;
  var sum = 0;

  data.forEach(function(datum) {
    props.forEach(function(prop) {
      if (Object.prototype.hasOwnProperty.call(datum, prop)) {
        if (typeof datum[prop] == "number") {
          sum += datum[prop];
        }
      }
    });
  });

  return sum;
}
