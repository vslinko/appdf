zipfile = require "zipfile"
xml2js = require "xml2js"
async = require "async"
fs = require "fs"


module.exports = (file, callback) ->
  async.waterfall [
    (callback) ->
      fs.stat file, (err, stats) ->
        return callback err if err
        return callback new Error "\"#{file}\" isn't file" unless stats.isFile()
        callback()

    (callback) ->
      try
        appdf = new zipfile.ZipFile file

        unless "description.xml" in appdf.names
          return callback new Error "\"#{file}\" isn't valid AppDF file"

        callback null, appdf
      catch err
        callback err

    (appdf, callback) ->
      appdf.readFile "description.xml", callback

    (buffer, callback) ->
      options = normalizeTags: true, explicitArray: false, async: true
      xml2js.parseString buffer.toString().trim(), options, callback

    (result, callback) ->
      callback null, result["application-description-file"]["application"]

  ], callback
