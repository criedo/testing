<h2>Tutorial Rails 3.1.1 => byexample2</h2>
<h3>http://ruby.railstutorial.org/chapters/rails-3-1#top</h3>

<b>ruby_path</b>: <code>D:\prog_projects\ruby\r192\bin</code><br />
<b>project_path</b>: <code>D:\prog_projects\ruby\r192\apps\byexample2</code><br />
<ul>
<li><b>Upgrading the sample app (byexample2) to Rails3.1</b><br/>
<p><i>First approach</i>: edit the sample application directly, changing the Gemfile and the configuration files, and then dealing with any breakage that ensues<br />
<b>into the browser</b>: <code>http://davidjrice.co.uk/2011/05/25/how-to-upgrade-a-rails-application-to-version-3-1-0.html</code><br />
<i>Second approach</i> (used by the author): create a new Rails 3.1 application from scratch, and then copy over files one by one from the existing sample application until we get the new application to work<br />
<ul>Advantages:<li>configuration files will automatically be configured correctly;</li><li>easily isolate the source of any breakage</li></ul><br />
create the new enviroment (view <code>D:\Download\prog\ruby\creatingNewEnvironment.rtf</code>)<br />
<b>into the prompt</b> [cmd]: prepare the file <code>railsd</code>[.bat] => change the prompt to <code>project_path</code></p>
change to folder <code>project_path/..</code><br />
<i>prepare</i> the .bat files [by2|by2_c|by2_s|by2_t|2testing]<br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>by2</b>[.bat] => change the prompt to <code>project_path</code><br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>by2_c</b>[.bat] => start the console [exit or ctrl+D to exti] => <b>into the console</b><br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>by2_s</b>[.bat] => start the webserver => <b>into the browser</b><br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>by2_t</b> => start the test environment<br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>2testing</b>[.bat] => copy all files to the folder <code>testing</code> connected with github (by security issue I prefer to use a intermediary folder - and maintain a copy with the uploaded files)</p>
<code>rails new byexample2</code></p>
<p><b>into the editor</b>: <i>edit</i> the file <code>project_path/Gemfile</code><br />
<i>change</i> all the code with:<code><br />
source 'http://rubygems.org'<br />
gem 'rails', '3.1.1'<br />
gem 'sqlite3'<br />
group :assets do<br />
&nbsp;&nbsp;gem 'sass-rails',   '~> 3.1.4'<br />
&nbsp;&nbsp;gem 'coffee-rails', '~> 3.1.1'<br />
&nbsp;&nbsp;gem 'uglifier',     '>= 1.0.3'<br />
end<br />
gem 'jquery-rails'<br />
gem 'ruby-debug19', :require => 'ruby-debug'<br />
gem 'gravatar_image_tag', '1.0.0'<br />
gem 'will_paginate', '3.0.0'<br />
group :development do<br />
&nbsp;&nbsp;gem 'rspec-rails', '2.6.1'<br />
&nbsp;&nbsp;gem 'annotate', '2.4.0'<br />
&nbsp;&nbsp;gem 'faker', '1.0.0'<br />
end<br />
group :test do<br />
&nbsp;&nbsp;gem 'rspec-rails', '2.6.1'<br />
&nbsp;&nbsp;gem 'webrat', '0.7.3'<br />
&nbsp;&nbsp;gem 'spork', '0.9.0.rc9'<br />
&nbsp;&nbsp;gem 'factory_girl_rails', '1.1.0'<br />
&nbsp;&nbsp;gem 'turn', :require => false<br />
end</code></p>
<p><b>into the prompt</b>: <code>bundle install</code><br />
<code>rails generate rspec:install</code></p>
<p><i>copy</i> all the files between directories (old files in C:/Programmi/InstantRails-2.0/rails_app/byexample2)<br />
<i>edit</i> the file <code>.gitignore</code> based on the old file<br />
<i>copy</i> all the old files/directories to <code>project_path/app/controllers</code><br />
<i>copy</i> all the old files/directories to <code>project_path/app/app/helpers</code><br />
<i>copy</i> all the old files/directories to <code>project_path/app/models</code><br />
<i>copy</i> all the old files/directories to <code>project_path/app/views</code><br />
<i>copy</i> the old file <code>routes.rb</code> to <code>project_path/config</code><br />
<i>copy</i> all the old files/directories except <code>seeds.rb</code> to <code>project_path/db</code><br />
<i>copy</i> all the old files/directories in <code>project_path/public/images</code> to <code>project_path/app/assets/images</code><br />
<i>copy</i> all the old files/directories in <code>project_path/public/stylesheets</code> to <code>project_path/app/assets/stylesheets</code><br />
<i>copy</i> all the old files/directories to <code>project_path/spec</code><br />
<b>into the browser</b>: <code>http://localhost:3000/</code> => control the environment<br />
<b>into the prompt</b>: <i>delete</i> the file <code>project_path/public/index.html</code><br />
bundle exec rspec spec/ => don't run with <code>blueprint</code><br />
&nbsp;&nbsp;&nbsp;&nbsp;=> if deleted all files/directories at <code>project_path/app/assets/stylesheets</code> except <code>[application.css|custom.css]</code> => 164 examples, 0 failures<br />
<b>into the editor</b>:<i>edit</i> the file <code>project_path/public/stylesheets/custom.css</code><br />
<i>replace</i> the definition <code>.container</code> with: <code>width: 810px; padding-left: 15%;</code></p></li>

<li><b>Major differences</b> - Asset directories<br />
<b>into the prompt</b>: place the old <code>public/stylesheets/blueprint</code> CSS directory in <code>project_path/vendor/assets/stylesheets</code>
<p><b>into the editor</b>:<i>edit</i> the file <code>project_path/app/views/layouts/application.html.erb</code><br />
<i>replace</i> the block <code>(/head)</code> with:<code><br />
(title)<%= title %>(/title)<br />
<%= csrf_meta_tag %><br />
<%= render 'layouts/stylesheets' %><br />
<%= stylesheet_link_tag "application" %><br />
<%= javascript_include_tag "application" %></code></p>
<p><i>create</i> the file <code>project_path/app/views/layouts/_stylesheets.html.erb</code><br />
<i>insert</i> the code:<code><br />
(!--[if lt IE 9])(script src="http://html5shiv.googlecode.com/svn/trunk/html5.js")(/script)(![endif]--)<br />
<%= stylesheet_link_tag 'blueprint/screen', :media => 'screen' %><br />
<%= stylesheet_link_tag 'blueprint/print',  :media => 'print' %><br />
(!--[if lt IE 8])(%= stylesheet_link_tag 'blueprint/ie' %)(![endif]--)</code></p>
<p><i>edit</i> the file <code>project_path/public/stylesheets/custom.css</code><br />
<i>replace</i> the definition <code>.container</code> with: <code>width: 710px;</code></p>
<p><i>edit</i> the file <code>project_path/app/views/relationships/create.js.erb</code><br />
<i>replace</i> all the code with:<code><br />
$("#follow_form").html("<%= escape_javascript(render('users/unfollow')) %>")<br />
$("#followers").html('<%= "#{@user.followers.count} followers" %>')</code></p>
<p><i>edit</i> the file <code>project_path/app/views/relationships/destroy.js.erb</code><br />
<i>replace</i> all the code with:<code><br />
$("#follow_form").html("<%= escape_javascript(render('users/follow')) %>")<br />
$("#followers").html('<%= "#{@user.followers.count} followers" %>')</code></p>
</li></ul><p>End of the road</p>
