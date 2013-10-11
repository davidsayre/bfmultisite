{let use_url_translation=ezini('URLTranslator','Translation')|eq('enabled')
     is_update=false()}
{*Org Settings*}
{def $orgUrl = ezini("SiteSettings","SiteURL")} 
{def $receivername = ezini("SiteSettings","SiteName")}
{def $receiveremail= ezini("MailSettings","EmailSender")}

{def $hrefUrl = $object.main_node.url_alias}

{def $isWashFunders = false()}
{if $object.class_identifier|eq('forum_reply')}
	{set $hrefUrl = $object.main_node.parent.url_alias}
{/if}

{*set variables if NEW content *}
{def $senderName = $object.current.creator.name|wash}
{if $is_update|not}
	{set $senderName = $object.owner.name}
{/if}


{section loop=$object.versions}{if and($:item.status|eq(3),$:item.version|ne($object.current_version))}{set is_update=true()}{/if}{/section}
{section show=$is_update}
	{set-block scope=root variable=subject}{$object.content_class.name|wash} {'"%name" was updated'|i18n('design/standard/notification', '', hash( '%name', $object.name|wash ))} [{$orgUrl} - {$object.main_node.parent.name|wash}]{/set-block}
	{set-block scope=root variable=from}{concat($senderName,' <', $sender, '>')}{/set-block}
	{set-block scope=root variable=receiver_name}{concat($receivername,' <', $receiveremail, '>')}{/set-block}
	{set-block scope=root variable=receiver_email}{$receiveremail}{/set-block}
	{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@',$orgUrl,'>')}{/set-block}
	{set-block scope=root variable=reply_to}{concat('<node.',$object.main_node_id,'.eznotification','@',$orgUrl,'>')}{/set-block}
	{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.path_array}{concat('<node.',$:item,'.eznotification','@',$orgUrl,'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
	{if $isWashFunders}
		{"A new discussion item has been posted at %sitename."|i18n('design/standard/notification','',hash('%sitename',$orgUrl))}
	{else}
		{"This email is to inform you that an updated item has been published at %sitename."|i18n('design/standard/notification','',hash('%sitename',$orgUrl))}
	{/if}
	{"The item can be viewed by using the URL below."|i18n('design/standard/notification')}
	<br/><br/>
	{$object.name|wash} - {$object.current.creator.name|wash} (Owner: {$object.owner.name|wash})
{section-else}
	{set-block scope=root variable=subject}{$object.content_class.name|wash} {'"%name" was published'|i18n('design/standard/notification', '', hash( '%name', $object.name|wash ))} [{$orgUrl} - {$object.main_node.parent.name|wash}]{/set-block}
	{set-block scope=root variable=from}{concat($senderName,' <', $sender, '>')}{/set-block}
	{set-block scope=root variable=receiver_name}{concat($receivername,' <', $receiveremail, '>')}{/set-block}
	{set-block scope=root variable=receiver_email}{$receiveremail}{/set-block}
	{set-block scope=root variable=message_id}{concat('<node.',$object.main_node_id,'.eznotification','@', $orgUrl,'>')}{/set-block}
	{set-block scope=root variable=reply_to}{concat('<node.',$object.main_node.parent_node_id,'.eznotification','@',$orgUrl,'>')}{/set-block}
	
	{set-block scope=root variable=references}{section name=Parent loop=$object.main_node.parent.path_array}{concat('<node.',$:item,'.eznotification','@',$orgUrl,'>')}{delimiter}{" "}{/delimiter}{/section}{/set-block}
	{if $isWashFunders}
		{"A new discussion item has been posted at %sitename."|i18n('design/standard/notification','',hash('%sitename',$orgUrl))}
	{else}
		{"This email is to inform you that a new item has been published at %sitename."|i18n('design/standard/notification','',hash('%sitename',$orgUrl))}
	{/if}
	{"The item can be viewed by using the URL below."|i18n('design/standard/notification')}
	<br/><br/>
	{$object.name|wash} - {$object.owner.name|wash}
{/section}
<br/>
<a href="http://{$orgUrl}{cond( $use_url_translation, $hrefUrl|ezurl(no),
                                               true(), concat( "/content/view/full/", $object.main_node_id )|ezurl(no) )}">http://{$orgUrl}{cond( $use_url_translation, $hrefUrl|ezurl(no),
                                               true(), concat( "/content/view/full/", $object.main_node_id )|ezurl(no) )}</a>

<br/><br/>
	{"If you do not want to continue receiving these notifications, change your settings at:"|i18n('design/standard/notification')}
	<a href='http://{$orgUrl}{concat("notification/settings/")|ezurl(no)}'>http://{$orgUrl}{concat("notification/settings/")|ezurl(no)}</a>
	-- 
	{"%sitename notification system" |i18n('design/standard/notification',,hash('%sitename',$orgUrl))}
{/let}
