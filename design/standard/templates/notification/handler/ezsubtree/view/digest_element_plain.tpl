{let use_url_translation=ezini('URLTranslator','Translation')|eq('enabled')
     is_update=false()}
{*?template charset=utf-8?*}
{let content_object_version=fetch(notification,event_content,hash(event_id,$collection_item.event_id))}

{def $orgUrl = ezini("SiteSettings","SiteURL")} 
{def $hrefUrl = $content_object_version.contentobject.main_node.url_alias}
{if $content_object_version.contentobject.class_identifier|eq('forum_reply')}
	{set $hrefUrl = $content_object_version.contentobject.main_node.parent.url_alias}
{/if}

{*display Title *}
<p> {$content_object_version.contentobject.name} <br>

{* display author *}
Added/ Update by: {$content_object_version.creator.name} <br>

{* display link*}
Location: 
<a href="http://{$orgUrl}{cond( $use_url_translation, $hrefUrl|ezurl(no),
                                               true(), concat( "/content/view/full/", $content_object_version.contentobject.main_node_id )|ezurl(no) )}">http://{$orgUrl}{cond( $use_url_translation, $hrefUrl|ezurl(no),
                                               true(), concat( "/content/view/full/", $content_object_version.contentobject.main_node_id )|ezurl(no) )}</a>
<br>
</p>
<br>
{/let}
