<h3><b>Source</b>: <code>http://blog.bernatfarrero.com/jquery-and-rails-3-mini-tutorial/</code> (with little "CSS" changes)</h3>
<b>ruby -v  </b>=> <code>ruby 1.9.3p0 (2011-10-30) [i386-mingw32]</code><br />
<b>gem -v   </b>=> <code>1.8.11</code><br />
<b>Rails -v </b>=> <code>Rails 3.1.3</code><br />
<b>project_path</b>: <code>C:\projects\apps\miniComments</code><br />

<ul><li><b>Prepare the environment</b><br />
2rails[.bat]<br />
rails new miniComments -T<br /> => [<i>-T => don't generate a test directory associated with the default Test::Unit framework</i>]
<b>=></b> cd miniComments<br />
rails g resource Comment name:string body:text<br />
rake db:migrate<br />
<b>=></b>It isn't necessary insert the three "javascript_include_tag" into the file <code>/app/views/layouts/application.html.erb</code><br /></li>
<li><b>Prepare the code</b><br />
<p><i>edit</i> the file <code>project_path/app/controllers/comments_controller.rb</code><br />
<i>insert</i> before the last <code>end</code>:<br />
<code>def index<br />
&nbsp;&nbsp;@comments = Comment.all<br />
&nbsp;&nbsp;respond_to do |format|<br />
&nbsp;&nbsp;&nbsp;&nbsp;format.html # index.html.erb<br />
&nbsp;&nbsp;&nbsp;&nbsp;format.rss<br />
&nbsp;&nbsp;end<br />
end<br />
def create<br />
&nbsp;&nbsp;@comment = Comment.create!(params[:comment])<br />
&nbsp;&nbsp;flash[:notice] = "Thanks for commenting!"<br />
&nbsp;&nbsp;respond_to do |format|<br />
&nbsp;&nbsp;&nbsp;&nbsp;format.html { redirect_to comments_path }<br />
&nbsp;&nbsp;&nbsp;&nbsp;format.js<br />
&nbsp;&nbsp;end<br />
end<br />
def destroy<br />
&nbsp;&nbsp;@comment = Comment.find(params[:id])<br />
&nbsp;&nbsp;@comment.destroy<br />
&nbsp;&nbsp;respond_to do |format|<br />
&nbsp;&nbsp;&nbsp;&nbsp;format.html { redirect_to comments_path }<br />
&nbsp;&nbsp;&nbsp;&nbsp;format.js<br />
&nbsp;&nbsp;end<br />
end</code></p>
<p><i>create</i> the file <code>project_path/app/views/comments/index.html.erb</code><br />
<i>insert</i>:<br />
<code>&lt;span id="comments_count"&gt;&lt;%= pluralize(@comments.count, "Comment") %&gt;</span>
&lt;div id="comments"&gt;  &lt;%= render :partial =&gt; @comments, :locals =&gt; { :list => true } %&gt;&lt;/div&gt;<br />
&lt;hr /&gt;&lt;div id="comment-notice"&gt;&lt;/div&gt;<br />
&lt;h2&gt;Say something!&lt;/h2&gt;<br />
&lt;%= form_for(Comment.new, :action =&gt; "create", :remote =&gt; true) do |f| -%&gt;<br />
&nbsp;&nbsp;&lt;div class="data_in"&gt;&lt;%= f.label :name, "Your name:" %&gt;&lt;%= f.text_field :name %&gt;&lt;/div&gt;<br />
&nbsp;&nbsp;&lt;div class="data_in"&gt;&lt;%= f.label :body, "Comment:" %&gt;    &lt;%= f.text_area :body, :rows =&gt; 8 %&gt;&lt;br /&gt;&lt;/div&gt;<br />
&nbsp;&nbsp;&lt;div class="data_in"&gt;&lt;%= submit_tag "Add comment" %&gt;&lt;/div&gt;<br />
&lt;% end -%></code></p>
<p><i>edit</i> the file <code>project_path/app/controllers/comments_controller.rb</code><br />
<i>insert</i> at the end of the file:<br />
<code>label { float:left; width:5em; }<br />
.data_in { padding-bottom:5px; }</code><br />
&nbsp;&nbsp;<b><u>Warning</u></b>: if <code>float:left;</code> isn't inserted, <code>label</code> will be considerate an <i>in-line style</i> and <code>width</code> won't be considered!</p>
<p><i>create</i> the file <code>project_path/app/views/comments/_comment.html.erb</code><br />
<i>insert</i>:<br />
<code>&lt;%= div_for comment do %&gt;<br />
&nbsp;&nbsp;&lt;span class="dateandoptions"&gt;<br />
&nbsp;&nbsp;&nbsp;&nbsp;Posted &lt;%=time_ago_in_words(comment.created_at)%&gt; ago<br />
&nbsp;&nbsp;&nbsp;&nbsp;&lt;%= link_to 'Delete', comment_path(comment), :method =&gt; :delete, :class =&gt; "delete", :remote =&gt; true  %&gt;<br />
&nbsp;&nbsp;&lt;/span&gt;<br />
&nbsp;&nbsp;&lt;span&gt;: &lt;b&gt;&lt;%= comment.name %&gt;&lt;/b&gt; wrote:&lt;/span&gt;<br />
&nbsp;&nbsp;&lt;%= content_tag(:span, comment.body, :class => "comment-body") %&gt;<br />
&lt;% end %&gt;</code></p>
<p><i>create</i> the file <code>project_path/app/views/comments/create.js.erb</code><br />
<i>insert</i>:<br />
/* Insert a notice between the last comment and the comment form */<br />
$("#comments_count").html("<%= pluralize(Comment.count, 'Comment') %>");$("#comment-notice").html('(div class="flash notice")<%= escape_javascript(flash.discard(:notice)) %>(/div)');<br />
/* Replace the count of comments */<br />
$("#comments_count").html("<%= pluralize(Comment.count, 'Comment') %>");<br />
/* Add the new comment to the bottom of the comments list */<br />
$("#comments").append("<%= escape_javascript(render(@comment)) %>");<br />
/* Highlight the new comment */<br />
$("#comment_<%= @comment.id %>").effect("highlight", {}, 3000);<br />
/* Reset the comment form */<br />
$("#new_comment")[0].reset();<br />
&nbsp;&nbsp;<b><u>Warning</u></b>: <i>an <b>error</b> occurs</i> if <code>flash.delete(:notice)</code> (like as in the source) isn't change to <code>flash.discard(:notice)</code><br />
&nbsp;&nbsp;and the comments won't be rendered (but the data will be inserted in the db)</p>
<p><i>create</i> the file <code>project_path/app/views/comments/destroy.js.erb</code><br />
<i>insert</i>:<br />
/* Eliminate the comment by fading it out */<br />
$('#comment_<%= @comment.id %>').fadeOut();<br />
/* Replace the count of comments */<br />
$("#comments_count").html("<%= pluralize(Comment.count, 'Comment') %>");</p></li>
<li><b>Finish!</b></li></ul>