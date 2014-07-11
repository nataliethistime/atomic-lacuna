# encoding: utf-8


####
#
# The build script for all this crazy stuff.
#
####

require 'fileutils'
require 'json'

# Auto-Flush STDOUT
STDOUT.sync = true


# TODO: clean out any files remaining from the previous run!


# Get our working area sorted out.
build_dir = File.join(Dir.getwd, 'build')
FileUtils::mkdir_p build_dir
FileUtils::mkdir_p File.join(build_dir, 'app')


# Do this first, because it's needed for every build type.
puts "Running Browserify on the JavaScript code."
puts "Concatenating all the CSS files."
successful = system 'gulp code-build'
print "\n\n" # some space

if successful

    puts "Pulling all the code together."
    FileUtils.cp('public/dist/application.js', 'build/app/application.js')
    FileUtils.cp('public/dist/styles.css', 'build/app/styles.css')
    FileUtils.cp('public/index-template.html', 'build/app/index-template.html')
    FileUtils.cp('public/browser.html', 'build/app/browser.html')
    FileUtils.cp('src/main.js', 'build/app/main.js')

    # Clean up the package.json file so that the 'main' attribute points correctly to
    # the app's launch file. (Which has obviously changed...)
    json = JSON.parse(File.read('package.json'))
    json['dependencies'] = nil
    json['main'] = 'main.js'

    # Reject all that are nil so that we clear the keys out as well.
    json.reject! { |k, v| v.nil? }

    # Finally write the json back to where we want it.
    File.write('build/app/package.json', JSON.pretty_generate(json, {indent: ' ' * 4}))
else
    puts 'ERR: code-build failed. Die die die!'
    exit
end


# TODO: download all the atom-shell binaries we need. (There are 3 of them).


# Finally, let's get started.
print "\n\n" # some space
%w(linux darwin windows web).each do |build|
    bin_path = File.join(build_dir, build + '_binary')
    if build == 'web' || build == 'windows' || build == 'darwin'
        puts "#{build.capitalize} build not implemented!"
        next
    end

    puts "Constructing #{build.capitalize} package."

    unless Dir.exists? bin_path
        puts "ERR: please download the #{build} binary."
        next
    end

    if build == 'web'
        # Something special
    else
        src = File.join(build_dir, 'app')
        dest = File.join(bin_path, 'resources', 'app')
        FileUtils.mkdir_p dest # make sure we have somewhere to go..

        # Move the templates and JavaScript into place.
        FileUtils.cp_r('app/js/.', File.join(dest, 'js'))
        FileUtils.cp_r('app/templates/.', File.join(dest, 'templates'))
        FileUtils.cp_r('app/lib/.', File.join(dest, 'lib'))

        # Woo! resources.json!
        FileUtils.mkdir_p File.join(dest, 'data')
        FileUtils.cp_r('app/data/resources.json', File.join(dest, 'data', 'resources.json'))

        FileUtils.cp_r([
            File.join(src, 'package.json'),
            File.join(src, 'styles.css'),
            File.join(src, 'index-template.html'),
            File.join(src, 'main.js'),
        ], dest)
    end
end
