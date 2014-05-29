<?php

/**
 * Look in the operator files for documentation on use and parameters definition.
 *
 * @var array $eZTemplateOperatorArray
 */
$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] = array( 
	'script'         => 'extension/bfmultisite/autoloads/bfmultisitetemplatefunctions.php',
	'class'          => 'bfmultisitetemplatefunctions',
	'operator_names' => array( 'get_siteaccess_ini' ) 	
);

?>