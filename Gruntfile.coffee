async = require "async"
https = require "https"
zlib = require "zlib"
tar = require "tar"
fs = require "fs.extra"


module.exports = (grunt) ->
  grunt.initConfig
    clean:
      samples: "samples"
    simplemocha:
      unit: "test/*.coffee"
      options: reporter: process.env.REPORTER or "spec"
    coffeelint:
      lib: "lib/**/*.coffee"
      grunt: "Gruntfile.coffee"

  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-simple-mocha"
  grunt.loadNpmTasks "grunt-coffeelint"

  grunt.registerTask "default", ["samples", "simplemocha", "coffeelint"]

  grunt.registerTask "samples", ->
    callback = @async()

    fs.stat "samples", (err, stats) ->
      return callback() unless err

      async.series [
        (callback) ->
          url = "https://nodeload.github.com/onepf/AppDF/tar.gz/master"
          request = https.get url

          request.on "response", (response) ->
              gunzip = zlib.createGunzip()
              untar = tar.Extract path: __dirname

              untarStream = response.pipe(gunzip).pipe(untar)

              untarStream.on "error", (err) ->
                callback err

              untarStream.on "end", ->
                callback()

          request.end()

        (callback) ->
          fs.move "AppDF-master/samples", "samples", callback

        (callback) ->
          fs.rmrf "AppDF-master", callback

      ], callback
