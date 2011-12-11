h3><b>Source</b>: <code>http://blog.bernatfarrero.com/jquery-and-rails-3-mini-tutorial/</code> (with little "CSS" changes)</h3>
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
<li><b>Insert the code</b><br />
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
<i>insert</i>: [<i><b>Warning</b>: for "best visualization" the caracters "<>" will be changed with "()" in the HTML tags</i>]<br />
<code>(span id="comments_count">(%= pluralize(@comments.count, "Comment") %)</span>
(div id="comments")  (%= render :partial => @comments, :locals => { :list => true } %)(/div)<br />
(hr /)(div id="comment-notice")(/div)<br />
(h2)Say something!(/h2)<br />
(%= form_for(Comment.new, :action => "create", :remote => true) do |f| -%)<br />
&nbsp;&nbsp;(div class="data_in")(%= f.label :name, "Your name:" %)(%= f.text_field :name %)(/div)<br />
&nbsp;&nbsp;(div class="data_in")(%= f.label :body, "Comment:" %)    (%= f.text_area :body, :rows => 8 %)(br /)(/div)<br />
&nbsp;&nbsp;(div class="data_in")(%= submit_tag "Add comment" %)(/div)<br />
(% end -%)</code></p>
<p><i>edit</i> the file <code>project_path/app/controllers/comments_controller.rb</code><br />
<i>insert</i> at the end of the file:<br />
<code>label { float:left; width:5em; }<br />
.data_in { padding-bottom:5px; }</code><br />
&nbsp;&nbsp;<b><u>Warning</u></b>: if <code>float:left;</code> isn't inserted, <code>label</code> will be considerate an <i>in-line style</i> and <code>width</code> won't be considered!</p>
<p><i>create</i> the file <code>project_path/app/views/comments/_comment.html.erb</code><br />
<i>insert</i>:<br />
<code>(%= div_for comment do %)<br />
&nbsp;&nbsp;(span class="dateandoptions")<br />
&nbsp;&nbsp;&nbsp;&nbsp;Posted (%=time_ago_in_words(comment.created_at)%) ago<br />
&nbsp;&nbsp;&nbsp;&nbsp;(%= link_to 'Delete', comment_path(comment), :method => :delete, :class => "delete", :remote => true  %)<br />
&nbsp;&nbsp;(/span)<br />
&nbsp;&nbsp;(span): (b)(%= comment.name %)(/b) wrote:(/span)<br />
&nbsp;&nbsp;(%= content_tag(:span, comment.body, :class => "comment-body") %)<br />
(% end %)</code></p>
<p><i>create</i> the file <code>project_path/app/views/comments/create.js.erb</code><br />
<i>insert</i>:<br />
/* Insert a notice between the last comment and the comment form */<br />
$("#comments_count").html("(%= pluralize(Comment.count, 'Comment') %)");$("#comment-notice").html('(div class="flash notice")(%= escape_javascript(flash.discard(:notice)) %)(/div)');<br />
/* Replace the count of comments */<br />
$("#comments_count").html("(%= pluralize(Comment.count, 'Comment') %)");<br />
/* Add the new comment to the bottom of the comments list */<br />
$("#comments").append("(%= escape_javascript(render(@comment)) %)");<br />
/* Highlight the new comment */<br />
$("#comment_(%= @comment.id %)").effect("highlight", {}, 3000);<br />
/* Reset the comment form */<br />
$("#new_comment")[0].reset();<br />
&nbsp;&nbsp;<b><u>Warning</u></b>: <i>an <b>error</b> occurs</i> if <code>flash.delete(:notice)</code> (like as in the source) isn't change to <code>flash.discard(:notice)</code><br />
&nbsp;&nbsp;and the comments won't be rendered (but the data will be inserted in the db)</p>
<p><i>create</i> the file <code>project_path/app/views/comments/destroy.js.erb</code><br />
<i>insert</i>:<br />
/* Eliminate the comment by fading it out */<br />
$('#comment_(%= @comment.id %)').fadeOut();<br />
/* Replace the count of comments */<br />
$("#comments_count").html("(%= pluralize(Comment.count, 'Comment') %)");</p></li>
<li>Finish!</li></ul>