appdf = require "../lib/appdf"
chai = require "chai"


describe "appdf.read()", ->
  chai.should()

  it "should yield error if file doesn't exists", (callback) ->
    appdf.read "invalid", (err, result) ->
      err.should.be.an.instanceOf Error
      err.code.should.equal "ENOENT"
      callback()

  it "should yield error if file isn't file", (callback) ->
    appdf.read ".", (err, result) ->
      err.should.be.an.instanceOf Error
      err.message.should.equal "\".\" isn't file"
      callback()

  it "should yield error if file isn't zip archive", (callback) ->
    message = "cannot open file: samples/README.md error: Not a zip archive\n"

    appdf.read "samples/README.md", (err, result) ->
      err.should.be.an.instanceOf Error
      err.message.should.equal message
      callback()

  it "should yield error if file doesn't contain description.xml", (callback) ->
    message = "\"test/fixtures/dummy.zip\" isn't valid AppDF file"

    appdf.read "test/fixtures/dummy.zip", (err, result) ->
      err.should.be.an.instanceOf Error
      err.message.should.equal message
      callback()

  it "should yield parsed schema", (callback) ->
    appdf.read "samples/Yandex.Shell/yandex.shell.appdf", (err, result) ->
      result.description.texts.title.should.equal "Yandex.Shell"
      callback()
