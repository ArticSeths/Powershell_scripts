$urls='https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%3D766273&format=json&callback='
$q=(Invoke-WebRequest -Uri $urls).Content | ConvertFrom-JSON
$q.query.results.channel.item