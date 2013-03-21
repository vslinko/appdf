# appdf

[![Build Status](http://teamcity.rithis.com/httpAuth/app/rest/builds/buildType:id:bt7,branch:master/statusIcon?guest=1)](http://teamcity.rithis.com/viewType.html?buildTypeId=bt7&guest=1) [![Dependency Status](https://gemnasium.com/rithis/appdf.png)](https://gemnasium.com/rithis/appdf)

[AppDF](https://github.com/onepf/AppDF) reader and publisher.

## Installation

```shell
$ npm install -g appdf
```

## Usage

AppDF reader API:

```coffee
appdf = require "appdf"

appdf.read __dirname + "/Yandex.Shell.appdf", (err, result) ->
  console.log result.description.texts.title
```

## Testing

```shell
$ git clone git://github.com/rithis/appdf.git
$ cd appdf
$ npm install
$ ./node_modules/.bin/grunt
```
