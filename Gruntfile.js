module.exports = function(grunt) {
    'use strict';
    var path = require('path');
    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        coffee: {
            compileWithMapsDir: {
                options: {
                    join: true,
                    sourceMap: true
                },
                files: {
                    "public/scripts/main.js": "public/scripts/coffee/*.coffee"
                }
            }
        },
        less: {
            main: {
                files: {
                    "public/styles/main.css": "public/styles/less/*.less",
                }
            }
        },
        watch: {
            coffee: {
                files: [
                    "public/scripts/coffee/*.coffee"
                ],
                options: {
                    livereload: true
                },
                tasks: ['coffee']
            },
            less: {
                files: [
                    'public/styles/less/*.less'
                ],
                options: {
                    livereload: true
                },
                tasks: ['less']
            }
        }
    });

    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-less');

    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['coffee', 'less', 'watch']);

}
