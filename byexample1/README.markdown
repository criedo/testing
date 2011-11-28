<h2>Tutorial Rails 3.0 => byexample1</h2>
<h3>http://ruby.railstutorial.org/chapters/a-demo-app#top</h3>

<b>ruby_path</b>: C:/Programmi/InstantRails-2.0/ruby<br />
<b>project_path</b>: C:/Programmi/InstantRails-2.0/rails_app/byexample1<br />
<b>nel prompt</b> [cmd]: <b>2rails</b>[.bat] => per cambiare alla cartella ruby_path/rails_app<br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>rails s</b> => per attivare il server => <b>nell'applicativo</b><br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>rails consolle</b> => per attivare la consolle [per chiudere: exit or ctrl+D] => <b>nella consolle</b><br />
&nbsp;&nbsp;&nbsp;&nbsp;<b>2testing</b>[.bat] => per copiare i dati nella cartella di connessione a github<br />
<ul>
<li><b>nel prompt</b>: rails new byexample1<br />
cd byexample1<br />
bundle install [Warning: at Ruby level, not for single application]<br />
=> make the first commit<br />
rails generate scaffold User name:string email:string<br />
<p><i>Rake is Ruby make, a make-like language written in Ruby - To see all the Rake tasks available, run $ bundle exec rake -T</i>
bundle exec rake db:migrate [used db default: development.sqlite3]<br />
<i>need to run rake using bundle exec => section 3.2.2</i></p>
rails s => to active the server<br />
<p><i>in the context of Rails applications REST means that most application components (such as users and microposts) are modeled as resources that can be created, read, updated, and deleted—operations that correspond both to the CRUD operations of relational databases and the four fundamental HTTP request methods: POST, GET, PUT, and DELETE</i><br />
Weaknesses: 1)no data validations; 2)no authentication; 3)no tests; 3)no layout</p></li>
<li><b>nell'applicativo</b>: insert 1 or 2 users</li>
<li><b>nel prompt</b>: rails generate scaffold Micropost content:string user:references<br />
bundle exec rake db:migrate<br />
<p><b><i>Warning</i></b>: rewrite project_path/public/stylesheets/scaffold.css<br />
I decided to change <code>user_id:integer</code> a <code>user:references</code><br />
=> inserisce <code>_id</code> al nome della colonna e <code>belongs_to :user</code> al modello creato (project_path/app/models/micropost.rb)<br />
<b>nell'editor</b>: <i>edit</i> project_path/app/models/user.rb<br />
inserisce <code>has_many :microposts</code> prima di <code>end</code><br />
<b>nel applicativo</b>: insert a micropost<br />
<b><i>Warning</i></b>: problem during the insert call (<i>ActiveRecord::AssociationTypeMismatch in MicropostsController#create</i>)<br />
<b>nel prompt</b>: bundle exec rake db:rollback<br /></p></li>
<li><b>nel prompt</b>: rails generate scaffold Micropost content:string user_id:integer<br />
bundle exec rake db:migrate</li>
<li><b>nell'applicativo</b>: insert 1 or 2 posts</li>
<li><b>nell'editor</b>: <i>edit</i> project_path/app/models/post.rb<br />
inserisce <code>belongs_to :user<br />
validates :content, :length => { :maximum => 140 }</code> prima di <code>end</code><br />
<i>edit</i> project_path/app/models/user.rb<br />
inserisce <code>has_many :posts</code> prima di <code>end</code></li>
<li><b>nella consolle</b>: u = User.first =>  < User id: 1, name: .., email: .., created_at: .., updated_at: ..><br />
u.posts => [ < Post id: 1, content: .., user_id: 1, created_at: .., updated_at: ..>, < Post id: 2, content: .., user_id: 1, created_at: ..,
updated_at: ..>]<br />
exit</li>
</ul><p>End of the road<p>