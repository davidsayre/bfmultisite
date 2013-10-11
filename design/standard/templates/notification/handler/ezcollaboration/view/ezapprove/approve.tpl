{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{let approval_content=$collaboration_item.content
     objectversion=fetch( content, version,
                          hash( object_id, $approval_content.content_object_id,
                                version_id, $approval_content.content_object_version ) )}

{def $orgName = "eZ Publish Notice"} 
{def $adminUrl = ezini( "SiteSettings", "AdminSiteURL" )}
{def $adminEmail = ezini( "MailSettings", "AdminEmail" )}

{set-block scope=root variable=subject}
	{'%sitename Approval of "%objectname" awaits your attention' |
		i18n( "design/standard/collaboration/approval",,hash( '%sitename', $orgName, '%objectname', $objectversion.version_name|wash ) )}
{/set-block}

This email is to inform you that "{$objectversion.version_name|wash}" awaits your attention.  Please review and approve, if appropriate.
<br/><br/>			  

View Item: <a href="http://{$adminUrl}{concat( "collaboration/item/full/", $collaboration_item.id )|ezurl( no )}">
	http://{$adminUrl}{concat( "collaboration/item/full/", $collaboration_item.id )|ezurl( no )}</a>

<br/><br/>

If you are unsure why you are receiving this message, please e-mail <a href="mailto:{$adminEmail}">{$adminEmail}</a>