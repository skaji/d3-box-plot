# d3 box plot

Based on
[エンジニアのための データ可視化[実践]入門](http://www.amazon.co.jp/dp/4774163260) section 10.10

![box](https://raw.githubusercontent.com/shoichikaji/d3-box-plot/master/misc/screenshot.png)

### usage

`data.csv`

    kind,label,min,q1,med,q3,max,mean
    A,a,26,52,78,104,130,78
    A,b,58,112,168,226,282,166
    A,c,42,66,99,141,174,90

Then

    d3.csv('./data.csv', function(data) {
      var nest = d3.nest()
        .key(function(d) { return d.kind; })
        .key(function(d) { return d.label; })
        .entries(data);
      boxPlot(
        d3.select('body').append('svg').attr({width: 600, height: 300}),
        nest
      );
    });

## author

Shoichi Kaji
