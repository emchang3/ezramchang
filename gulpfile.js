const exec = require("child_process").exec;
const gulp = require("gulp");
const pump = require("pump");

const cleanCSS = require("gulp-clean-css");
const less = require("gulp-less");

const lessFiles = `${__dirname}/src/styles/*.less`;
const excludedLess = `!${__dirname}/src/styles/_*.less`;
const cssDest = `${__dirname}/static/styles`;

async function shrink() {
    console.log("** Compiling and minifying .less **");

    await pump(
        [
            gulp.src([ lessFiles, excludedLess ]),
            less(),
            cleanCSS(),
            gulp.dest(cssDest)
        ],
        function(err) {
            if (err) {
                console.log("--- err:", err);
            }
        }
    );
}

gulp.task("shrink", shrink);

gulp.task("default", gulp.series("shrink", function() {
    console.log("--- Starting .less watcher ---");
    
    gulp.watch(lessFiles).on("change", shrink);
}));
