{def $number_of_items=10
     $subscribed_nodes = fetch( 'notification', 'subscribed_nodes' )
     $subscribed_nodes_count=fetch( 'notification', 'subscribed_nodes_count' )}
     {*, hash( 'limit', $number_of_items) ), 'offset', $view_parameters.offset *}
	 

<br />

<h2>{'My item notifications'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit', , hash( '%notification_count', $subscribed_nodes_count ) )}</h2>

{if $subscribed_nodes_count|gt( 0 )}

<table class="list" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <th class="tight">
        <img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}" title="{'Invert selection.'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}" onclick="ezjs_toggleCheckboxes( document.notification, 'SelectedRuleIDArray_{$handler.id_string}[]' ); return false;" />
    </th>
    <th class="item-name">
    {'Name'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}
    </th>
    <th class="item-type">
    {'Type'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}
    </th>
    {* 
    <th>
    {'Section'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}
    </th>
    *}
</tr>


{def $path_prefix = ezini('SiteAccessSettings','PathPrefix')}
{foreach $subscribed_nodes as $rule
		sequence array( 'bgdark', 'bglight' ) as $style}		
	{if $rule.node.path_identification_string|downcase|contains($path_prefix|downcase)}
		<tr class="{$style}">
			<td align="center">
				  <input type="checkbox" name="SelectedRuleIDArray_{$handler.id_string}[]" value="{$rule.id}" />
			</td>
			<td>
				<a href="{$rule.node.url_alias|ezurl(no)}">{$rule.node.name|wash()}</a>
			</td>
			<td>
				{$rule.node.object.content_class.name|wash}
			</td>
			{* SKIP
			<td>
				{def $section_object=fetch( 'section', 'object', hash( 'section_id', $rule.node.object.section_id ) )}{if $section_object}{$section_object.name|wash()}{else}<i>{'Unknown'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}</i>{/if}
				{undef $section_object}
			</td>
			*}
		</tr>
	{/if}
{/foreach}
</table>

{else}
<p>{'You have not subscribed to receive notifications about any items.'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}</p>
{/if}

{*
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri='/notification/settings'
         item_count=$subscribed_nodes_count
         view_parameters=$view_parameters
         item_limit=$number_of_items}
*}
<div class="buttonblock">
{if $subscribed_nodes_count|gt( 0 )}
<input class="button" type="submit" name="RemoveRule_{$handler.id_string}" value="{'Remove selected'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}" /> 
{/if}
<!--input class="button" type="submit" name="NewRule_{$handler.id_string}" value="{'Add'|i18n( 'design/ezwebin/notification/handler/ezsubtree/settings/edit' )}" /-->
</div>