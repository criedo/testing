<h2>Tutorial Rails 3.0 => blog</h2>
<h3>http://guides.rubyonrails.org/getting_started.html</h3>

<b>ruby_path</b>: C:/Programmi/InstantRails-2.0/ruby<br />
<b>project_path</b>: C:/Programmi/InstantRails-2.0/rails_app/blog<br />
<b>nel prompt</b>: rails[.bat => per cambiare cartella]<br />
rails new blog<br />
<p>[project_path/config/initializers: everything inside is loaded at the same time the original environment.rb is, and that's because when you're using several different plugins and gems in your project, the environment.rb file tends to become cluttered and difficult to maintain.<br />
<b>[view]</b>: In Rails 3.0, use <%=h post.name %> to escape HTML from the page is now the default. To get unescaped HTML, you now use <%= raw post.name %></p>
<p>Database configuration: project_path/config/database.yml*:<br />
<i>Trick</i><br />
defaults: &defaults<br />
  adapter: postgresql<br />
  encoding: utf8<br />
  pool: 5<br />
  username: jruby<br />
  password: jruby<br />
<i>sostituito da</i><br />
  <<: *defaults<br /></p>
<br /><i>new Rake tasks</i>:<ul>
<li>db:charset          Retrieves the charset for the current environment's database</li>
<li>db:collation        Retrieves the collation for the current environment's database</li>
<li>db:create           Create the database defined in config/database.yml for the current RAILS_ENV</li>
<li>db:create:all       Create all the local databases defined in config/database.yml</li>
<li>db:drop             Drops the database for the current RAILS_ENV</li>
<li>db:drop:all         Drops all the local databases defined in config/database.yml</li>
<li>db:reset            Drops and recreates the database from db/schema.rb for the current environment.</li>
<li>db:rollback         Rolls the schema back to the previous version. Specify the number of steps with STEP=n</li>
<li>db:version          Retrieves the current schema version number</li></ul>
<br /><ul>
<li><b>nell'editor</b>: <i>edit</i> Gemfile => inserire <u>gem 'pg', :require => 'pg'</u><br />
bundle install => Your blundle is complete!</li>
<li><b>nel prompt</b>: cd blog [ATTENTI: NON dimenticare di canbiare la cartella]<br />
rake db:create:all [already exists => attento coi permessi]<br />
rails generate controller home index<br /></li>
<li><b>nell'editor</b>: <i>edit</i> project_path/config/routes.rb<br />
sostituisce la riga <code>  # root :to => "welcome#index"</code> per <code>root :to => "home#index"</code><br />
<i>rename</i> da <code>project_path/public/index.html</code> a <code>project_path/public/index.html.old</code><br />
<i>edit</i> project_path/app/views/home/index.html.erb<br />
sostituisce tutto per <code>< h1>Hello, Rails!< /h1></code></li>
<li><b>nel prompt</b>: rails server<br />
rails generate scaffold Post name:string title:string content:text<br />
rake db:migrate</li>
<li><b>nell'editor</b>: <i>edit</i> project_path/app/views/home/index.html.erb<br />
inserisce al fine <code>< %= link_to "My Blog", posts_path %></code><br />
<i>edit</i> project_path/app/models/post.rb<br />
inserisce le validazione:<code><br />
  validates :name,  :presence => true<br />
  validates :title, :presence => true, :length => { :minimum => 5, :maximum => 255 }</code><br />
dopo <code>class Post < ActiveRecord::Base</code></li>
<li><b>nel prompt</b>: rails console => apre la consolle [ctrl+D => per chiudere]</li>
<li><b>nella consolle</b>: p = Post.new(:content => "A new post") => #< Post id: nil, name: nil, title: nil, content: "A new post", created_at: nil, pdated_at: nil><br />
p.save => false<br />
p.errors => #< OrderedHash { :title=>["can't be blank", "is too short (minimum is 5 characters)"], :name=>["can't be blank"] }></li>
<li><b>nell'editor</b>: <i>edit</i> project_path/public/stylesheets/scaffold.css<br />
sostituisce <code>background-color: #fff;</code> per <code>background: #EEEEEE;</code><br /></li>
<li><b>nel prompt</b>: rails generate model Comment commenter:string body:text post:references<br />
rake db:migrate</li>
<li><b>nell'editor</b>: <i>edit</i> project_path/app/models/post.rb<br />
inserisce <code>has_many :comments</code> prima di <code>end</code><br />
<i>edit</i> project_path/config/routes.rb<br />
inserisce <code> do<br />
  resources :comments<br />
end</code><br />
dopo di <code>resources :posts</code><br /></li>
<li><b>nel prompt</b>: rails generate controller Comments</li>
<li><b>nell'editor</b>: <i>edit</i> project_path/app/views/posts/show.html.erb<br />
inserisce <code>< h2>Add a comment:< /h2><br />
< %= form_for([@post, @post.comments.build]) do |f| %><br />
  < div class="field">< %= f.label :commenter %>< br />< %= f.text_field :commenter %>< /div><br />
  < div class="field">< %= f.label :body %>< br />< %= f.text_area :body %>< /div><br />
  < div class="actions">< %= f.submit %>< /div><br />
< % end %></code><br />
dopo di <code>resources :posts</code><br />
<i>edit</i> project_path/app/controllers/comments_controller.rb<br />
inserisce <code>def create<br />
  @post = Post.find(params[:post_id])<br />
  @comment = @post.comments.create(params[:comment])<br />
  redirect_to post_path(@post)<br />
end</code><br />
dopo di <code>ApplicationController</code><br />
<i>edit</i> project_path/app/views/posts/show.html.erb<br />
inserisce <code>< h2>Comments< /h2><br />
< % @post.comments.each do |comment| %><br />
  < p>< b>Commenter:< /b>< %= comment.commenter %>< /p><br />
  < p>< b>Comment:< /b>< %= comment.body %>< /p><br />
< % end %></code><br />
dopo id <code>< p>< b>Content:< /b>< %= @post.content %>< /p></code><br />
<i>crea file</i> project_path/app/views/comments/_comment.html.erb<br />
inserisce <code>< p>< b>Commenter:< /b>< %= comment.commenter %>< /p><br />
< p>< b>Comment:< /b><%= comment.body %>< /p></code><br />
<i>edit</i> project_path/app/views/posts/show.html.erb<br />
sostituisce <code>< p>< b>Commenter:< /b>< %= comment.commenter %>< /p><br />
< p>< b>Comment:< /b><%= comment.body %>< /p></code><br />
per <code>< %= render :partial => "comments/comment", :collection => @post.comments %></code><br />
<i>crea file</i> project_path/app/views/comments/_form.html.erb<br />
inserisce <code>< %= form_for([@post, @post.comments.build]) do |f| %><br />
  < div class="field">< %= f.label :commenter %>< br /><%= f.text_field :commenter %>< /div><br />
  < div class="field">< %= f.label :body %>< br />< %= f.text_area :body %>< /div><br />
  < div class="actions">< %= f.submit %>< /div><br />
< % end %></code><br />
<i>edit</i> project_path/app/views/posts/show.html.erb<br />
sostituisce <code>< %= form_for([@post, @post.comments.build]) do |f| %><br />
  < div class="field">< %= f.label :commenter %>< br /><%= f.text_field :commenter %>< /div><br />
  < div class="field">< %= f.label :body %>< br />< %= f.text_area :body %>< /div><br />
  < div class="actions">< %= f.submit %>< /div><br />
< % end %></code><br />
per <code>< %= render "comments/form" %></code>
<i>edit</i> project_path/app/views/comments/_comment.html.erb<br />
inserisce al fine <code>< p><%= link_to 'Destroy Comment', [comment.post, comment], :confirm => 'Are you sure?', :method => :delete %>< /p></code><br />
<i>edit</i> project_path/app/views/comments/_comment.html.erb<br />
inserisce <code>def destroy<br />
  @post = Post.find(params[:post_id])<br />
  @comment = @post.comments.find(params[:id])<br />
  @comment.destroy<br />
  redirect_to post_path(@post)<br />
end</code><br />
<i>edit</i> project_path/app/views/comments/_comment.html.erb<br />
inserisce <code>, :dependent => :destroy</code><br />
<i>edit</i> project_path/app/controllers/application_controller.rb<br />
inserisce <code>private<br />
  def authenticate<br />
    authenticate_or_request_with_http_basic do |user_name, password|user_name == 'admin' && password == 'password'<br />
    end<br />
  end</code><br />
prima dell'ultimo <code>end</code><br />
<i>edit</i> project_path/app/controllers/posts_controller.rb<br />
inserisce <code>before_filter :authenticate, :except => [:index, :show]</code><br />
nella seconda riga<br />
<i>edit</i> project_path/app/controllers/comments_controller.rb<br />
inserisce <code>before_filter :authenticate, :only => :destroy</code><br />
nella seconda riga</li>
rails generate model tag name:string post:references
<li><b>nel prompt</b>: rails generate model tag name:string post:references => 20110819192102_create_tags.rb<br />
rake db:migrate</li>
<li><b>nell'editor</b>: <i>edit</i> project_path/app/models/post.rb<br />
inserisce <code>has_many :tags<br />
  accepts_nested_attributes_for :tags, :allow_destroy => :true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }</code><br />
