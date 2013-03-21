# appdf

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
