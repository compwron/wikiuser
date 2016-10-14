This is a series of terrible things that I have done while trying to use the gem https://github.com/webis-de/wikipedia-vandalism-detection

Nothing I have done is working yet



Notes

http://www.cs.waikato.ac.nz/ml/weka/downloading.html


The purpose of messy.rb is to resolve unknown dependencies of the gem 'wikipedia-vandalism_detection'


The last successful build on travis of -- did not actually run any tests. Here are links to its link and output. You can also see the output in this repo in last_successful_build_output_3Feb2015.txt
https://travis-ci.org/webis-de/wikipedia-vandalism-detection/builds/69730587
https://s3.amazonaws.com/archive.travis-ci.org/jobs/69730589/log.txt

## current error:

running import of
/Users/me/.rvm/rubies/ruby-1.9.3-p551/lib/ruby/site_ruby/1.9.1/rubygems/core_ext/kernel_require.rb:121:in `require': cannot load such file -- java (LoadError)
