/***
 * Copyright (c) 2022 - Nathan Franklin - All rights reserved
 *
 * @description Sample Domain class for Government Domain within account
 * @author Nathan Franklin
 * @changelog
 */
public inherited sharing class aef_GovernmentAccountDomain extends aef_ApplicationDomain implements IHasClassType {

	private static final Set<String> GOVERNMENT_INDUSTRIES = new Set<String>{'Government'};

	public static aef_GovernmentAccountDomain newInstance(List<SObject> sObjectList) {
		return (aef_GovernmentAccountDomain)aef_ApplicationDomain.newInstance(aef_GovernmentAccountDomain.class, sObjectList);
	}

	/**
	 * These are the modules that the domain will use for triggers or method execution
	 */
	public override void registerModules() {
		registerModule(aef_GovernmentAccountRatingModule.class);
	}

	/**
	 * Because Apex doesn't have a decent reflection implementation, we need to return the concrete class type
	 */
	public Type getClassType() {
		return aef_GovernmentAccountDomain.class;
	}

	/**
	 * Prefilter the records passed in to ensure this domain class only processes applicable records.
	 */
	public override List<SObject> filter(List<SObject> records) {
		List<SObject> output = new List<SObject>();
		for(Account record : (List<Account>)records) {
			if(GOVERNMENT_INDUSTRIES.contains(record.Industry)) {
				output.add(record);
			}
		}
		return output;
	}
}