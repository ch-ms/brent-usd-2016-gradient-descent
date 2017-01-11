var fetch = require('node-fetch');
var cheerio = require('cheerio');

var getUrl = function(page, month) {
  return "https://www.calc.ru/" + page + "?date=2016-" + month
}

var MONTHS = [
  '01', '02', '03',
  '04', '05', '06',
  '07', '08', '09',
  '10', '11', '12'];

var PAGES = ["dinamika-Brent.html", "kotirovka-dollar-ssha.html"]

var data = {}
var processed = 0

PAGES.forEach(
  function(page) {

    data[page] = []
    MONTHS.forEach(
      function(month) {
        fetch(getUrl(page, month))
          .then(function(response){ return response.text() })
          .then(function(text){
            var $ = cheerio.load(text)
            var tdata = {}
            var days = $(".result_table tr td:first-child")
            var values = $(".result_table tr td:last-child")

            for (var i = 0; i < days.length; i++) {
              var day = days[i].children[0].data.trim()
              var value = values[i].children[0].data.trim()
              tdata[day] = +value
            }

            data[page][(+month - 1)] = tdata

            processed++
            if (processed == MONTHS.length * PAGES.length) {
              postProduction(data)
            }
          }).catch(function(error){
            console.log("Error on fetching ", error)
          })
      }
    )

  }
)

function flatten(data) {
  return data.reduce(
    function(acc, cur){ return acc.concat(cur) }, [])
}

function postProduction(data) {
  var p0 = data[PAGES[0]]
  var p1 = data[PAGES[1]]
  var result = p0.map(function(month, i) {
      var res = []
      for(var day in month){
        res.push(day + "," + month[day] + "," + p1[i][day])
      }

      return res
  })

  result = flatten(result)

  result.forEach(function(e){
    console.log(e)
  })
}
