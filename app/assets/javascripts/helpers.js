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

function divmod(dividend, divisor) {
  var remainder, times;
  dividend = Math.abs(dividend);
  divisor = Math.abs(divisor);
  if (divisor === 0) { return null; }

  quotient = parseInt(dividend / divisor, 10);
  times = divisor * quotient;
  remainder = dividend - times;
  return [quotient, Number(remainder.toFixed(6))];
}

function mmToHHMM(mm) {
  mm = Number(mm);
  var hhmm = divmod(mm, 60);
  if (hhmm === null) { return 0; }
  return String(hhmm[0]).padStart(2, "0") + ":" + String(hhmm[1]).padStart(2, "0");
}

// Works for arrays or arrays of arrays, no regular objects
equalArrays = function(array1, array2) {
  // if the other array is a falsy value, return
  if (!array1 || !array2) { return false; }

  // compare lengths - can save a lot of time
  if (array1.length != array2.length) { return false; }

  for (var i = 0, l = array1.length; i < l; i++) {
    // Check if we have nested arrays
    if (array1[i] instanceof Array && array2[i] instanceof Array) {
      // recurse into the nested arrays
      if (!equalArrays(array1[i], array2[i])) { return false; }
    }
    else if (array1[i] != array2[i]) {
      // Warning - two different object instances will never be equal: {x:20} != {x:20}
      return false;
    }
  }
  return true;
}

function padStartZeroes(number, count) {
  return String(number).padStart(count, "0");
}
