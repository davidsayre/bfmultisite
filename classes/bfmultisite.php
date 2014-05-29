
<?php

class bfmultisite {

	public static function getSiteAccessIniByPathPrefix ($sFindPathPrefix) {
		/* loop over the main site.ini site_accesses */
		$oSiteIni = eZSite::getIni( 'site.ini' );
		foreach($oSiteIni['SiteList'] as $sSiteAccess)
		{
			$aSiteAccessIni = getSiteAccessIni($sSiteAccess,'site.ini');
			if(array_key_exists('SiteAccessSettings',$aSiteAccessIni)) {
				$aSiteAccessSettings = $aSiteAccessIni['SiteAccessSettings'];
				if(array_key_exists('PathPrefix', $aSiteAccessSettings)) {
					if(lcase($aSiteAccessSettings['PathPrefix']) == $sFindPathPrefix) {
						return $aSiteAccessIni;
					}
				}
			}
		}

		//if not found
		return false;
	}

	public static function getSiteAccessIni($sSiteAccess,$sSettingsFile){
		$ini = eZSiteAccess::getIni( $sSiteAccess, $sSettingsFile );
		return $ini->BlockValues;
	}

}

?>