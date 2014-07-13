# encoding: utf-8


####
#
# The build script for all this crazy stuff.
#
####

require 'fileutils'
require 'json'

# This is a non-core dependency. If you're getting an error on this line, you'll
# need to get and run bundler on in this directory. (Google it. :P)
require 'archive/zip'

# Auto-Flush STDOUT
STDOUT.sync = true


# Get our working area sorted out.
build_dir = File.join(Dir.getwd, 'build')
FileUtils::mkdir_p build_dir


PACKAGES = %w(linux-32 linux-64 win32-32)

# Clean out the old build files 'n' things.
puts 'Cleaning out files from previous run...'
PACKAGES.each do |package|
    bin = File.join(build_dir, package)
    zip = bin + '.zip'

    FileUtils.remove_entry_secure bin if Dir.exists? bin
    FileUtils.remove_entry_secure zip if File.exists? zip
end

print "\n\n"


# Run the Gulp task which downloads the atom-shell for different platforms.
unless system 'gulp download-shell'
    puts "ERR: Failed to download atom-shell"
    exit
else
    print "\n\n"
end


# Do this first, because it's needed for every build type.
puts "Running Browserify on the JavaScript code."
puts "Concatenating all the CSS files."
successful = system 'gulp code-build'
print "\n\n" # some space

if successful

    puts "Pulling all the code together."
    FileUtils::mkdir_p File.join(build_dir, 'app')
    FileUtils.cp('public/dist/application.js', 'build/app/application.js')
    FileUtils.cp('public/dist/styles.css', 'build/app/styles.css')
    FileUtils.cp('public/index-template.html', 'build/app/index-template.html')
    FileUtils.cp('public/browser.html', 'build/app/browser.html')
    FileUtils.cp('src/main.js', 'build/app/main.js')

    # Clean up the package.json file so that the 'main' attribute points correctly to
    # the app's launch file. (Which has obviously changed...)
    json = JSON.parse(File.read('package.json'))
    json['dependencies'] = nil
    json['devDependencies'] = nil
    json['main'] = 'main.js'

    # Reject all that are nil so that we clear the keys out as well.
    json.reject! { |k, v| v.nil? }

    # Finally write the json back to where we want it.
    File.write('build/app/package.json', JSON.pretty_generate(json, {indent: ' ' * 4}))
else
    puts 'ERR: code-build failed. Die die die!'
    exit
end


# Finally, let's get started.
print "\n\n" # some space
PACKAGES.each do |build|
    bin_path = File.join(build_dir, build)

    puts "Constructing the #{build} package."

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

        # Need to copy node_modules because this code isn't run through Browserify.
        # TODO: ignore the dependencies in the devDependencies object of the package.json.
        FileUtils.cp_r('node_modules/.', File.join(bin_path, 'node_modules'))

        FileUtils.cp_r([
            File.join(src, 'package.json'),
            File.join(src, 'styles.css'),
            File.join(src, 'index-template.html'),
            File.join(src, 'main.js'),
        ], dest)
    end

    # Now we need to zip this thing!!
    Archive::Zip.archive(File.join(build_dir, build + '.zip'), bin_path)
end

puts "All finished! Ready to push to Github! :D"
print "\n"
