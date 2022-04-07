/**
 * Copyright (c) 2022 - Nathan Franklin - All rights reserved
 *
 * @description
 *
 * @author Nathan Franklin
 * @changelog
 */
public inherited sharing class aef_EnterpriseCasesModule extends aef_ApplicationDomain.Module {

	// Setup which triggers this module should respond to
	public aef_EnterpriseCasesModule() {
		getTriggerEvents().enableBeforeInsert();
	}

	public override void onBeforeInsert(List<SObject> records, aef_ApplicationUnitOfWork uow) {
		maybeDefaultCasePriorities((List<Case>)records, uow);
	}

	private void maybeDefaultCasePriorities(List<Case> records, aef_ApplicationUnitOfWork uow) {

		for(Case record : records) {
			// remembering that all Cases entering this module are cases linked to enterprise accounts (from the Domain's filter method)
			// we can simply default the priority of the created case to High
			record.Priority = 'High';
		}

	}

	/**
	 * Module instantiation context. This allows us to dynamically instantiate this module within ApplicationModule
	 */
	public class Constructor implements aef_ApplicationDomain.IConstructableModule {
		public aef_ApplicationDomain.Module construct() {
			return (aef_ApplicationDomain.Module)aef_EnterpriseCasesModule.newInstance();
		}
	}

	public static aef_EnterpriseCasesModule newInstance() {
		return (aef_EnterpriseCasesModule)aef_Application.Utilities.newInstance(aef_EnterpriseCasesModule.class);
	}
	
}