prima dell'ultimo <code>end</code><br />
<i>edit</i> project_path/views/posts/_form.html.erb<br />
inserisce <code><% @post.tags.build %></code> all'inizio<br />
inserisce <code>< h2>Tags< /h2>
  < %= render :partial => 'tags/form', :locals => {:form => post_form} %>
  < div class="actions">< %= post_form.submit %>< /div></code><br />
prima di <code>< div class="actions"></code>
sostituire <code>f.</code> per <code>post_form.</code><br />
<i>crea file</i> project_path/views/tags/_form.html.erb<br />
inserisce <code>< %= form.fields_for :tags do |tag_form| %><br />
  < div class="field">< %= tag_form.label :name, 'Tag:' %>< %= tag_form.text_field :name %>< /div><br />
  < % unless tag_form.object.nil? || tag_form.object.new_record? %><br />
    < div class="field">< %= tag_form.label :_destroy, 'Remove:' %>< %= tag_form.check_box :_destroy %>< /div><br />
  < % end %><br />
<% end %></code><br />
<i>edit</i> project_path/views/posts/show.html.erb<br />
inserisce <code>< p>< b>Tags:< /b>< %= @post.tags.map { |t| t.name }.join(", ") %>< /p></code><br />
<i>edit</i> project_path/app/helpers/posts_helper.rb<br />
inserisce <code>def join_tags(post)<br />
  post.tags.map { |t| t.name }.join(", ")<br />
end</code> nella seconda riga<br />
<i>edit</i> project_path/views/posts/show.html.erb<br />
sostituisce <code>< %= @post.tags.map { |t| t.name }.join(", ") %></code><br />
per <code>< %= join_tags(@post) %></code>
</li></ul>
