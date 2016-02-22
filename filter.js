var filter = function(array, fn) {
  var result = [];
  for (var i = 0; i < array.length; i++) {
    if ( fn(array[i]) ) {
      result.push(array[i]);
    }
  }
  return result;
};

var isEven = function (x) { return x % 2 == 0; };
filter([1, 2, 3, 4], isEven); // => [2, 4]
