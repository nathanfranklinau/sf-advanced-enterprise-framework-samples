/***
 * Copyright (c) 2022 - Nathan Franklin - All rights reserved
 *
 * @description Sample Domain class for Government Domain within account
 * @author Nathan Franklin
 * @changelog
 */
public inherited sharing class aef_EnterpriseAccountDomain extends aef_ApplicationDomain {

	public static aef_EnterpriseAccountDomain newInstance(List<SObject> sObjectList) {
		return (aef_EnterpriseAccountDomain)aef_ApplicationDomain.newInstance(aef_EnterpriseAccountDomain.class, sObjectList);
	}

	/**
	 * These are the modules that the domain will use for triggers or method execution
	 */
	public override void registerModules() {

		// used to retro fit case priority when an account is reclassified as enterprise
		registerModule(aef_EnterpriseAccountCasesModule.class);

	}

	/**
	 * Prefilter the records passed in to ensure this domain class only processes applicable records.
	 */
	public override List<SObject> filter(List<SObject> records) {
		System.debug('filter: ' + className);
		return aef_EnterpriseService.getInstance().filterEnterpriseAccounts(records);
	}

	/**
	 * Trigger instantiation context
	 */
	public virtual class Constructor implements aef_ApplicationDomain.IConstructable {
		public aef_EnterpriseAccountDomain construct(List<SObject> sObjectList) {
			return aef_EnterpriseAccountDomain.newInstance(sObjectList);
		}
	}
}