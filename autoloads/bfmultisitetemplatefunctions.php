<?php

/*!
  \class   bfmultisitetemplatefunctions bfmultisitetemplatefunctions.php
  \ingroup eZTemplateOperators
  \brief   Handles template operators for the bfmultisite extension
  \version 1.0
  \date	   Friday May 29 2013 12:36:00 pm
  \author  david.sayre@beaconfire.com

  

  Example:
\code
{get_sitaccess_ini('admin2','site.ini')|attribute(show,3)}
\endcode
*/

class bfmultisitetemplatefunctions
{
	/*!
	  Constructor, does nothing by default.
	*/
	function bfmultisitetemplatefunctions()
	{
	}

	/*!
	 \return an array with the template operator name.
	*/
	function operatorList()
	{
		return array( 'get_siteaccess_ini');
	}

	/*!
	 \return true to tell the template engine that the parameter list exists per operator type,
			 this is needed for operator classes that have multiple operators.
	*/
	function namedParameterPerOperator()
	{
		return true;
	}

	/*!
	 See eZTemplateOperator::namedParameterList
	*/
	function namedParameterList()
	{
		return array(
			'get_siteaccess_ini' => array(				
				'siteaccess' => array(
					'type'     => 'string',
					'required' => false
				),	
				'ini' => array(
					'type'     => 'string',
					'required' => false
				),
			),
		);
	}

	/*!
	 Executes the PHP function for the operator cleanup and modifies \a $operatorValue.
	*/
	function modify( $tpl, $operatorName, $operatorParameters, $rootNamespace, $currentNamespace, &$operatorValue, $namedParameters, $placement )
	{
		$bfm = new bfmultisite();
		switch ( $operatorName ) {
			case 'get_siteaccess_ini': {
				$sSiteAccess = $namedParameters['siteaccess'];
				$sINIFile = $namedParameters['ini'];
				$operatorValue = $bfm->getSiteAccessIni($sSiteAccess,$sINIFile);
			} break;			
		}
	}
}

?>
